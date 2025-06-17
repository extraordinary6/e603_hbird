WAVEFSDB	 := 1

VSRC_DIR     := ${RUN_DIR}/../../design
VTB_DIR      := ${RUN_DIR}/../install/tb
TESTNAME     := $(notdir $(patsubst %.dump,%,${TESTCASE}.dump))
ifeq ($(JTAG_TEST),)
TEST_RUNDIR  ?= ${TESTNAME}_$(strip ${SEED})
else
TEST_RUNDIR  ?= ${JTAG_TEST}_$(strip ${SEED})
endif

RTL_V_FILES		+= $(wildcard ${VSRC_DIR}/*.v)
RTL_V_FILES		+= $(wildcard ${VSRC_DIR}/*/*.v)
RTL_V_FILES		+= $(wildcard ${VSRC_DIR}/*/*/*.v)
TB_V_FILES		:= $(wildcard ${VTB_DIR}/*.v)
TB_V_FILES		+= $(wildcard ${VTB_DIR}/*.c)
VDB_FILES		:= $(wildcard ${RUN_DIR}/rv32*/simv.vdb)

INCDIR_OPTIONS = +incdir+${VSRC_DIR}/core+${VSRC_DIR}/tech+${VSRC_DIR}/soc+${VTB_DIR}

ifneq ($(USER_INCDIRS),)
INCDIRS_WITH_PREFIX = $(addprefix +incdir+,$(USER_INCDIRS))
INCDIR_OPTIONS += $(INCDIRS_WITH_PREFIX)
endif
ifneq ($(USER_RTLDIRS),)
USER_RTLVFILES = $(foreach dir,$(USER_RTLDIRS),$(wildcard $(dir)/*.v))
RTL_V_FILES += $(USER_RTLVFILES)
endif


# The following portion is depending on the EDA tools you are using, Please add them by yourself according to your EDA vendors
SIM_TOOL      := vcs

COMP_OPTIONS   := +v2k -sverilog -notice -q +lint=all,noSVA-NSVU,noPCTIO-L,noVCDE,noUI,noSVA-CE,noSVA-DIU,noPORTFRC,noSVA-ICP,noNS  -debug_access+all -full64 -timescale=1ns/10ps -kdb 
COMP_OPTIONS   += $(INCDIR_OPTIONS) $(USER_COMPILE_OPTIONS)
COMP_OPTIONS   += +define+DISABLE_SV_ASSERTION +define+FLASH_SIM
COMP_OPTIONS   += -l compile.log
COMP_OPTIONS   += -CC "-I${RUN_DIR}/../"

ifeq ($(RUN_LIMIT_TIME),)
SIM_EXEC      := ${RUN_DIR}/simv  
else
SIM_EXEC      := timeout $(RUN_LIMIT_TIME)m ${RUN_DIR}/simv  
endif

ifeq ($(WAVEFSDB),1)
WAV_TOOL      := verdi
else
WAV_TOOL      := dve
endif
WAV_OPTIONS   := +v2k -sverilog  -vc +ignorefileext+.c+.cpp 
WAV_OPTIONS   += $(INCDIR_OPTIONS) $(USER_COMPILE_OPTIONS)
WAV_OPTIONS   += +define+DISABLE_SV_ASSERTION +define+FLASH_SIM

ifeq ($(WAVEFSDB),1)
WAV_PFIX      := fsdb
else
WAV_PFIX      := vpd
endif


ifneq ($(BOOT_ADDR),)
SIMV_OPTIONS    += +BOOT_ADDR=$(BOOT_ADDR) +fsdb+force
endif

ifeq ($(TIMEOUT),)
TIMEOUT = 2000000000
endif

SIMV_OPTIONS += +timeout=$(TIMEOUT) $(SIM_ARG) +plusarg_save +plusargs +ntb_random_seed=${SEED}


LOG := -l ${TESTNAME}.log

all: run

${RUN_DIR}/build_file.vf: ${RTL_V_FILES} ${TB_V_FILES} 
	@echo $^ | tr ' ' '\n' > $@

${RUN_DIR}/simv: ${RUN_DIR}/build_file.vf 
ifeq ($(BUILD_TOP),1)
	${SIM_TOOL} ${COMP_OPTIONS} -top tb_top -f $^;
else
	${SIM_TOOL} ${COMP_OPTIONS} -f $^;
endif

compile: ${RUN_DIR}/simv 

wave: 
	([ -e ${TESTCASE}.dump ] && gvim  ${TESTCASE}.dump) | ([ -e $(_TESTCASE).dump ] && gvim ${_TESTCASE}.dump) &
ifeq ($(WAVEFSDB), 1)
	${WAV_TOOL} ${WAV_OPTIONS} $(INCDIR_OPTIONS)  ${RTL_V_FILES} ${TB_V_FILES} -ssf ${TEST_RUNDIR}/tb_top.${WAV_PFIX} -top tb_top -nologo & 
else
	${WAV_TOOL} -vpd ${TEST_RUNDIR}/tb_top.${WAV_PFIX} &
endif

verilog: 
	${WAV_TOOL} ${WAV_OPTIONS} $(INCDIR_OPTIONS)  ${RTL_V_FILES} ${TB_V_FILES}  -logdir ${RUN_DIR}/verdilog -nologo -top tb_top & 

verilog_rtlonly: 
ifeq ($(BUILD_TOP),1)
	${WAV_TOOL} ${WAV_OPTIONS} $(INCDIR_OPTIONS) -f ${RUN_DIR}/rtlonly_flist -top soc_top  & 
else
	${WAV_TOOL} ${WAV_OPTIONS} $(INCDIR_OPTIONS) -f ${RUN_DIR}/rtlonly_flist & 
endif

compile_rtlonly: 
ifeq ($(BUILD_TOP),1)
	${SIM_TOOL} ${COMP_OPTIONS} $(INCDIR_OPTIONS) -f ${RUN_DIR}/rtlonly_flist -top soc_top
else
	${SIM_TOOL} ${COMP_OPTIONS} $(INCDIR_OPTIONS) -f ${RUN_DIR}/rtlonly_flist    
endif

verilog_core: 
ifeq ($(BUILD_TOP),1)
	${WAV_TOOL} ${WAV_OPTIONS} $(INCDIR_OPTIONS) -f ${RUN_DIR}/core_flist -top $(CPU_TOP_MODULE_NAME) & 
else
	${WAV_TOOL} ${WAV_OPTIONS} $(INCDIR_OPTIONS) -f ${RUN_DIR}/core_flist & 
endif

compile_core: 
ifeq ($(BUILD_TOP),1)
	${SIM_TOOL} ${COMP_OPTIONS} $(INCDIR_OPTIONS) -f ${RUN_DIR}/core_flist -top $(CPU_TOP_MODULE_NAME)
else
	${SIM_TOOL} ${COMP_OPTIONS} $(INCDIR_OPTIONS) -f ${RUN_DIR}/core_flist    
endif

ifeq ($(EVALSOC_SYSMEM_BASE),)
EVALSOC_SYSMEM_BASE=0xa0000000
endif

run: compile
	mkdir -p ${TEST_RUNDIR}
	cd ${TEST_RUNDIR}; ${SIM_EXEC} ${SIMV_OPTIONS} +DUMPWAVE=${DUMPWAVE} +WAVEFSDB=${WAVEFSDB} +TESTCASE=${TESTCASE} ${LOG} || echo "ERROR: Run timeout"


.PHONY: run clean all 


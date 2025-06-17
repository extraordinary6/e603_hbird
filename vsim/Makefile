include ./cpufeature.mk
export
SIM_DIR     := ${PWD}
RUN_DIR      := ${PWD}/run
INSTALL_DIR  := ${SIM_DIR}/install
DESIGN_ROOT  := $(PWD)/../design
ISADIR        := ${RUN_DIR}/../../riscv-tests/isa/
ENVDIR        := ${RUN_DIR}/../../riscv-tests/env/
RVTDIR        := ${RUN_DIR}/../../riscv-tests
TESTFLIS_FILE := ${RUN_DIR}/tests_flist
ENVFLIS_FILE := ${RUN_DIR}/env_flist
DUMPWAVE     		:= 1
JTAGVPI		 		:= 0
JTAGPORT     		:= 6666
JTAG_MODEL   		:= 0
JTAG_MODEL_2WIRE	:= 0
# JTAG_TEST to speicy the jtag run case name, can be demo, halt_on_reset, chain_test
JTAG_TEST :=

# BOOT_ADDR set the cpu boot address, it empty, set the elf start entry 
BOOT_ADDR       := 
TIMEOUT         := 200000000 
CORE    := e603
ELF_DIR := 
SIM_ARG :=

# RUN_LIMIT_TIME set the simulation max run CPU time, the unit is minutes, 
# for example 60, it indicates 60 minutes.
RUN_LIMIT_TIME :=
# BUILD_TOP set the compile with -top xxx option.
BUILD_TOP := 1

SYN_SRAM := 0
ifeq ($(SYN_SRAM),1)
# USER_COMPILE_OPTIONS specify the compile options, it will pass to simulation tool.
USER_COMPILE_OPTIONS := +define+SYNTHESIS+TECH_NUCLEI_DUMMY_RAM+TECH_NUCLEI_DUMMY_RAM_SPLIT
# USER_INCDIRS specify the include file path
USER_INCDIRS = $(SIM_DIR)/../syn/mem/wrapper
# USER_RTLDIRS specify the user self rtl file path
# if more than one directory, use space to split. for example  $(SIM_DIR)/../syn/mem/vmode1 $(SIM_DIR)/../syn/mem/vmodel2
USER_RTLDIRS = $(SIM_DIR)/../syn/mem/vmodel
else
USER_COMPILE_OPTIONS :=
USER_INCDIRS = 
USER_RTLDIRS = 
endif

CPU_TOP_MODULE_NAME=$(CORE)_core_rams


#   DOWNLOAD : can be ilm or sram. specify case run location
DOWNLOAD=sram
#  V=1  : build sdk display more information

GEN_DEFINES_V  :=  $(wildcard $(DESIGN_ROOT)/core/*_defines.v)

NUCLEI_GCC_NOEXIST := $(shell riscv64-unknown-elf-gcc -v > /dev/null 2>&1 ; echo $$?)

XLEN=64
TESTNAME     := rv${XLEN}ui-p-lb

TESTCASE     := ${RUN_DIR}/../../riscv-tests/isa/generated/${TESTNAME}
_TESTCASE := $(patsubst %.elf,%,$(TESTCASE))

SEED       := 20180622 

all: run_test

help:
	@echo "** Help about install/compile/run in Nuclei Evalsoc testbench **"
	@echo "make install                          install tb and ISA self-check cases"
	@echo "make compile                          compile testbench"
	@echo "make run_test TESTCASE=your_elf_path  run your elf in testbench"
	@echo "make wave TESTCASE=your_elf_path      launch verdi to debug" 
	@echo "make verilog_core                     launch verdi to see core code"
	@echo "** run benchmark command: **"
	@echo "     * The benchmark elfs are pre-compiled by Nucleisys"
	@echo "     * The compile ISA is imac" 
	@echo "     * Put in riscv-tests dir"
	@echo "make showtoolver                      show tools version for sdk used"
	@echo "make show_sdk                         show all nuclei-sdk case"
	@echo "make build_sdk                        build nuclei-sdk case"
	@echo "make run_sdk                          run nuclei-sdk case in testbench"
	@echo "make wave_sdk                         launch verdi to debug nuclei-sdk case"



install/tb: 
	mkdir -p install
	cd install; ln -snf ../../tb . 
	find ${SIM_DIR}/../design/ -name *.v >& ${RUN_DIR}/rtlonly_flist
	find ${SIM_DIR}/../design/core/  ${SIM_DIR}/../design/tech/ ${SIM_DIR}/../design/soc/ -name *.v >& ${RUN_DIR}/core_flist

${RUN_DIR}: 
	mkdir -p ${RUN_DIR}
	rm -f ${RUN_DIR}/Makefile
	ln -s ${SIM_DIR}/bin/run.makefile ${RUN_DIR}/Makefile

${INSTALL_DIR}: ${RUN_DIR} install/tb

install: ${RUN_DIR} ${INSTALL_DIR}
ifeq ($(NUCLEI_GCC_NOEXIST),0)
	cd  ${RVTDIR}; bash prepare.sh

ifeq ($(XLEN),64)
		sed -i "s/riscv_test/riscv_test64/g" ${RVTDIR}/env/*/*
		sed -i "s/riscv_test/riscv_test64/g" ${RVTDIR}/isa/rv64*/*
		sed -i "s/test_register/test_register64/g" ${RVTDIR}/env/*/*
		sed -i "s/test_register/test_register64/g" ${RVTDIR}/isa/rv64*/*
endif 
	ls -1 ${RUN_DIR}/../../riscv-tests/isa/rv*/* >& ${RUN_DIR}/tests_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/isa/Makefile >> ${RUN_DIR}/tests_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/isa/macros/scalar/* >> ${RUN_DIR}/tests_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env/*.h  >& ${RUN_DIR}/env_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env/p/*  >> ${RUN_DIR}/env_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env/pm/*  >> ${RUN_DIR}/env_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env/pt/*  >> ${RUN_DIR}/env_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env/v/*  >> ${RUN_DIR}/env_flist
	cd ${ISADIR}; mkdir generated; make -C generated -f ../Makefile src_dir=../ XLEN=${XLEN}
else
	@echo "ERROR: Nuclei GCC tool don't installed, you should install the Nuclei GCC first" && exit 1
endif


verilog: ${INSTALL_DIR}
	make verilog RUN_DIR=${RUN_DIR} -C ${RUN_DIR} 

verilog_rtlonly: ${INSTALL_DIR}
	make verilog_rtlonly RUN_DIR=${RUN_DIR} -C ${RUN_DIR} 

compile_rtlonly: ${INSTALL_DIR}
	make compile_rtlonly RUN_DIR=${RUN_DIR} -C ${RUN_DIR} 

verilog_core: ${INSTALL_DIR}
	make verilog_core RUN_DIR=${RUN_DIR} -C ${RUN_DIR}

compile_core: ${INSTALL_DIR}
	make compile_core RUN_DIR=${RUN_DIR} -C ${RUN_DIR}

compile: ${INSTALL_DIR}
	make compile RUN_DIR=${RUN_DIR} -C ${RUN_DIR} TESTCASE=${TESTCASE}

wave: ${INSTALL_DIR}
	make wave TESTCASE=${TESTCASE} RUN_DIR=${RUN_DIR} -C ${RUN_DIR} 

run_test: compile
	make run DUMPWAVE=${DUMPWAVE} TESTCASE=${TESTCASE} SEED=${SEED} RUN_DIR=${RUN_DIR} -C ${RUN_DIR}

SELF_TESTS := $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv${XLEN}uc-p*.dump))
SELF_TESTS += $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv${XLEN}um-p*.dump))
SELF_TESTS += $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv${XLEN}ua-p*.dump))
SELF_TESTS += $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv${XLEN}ui-p*.dump))
SELF_TESTS += $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv${XLEN}uf-p*.dump))
SELF_TESTS += $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv${XLEN}ud-p*.dump))
SELF_TESTS += $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv${XLEN}up-p*.dump))
SELF_TESTS += $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv${XLEN}uv-p*.dump))

ifneq ($(ELF_DIR),)
ELF_TESTS = $(shell find $(ELF_DIR) -name "*.elf")
RGS_TESTS = $(ELF_TESTS)
else
RGS_TESTS = $(SELF_TESTS)
endif


regress_prepare:
	make compile
	@-rm -rf ${RUN_DIR}/rv*.log
regress_run:
ifeq ($(strip $(RGS_TESTS)),)
	$(error no case to run)
endif
	$(foreach tst,$(RGS_TESTS), make run_test TESTCASE=$(tst) DUMPWAVE=0;)
regress_collect:
	@-rm -rf ${RUN_DIR}/regress.res
	@chmod u+x bin/find_test_fail.sh
	@find ${RUN_DIR} \( -name "rv*.log" -o -name "tb_sram_scan.log" \) -exec bash bin/find_test_fail.sh {} >> ${RUN_DIR}/regress.res \;
	@cat ${RUN_DIR}/regress.res
regress: regress_prepare regress_run regress_collect 


ifneq ($(TESTNAME),)
ifeq ($(TESTNAME),freertos_demo)
SDK_TEST_DIR := $(PWD)/../nuclei-sdk/application/freertos/demo
else ifeq ($(TESTNAME),rtthread_demo)
SDK_TEST_DIR := $(PWD)/../nuclei-sdk/application/rtthread/demo
else ifeq ($(TESTNAME),ucosii_demo)
SDK_TEST_DIR := $(PWD)/../nuclei-sdk/application/ucosii/demo
else
SDK_TEST_DIR := $(shell find $(PWD)/../nuclei-sdk/application/{baremetal,cpu_features} -name Makefile | grep "/$(TESTNAME)/")
ifneq ($(SDK_TEST_DIR),)
SDK_TEST_DIR := $(shell dirname $(SDK_TEST_DIR))
endif
endif
endif


ifneq ($(SDK_TEST_DIR),)
SDK_TEST = $(SDK_TEST_DIR)/$(TESTNAME).elf
SDK_TEST_C_SOURCE = $(wildcard $(SDK_TEST_DIR)/*.c)
SDK_TEST_H_SOURCE = $(wildcard $(SDK_TEST_DIR)/*.h)
endif

ifeq ($(DOWNLOAD),)
SDK_SHARE_ARG = clean dasm SIMULATION=1 
else
SDK_SHARE_ARG = clean dasm SIMULATION=1 DOWNLOAD=$(DOWNLOAD)
endif

.PHONY: $(SDK_TEST)
$(SDK_TEST) : 
ifeq ($(TESTNAME),dhrystone)
	cd $(SDK_TEST_DIR); make $(SDK_SHARE_ARG) CORE=$(SDK_DHRYSTONE_CORE) ARCH_EXT=$(SDK_DHRYSTONE_ARCH_EXT)
else ifeq ($(TESTNAME),coremark)
	cd $(SDK_TEST_DIR); make $(SDK_SHARE_ARG) CORE=$(SDK_COREMARK_CORE) ARCH_EXT=$(SDK_COREMARK_ARCH_EXT)
else ifeq ($(TESTNAME),whetstone)
	cd $(SDK_TEST_DIR); make $(SDK_SHARE_ARG) CORE=$(SDK_WHETSTONE_CORE) ARCH_EXT=$(SDK_WHETSTONE_ARCH_EXT)
else
	cd $(SDK_TEST_DIR); make $(SDK_SHARE_ARG) CORE=$(SDK_CORE) ARCH_EXT=$(ARCH_EXT)
endif

build_sdk: $(SDK_TEST)

showtoolver:
	make -C ../nuclei-sdk showtoolver || exit 0

SDK_TEST_ALL := $(shell find $(PWD)/../nuclei-sdk/application/{baremetal,cpu_features} -name Makefile -exec dirname {} \; | awk -F/ '{print $$NF}')
ifeq ($(CFG_FLEN),)
SDK_TEST_ALL :=  $(subst whetstone,,${SDK_TEST_ALL})
endif

case_pdf = $(wildcard ../nuclei-sdk/*.pdf)
show_sdk: 
	@echo "sdk case list: $(SDK_TEST_ALL) freertos_demo ucosii_demo rtthread_demo"
	@echo "You can open $(case_pdf) to see detail case information"

run_sdk: $(SDK_TEST)
ifeq ($(SDK_TEST),)
	$(error can't find the case $(TESTNAME), please execute 'make show_sdk' to get the case supported)
endif
	@echo "run sdk test: $(SDK_TEST)"
	make run_test TESTCASE=$(SDK_TEST) TESTNAME=$(TESTNAME).elf

sdk_regress: 
	for case in $(SDK_TEST_ALL); do make run_sdk TESTNAME=$${case}; done

wave_sdk: 
ifeq ($(SDK_TEST),)
	$(error can't find the real elf, please specify the correct TESTNAME)
endif
	make wave TESTCASE=$(SDK_TEST) TESTNAME=$(TESTNAME).elf


clean:
	rm -rf run
	rm -rf install

.PHONY: help compile run install clean all run_test regress regress_prepare regress_run regress_collect 


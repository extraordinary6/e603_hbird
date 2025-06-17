#=======================================================================
# Makefile for riscv-tests/isa
#-----------------------------------------------------------------------

XLEN ?= 32

#INTERNAL_CODE_BEGIN

#INTERNAL_CODE_END

src_dir := .

include $(src_dir)/rv64ui/Makefrag
include $(src_dir)/rv64uc/Makefrag
include $(src_dir)/rv64um/Makefrag
include $(src_dir)/rv64ua/Makefrag
include $(src_dir)/rv64uf/Makefrag
include $(src_dir)/rv64ud/Makefrag
include $(src_dir)/rv64uv/Makefrag
include $(src_dir)/rv32ui/Makefrag
include $(src_dir)/rv32uc/Makefrag
include $(src_dir)/rv32um/Makefrag
include $(src_dir)/rv32ua/Makefrag
include $(src_dir)/rv32uf/Makefrag
include $(src_dir)/rv32ud/Makefrag
include $(src_dir)/rv32up/Makefrag

#include $(src_dir)/rv32imc_0/Makefrag
#include $(src_dir)/rv32imc_1/Makefrag
#include $(src_dir)/rv32imc_2/Makefrag

default: all

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------
RISCV_PREFIX ?= riscv64-unknown-elf
RISCV_GCC ?= $(RISCV_PREFIX)-gcc
RISCV_GCC_OPTS ?= -static -mcmodel=medany -g -fvisibility=hidden -nostdlib -nostartfiles -I../../../vsim
RISCV_OBJDUMP ?= $(RISCV_PREFIX)-objdump -d -S
RISCV_OBJCOPY ?= $(RISCV_PREFIX)-objcopy -O verilog 

vpath %.S $(src_dir)

#------------------------------------------------------------
# Build assembly tests
%.dump: % 
	$(RISCV_OBJDUMP) $< > $@
	$(RISCV_OBJCOPY) $<   $<.verilog

define compile_template

$$($(1)_p_tests): $(1)-p-%: $(1)/%.S
	$$(RISCV_GCC) $(2) $$(RISCV_GCC_OPTS) -I$(src_dir)/../env/p -I$(src_dir)/macros/scalar -T$(src_dir)/../env/p/link.ld -L$(src_dir)/../env/p $$< -o $$@
$(1)_tests += $$($(1)_p_tests)

$(1)_tests_dump = $$(addsuffix .dump, $$($(1)_tests))

$(1): $$($(1)_tests_dump)

.PHONY: $(1)

tests += $$($(1)_tests)

endef
ifeq ($(XLEN),64)
  $(eval $(call compile_template,rv64ui,-march=rv64imafdc -mabi=lp64))
  $(eval $(call compile_template,rv64uc,-march=rv64imafdc -mabi=lp64))
  $(eval $(call compile_template,rv64um,-march=rv64imafdc -mabi=lp64))
  $(eval $(call compile_template,rv64ua,-march=rv64imafdc -mabi=lp64))
  $(eval $(call compile_template,rv64uf,-march=rv64imafdc -mabi=lp64))
  $(eval $(call compile_template,rv64ud,-march=rv64imafdc -mabi=lp64))
  $(eval $(call compile_template,rv64uv,-march=rv64imafdcv -mabi=lp64))

else
  $(eval $(call compile_template,rv32ui,-march=rv32imafdc -mabi=ilp32))
  $(eval $(call compile_template,rv32uc,-march=rv32imafdc -mabi=ilp32))
  $(eval $(call compile_template,rv32um,-march=rv32imafdc -mabi=ilp32))
  $(eval $(call compile_template,rv32ua,-march=rv32imafdc -mabi=ilp32))
  $(eval $(call compile_template,rv32uf,-march=rv32imafdc -mabi=ilp32))
  $(eval $(call compile_template,rv32ud,-march=rv32imafdc -mabi=ilp32))
ifeq ($(RISCV_PREFIX),riscv64-unknown-elf)
  $(eval $(call compile_template,rv32up,-march=rv32imafdc_xxldspn3x -mabi=ilp32))
else
  $(eval $(call compile_template,rv32up,-march=rv32imafdcp -mabi=ilp32))
endif
endif

tests_verilog = $(addsuffix .verilog, $(tests))
tests_dump = $(addsuffix .dump, $(tests))
tests_hex = $(addsuffix .hex, $(tests))

junk += $(tests) $(tests_verilog) $(tests_dump) $(tests_hex)
elf_junk += $(tests)

#------------------------------------------------------------
# Default

all: $(tests_dump)
#	rm -rf $(elf_junk)

#------------------------------------------------------------
# Clean up

clean:
	rm -rf $(junk)


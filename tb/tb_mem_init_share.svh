
typedef int unsigned uint32_t;
typedef byte unsigned uint8_t;

/*
    mem split three region
    0000_0000 - 0x0800_0000 : ilm
    0800_0000 - 0x1000_0000 : dlm
    1000_0000 - 0x2000_0000 : sysmem
    2000_0000 - 0x3000_0000 : flash
*/
`define EVALSOC_FLASH_XIP_ADDR_WIDTH             28

bit [7:0] mem [0:32'h2000_0000-1]; // 

bit [7:0] flash_mem [2**`EVALSOC_FLASH_XIP_ADDR_WIDTH-1:0];

bit[31:0] sys_mem_max_offset;
bit[31:0] flash_max_offset;

import "DPI-C" context function load_elf64_to_mem(string elf_file);
import "DPI-C" context function load_elf32_to_mem(string elf_file);

export "DPI-C" function elf_ini_mem;

function int elf_ini_mem(input uint32_t address, input uint8_t data);
    if (address >= 32'h2000_0000) begin
        // flash
        flash_max_offset = address - 32'h2000_0000; 
        flash_mem[flash_max_offset] = data; 
    end
    if (address >= 32'h1000_0000) begin
        sys_mem_max_offset = address - 32'h1000_0000;
    end
    mem[address] = data;
    return 1;
endfunction: elf_ini_mem


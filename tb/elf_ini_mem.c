#include <elf.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdio.h>
#include "svdpi.h"
#define EVALSOC_IRAM_BASE_ADDR                   0x60000000
#define EVALSOC_IRAM_ADDR_WIDTH                  16
#define EVALSOC_DRAM_BASE_ADDR                   0x68000000
#define EVALSOC_DRAM_ADDR_WIDTH                  16
#define EVALSOC_FLASH_XIP_BASE                   0x20000000
#define EVALSOC_FLASH_XIP_ADDR_WIDTH             28
#define EVALSOC_SYSMEM_BASE                      0x80000000
#define EVALSOC_SYSMEM_ADDR_WIDTH                31


#define ILM_BASE EVALSOC_IRAM_BASE_ADDR
#define ILM_SIZE (1<<EVALSOC_IRAM_ADDR_WIDTH)

#define DLM_BASE EVALSOC_DRAM_BASE_ADDR
#define DLM_SIZE (1<<EVALSOC_DRAM_ADDR_WIDTH)


#define XIP_REGION_BASE EVALSOC_FLASH_XIP_BASE
#define XIP_REGION_END  (EVALSOC_FLASH_XIP_BASE  + (1 << EVALSOC_FLASH_XIP_ADDR_WIDTH))

#define SYSMEM_REGION_BASE EVALSOC_SYSMEM_BASE 
#if EVALSOC_SYSMEM_ADDR_WIDTH > 28
#define SYSMEM_REGION_END  (EVALSOC_SYSMEM_BASE + (1 << 28))
#else
#define SYSMEM_REGION_END  (EVALSOC_SYSMEM_BASE + (1 << EVALSOC_SYSMEM_ADDR_WIDTH))
#endif

#ifdef __cplusplus
extern "C" {
#endif
extern int elf_ini_mem(unsigned int address, unsigned char data);

int parse_elf(char const* elf_file, uint64_t *addr) {
    FILE *fp = NULL;
    char context[100];
    int len;
    Elf32_Ehdr *a;
    Elf64_Ehdr *b;

    fp = fopen(elf_file, "rb");
    len = fread(context, sizeof(unsigned char), 100, fp);
    a = (Elf32_Ehdr *)&context[0];
    b = (Elf64_Ehdr *)&context[0];
    if (a->e_ident[4] == 1) { // elf32
        *addr = a->e_entry;
    }
    else if (b->e_ident[4] == 2) { // elf64
        *addr = b->e_entry;
    }
    else {
        io_printf("ERROR: no valid elf\n");
        return 1;
    }
    io_printf("elf entry addr: 0x%x\n", *addr);
    return 0;
}

int file_size(char const * file_name) {
    struct stat statbuf;
    stat(file_name, &statbuf);
    return statbuf.st_size;
}

void load_ph2mem(char* addr, long offset, int p_filesz) {
    int j;
    // set the scope
    // tb_top.u_tb_mem_init
    for(j=0; j<p_filesz; j++) {
        unsigned int mem_addr = offset + j;
        unsigned char value = *(addr + j);
        elf_ini_mem(mem_addr, value);
    }
}

int load_ph_to_mem(int ph_index, char *addr, unsigned long long  p_paddr, int p_offset, int p_filesz) {
    unsigned long long offset;
    io_printf("ph: [%d]:%x, size: %x\n", ph_index, p_paddr, p_filesz);
    if ((p_paddr >= ILM_BASE && p_paddr < (ILM_BASE + ILM_SIZE)) && p_filesz) {
        offset = p_paddr - ILM_BASE;
        io_printf("parse ph: addr %lx, offset=%lx\n", p_paddr, offset);
        load_ph2mem(addr+p_offset, offset, p_filesz);
    }
    else if ((p_paddr >= DLM_BASE && p_paddr < (DLM_BASE + DLM_SIZE)) && p_filesz) {
        offset = p_paddr - DLM_BASE;
        io_printf("parse ph: addr %lx, offset=%lx\n", p_paddr, offset);
        load_ph2mem(addr+p_offset, 0x08000000 + offset, p_filesz);
    }
    else if ((p_paddr >= SYSMEM_REGION_BASE && p_paddr < SYSMEM_REGION_END) && p_filesz) {
        offset = p_paddr - SYSMEM_REGION_BASE;
        io_printf("parse ph: addr %lx, offset=%lx\n", p_paddr, offset);
        load_ph2mem(addr+p_offset, 0x10000000 + offset, p_filesz);
    }
    else if ((p_paddr >= XIP_REGION_BASE && p_paddr < XIP_REGION_END) && p_filesz) {
        offset = p_paddr - XIP_REGION_BASE;
        io_printf("xip parse ph: addr %lx, offset=%lx\n", p_paddr, offset);
        load_ph2mem(addr+p_offset, 0x20000000 + offset, p_filesz);
    }
}

int elf_is_valid(char *addr) {
    if (addr[0] != 0x7f)
        return 0;
    if (addr[1] != 0x45)
        return 0;
    if (addr[2] != 0x4c)
        return 0;
    if (addr[3] != 0x46)
        return 0;
    return 1;
}

int elf_is_elf64(char *addr) {
    if (!elf_is_valid(addr))
        return 0;
    if (addr[4] != 2)
        return 0;
    return 1;
}

int elf_is_elf32(char *addr) {
    if (!elf_is_valid(addr))
        return 0;
    if (addr[4] != 1)
        return 0;
    return 1;
}

void print_info() {
    io_printf("IRAM_BASE: 0x%lx, IRAM_SIZE: 0x%x\n", ILM_BASE, ILM_SIZE);
    io_printf("DRAM_BASE: 0x%lx, DRAM_SIZE: 0x%x\n", DLM_BASE, DLM_SIZE);
    io_printf("FLASH BASE: 0x%lx, FLASH_SIZE: 0x%x\n", XIP_REGION_BASE, XIP_REGION_END - XIP_REGION_BASE);
    io_printf("SYSMEM_BASE: 0x%lx, SYSMEM_SIZE: 0x%x\n", SYSMEM_REGION_BASE, SYSMEM_REGION_END - SYSMEM_REGION_BASE);
}

int load_elf64_to_mem(char const *elf_file) {
    int i;
    io_printf("parse: %s\n", elf_file);
    int fd;
    FILE *w_fp;
    char context[100];
    int len;
    svSetScope(svGetScopeFromName("tb_top.u_tb_mem_init"));
    fd = open(elf_file, O_RDONLY);
    if (fd == NULL) {
        io_printf("%s is not exist\n", elf_file);
        return 0;
    }
    int size = file_size(elf_file);
    char* addr = (char *)mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (!elf_is_elf64(addr)) {
        io_printf("%s is not elf64\n", elf_file);
        return 0;
    }
    print_info();
    Elf64_Ehdr *a = (Elf64_Ehdr *)addr;
    int e_phoff = a->e_phoff;
    int e_phnum = a->e_phnum;
    int e_phentsize = a->e_phentsize;

    Elf64_Phdr * phdr;
    Elf64_Addr p_paddr;
    int p_offset;
    int p_filesz;
    for(i=0; i<e_phnum; i++) {
        phdr = (Elf64_Phdr*)(addr + e_phoff + i * e_phentsize);
        p_filesz = phdr->p_filesz;
        p_offset = phdr->p_offset; 
        p_paddr =  phdr->p_paddr;
        load_ph_to_mem(i, addr, p_paddr, p_offset, p_filesz);
    }
    return 1;
}

int load_elf32_to_mem(char const *elf_file) {
    int i;
    io_printf("parse: %s\n", elf_file);
    int fd;
    FILE *w_fp;
    char context[100];
    int len;
    fd = open(elf_file, O_RDONLY);
    if (fd == NULL) {
        io_printf("%s is not exist\n", elf_file);
        return 0;
    }
    int size = file_size(elf_file);
    svSetScope(svGetScopeFromName("tb_top.u_tb_mem_init"));
    char* addr = (char *)mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (!elf_is_elf32(addr)) {
        io_printf("%s is not elf32\n", elf_file);
        return 0;
    }
    print_info();
    Elf32_Ehdr *a = (Elf32_Ehdr *)addr;
    int e_phoff = a->e_phoff;
    int e_phnum = a->e_phnum;
    int e_phentsize = a->e_phentsize;

    Elf32_Phdr * phdr;
    Elf32_Addr p_paddr;
    int p_offset;
    int p_filesz;
    for(i=0; i<e_phnum; i++) {
        phdr = (Elf32_Phdr*)(addr + e_phoff + i * e_phentsize);
        p_filesz = phdr->p_filesz;
        p_offset = phdr->p_offset; 
        p_paddr =  phdr->p_paddr;
        load_ph_to_mem(i, addr, p_paddr, p_offset, p_filesz);
    }
    return 1;
}


#ifdef __cplusplus
}
#endif



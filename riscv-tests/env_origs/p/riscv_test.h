// See LICENSE for license details.
#ifndef _ENV_PHYSICAL_SINGLE_CORE_H
#define _ENV_PHYSICAL_SINGLE_CORE_H

#include "../encoding.h"
#include "e603_defines.h"

#ifdef N600_CFG_HAS_MINI_CORE //{
#include "riscv_test_mini.h"
#endif

#ifndef N600_CFG_HAS_MINI_CORE
#include "riscv_test_full.h"
#endif //}

#endif

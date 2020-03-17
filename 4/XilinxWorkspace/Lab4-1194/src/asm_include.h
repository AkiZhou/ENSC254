// For inclusion from .S assembly code files.
// To get preprocessor definitions for the Zedboard
// as configured for ENSC 254/351 at Simon Fraser University (SFU)
// Copyright (C) 2019 School of Engineering Science, SFU

#define extern ;@
#define void ;@
#define u8 ;@

#define XIL_TYPES_H
#define XIL_IO_H
#define XIL_ASSERT_H

#include "xparameters.h"

// Xilinx Timer
#include "xtmrctr_l.h"

// Xilinx GPIO
#include "xgpio_l.h"

// Xilinx 16550-compatible UART
#include "xuartns550_l.h"

// For ARM cortex A9 processor
#include "xreg_cortexa9.h"

#undef u8
#undef void
#undef extern

#undef XIL_TYPES_H
#undef XIL_IO_H
#undef XIL_ASSERT_H
 

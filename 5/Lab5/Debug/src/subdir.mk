################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/fib.c \
../src/main.c 

S_UPPER_SRCS += \
../src/OLED.S \
../src/asm.S \
../src/asuAdd.S 

OBJS += \
./src/OLED.o \
./src/asm.o \
./src/asuAdd.o \
./src/fib.o \
./src/main.o 

S_UPPER_DEPS += \
./src/OLED.d \
./src/asm.d \
./src/asuAdd.d 

C_DEPS += \
./src/fib.d \
./src/main.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -mno-thumb-interwork -fomit-frame-pointer -fno-asynchronous-unwind-tables -fno-dwarf2-cfi-asm -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../standalone_bsp_0/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -mno-thumb-interwork -fomit-frame-pointer -fno-asynchronous-unwind-tables -fno-dwarf2-cfi-asm -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../standalone_bsp_0/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '



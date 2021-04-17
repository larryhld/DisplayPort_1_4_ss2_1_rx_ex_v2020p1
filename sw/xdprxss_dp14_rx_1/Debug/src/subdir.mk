################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/idt_8t49n24x.c \
../src/ti_lmk03318.c \
../src/xdprxss_dp14_rx.c \
../src/xvidframe_crc.c 

OBJS += \
./src/idt_8t49n24x.o \
./src/ti_lmk03318.o \
./src/xdprxss_dp14_rx.o \
./src/xvidframe_crc.o 

C_DEPS += \
./src/idt_8t49n24x.d \
./src/ti_lmk03318.d \
./src/xdprxss_dp14_rx.d \
./src/xvidframe_crc.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v8 gcc compiler'
	aarch64-none-elf-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -IC:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/sw/zcu102_rxo/export/zcu102_rxo/sw/zcu102_rxo/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '



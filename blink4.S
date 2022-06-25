.global start

start:

GPIO_BOP_OFFSET   = 0x10 	# GPIO port bit operation register
GPIO_OCTL_OFFSET  = 0x0C 	# GPIO port output control register
GPIO_CTL0_OFFSET  = 0x00 	# GPIO port control register 0
GPIO_CTL1_OFFSET  = 0x04 	# GPIO port control register 1
GPIO_BASE_ADDR_A = 0x40010800   # GD32VF103 Manual: Section 7.5 (green and blue LEDs)
GPIO_BASE_ADDR_C = 0x40011000   # GD32VF103 Manual: Section 7.5 (red LED)
RCU_APB2EN_PAEN_BIT = 2
RCU_APB2EN_PCEN_BIT = 4
RCU_BASE_ADDR = 0x40021000
RCU_APB2EN_OFFSET   = 0x18
GPIO_MODE_PP_50MHZ    = 0x3 	#  push-pull output, max speed 50MHz
GPIO_BC_OFFSET    = 0x14 	# GPIO bit clear register 
GPIO_OCTL_OFFSET  = 0x0C 	# GPIO port output control register

main:								# blinks red ,green , blue infinitly

li a0, RCU_BASE_ADDR				   		# clock base address
li a1,(1 << RCU_APB2EN_PAEN_BIT| 1 << RCU_APB2EN_PCEN_BIT) 	# a , c ports enabled
sw a1, RCU_APB2EN_OFFSET(a0)					# store in rcu apb2enable register
li a0,GPIO_BASE_ADDR_A						# GPIO A base address
li a1,((GPIO_MODE_PP_50MHZ << 4 | GPIO_MODE_PP_50MHZ << 8)) 	# binary from right to left 0b11  loaded fro 4 to 5,, 0b0011 =pushpull output,50mhz on pin 1,pin2
sw a1,GPIO_CTL0_OFFSET(a0)					# store in GPIO control register0 (GPIO_CTL0 controls pin 0 to pin7)
li a0,GPIO_BASE_ADDR_C						# GPIO C base address		
li a1,(GPIO_MODE_PP_50MHZ << 20 )				# 0b0011 shifted 20 positions left enables pin 13 as pushpull output with 50mhs speed
sw a1,GPIO_CTL1_OFFSET(a0)					# store in GPIO control register1 (GPIO_CTL1 controls pin 8 to pin15)
blink:
li a0,GPIO_BASE_ADDR_C						# GPIO C base address
li a1, (1 << 13)						# value of 1 shifted 13 positions left loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 13 high (led off)
li a0,GPIO_BASE_ADDR_A						# GPIO A base address
li a1,(1 << 2 | 1 << 1)						# value of 1 lhs 2 OR 1 lhs 2 loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 1, pin 2 high ( led blue and green off)
call delay							# call delay routine

li a0,GPIO_BASE_ADDR_C						# GPIO C base address
li a1,(1 << 29)							# value of 1 shifted 29 positions left loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 13 low (led on)
call delay							# # call delay routine

li a0,GPIO_BASE_ADDR_C						# GPIO C base address
li a1, (1 << 13)						# value of 1 shifted 13 positions left loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 13 high (led off)
li a0,GPIO_BASE_ADDR_A						# GPIO A base address
li a1,(1 << 2 | 1 << 1)						# value of 1 lhs 2 OR 1 lhs 2 loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 1, pin 2 high ( led blue and green off)
call delay							# call delay routine


li a0,GPIO_BASE_ADDR_A						# GPIO A base address
li a1,(1 << 17)							# value of 1 shifted 17 positions left loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 1 low (led on)
call delay							# call delay routine

li a0,GPIO_BASE_ADDR_C						# GPIO C base address
li a1, (1 << 13)						# value of 1 shifted 13 positions left loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 13 high (led off)
li a0,GPIO_BASE_ADDR_A						# GPIO A base address
li a1,(1 << 2 | 1 << 1)						# value of 1 lhs 2 OR 1 lhs 2 loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 1, pin 2 high ( led blue and green off)
call delay							# call delay routine

li a0,GPIO_BASE_ADDR_A						# GPIO A base address
li a1,(1 << 18)							# value of 1 shifted 18 positions left loaded in a1
sw a1,GPIO_BOP_OFFSET(a0)					# store in GPIO bit operate register to make pin 2 low (led on)
call delay							# call delay routine

j blink								# jump to label blink

delay:								# delay routine
li t1,2000000							# load an arbitarary value 20000000 to t1 register		
loop:
addi t1,t1,-1							# subtract 1 from t1
bne t1,zero,loop						# if t1 not equal to 0 branch to label loop
ret								# return to caller




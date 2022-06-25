# GD32VF103-LONGAN-NANO-BLINKY
ASSEMBLY PROGRAM TO BLINK ON BOARD LEDS
This is my first riscv program written in assembly successfully blinking red green and blue leds on board of Longan Nano boeard (GD32VF103 chip)
GCC tool kit was used to assemble and link the program. The prebuilt tool chain for windows is "riscv32-embecosm-win64-gcc12.1.0" can be downloaded 
from https://www.embecosm.com/resources/tool-chain-downloads/ . Un zip the pckage and add to path the bin folder. CD  to directory with 
assembly and linker files from windows command window to assemble and link.
I used the following commands to get the results

assemble;                      riscv32-unknown-elf-as -g blink4.S -o blink4.O
link:                          riscv32-unknown-elf-ld -T gd32vf103.ld  -Map=final.map blink4.O  
create HEX;                    riscv32-unknown-elf-objcopy -O ihex a.out blink4.hex

download GD32vF103 programming tool from  https://www.gd32mcu.com/en/download/7?kw=GD32VF1

1) ALL IN  ONE PROGRAMMER version 2.0.3.13854     (latest)
2) GD32 MCU DFU tool version 3.8.2.9056  (older)
3) GD32 DFU drivers  version 3.6.6.6167

Upload the blink4.hex file to the longan nano board with usb cable 
led blinks in sequence of red , blue ,green ( pins PA1,PA2,PC13)







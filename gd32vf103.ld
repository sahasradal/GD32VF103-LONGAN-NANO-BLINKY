ENTRY(start)

MEMORY
{
	FLASH (rx): ORIGIN = 0x08000000, LENGTH = 128k
	SRAM (rwx): ORIGIN = 0x20000000, LENGTH = 32k
}

SECTIONS

{ 	
	.text :

	{
		*(.isr_vector)
		*(.text)
		*(.rodata)
		_etext = .;

	}> FLASH AT> FLASH


	.data :
	{
		_sdata = .;
		*(.data)
		_edata = .;

	}> SRAM AT> FLASH


	.bss :
	{
		_sbss = .;
		*(.bss)
		_ebss = .;
	}> SRAM

} 	


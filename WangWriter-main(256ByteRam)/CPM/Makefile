all: cbios.asm cpm22.asm bootsector.asm diskheader.cim
	zmac --od . --oo cim -l bootsector.asm > bootsector.lst
	zmac -8 --dri --od . --oo cim -l cbios.asm > cbios.lst
	zmac -8 --dri --od . --oo cim -l cpm22.asm > cpm22.lst
	cat diskheader.cim bootsector.cim cpm22.cim cbios.cim > bootblock.bin
	dd if=/dev/zero of=disk.img bs=256 count=1280
	mkfs.cpm -f wang -b bootblock.bin disk.img
	cpmcp -f wang disk.img diskfiles/*.* 0:

.PHONY: clean

clean:
	rm -f $(PROJECT_NAME)


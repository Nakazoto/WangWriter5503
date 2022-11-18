all: keyboard.asm
	zmac  --od . --oo cim -l -m keyboard.asm > keyboard.lst
	cat diskheader.cim keyboard.cim > keyboard.bin
	dd if=/dev/zero of=keyboard.img bs=256 count=1280
	mkfs.cpm -f wang -b keyboard.bin keyboard.img

.PHONY: clean

clean:
	rm -f $(PROJECT_NAME)


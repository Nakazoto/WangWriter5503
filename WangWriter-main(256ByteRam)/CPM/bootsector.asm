
UBS	equ	0x03	; Upper Bank Select
DISPLAY	equ	0x5F

PORTA	equ	0x30
PORTB	equ	0x31
CMDA	equ	0x32
CMDB	equ	0x33

	org	0x0200
entry:	di
	ld	sp, 0x200
	ld	a, 0xFF
	out	(DISPLAY), a
	ld	a,0x80
	out	(UBS),a			; Change upper bank to CRT Select (0x80 = D7 = 1 = CRT Select)
	out	(0x4e),a			; Start timing chain
	out	(0x4a),a			; VTAC reset
	out	(0x4e),a			; Start timing chain
	ld	a,0x63
	out	(0x40),a			; Load horizontal line count (0x63)
	ld	a,0x26
	out	(0x41),a			; Load sync width, delay, interface (0x26)
	ld	a,0x55
	out	(0x42),a			; Load scans/data row, char/data row (0x55)
	ld	a,0xd7
	out	(0x43),a			; Load skew bits, data rows/frame (0xd7)
	ld	a,0x14
	out	(0x44),a			; Load scan lines/fram (0x14)
	ld	a,0x1f
	out	(0x45),a			; Load vertical data start (0x1f)
	ld	a,0x17
	out	(0x46),a
	
	ld	hl, cpm
	ld	e, 0
	ld	a, (cpm+2)	; Page vector for CP/M image
	sui	3
	mov	d, a
	ld	bc, 7168	; Size
	ldir
	
	ld	l, 0
	add	a, 0x16		; Offset of 0x1600
	ld	h, a
	jp	(hl)
	
	rept	(0x200 - $)
	db	0
	endm
	
cpm	equ	$



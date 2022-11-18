
UBS	equ	0x03	; Upper Bank Select
DISPLAY	equ	0x5F

PORTA	equ	0x30
PORTB	equ	0x31
CMDA	equ	0x32
CMDB	equ	0x33

bs	equ	8
cr	equ	13
lf	equ	10

	org	0x0200
entry:	di
	ld	sp, entry
	ld	a, 0xFF
	out	(DISPLAY), a
	ld	a,0x80
	out	(UBS),a		; Change upper bank to CRT Select (0x80 = D7 = 1 = CRT Select)
	out	(0x4e),a	; Start timing chain
	out	(0x4a),a	; VTAC reset
	out	(0x4e),a	; Start timing chain
	ld	a,0x63
	out	(0x40),a	; Load horizontal line count (0x63)
	ld	a,0x26
	out	(0x41),a	; Load sync width, delay, interface (0x26)
	ld	a,0x55
	out	(0x42),a	; Load scans/data row, char/data row (0x55)
	ld	a,0xd7
	out	(0x43),a	; Load skew bits, data rows/frame (0xd7)
	ld	a,0x14
	out	(0x44),a	; Load scan lines/fram (0x14)
	ld	a,0x1f
	out	(0x45),a	; Load vertical data start (0x1f)
	ld	a,0x17
	out	(0x46),a
		
kbinit:	di
	im2
	ld	a, 07h		; Disable interrupts
	out	(cmda), a
	out	(cmdb), a
	
	ld	a, low irqtab
	out	(cmda), a
	out	(cmdb), a
	ld	a, high irqtab
	ld	i, a
	
	ld	a, 04Fh		; Set mode
	out	(cmda), a
	ld	a, 087h		; Enable interrupts for PORTA
	out	(cmda), a
	
	ld	a, 0FFh
	out	(cmdb), a
	ld	a, 0C1h		; Input bits
	out	(cmdb), a
	
	xor	a, a
	out	(portb), a
	ld	(inptr), a
	ld	(outptr), a
	
	in	a, (porta)
	in	a, (portb)
	
	ei
	
	in	a, (PORTB)	; Keyboard strobe
	set	1, a
	out	(PORTB), a
	xor	a, a
wait:	dec	a
	jrnz	wait
	res	1, a
	out	(PORTB), a
	
loop:	ld	a, (outptr)
	ld	e, a
	ld	d, 0
	ld	a, (inptr)
	cp	e
	jr	z, loop		; Wait for outptr and inptr to be different
	
	ld	hl, buffer	; Get address of next character
	add	hl, de
	
	ld	a, e		; Next address
	inc	a
	and	a, 31		; Modulo 32
	ld	(outptr), a
	
	ld	a, (hl)		; Get data from buffer
	call	phex		; Print it to screen as hex

	ld	c, ' '		; Two spaces to keep things neat
	call	conout
	ld	c, ' '
	call	conout

	jr	loop


phex	push	af		; Will use A twice
	rar			; Shift upper to lower nibble
	rar
	rar
	rar
	call	phex1		; Print it
	pop	af		; Restore original Acc
phex1	and	a, 0x0F		; Mask off high nibble
	add	a, 0x90		; Decimal adjust for ASCII
	daa
	adc	a, 0x40
	daa
	ld	c, a		; Print it
	;jp	conout
	
	; Console out
conout	mvi	a, cr
	cmp	c
	jrz	concr
	mvi	a, lf
	cmp	c
	jrz	conlf
	mvi	a, bs
	cmp	c
	jrz	conbs
	mvi	a, ' '
	cmp	c
	jrnz	conout1
	mvi	c, 0		; Blank for space
conout1	push	d
	lhld	cursor
	push	h
	lxi	d, 0E000h	; CRT base address
	dad	d
	mov	m, c
	pop	h
	pop	d
	inx	h
	shld	cursor
	mvi	a, 80		; 80 columns
	cmp	l
	rnz
	mvi	l, 0		; Newline
	inr	h
	shld	cursor
	lxi	h, cursor+1
	mov	a, m
	jr	scroll

concr:	xra	a		; Low byte is column
	sta	cursor
	ret
	
conbs:	lxi	h, cursor	; Point at cursor column
	dcr	m		; Backspace it
	rnc			; Too far?
	inr	m		; Undo
	ret
	
conlf:	lxi	h, cursor+1	; Newline and scroll
	inr	m		; High byte is line
	mov	a, m

scroll:	cmp	24
	rc
	dcr	m

	mvi	a, 0E0h
scrll:	push	a
	mov	d, a
	mvi	e, 0
	inr	a
	mov	h, a
	mvi	l, 0
	lxi	b, 80
	ldir
	pop	a
	inr	a
	cmp	0F7h
	jrnz	scrll
	
	xra	a		; Last line blanked
	lxi	h, 0F700h
	mvi	b, 80
endlin:	mov	m, a
	inx	h
	djnz	endlin
	ret
	
kbd:	push	af
	push	hl
	push	de
	
	ld	a, (inptr)	; input offset to buffer
	ld	e, a
	ld	d, 0
	ld	hl, buffer	; Buffer origin address
	add	hl, de		; Add the two
	inc	a		; Next address
	and	a, 31		; Modulo 32
	ld	(inptr), a
	
	in	a, (PORTA)	; Get the data
	ld	(hl), a		; Store it
	
	out	(0), a 		; Click
	
	pop	de
	pop	hl
	pop	af
	ei
	reti

cursor:	dw	0		; Address of cursor
inptr:	db	0		; input pointer to buffer
outptr:	db	0		; output pointer to buffer
buffer:	ds	32

	org	0x400
irqtab:	dw	kbd
	
	rept	(0x200 - $)
	db	0
	endm
	
cpm	equ	$



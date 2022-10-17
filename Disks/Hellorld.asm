0200:		C3 31 02 	jp 0x0231				; If zero flag is not set, jump to 0x0231 (Jumps too far?)

; "HELLORLD!" ASCII DATA
0203:		48 45 4C 4C 4F 52 4C 44 21 00

; PADDING ZEROS
020b ~ 02FF: 00

; MAIN ROUTINE
0230:		02			ld (bc),a				; Store A into memory pointed at by bc
0231:		31 00 02	ld sp,0x0200			; Load 0x0200 into sp
0234:		cd 56 02	call 0x0256				; Jump to video control/setup subroutine (0x0256)
0237:		01 03 02	ld bc,0x0203			; Load 0x0203 into bc
023a:		c5			push bc					; Push b and c onto stack
023b:		11 00 f6	ld de,0xf600			; Load 0xf600 into de
023e:		01 11 00	ld bc,0x0011			; Load 0x0011 into bc
0241:		cd 7d 02	call 0x027d				; Jump to unknown subroutine (0x027d)
0244:		01 14 02	ld bc,0x0214			; Load 0x0214 into bc
0247:		c5			push bc					; Push b and c onto stack	
0248:		11 00 f7	ld de,0xf700			; Load 0xf700 into de
024b:		01 1a 00	ld bc,0x001a			; Load 0x001a into bc
024e:		cd 7d 02	call 0x027d				; Jump to unknown subroutine (0x027d)
0251:		c3 51 02	jp 0x0251				; If zero flag is not set, jump to 0x0251 (I don't understand this one)
0254:		fb			ei						; Sets both interrupt flip-flops (allow maskable interrupts)
0255:		76			halt


; VIDEO CONTROL/SETUP SUBROUTINE
0256:		3e 80		ld a,0x80
0258:		d3 03		out (0x03),a			; Change upper bank to CRT Select (0x80 = D7 = 1 = CRT Select)
025a:		d3 4e		out (0x4e),a			; Start timing chain
025c:		d3 4a		out (0x4a),a			; VTAC reset
025e:		d3 4e		out (0x4e),a			; Start timing chain
0260:		3e 63		ld a,0x63
0262:		d3 40		out (0x40),a			; Load horizontal line count (0x63)
0264:		3e 26		ld a,0x26
0266:		d3 41		out (0x41),a			; Load sync width, delay, interface (0x26)
0268:		3e 55		ld a,0x55
026a:		d3 42		out (0x42),a			; Load scans/data row, char/data row (0x55)
026c:		3e d7		ld a,0xd7
026e:		d3 43		out (0x43),a			; Load skew bits, data rows/frame (0xd7)
0270:		3e 14		ld a,0x14
0272:		d3 44		out (0x44),a			; Load scan lines/fram (0x14)
0274:		3e 1f		ld a,0x1f
0276:		d3 45		out (0x45),a			; Load vertical data start (0x1f)
0278:		3e 17		ld a,0x17
027a:		d3 46		out (0x46),a			; Load last displayed data row (0x17)
027c:		c9			ret	 					; Return from subroutine (stack popped into PC)

; UNKNOWN SUBROUTINE (Routine that copies the ASCII to the screen?)
027d:		e1			pop hl					; Pop stack into hl
027e:		e3			ex (sp),hl				; Exchanges (SP) with L, and (SP+1) with H
027f:		78			ld a,b					; Load b into a (b should have 00 in it at this time)
0280:		b1			or c					; OR a with c (c should have 11 or 1a in it at this time)
0281:		28 02		jr z,0x0055				; If zero flag is set, d is added to pc
0283:		ed b0		ldir					; Transfers byte at location pointed by HL to location pointed by DE. HL, DE incremented, BC decremented, repeat if BC not zero
0285:		c9			ret						; Top of stack popped into pc


0x0000 c3 c8 c2                         jp 0xc2c8
0x0003 c3 83 c0                         jp 0xc083
0x0006 31 00 c0                         ld sp,0xc000
0x0009 cd 4c c0                         call 0xc04c
0x000c da 00 c0                         jp c,0xc000
0x000f 06 80                            ld b,0x80
0x0011 0e 00                            ld c,0x00
0x0013 16 10                            ld d,0x10
0x0015 1e 20                            ld e,0x20
0x0017 2e 00                            ld l,0x00
0x0019 26 00                            ld h,0x00
0x001b 3e 01                            ld a,0x01
0x001d cd 03 c0                         call 0xc003
0x0020 da 3d c0                         jp c,0xc03d
0x0023 06 00                            ld b,0x00
0x0025 ed 5b 00 11                      ld de,(0x1100)
0x0029 53                               ld d,e
0x002a 1e 20                            ld e,0x20
0x002c cd 03 c0                         call 0xc003
0x002f da 3d c0                         jp c,0xc03d
0x0032 21 01 01                         ld hl,0x0101
0x0035 1e 00                            ld e,0x00
0x0037 19                               add hl,de
0x0038 5e                               ld e,(hl)
0x0039 23                               inc hl
0x003a 56                               ld d,(hl)
0x003b eb                               ex de,hl
0x003c e9                               jp (hl)
0x003d db 0a                            in a,(0x0a)
0x003f cb 97                            res 2,a
0x0041 d3 0a                            out (0x0a),a
0x0043 01 00 00                         ld bc,0x0000
0x0046 cd 2c c2                         call 0xc22c
0x0049 c3 00 c0                         jp 0xc000
0x004c f3                               di
0x004d 3e ff                            ld a,0xff
0x004f d3 33                            out (0x33),a
0x0051 3e ff                            ld a,0xff
0x0053 d3 33                            out (0x33),a
0x0055 3e 07                            ld a,0x07
0x0057 d3 33                            out (0x33),a
0x0059 3e ff                            ld a,0xff
0x005b d3 31                            out (0x31),a
0x005d db 0a                            in a,(0x0a)
0x005f cb ef                            set 5,a
0x0061 d3 0a                            out (0x0a),a
0x0063 01 7b 02                         ld bc,0x027b
0x0066 cd 2c c2                         call 0xc22c
0x0069 db 0a                            in a,(0x0a)
0x006b cb af                            res 5,a
0x006d d3 0a                            out (0x0a),a
0x006f 01 ac 00                         ld bc,0x00ac
0x0072 cd 2c c2                         call 0xc22c
0x0075 21 00 bf                         ld hl,0xbf00
0x0078 36 00                            ld (hl),0x00
0x007a 06 03                            ld b,0x03
0x007c 21 13 c2                         ld hl,0xc213
0x007f cd 20 c2                         call 0xc220
0x0082 c9                               ret
0x0083 f3                               di
0x0084 dd e5                            push ix
0x0086 fd e5                            push iy
0x0088 d5                               push de
0x0089 c5                               push bc
0x008a e5                               push hl
0x008b fd 21 00 bf                      ld iy,0xbf00
0x008f dd 21 08 bf                      ld ix,0xbf08
0x0093 fd 72 03                         ld (iy+3),d
0x0096 fd 71 02                         ld (iy+2),c
0x0099 fd 73 04                         ld (iy+4),e
0x009c fd 75 01                         ld (iy+1),l
0x009f fd 70 05                         ld (iy+5),b
0x00a2 fd 77 06                         ld (iy+6),a
0x00a5 7c                               ld a,h
0x00a6 07                               rlca
0x00a7 07                               rlca
0x00a8 fd 77 07                         ld (iy+7),a
0x00ab fd cb 06 46                      bit 0,(iy+6)
0x00af db 0a                            in a,(0x0a)
0x00b1 20 08                            jr nz,0x00bb
0x00b3 cb 5f                            bit 3,a
0x00b5 20 12                            jr nz,0x00c9
0x00b7 cb df                            set 3,a
0x00b9 18 06                            jr 0x00c1
0x00bb cb 57                            bit 2,a
0x00bd 20 0a                            jr nz,0x00c9
0x00bf cb d7                            set 2,a
0x00c1 d3 0a                            out (0x0a),a
0x00c3 01 00 81                         ld bc,0x8100
0x00c6 cd 2c c2                         call 0xc22c
0x00c9 cd 54 c2                         call 0xc254
0x00cc da 10 c2                         jp c,0xc210
0x00cf fd cb 06 46                      bit 0,(iy+6)
0x00d3 20 0c                            jr nz,0x00e1
0x00d5 fd cb 00 46                      bit 0,(iy+0)
0x00d9 20 10                            jr nz,0x00eb
0x00db fd cb 00 c6                      set 0,(iy+0)
0x00df 18 11                            jr 0x00f2
0x00e1 fd cb 00 4e                      bit 1,(iy+0)
0x00e5 fd cb 00 ce                      set 1,(iy+0)
0x00e9 28 07                            jr z,0x00f2
0x00eb fd cb 05 7e                      bit 7,(iy+5)
0x00ef ca 42 c1                         jp z,0xc142
0x00f2 dd 36 00 07                      ld (ix+0),0x07
0x00f6 fd 7e 06                         ld a,(iy+6)
0x00f9 dd 77 01                         ld (ix+1),a
0x00fc 06 02                            ld b,0x02
0x00fe 21 08 bf                         ld hl,0xbf08
0x0101 cd 20 c2                         call 0xc220
0x0104 da 10 c2                         jp c,0xc210
0x0107 cd ae c2                         call 0xc2ae
0x010a 06 01                            ld b,0x01
0x010c 21 16 c2                         ld hl,0xc216
0x010f cd 20 c2                         call 0xc220
0x0112 da 10 c2                         jp c,0xc210
0x0115 06 02                            ld b,0x02
0x0117 cd 80 c2                         call 0xc280
0x011a da 10 c2                         jp c,0xc210
0x011d dd 7e 00                         ld a,(ix+0)
0x0120 e6 03                            and 0x03
0x0122 fd be 06                         cp (iy+6)
0x0125 c2 07 c1                         jp nz,0xc107
0x0128 3e c0                            ld a,0xc0
0x012a dd a6 00                         and (ix+0)
0x012d c2 10 c2                         jp nz,0xc210
0x0130 dd 7e 01                         ld a,(ix+1)
0x0133 b7                               or a
0x0134 c2 10 c2                         jp nz,0xc210
0x0137 fd cb 00 56                      bit 2,(iy+0)
0x013b fd cb 00 96                      res 2,(iy+0)
0x013f c2 10 c2                         jp nz,0xc210
0x0142 dd 36 00 0f                      ld (ix+0),0x0f
0x0146 fd 6e 01                         ld l,(iy+1)
0x0149 dd 75 02                         ld (ix+2),l
0x014c fd 7e 07                         ld a,(iy+7)
0x014f fd b6 06                         or (iy+6)
0x0152 dd 77 01                         ld (ix+1),a
0x0155 06 03                            ld b,0x03
0x0157 21 08 bf                         ld hl,0xbf08
0x015a cd 20 c2                         call 0xc220
0x015d da 10 c2                         jp c,0xc210
0x0160 cd ae c2                         call 0xc2ae
0x0163 06 01                            ld b,0x01
0x0165 21 16 c2                         ld hl,0xc216
0x0168 cd 20 c2                         call 0xc220
0x016b da 10 c2                         jp c,0xc210
0x016e 06 02                            ld b,0x02
0x0170 cd 80 c2                         call 0xc280
0x0173 da 10 c2                         jp c,0xc210
0x0176 dd 7e 00                         ld a,(ix+0)
0x0179 e6 03                            and 0x03
0x017b fd be 06                         cp (iy+6)
0x017e c2 60 c1                         jp nz,0xc160
0x0181 3e c0                            ld a,0xc0
0x0183 dd a6 00                         and (ix+0)
0x0186 c2 10 c2                         jp nz,0xc210
0x0189 fd 7e 01                         ld a,(iy+1)
0x018c dd be 01                         cp (ix+1)
0x018f c2 10 c2                         jp nz,0xc210
0x0192 fd cb 00 56                      bit 2,(iy+0)
0x0196 fd cb 00 96                      res 2,(iy+0)
0x019a c2 10 c2                         jp nz,0xc210
0x019d 01 09 00                         ld bc,0x0009
0x01a0 11 08 bf                         ld de,0xbf08
0x01a3 21 17 c2                         ld hl,0xc217
0x01a6 ed b0                            ldir
0x01a8 fd 7e 07                         ld a,(iy+7)
0x01ab 0f                               rrca
0x01ac 0f                               rrca
0x01ad dd 77 03                         ld (ix+3),a
0x01b0 fd 7e 07                         ld a,(iy+7)
0x01b3 fd b6 06                         or (iy+6)
0x01b6 dd 77 01                         ld (ix+1),a
0x01b9 fd 6e 01                         ld l,(iy+1)
0x01bc fd 66 02                         ld h,(iy+2)
0x01bf 24                               inc h
0x01c0 dd 75 02                         ld (ix+2),l
0x01c3 dd 74 04                         ld (ix+4),h
0x01c6 06 09                            ld b,0x09
0x01c8 21 08 bf                         ld hl,0xbf08
0x01cb cd 20 c2                         call 0xc220
0x01ce da 10 c2                         jp c,0xc210
0x01d1 fd 46 04                         ld b,(iy+4)
0x01d4 fd 66 03                         ld h,(iy+3)
0x01d7 2e 00                            ld l,0x00
0x01d9 0e 0b                            ld c,0x0b
0x01db c5                               push bc
0x01dc 06 00                            ld b,0x00
0x01de db 31                            in a,(0x31)
0x01e0 87                               add a,a
0x01e1 38 10                            jr c,0x01f3
0x01e3 f2 de c1                         jp p,0xc1de
0x01e6 ed a2                            ini
0x01e8 c2 de c1                         jp nz,0xc1de
0x01eb c1                               pop bc
0x01ec 10 ed                            djnz 0x01db
0x01ee cd a3 c2                         call 0xc2a3
0x01f1 18 01                            jr 0x01f4
0x01f3 c1                               pop bc
0x01f4 06 07                            ld b,0x07
0x01f6 cd 80 c2                         call 0xc280
0x01f9 da 10 c2                         jp c,0xc210
0x01fc 3e c0                            ld a,0xc0
0x01fe dd a6 00                         and (ix+0)
0x0201 c2 10 c2                         jp nz,0xc210
0x0204 af                               xor a
0x0205 fd 7e 06                         ld a,(iy+6)
0x0208 e1                               pop hl
0x0209 c1                               pop bc
0x020a d1                               pop de
0x020b fd e1                            pop iy
0x020d dd e1                            pop ix
0x020f c9                               ret
0x0210 37                               scf
0x0211 18 f2                            jr 0x0205
0x0213 03                               inc bc
0x0214 bf                               cp a
0x0215 10 08                            djnz 0x021f
0x0217 e6 00                            and 0x00
0x0219 00                               nop
0x021a 00                               nop
0x021b 00                               nop
0x021c 01 10 14                         ld bc,0x1410
0x021f ff                               rst 0x38
0x0220 cd 37 c2                         call 0xc237
0x0223 d8                               ret c
0x0224 7e                               ld a,(hl)
0x0225 d3 0b                            out (0x0b),a
0x0227 23                               inc hl
0x0228 10 f6                            djnz 0x0220
0x022a bf                               cp a
0x022b c9                               ret
0x022c e5                               push hl
0x022d 2a 00 00                         ld hl,(0x0000)
0x0230 e1                               pop hl
0x0231 0b                               dec bc
0x0232 78                               ld a,b
0x0233 b1                               or c
0x0234 20 f6                            jr nz,0x022c
0x0236 c9                               ret
0x0237 d5                               push de
0x0238 11 00 00                         ld de,0x0000
0x023b db 0c                            in a,(0x0c)
0x023d cb 7f                            bit 7,a
0x023f c2 4c c2                         jp nz,0xc24c
0x0242 1b                               dec de
0x0243 7a                               ld a,d
0x0244 b3                               or e
0x0245 c2 3b c2                         jp nz,0xc23b
0x0248 d1                               pop de
0x0249 c3 a1 c2                         jp 0xc2a1
0x024c d1                               pop de
0x024d cb 77                            bit 6,a
0x024f c2 a1 c2                         jp nz,0xc2a1
0x0252 bf                               cp a
0x0253 c9                               ret
0x0254 dd 36 00 4a                      ld (ix+0),0x4a
0x0258 fd 7e 07                         ld a,(iy+7)
0x025b fd b6 06                         or (iy+6)
0x025e dd 77 01                         ld (ix+1),a
0x0261 06 02                            ld b,0x02
0x0263 21 08 bf                         ld hl,0xbf08
0x0266 cd 20 c2                         call 0xc220
0x0269 d8                               ret c
0x026a cd ae c2                         call 0xc2ae
0x026d 06 07                            ld b,0x07
0x026f cd 80 c2                         call 0xc280
0x0272 d8                               ret c
0x0273 fd cb 00 56                      bit 2,(iy+0)
0x0277 fd cb 00 96                      res 2,(iy+0)
0x027b c2 a1 c2                         jp nz,0xc2a1
0x027e af                               xor a
0x027f c9                               ret
0x0280 21 08 bf                         ld hl,0xbf08
0x0283 0e 0b                            ld c,0x0b
0x0285 11 00 00                         ld de,0x0000
0x0288 db 0c                            in a,(0x0c)
0x028a cb 7f                            bit 7,a
0x028c 20 08                            jr nz,0x0296
0x028e 1b                               dec de
0x028f 7a                               ld a,d
0x0290 b3                               or e
0x0291 20 f5                            jr nz,0x0288
0x0293 c3 a1 c2                         jp 0xc2a1
0x0296 cb 77                            bit 6,a
0x0298 ca a1 c2                         jp z,0xc2a1
0x029b ed a2                            ini
0x029d 20 e9                            jr nz,0x0288
0x029f bf                               cp a
0x02a0 c9                               ret
0x02a1 37                               scf
0x02a2 c9                               ret
0x02a3 db 0a                            in a,(0x0a)
0x02a5 cb e7                            set 4,a
0x02a7 d3 0a                            out (0x0a),a
0x02a9 cb a7                            res 4,a
0x02ab d3 0a                            out (0x0a),a
0x02ad c9                               ret
0x02ae 01 00 00                         ld bc,0x0000
0x02b1 db 31                            in a,(0x31)
0x02b3 cb 7f                            bit 7,a
0x02b5 c0                               ret nz
0x02b6 0b                               dec bc
0x02b7 78                               ld a,b
0x02b8 b1                               or c
0x02b9 f5                               push af
0x02ba f5                               push af
0x02bb f1                               pop af
0x02bc f1                               pop af
0x02bd c2 b1 c2                         jp nz,0xc2b1
0x02c0 cd a3 c2                         call 0xc2a3
0x02c3 fd cb 00 d6                      set 2,(iy+0)
0x02c7 c9                               ret
0x02c8 f3                               di
0x02c9 ed 5e                            im 2
0x02cb 3e 86                            ld a,0x86
0x02cd d3 5f                            out (0x5f),a
0x02cf ed 57                            ld a,i
0x02d1 20 fe                            jr nz,0x02d1
0x02d3 af                               xor a
0x02d4 d3 5f                            out (0x5f),a
0x02d6 31 00 c0                         ld sp,0xc000
0x02d9 af                               xor a
0x02da d3 06                            out (0x06),a
0x02dc 3e 03                            ld a,0x03
0x02de d3 20                            out (0x20),a
0x02e0 d3 21                            out (0x21),a
0x02e2 d3 22                            out (0x22),a
0x02e4 d3 23                            out (0x23),a
0x02e6 3e 07                            ld a,0x07
0x02e8 d3 32                            out (0x32),a
0x02ea d3 33                            out (0x33),a
0x02ec d3 52                            out (0x52),a
0x02ee d3 53                            out (0x53),a
0x02f0 21 c4 c6                         ld hl,0xc6c4
0x02f3 7d                               ld a,l
0x02f4 d3 32                            out (0x32),a
0x02f6 7c                               ld a,h
0x02f7 ed 47                            ld i,a
0x02f9 3e 4f                            ld a,0x4f
0x02fb d3 32                            out (0x32),a
0x02fd 3e 87                            ld a,0x87
0x02ff d3 32                            out (0x32),a
0x0301 db 30                            in a,(0x30)
0x0303 af                               xor a
0x0304 d3 33                            out (0x33),a
0x0306 3e ff                            ld a,0xff
0x0308 d3 33                            out (0x33),a
0x030a 3e c1                            ld a,0xc1
0x030c d3 33                            out (0x33),a
0x030e d3 4e                            out (0x4e),a
0x0310 d3 4a                            out (0x4a),a
0x0312 d3 4e                            out (0x4e),a
0x0314 3e 63                            ld a,0x63
0x0316 d3 40                            out (0x40),a
0x0318 3e 26                            ld a,0x26
0x031a d3 41                            out (0x41),a
0x031c 3e 55                            ld a,0x55
0x031e d3 42                            out (0x42),a
0x0320 3e d7                            ld a,0xd7
0x0322 d3 43                            out (0x43),a
0x0324 3e 14                            ld a,0x14
0x0326 d3 44                            out (0x44),a
0x0328 3e 1f                            ld a,0x1f
0x032a d3 45                            out (0x45),a
0x032c 3e 17                            ld a,0x17
0x032e d3 46                            out (0x46),a
0x0330 af                               xor a
0x0331 d3 31                            out (0x31),a
0x0333 5f                               ld e,a
0x0334 fb                               ei
0x0335 26 02                            ld h,0x02
0x0337 0e 00                            ld c,0x00
0x0339 06 c8                            ld b,0xc8
0x033b 10 fe                            djnz 0x033b
0x033d 10 fe                            djnz 0x033d
0x033f 10 fe                            djnz 0x033f
0x0341 10 fe                            djnz 0x0341
0x0343 10 fe                            djnz 0x0343
0x0345 0d                               dec c
0x0346 20 f1                            jr nz,0x0339
0x0348 25                               dec h
0x0349 c2 39 c3                         jp nz,0xc339
0x034c fe 12                            cp 0x12
0x034e c2 76 c3                         jp nz,0xc376
0x0351 af                               xor a
0x0352 fb                               ei
0x0353 26 02                            ld h,0x02
0x0355 0e 00                            ld c,0x00
0x0357 06 c8                            ld b,0xc8
0x0359 10 fe                            djnz 0x0359
0x035b 10 fe                            djnz 0x035b
0x035d 10 fe                            djnz 0x035d
0x035f 10 fe                            djnz 0x035f
0x0361 10 fe                            djnz 0x0361
0x0363 0d                               dec c
0x0364 20 f1                            jr nz,0x0357
0x0366 25                               dec h
0x0367 20 ee                            jr nz,0x0357
0x0369 31 00 c0                         ld sp,0xc000
0x036c fe 7e                            cp 0x7e
0x036e ca e5 c5                         jp z,0xc5e5
0x0371 fe 7d                            cp 0x7d
0x0373 ca 06 c0                         jp z,0xc006
0x0376 f3                               di
0x0377 31 00 c0                         ld sp,0xc000
0x037a af                               xor a
0x037b d3 32                            out (0x32),a
0x037d ed 47                            ld i,a
0x037f 3e 4f                            ld a,0x4f
0x0381 d3 32                            out (0x32),a
0x0383 3e 87                            ld a,0x87
0x0385 d3 32                            out (0x32),a
0x0387 db 30                            in a,(0x30)
0x0389 3e 8d                            ld a,0x8d
0x038b d3 5f                            out (0x5f),a
0x038d 06 08                            ld b,0x08
0x038f 21 00 c0                         ld hl,0xc000
0x0392 3e ff                            ld a,0xff
0x0394 07                               rlca
0x0395 30 02                            jr nc,0x0399
0x0397 ee 08                            xor 0x08
0x0399 ae                               xor (hl)
0x039a 2c                               inc l
0x039b 20 f7                            jr nz,0x0394
0x039d 24                               inc h
0x039e 10 f4                            djnz 0x0394
0x03a0 a7                               and a
0x03a1 20 fe                            jr nz,0x03a1
0x03a3 3e c0                            ld a,0xc0
0x03a5 d3 5f                            out (0x5f),a
0x03a7 db 0a                            in a,(0x0a)
0x03a9 cb ef                            set 5,a
0x03ab d3 0a                            out (0x0a),a
0x03ad 06 00                            ld b,0x00
0x03af 10 02                            djnz 0x03b3
0x03b1 06 30                            ld b,0x30
0x03b3 10 fe                            djnz 0x03b3
0x03b5 db 0a                            in a,(0x0a)
0x03b7 cb af                            res 5,a
0x03b9 d3 0a                            out (0x0a),a
0x03bb db 31                            in a,(0x31)
0x03bd cb 7f                            bit 7,a
0x03bf 28 fa                            jr z,0x03bb
0x03c1 db 0c                            in a,(0x0c)
0x03c3 fe 80                            cp 0x80
0x03c5 20 fe                            jr nz,0x03c5
0x03c7 3e a0                            ld a,0xa0
0x03c9 d3 5f                            out (0x5f),a
0x03cb 16 4c                            ld d,0x4c
0x03cd 1e 49                            ld e,0x49
0x03cf 06 00                            ld b,0x00
0x03d1 4a                               ld c,d
0x03d2 78                               ld a,b
0x03d3 ed 79                            out (c),a
0x03d5 4b                               ld c,e
0x03d6 ed 78                            in a,(c)
0x03d8 b8                               cp b
0x03d9 20 fe                            jr nz,0x03d9
0x03db 04                               inc b
0x03dc 20 f3                            jr nz,0x03d1
0x03de 3e af                            ld a,0xaf
0x03e0 d3 5f                            out (0x5f),a
0x03e2 db 07                            in a,(0x07)
0x03e4 e6 03                            and 0x03
0x03e6 57                               ld d,a
0x03e7 47                               ld b,a
0x03e8 1e 7f                            ld e,0x7f
0x03ea d3 05                            out (0x05),a
0x03ec 21 ff bf                         ld hl,0xbfff
0x03ef 3e aa                            ld a,0xaa
0x03f1 77                               ld (hl),a
0x03f2 2b                               dec hl
0x03f3 7c                               ld a,h
0x03f4 bb                               cp e
0x03f5 20 f8                            jr nz,0x03ef
0x03f7 7b                               ld a,e
0x03f8 fe ff                            cp 0xff
0x03fa 28 0a                            jr z,0x0406
0x03fc 05                               dec b
0x03fd 78                               ld a,b
0x03fe fe 00                            cp 0x00
0x0400 20 e8                            jr nz,0x03ea
0x0402 1e ff                            ld e,0xff
0x0404 18 e4                            jr 0x03ea
0x0406 af                               xor a
0x0407 47                               ld b,a
0x0408 10 fe                            djnz 0x0408
0x040a 3c                               inc a
0x040b 20 fa                            jr nz,0x0407
0x040d 1e 7f                            ld e,0x7f
0x040f 42                               ld b,d
0x0410 78                               ld a,b
0x0411 d3 05                            out (0x05),a
0x0413 21 ff bf                         ld hl,0xbfff
0x0416 3e aa                            ld a,0xaa
0x0418 4e                               ld c,(hl)
0x0419 b9                               cp c
0x041a 20 1c                            jr nz,0x0438
0x041c cb 06                            rlc (hl)
0x041e 4e                               ld c,(hl)
0x041f 3e 55                            ld a,0x55
0x0421 b9                               cp c
0x0422 20 14                            jr nz,0x0438
0x0424 2b                               dec hl
0x0425 7c                               ld a,h
0x0426 bb                               cp e
0x0427 20 ed                            jr nz,0x0416
0x0429 7b                               ld a,e
0x042a fe ff                            cp 0xff
0x042c 28 24                            jr z,0x0452
0x042e 05                               dec b
0x042f 78                               ld a,b
0x0430 fe 00                            cp 0x00
0x0432 20 dd                            jr nz,0x0411
0x0434 1e ff                            ld e,0xff
0x0436 18 d9                            jr 0x0411
0x0438 5f                               ld e,a
0x0439 78                               ld a,b
0x043a ba                               cp d
0x043b 28 fb                            jr z,0x0438
0x043d 7a                               ld a,d
0x043e d3 05                            out (0x05),a
0x0440 7b                               ld a,e
0x0441 c5                               push bc
0x0442 f5                               push af
0x0443 e5                               push hl
0x0444 11 00 80                         ld de,0x8000
0x0447 21 c6 c6                         ld hl,0xc6c6
0x044a 01 b5 00                         ld bc,0x00b5
0x044d ed b0                            ldir
0x044f c3 00 80                         jp 0x8000
0x0452 3e 92                            ld a,0x92
0x0454 d3 5f                            out (0x5f),a
0x0456 11 00 00                         ld de,0x0000
0x0459 21 64 c4                         ld hl,0xc464
0x045c 01 50 00                         ld bc,0x0050
0x045f ed b0                            ldir
0x0461 c3 00 00                         jp 0x0000
0x0464 3e 80                            ld a,0x80
0x0466 d3 03                            out (0x03),a
0x0468 21 00 c0                         ld hl,0xc000
0x046b 3e ff                            ld a,0xff
0x046d 77                               ld (hl),a
0x046e 23                               inc hl
0x046f 7d                               ld a,l
0x0470 fe 50                            cp 0x50
0x0472 20 f7                            jr nz,0x046b
0x0474 2e 00                            ld l,0x00
0x0476 24                               inc h
0x0477 7c                               ld a,h
0x0478 fe d8                            cp 0xd8
0x047a 38 ef                            jr c,0x046b
0x047c fe e0                            cp 0xe0
0x047e 30 02                            jr nc,0x0482
0x0480 26 e0                            ld h,0xe0
0x0482 fe f8                            cp 0xf8
0x0484 38 e5                            jr c,0x046b
0x0486 21 00 c0                         ld hl,0xc000
0x0489 3e ff                            ld a,0xff
0x048b 4e                               ld c,(hl)
0x048c b9                               cp c
0x048d 20 fe                            jr nz,0x048d
0x048f 34                               inc (hl)
0x0490 4e                               ld c,(hl)
0x0491 af                               xor a
0x0492 b9                               cp c
0x0493 20 fe                            jr nz,0x0493
0x0495 23                               inc hl
0x0496 7d                               ld a,l
0x0497 fe 50                            cp 0x50
0x0499 20 ee                            jr nz,0x0489
0x049b 2e 00                            ld l,0x00
0x049d 24                               inc h
0x049e 7c                               ld a,h
0x049f fe d8                            cp 0xd8
0x04a1 38 e6                            jr c,0x0489
0x04a3 fe e0                            cp 0xe0
0x04a5 30 02                            jr nc,0x04a9
0x04a7 26 e0                            ld h,0xe0
0x04a9 fe f8                            cp 0xf8
0x04ab 38 dc                            jr c,0x0489
0x04ad af                               xor a
0x04ae d3 03                            out (0x03),a
0x04b0 c3 b3 c4                         jp 0xc4b3
0x04b3 3e ae                            ld a,0xae
0x04b5 d3 5f                            out (0x5f),a
0x04b7 cd cd c5                         call 0xc5cd
0x04ba cd cd c5                         call 0xc5cd
0x04bd 21 a8 c5                         ld hl,0xc5a8
0x04c0 22 00 00                         ld (0x0000),hl
0x04c3 06 00                            ld b,0x00
0x04c5 ed 5e                            im 2
0x04c7 fb                               ei
0x04c8 d3 31                            out (0x31),a
0x04ca 3e 02                            ld a,0x02
0x04cc d3 31                            out (0x31),a
0x04ce 3e ff                            ld a,0xff
0x04d0 3d                               dec a
0x04d1 20 fd                            jr nz,0x04d0
0x04d3 af                               xor a
0x04d4 d3 31                            out (0x31),a
0x04d6 af                               xor a
0x04d7 b8                               cp b
0x04d8 28 fc                            jr z,0x04d6
0x04da f3                               di
0x04db 3e 02                            ld a,0x02
0x04dd d3 31                            out (0x31),a
0x04df 3e d0                            ld a,0xd0
0x04e1 d3 5f                            out (0x5f),a
0x04e3 3e ff                            ld a,0xff
0x04e5 d3 53                            out (0x53),a
0x04e7 d3 53                            out (0x53),a
0x04e9 3e 07                            ld a,0x07
0x04eb d3 53                            out (0x53),a
0x04ed db 51                            in a,(0x51)
0x04ef cb 7f                            bit 7,a
0x04f1 20 fe                            jr nz,0x04f1
0x04f3 3e 20                            ld a,0x20
0x04f5 d3 5c                            out (0x5c),a
0x04f7 db 51                            in a,(0x51)
0x04f9 cb 7f                            bit 7,a
0x04fb 28 fe                            jr z,0x04fb
0x04fd af                               xor a
0x04fe d3 5c                            out (0x5c),a
0x0500 3e 8c                            ld a,0x8c
0x0502 d3 5f                            out (0x5f),a
0x0504 af                               xor a
0x0505 d3 06                            out (0x06),a
0x0507 3e 03                            ld a,0x03
0x0509 d3 20                            out (0x20),a
0x050b d3 21                            out (0x21),a
0x050d d3 22                            out (0x22),a
0x050f d3 23                            out (0x23),a
0x0511 3e 07                            ld a,0x07
0x0513 d3 32                            out (0x32),a
0x0515 d3 33                            out (0x33),a
0x0517 d3 52                            out (0x52),a
0x0519 d3 53                            out (0x53),a
0x051b ed 5e                            im 2
0x051d 21 a8 c5                         ld hl,0xc5a8
0x0520 22 00 00                         ld (0x0000),hl
0x0523 22 02 00                         ld (0x0002),hl
0x0526 22 04 00                         ld (0x0004),hl
0x0529 22 06 00                         ld (0x0006),hl
0x052c af                               xor a
0x052d ed 47                            ld i,a
0x052f 47                               ld b,a
0x0530 3e 00                            ld a,0x00
0x0532 d3 20                            out (0x20),a
0x0534 3e 97                            ld a,0x97
0x0536 d3 23                            out (0x23),a
0x0538 d3 22                            out (0x22),a
0x053a d3 21                            out (0x21),a
0x053c d3 20                            out (0x20),a
0x053e 3e 9c                            ld a,0x9c
0x0540 d3 23                            out (0x23),a
0x0542 d3 22                            out (0x22),a
0x0544 d3 21                            out (0x21),a
0x0546 d3 20                            out (0x20),a
0x0548 fb                               ei
0x0549 1e 38                            ld e,0x38
0x054b 16 ff                            ld d,0xff
0x054d 15                               dec d
0x054e 20 fd                            jr nz,0x054d
0x0550 1d                               dec e
0x0551 20 fa                            jr nz,0x054d
0x0553 3e 03                            ld a,0x03
0x0555 f3                               di
0x0556 d3 20                            out (0x20),a
0x0558 d3 21                            out (0x21),a
0x055a d3 22                            out (0x22),a
0x055c d3 23                            out (0x23),a
0x055e 78                               ld a,b
0x055f fe 44                            cp 0x44
0x0561 20 fe                            jr nz,0x0561
0x0563 3e 88                            ld a,0x88
0x0565 d3 5f                            out (0x5f),a
0x0567 cd 4c c0                         call 0xc04c
0x056a 06 80                            ld b,0x80
0x056c 0e 00                            ld c,0x00
0x056e 16 00                            ld d,0x00
0x0570 1e 01                            ld e,0x01
0x0572 26 00                            ld h,0x00
0x0574 2e 06                            ld l,0x06
0x0576 3e 01                            ld a,0x01
0x0578 cd 03 c0                         call 0xc003
0x057b 30 08                            jr nc,0x0585
0x057d 2e 06                            ld l,0x06
0x057f cd 71 c6                         call 0xc671
0x0582 c3 63 c5                         jp 0xc563
0x0585 2e 00                            ld l,0x00
0x0587 3e 01                            ld a,0x01
0x0589 ac                               xor h
0x058a 67                               ld h,a
0x058b 3e 01                            ld a,0x01
0x058d cd 03 c0                         call 0xc003
0x0590 38 f5                            jr c,0x0587
0x0592 af                               xor a
0x0593 b5                               or l
0x0594 20 01                            jr nz,0x0597
0x0596 37                               scf
0x0597 cb 15                            rl l
0x0599 cb 75                            bit 6,l
0x059b 28 ea                            jr z,0x0587
0x059d 3e d8                            ld a,0xd8
0x059f d3 5f                            out (0x5f),a
0x05a1 3e ff                            ld a,0xff
0x05a3 ed 47                            ld i,a
0x05a5 c3 06 c0                         jp 0xc006
0x05a8 fb                               ei
0x05a9 00                               nop
0x05aa 00                               nop
0x05ab 00                               nop
0x05ac 00                               nop
0x05ad 04                               inc b
0x05ae ed 4d                            reti
0x05b0 db 30                            in a,(0x30)
0x05b2 57                               ld d,a
0x05b3 31 c7 c5                         ld sp,0xc5c7
0x05b6 7b                               ld a,e
0x05b7 fe ff                            cp 0xff
0x05b9 7a                               ld a,d
0x05ba ca c2 c5                         jp z,0xc5c2
0x05bd 1e ff                            ld e,0xff
0x05bf 31 c5 c5                         ld sp,0xc5c5
0x05c2 00                               nop
0x05c3 ed 4d                            reti
0x05c5 4c                               ld c,h
0x05c6 c3 69 c3                         jp 0xc369
0x05c9 db 30                            in a,(0x30)
0x05cb ed 4d                            reti
0x05cd 0e 0a                            ld c,0x0a
0x05cf 06 00                            ld b,0x00
0x05d1 10 fe                            djnz 0x05d1
0x05d3 06 30                            ld b,0x30
0x05d5 10 fe                            djnz 0x05d5
0x05d7 0d                               dec c
0x05d8 20 f7                            jr nz,0x05d1
0x05da c9                               ret
0x05db 06 00                            ld b,0x00
0x05dd 10 fe                            djnz 0x05dd
0x05df 06 30                            ld b,0x30
0x05e1 10 fe                            djnz 0x05e1
0x05e3 00                               nop
0x05e4 c9                               ret
0x05e5 db 0a                            in a,(0x0a)
0x05e7 cb d7                            set 2,a
0x05e9 d3 0a                            out (0x0a),a
0x05eb 3e f0                            ld a,0xf0
0x05ed d3 5f                            out (0x5f),a
0x05ef cd 4c c0                         call 0xc04c
0x05f2 f3                               di
0x05f3 af                               xor a
0x05f4 d3 32                            out (0x32),a
0x05f6 ed 47                            ld i,a
0x05f8 3e 4f                            ld a,0x4f
0x05fa d3 32                            out (0x32),a
0x05fc 3e 87                            ld a,0x87
0x05fe d3 32                            out (0x32),a
0x0600 db 30                            in a,(0x30)
0x0602 af                               xor a
0x0603 d3 33                            out (0x33),a
0x0605 3e ff                            ld a,0xff
0x0607 d3 33                            out (0x33),a
0x0609 3e c1                            ld a,0xc1
0x060b d3 33                            out (0x33),a
0x060d af                               xor a
0x060e d3 31                            out (0x31),a
0x0610 21 c9 c5                         ld hl,0xc5c9
0x0613 22 00 00                         ld (0x0000),hl
0x0616 ed 5e                            im 2
0x0618 fb                               ei
0x0619 af                               xor a
0x061a fe 00                            cp 0x00
0x061c 28 fc                            jr z,0x061a
0x061e 2e 00                            ld l,0x00
0x0620 fe 65                            cp 0x65
0x0622 28 27                            jr z,0x064b
0x0624 2e 01                            ld l,0x01
0x0626 fe 6e                            cp 0x6e
0x0628 28 21                            jr z,0x064b
0x062a 2e 02                            ld l,0x02
0x062c fe 6d                            cp 0x6d
0x062e 28 1b                            jr z,0x064b
0x0630 2e 03                            ld l,0x03
0x0632 fe 6c                            cp 0x6c
0x0634 28 15                            jr z,0x064b
0x0636 2e 10                            ld l,0x10
0x0638 fe 6b                            cp 0x6b
0x063a 28 0f                            jr z,0x064b
0x063c 2e 20                            ld l,0x20
0x063e fe 6a                            cp 0x6a
0x0640 28 09                            jr z,0x064b
0x0642 2e 27                            ld l,0x27
0x0644 fe 69                            cp 0x69
0x0646 28 03                            jr z,0x064b
0x0648 c3 18 c6                         jp 0xc618
0x064b cd 54 c6                         call 0xc654
0x064e cd 71 c6                         call 0xc671
0x0651 c3 18 c6                         jp 0xc618
0x0654 3e 07                            ld a,0x07
0x0656 cd 94 c6                         call 0xc694
0x0659 d3 0b                            out (0x0b),a
0x065b 3e 01                            ld a,0x01
0x065d cd 94 c6                         call 0xc694
0x0660 d3 0b                            out (0x0b),a
0x0662 db 31                            in a,(0x31)
0x0664 cb 7f                            bit 7,a
0x0666 20 05                            jr nz,0x066d
0x0668 cd cd c5                         call 0xc5cd
0x066b 18 f5                            jr 0x0662
0x066d cd b2 c6                         call 0xc6b2
0x0670 c9                               ret
0x0671 3e 0f                            ld a,0x0f
0x0673 cd 94 c6                         call 0xc694
0x0676 d3 0b                            out (0x0b),a
0x0678 3e 01                            ld a,0x01
0x067a cd 94 c6                         call 0xc694
0x067d d3 0b                            out (0x0b),a
0x067f 7d                               ld a,l
0x0680 cd 94 c6                         call 0xc694
0x0683 d3 0b                            out (0x0b),a
0x0685 db 31                            in a,(0x31)
0x0687 cb 7f                            bit 7,a
0x0689 20 05                            jr nz,0x0690
0x068b cd cd c5                         call 0xc5cd
0x068e 18 f5                            jr 0x0685
0x0690 cd b2 c6                         call 0xc6b2
0x0693 c9                               ret
0x0694 f5                               push af
0x0695 c5                               push bc
0x0696 db 0c                            in a,(0x0c)
0x0698 cb 7f                            bit 7,a
0x069a 28 fa                            jr z,0x0696
0x069c cb 77                            bit 6,a
0x069e 20 fc                            jr nz,0x069c
0x06a0 c1                               pop bc
0x06a1 f1                               pop af
0x06a2 c9                               ret
0x06a3 f5                               push af
0x06a4 c5                               push bc
0x06a5 db 0c                            in a,(0x0c)
0x06a7 cb 7f                            bit 7,a
0x06a9 28 fa                            jr z,0x06a5
0x06ab cb 77                            bit 6,a
0x06ad 28 fc                            jr z,0x06ab
0x06af c1                               pop bc
0x06b0 f1                               pop af
0x06b1 c9                               ret
0x06b2 3e 08                            ld a,0x08
0x06b4 cd 94 c6                         call 0xc694
0x06b7 d3 0b                            out (0x0b),a
0x06b9 cd a3 c6                         call 0xc6a3
0x06bc db 0b                            in a,(0x0b)
0x06be cd a3 c6                         call 0xc6a3
0x06c1 db 0b                            in a,(0x0b)
0x06c3 c9                               ret
0x06c4 b0                               or b
0x06c5 c5                               push bc
0x06c6 3e 80                            ld a,0x80
0x06c8 d3 03                            out (0x03),a
0x06ca 21 00 c0                         ld hl,0xc000
0x06cd af                               xor a
0x06ce 77                               ld (hl),a
0x06cf 23                               inc hl
0x06d0 bc                               cp h
0x06d1 20 fb                            jr nz,0x06ce
0x06d3 21 68 80                         ld hl,0x8068
0x06d6 11 00 f2                         ld de,0xf200
0x06d9 7e                               ld a,(hl)
0x06da fe 03                            cp 0x03
0x06dc 28 0f                            jr z,0x06ed
0x06de fe 0d                            cp 0x0d
0x06e0 20 06                            jr nz,0x06e8
0x06e2 23                               inc hl
0x06e3 14                               inc d
0x06e4 1e 00                            ld e,0x00
0x06e6 18 f1                            jr 0x06d9
0x06e8 12                               ld (de),a
0x06e9 23                               inc hl
0x06ea 13                               inc de
0x06eb 18 ec                            jr 0x06d9
0x06ed d1                               pop de
0x06ee 7a                               ld a,d
0x06ef 21 10 f2                         ld hl,0xf210
0x06f2 cd 54 80                         call 0x8054
0x06f5 7b                               ld a,e
0x06f6 cd 54 80                         call 0x8054
0x06f9 f1                               pop af
0x06fa f5                               push af
0x06fb 21 10 f3                         ld hl,0xf310
0x06fe cd 54 80                         call 0x8054
0x0701 f1                               pop af
0x0702 c1                               pop bc
0x0703 a9                               xor c
0x0704 21 10 f5                         ld hl,0xf510
0x0707 cd 54 80                         call 0x8054
0x070a 79                               ld a,c
0x070b 21 10 f4                         ld hl,0xf410
0x070e cd 54 80                         call 0x8054
0x0711 78                               ld a,b
0x0712 21 1c f2                         ld hl,0xf21c
0x0715 cd 54 80                         call 0x8054
0x0718 18 fe                            jr 0x0718
0x071a f5                               push af
0x071b 0f                               rrca
0x071c 0f                               rrca
0x071d 0f                               rrca
0x071e 0f                               rrca
0x071f cd 5d 80                         call 0x805d
0x0722 f1                               pop af
0x0723 e6 0f                            and 0x0f
0x0725 c6 90                            add a,0x90
0x0727 27                               daa
0x0728 ce 40                            adc a,0x40
0x072a 27                               daa
0x072b 77                               ld (hl),a
0x072c 23                               inc hl
0x072d c9                               ret
0x072e 4d                               ld c,l
0x072f 65                               ld h,l
0x0730 6d                               ld l,l
0x0731 6f                               ld l,a
0x0732 72                               ld (hl),d
0x0733 79                               ld a,c
0x0734 20 45                            jr nz,0x077b
0x0736 72                               ld (hl),d
0x0737 72                               ld (hl),d
0x0738 6f                               ld l,a
0x0739 72                               ld (hl),d
0x073a 20 61                            jr nz,0x079d
0x073c 74                               ld (hl),h
0x073d 20 20                            jr nz,0x075f
0x073f 20 20                            jr nz,0x0761
0x0741 20 20                            jr nz,0x0763
0x0743 70                               ld (hl),b
0x0744 61                               ld h,c
0x0745 67                               ld h,a
0x0746 65                               ld h,l
0x0747 0d                               dec c
0x0748 45                               ld b,l
0x0749 78                               ld a,b
0x074a 70                               ld (hl),b
0x074b 65                               ld h,l
0x074c 63                               ld h,e
0x074d 74                               ld (hl),h
0x074e 65                               ld h,l
0x074f 64                               ld h,h
0x0750 20 64                            jr nz,0x07b6
0x0752 61                               ld h,c
0x0753 74                               ld (hl),h
0x0754 61                               ld h,c
0x0755 20 3d                            jr nz,0x0794
0x0757 0d                               dec c
0x0758 52                               ld d,d
0x0759 65                               ld h,l
0x075a 63                               ld h,e
0x075b 65                               ld h,l
0x075c 69                               ld l,c
0x075d 76                               halt
0x075e 65                               ld h,l
0x075f 64                               ld h,h
0x0760 20 64                            jr nz,0x07c6
0x0762 61                               ld h,c
0x0763 74                               ld (hl),h
0x0764 61                               ld h,c
0x0765 20 3d                            jr nz,0x07a4
0x0767 0d                               dec c
0x0768 58                               ld e,b
0x0769 4f                               ld c,a
0x076a 52                               ld d,d
0x076b 20 64                            jr nz,0x07d1
0x076d 61                               ld h,c
0x076e 74                               ld (hl),h
0x076f 61                               ld h,c
0x0770 20 3d                            jr nz,0x07af
0x0772 03                               inc bc
0x0773 00                               nop
0x0774 00                               nop
0x0775 00                               nop
0x0776 00                               nop
0x0777 00                               nop
0x0778 00                               nop
0x0779 00                               nop
0x077a 00                               nop
0x077b 00                               nop
0x077c 00                               nop
0x077d 00                               nop
0x077e 00                               nop
0x077f 00                               nop
0x0780 00                               nop
0x0781 00                               nop
0x0782 00                               nop
0x0783 00                               nop
0x0784 00                               nop
0x0785 00                               nop
0x0786 00                               nop
0x0787 00                               nop
0x0788 00                               nop
0x0789 00                               nop
0x078a 00                               nop
0x078b 00                               nop
0x078c 00                               nop
0x078d 00                               nop
0x078e 00                               nop
0x078f 00                               nop
0x0790 00                               nop
0x0791 00                               nop
0x0792 00                               nop
0x0793 00                               nop
0x0794 00                               nop
0x0795 00                               nop
0x0796 00                               nop
0x0797 00                               nop
0x0798 00                               nop
0x0799 00                               nop
0x079a 00                               nop
0x079b 00                               nop
0x079c 00                               nop
0x079d 00                               nop
0x079e 00                               nop
0x079f 00                               nop
0x07a0 00                               nop
0x07a1 00                               nop
0x07a2 00                               nop
0x07a3 00                               nop
0x07a4 00                               nop
0x07a5 00                               nop
0x07a6 00                               nop
0x07a7 00                               nop
0x07a8 00                               nop
0x07a9 00                               nop
0x07aa 00                               nop
0x07ab 00                               nop
0x07ac 00                               nop
0x07ad 00                               nop
0x07ae 00                               nop
0x07af 00                               nop
0x07b0 00                               nop
0x07b1 00                               nop
0x07b2 00                               nop
0x07b3 00                               nop
0x07b4 00                               nop
0x07b5 00                               nop
0x07b6 00                               nop
0x07b7 00                               nop
0x07b8 00                               nop
0x07b9 00                               nop
0x07ba 00                               nop
0x07bb 00                               nop
0x07bc 00                               nop
0x07bd 00                               nop
0x07be 00                               nop
0x07bf 00                               nop
0x07c0 00                               nop
0x07c1 00                               nop
0x07c2 00                               nop
0x07c3 00                               nop
0x07c4 00                               nop
0x07c5 00                               nop
0x07c6 00                               nop
0x07c7 00                               nop
0x07c8 00                               nop
0x07c9 00                               nop
0x07ca 00                               nop
0x07cb 00                               nop
0x07cc 00                               nop
0x07cd 00                               nop
0x07ce 00                               nop
0x07cf 00                               nop
0x07d0 00                               nop
0x07d1 00                               nop
0x07d2 00                               nop
0x07d3 00                               nop
0x07d4 00                               nop
0x07d5 00                               nop
0x07d6 00                               nop
0x07d7 00                               nop
0x07d8 00                               nop
0x07d9 00                               nop
0x07da 00                               nop
0x07db 00                               nop
0x07dc 00                               nop
0x07dd 00                               nop
0x07de 00                               nop
0x07df 00                               nop
0x07e0 00                               nop
0x07e1 00                               nop
0x07e2 00                               nop
0x07e3 00                               nop
0x07e4 00                               nop
0x07e5 00                               nop
0x07e6 00                               nop
0x07e7 00                               nop
0x07e8 00                               nop
0x07e9 00                               nop
0x07ea 00                               nop
0x07eb 00                               nop
0x07ec 00                               nop
0x07ed 00                               nop
0x07ee 00                               nop
0x07ef 00                               nop
0x07f0 00                               nop
0x07f1 00                               nop
0x07f2 00                               nop
0x07f3 00                               nop
0x07f4 00                               nop
0x07f5 00                               nop
0x07f6 00                               nop
0x07f7 00                               nop
0x07f8 00                               nop
0x07f9 00                               nop
0x07fa 00                               nop
0x07fb 00                               nop
0x07fc 00                               nop
0x07fd 51                               ld d,c
0x07fe 34                               inc (hl)
0x07ff                                  

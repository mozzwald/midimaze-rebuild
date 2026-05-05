	opt h-

	icl "include/atari_os.inc"
	icl "include/hardware.inc"
	icl "include/cartridge.inc"
	icl "include/game_ram.inc"

; Bank 05: switchable 8KB cartridge bank, mapped at $8000-$9FFF.
; Contains initialization/OS-facing code and preserved trailing fill.
; Generated Lxxxx symbols are preserved until their meaning is proven.
; Hardware/OS constants are named where confidently identified.
; Bank map (working):
;   $8000-$9FFF  Initialization/OS-facing code followed by preserved fill.

L0080	= $0080
L0081	= $0081
L008C	= $008C
L008D	= $008D
L00AD	= $00AD
L00AE	= $00AE
L00AF	= $00AF
L00B0	= $00B0
L00CE	= $00CE
L00CF	= $00CF
L00D0	= $00D0
L0400	= $0400
L0401	= $0401
L0402	= $0402
L0442	= $0442
L0443	= $0443
L0444	= $0444
L0445	= $0445
L0446	= $0446
L0447	= $0447
L0448	= $0448
L0449	= $0449
L044A	= $044A
L044B	= $044B
L044C	= $044C
L044D	= $044D
L044E	= $044E
L044F	= $044F
L0450	= $0450
L0451	= $0451
L0452	= $0452
L0453	= $0453
L0BC9	= $0BC9
L1E00	= $1E00
L1E10	= $1E10
L1EED	= $1EED
L1F4C	= $1F4C
L1F51	= $1F51
L1FC4	= $1FC4
L20B6	= $20B6
L20F3	= $20F3
L210B	= $210B
L2171	= $2171
L21B2	= $21B2
L21EF	= $21EF
L221D	= $221D
L2325	= $2325
L2399	= $2399
L23AA	= $23AA
L23AC	= $23AC
L23DC	= $23DC
L2414	= $2414
L2438	= $2438
L2449	= $2449
L244F	= $244F
L245B	= $245B
L247F	= $247F
L24AB	= $24AB
L24AF	= $24AF
L24D7	= $24D7
L251B	= $251B
L255C	= $255C
L2587	= $2587
L2591	= $2591
L2595	= $2595
L25A1	= $25A1
L25AC	= $25AC
L25B5	= $25B5
L25BE	= $25BE
L25C6	= $25C6
L26ED	= $26ED
L26FC	= $26FC
L273C	= $273C
L2789	= $2789
L278F	= $278F
L2793	= $2793
L2794	= $2794
L2795	= $2795
L2796	= $2796
L2797	= $2797
L2798	= $2798
L448D	= $448D
LA61F	= $A61F
LA91E	= $A91E
LAA20	= $AA20
LAD02	= $AD02
LAD23	= $AD23
BANK_RETURN	= $AF36
LE4A5	= $E4A5 ; OS ROM table/entry, exact purpose not yet verified.
LE6D0	= $E6D0 ; OS ROM routine, exact purpose not yet verified.
LF004	= $F004
LF4BE	= $F4BE
	org $8000
START1	CPY	#$00
	BNE	L800E
	LDA	#$87
	STA	L00AD
	LDA	#$80
	STA	L00AE
	BNE	L8016
L800E	LDA	#$40
	STA	L00AD
	LDA	#$8A
	STA	L00AE
L8016	LDA	#$00
	STA	RUNAD+1
	STA	INITAD+1
	TAY
L801F	LDA	(L00AD),Y
	STA	L00AF
	JSR	L8080
	LDA	(L00AD),Y
	STA	L00B0
	JSR	L8080
	LDA	L00B0
	CMP	#$FF
	BEQ	L801F
	LDA	(L00AD),Y
	STA	L0080
	JSR	L8080
	LDA	(L00AD),Y
	STA	L0081
	JSR	L8080
L8041	LDA	(L00AD),Y
	STA	(L00AF),Y
	INC	L00AD
	BNE	L804B
	INC	L00AE
L804B	LDA	L00AF
	CMP	L0080
	BEQ	L8059
L8051	INC	L00AF
	BNE	L8041
	INC	L00B0
	BNE	L8041
L8059	LDA	L00B0
	CMP	L0081
	BNE	L8051
	LDA	INITAD+1
	BEQ	L806F
	JSR	L807D
	LDY	#$00
	STY	INITAD+1
	JMP	L801F
L806F	LDA	RUNAD+1
	BEQ	L801F
	JSR	L807A
	JMP	BANK_RETURN
L807A	JMP	(RUNAD)
L807D	JMP	(INITAD)
L8080	INC	L00AD
	BNE	L8086
	INC	L00AE
L8086	RTS
	.byte	$FF
L8088	.byte	$FF,$00,$1E ; (undocumented opcode) - ISC L1E00,X
	.byte	$FB,$1E,$A9 ; (undocumented opcode) - ISC LA91E,Y
	ASL	L1EED,X
	.byte	$17,$20 ; (undocumented opcode) - SLO ICHIDZ,X
	ASL	LA61F
	JSR	L20B6
	JMP	L1E10
	.byte	$00 ; Screen code for ' '
L809D	LDA	#$98
	STA	MEMLO
	LDA	#$28
	STA	MEMLO+1
	JSR	L273C
	JSR	L247F
	LDY	#$FF
	STY	L0442
	STY	L0452
	STY	L044F
	LDA	L0450
	PHA
	INY
	STY	L0450
	JSR	L23AA
	PLA
	STA	L0450
	LDA	WARMST
	BEQ	L80D8
	LDA	#$10
	STA	L0442
	LDX	#$04
	STX	L044F
	JSR	L23DC
L80D8	LDA	#$00
	TAY
L80DB	STA	L0400,Y
	INY
	BPL	L80DB
	LDA	#$51
	STA	L0442
	STA	L0452
	STA	L044F
	JSR	L23AA
	JSR	L251B
	LDX	#$00
	STX	L0442
L80F7	LDA	HATABS,X
	BEQ	L8108
	CMP	#$54
	BEQ	L8108
	INX
	INX
	INX
	CPX	#$20
	BCC	L80F7
	RTS
L8108	LDA	#$52
	STA	HATABS,X
	LDA	#$00
	STA	HATABS+1,X
	LDA	#$1E
	STA	HATABS+2,X
	LDA	WARMST
	NOP
	NOP
	LDA	DOSINI
	STA	L2795
	LDA	DOSINI+1
	STA	L2796
	LDA	#$1D
	STA	DOSINI
	LDA	#$1E
	STA	DOSINI+1
	LDA	#$00
	STA	L2797
	CLC
	RTS
	.byte	$6C ; 'l'
	.byte	$95
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AF
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$03 ; Screen code for '#'
	.byte	$A0
	.byte	$96
	.byte	$60
	.byte	$A5
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A8
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0C ; Screen code for ','
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$51 ; 'Q'
	.byte	$1F ; Screen code for '?'
	.byte	$98
	.byte	$09 ; Screen code for ')'
	.byte	$90
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FE
	.byte	$8D
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$07 ; Screen code for '''
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$7F
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$91
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$A9
	.byte	$59 ; 'Y'
	.byte	$8D
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AC
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$90
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1B ; Screen code for ';'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$8C
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$88
	.byte	$84
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$A0
	.byte	$8B
	.byte	$60
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$F0
	.byte	$16 ; Screen code for '6'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$79 ; 'y'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$A9
	.byte	$51 ; 'Q'
	.byte	$8D
	.byte	$FC
	.byte	$1E ; Screen code for '>'
	.byte	$F7
	.byte	$1F ; Screen code for '?'
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1B ; Screen code for ';'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$8D
	.byte	$08 ; Screen code for '('
	.byte	$D2
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$60
L81A0	JSR	L2438
	STA	L0452
	LDX	L0451
	BNE	L81C1
	LDX	TSTDAT
	BEQ	L8208
	CMP	#$1B
	BEQ	L81B9
	CMP	#$9B
	BNE	L81DD
	BEQ	L81BE
L81B9	LDA	#$80
	STA	L0451
L81BE	LDY	#$01
	RTS
L81C1	BPL	L8203
	CMP	#$1B
	BEQ	L81BE
	LDA	L0442
	LSR
	LDA	L0452
	BCC	L81D4
	CMP	#$59
	BNE	L81DD
L81D4	SEC
	SBC	#$41
	BCC	L81DD
	CMP	#$1A
	BCC	L81ED
L81DD	LDA	#$00
	STA	L0451
L81E2	LDA	L0445
	ORA	#$01
	STA	L0445
	LDY	#$84
	RTS
L81ED	TAX
	LDA	L2171,X
	CLC
	ADC	#$8B
	STA	L044A
	LDA	#$21
	ADC	#$00
	STA	L044B
	LDA	#$00
	STA	L0451
L8203	LDY	#$01
	JMP	(L044A)
L8208	LDA	L0442
	AND	#$08
	BNE	L8212
	LDY	#$87
	RTS
L8212	LDA	L0442
	LSR
	BCS	L81E2
	LDA	L0443
	AND	#$30
	TAY
	BEQ	L8224
	CMP	#$20
	BCS	L8258
L8224	LDA	L0452
	CMP	#$9B
	BNE	L8242
	LDA	L0443
	AND	#$40
	BEQ	L823E
	LDA	#$0D
	JSR	L1FC4
	BPL	L823A
	RTS
L823A	LDA	#$0A
	BNE	L8255
L823E	LDA	#$0D
	BNE	L8255
L8242	CPY	#$10
	BEQ	L824A
	AND	#$7F
	BPL	L8255
L824A	CMP	#$20
	BCC	L8252
	CMP	#$7D
	BCC	L8255
L8252	LDY	#$01
	RTS
L8255	STA	L0452
L8258	LDA	L0443
	AND	#$03
	BEQ	L827D
	CMP	#$03
	BEQ	L8275
	TAY
	JSR	L25AC
	JSR	L25A1
	TYA
	AND	#$02
	BEQ	L8273
	BCC	L827D
	BPL	L8275
L8273	BCS	L827D
L8275	LDA	L0452
	ORA	#$80
	STA	L0452
L827D	JSR	L245B
	JSR	L2449
	LDA	L0401
	CMP	#$3F
	.byte	$B0,$F8 ; data bytes originally disassembled as BCS
	.byte	$1F,$F3,$20 ; (undocumented opcode) - SLO L20F3,X
	.byte	$F3,$78 ; (undocumented opcode) - ISC (DELTAC+1),Y
	LDY	L0449
	LDA	L0452
	STA	L0402,Y
	JSR	L25B5
	STA	L0449
	INC	L0401
	LDA	L0450
	BNE	L82A9
	JSR	L2587
L82A9	CLI
	LDY	#$01
	RTS
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$04 ; Screen code for '$'
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$A0
	.byte	$83
	.byte	$60
L82BA	LDA	L0442
	LSR
	BCC	L82C3
	JMP	L1F51
L82C3	CLI
	JSR	L245B
	JSR	L2449
	SEI
	LDY	L0447
	CPY	L0446
	BEQ	L82C3
	LDA	L2798,Y
	STA	L0452
	JSR	L25BE
	STY	L0447
	DEC	L0400
	CLI
	LDA	L0443
	LSR
	LSR
	AND	#$03
	BEQ	L830F
	CMP	#$03
	BEQ	L830C
	TAY
	LDA	L0452
	JSR	L25A1
	TYA
	AND	#$02
	BEQ	L8300
	BCC	L830C
	BPL	L8302
L8300	BCS	L830C
L8302	LDX	ICDNOZ
	LDA	#$20
	ORA	L0445
	STA	L0445
L830C	JSR	L25AC
L830F	LDA	L0443
	AND	#$30
	CMP	#$20
	BCC	L831E
	LDA	L0452
	LDY	#$01
	RTS
L831E	TAY
	JSR	L25AC
	CMP	#$0D
	BNE	L832A
	LDA	#$9B
	BNE	L8339
L832A	CPY	#$00
	BEQ	L8339
	CMP	#$20
	BCC	L8336
	CMP	#$7D
	BCC	L8339
L8336	LDA	L044C
L8339	LDY	#$01
	RTS
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$4A ; 'J'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$40 ; '@'
	.byte	$F0
	.byte	$05 ; Screen code for '%'
	.byte	$B0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$F5
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$4C ; 'L'
	.byte	$51 ; 'Q'
	.byte	$1F ; Screen code for '?'
	.byte	$A0
	.byte	$92
	.byte	$60
L834F	BIT	IRQST
	BPL	L8357
	JMP	(L2793)
L8357	PHA
	LDA	#$7F
	STA	IRQEN
	LDA	POKMSK
	STA	IRQEN
	LDA	#$00
	STA	L044F
	PLA
	RTI
	.byte	$D8
L836A	TYA
	PHA
	LDY	L0446
	LDA	L0400
	CMP	#$FF
	BCC	L8381
	LDA	L0445
	ORA	#$10
	STA	L0445
	DEC	L0400
L8381	LDA	SERIN
	STA	L2798,Y
	JSR	LF4BE
	JSR	L21EF
	AND	L008C
	LSR	RAMLO
	INC	L0400
	LDA	SKSTAT
	STA	SKREST
	EOR	#$FF
	AND	#$C0
	ORA	L0445
	STA	L0445
L83A4	PLA
	TAY
	PLA
	RTI
	.byte	$D8
L83A9	TYA
	PHA
	LDA	L0401
	BNE	L83BC
	LDA	#$E7
	AND	POKMSK
	STA	POKMSK
	STA	IRQEN
	JMP	L210B
L83BC	LDY	L0448
	LDA	L0402,Y
	STA	SEROUT
	JSR	L25B5
	STA	L0448
	DEC	L0401
L83CE	LDA	IRQST
	AND	#$08
	BEQ	L83CE
	BNE	L83A4
	CLD
	TYA
	PHA
	LDA	L0450
	BEQ	L83E6
	LDA	#$00
	STA	L0450
	BEQ	L83A4
L83E6	LDA	L0444
	AND	#$3E
	STA	L0444
	JMP	L210B
	.byte	$D8
	.byte	$98
	.byte	$48 ; 'H'
	.byte	$AD
	.byte	$44 ; 'D'
	.byte	$04 ; Screen code for '$'
	.byte	$49 ; 'I'
	.byte	$80
	.byte	$8D
	.byte	$44 ; 'D'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$80
	.byte	$F0
	.byte	$E6
	.byte	$AD
	.byte	$44 ; 'D'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$BF
	.byte	$8D
	.byte	$44 ; 'D'
	.byte	$04 ; Screen code for '$'
	.byte	$D0
	.byte	$9A
	.byte	$12 ; Screen code for '2'
	.byte	$00 ; Screen code for ' '
	.byte	$4B ; 'K'
	.byte	$00 ; Screen code for ' '
	.byte	$65 ; 'e'
	.byte	$6A ; 'j'
	.byte	$B4
	.byte	$0F ; Screen code for '/'
	.byte	$8D
	.byte	$9E
	.byte	$06 ; Screen code for '&'
	.byte	$D2
	.byte	$DE
	.byte	$EB
	.byte	$F3
	.byte	$FA
	.byte	$98
	.byte	$C3
	.byte	$CA
	.byte	$BB
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A5
	.byte	$AC
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$4C ; 'L'
	.byte	$1F ; Screen code for '?'
	.byte	$4C ; 'L'
	.byte	$D1
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$4C ; 'L'
	.byte	$6C ; 'l'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$4C ; 'L'
	.byte	$0D ; Screen code for '-'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$4C ; 'L'
	.byte	$89
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$4C ; 'L'
	.byte	$EE
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$4C ; 'L'
	.byte	$AD
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$4C ; 'L'
	.byte	$C3
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$8D
	.byte	$4C ; 'L'
	.byte	$04 ; Screen code for '$'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$8C
	.byte	$51 ; 'Q'
	.byte	$04 ; Screen code for '$'
	.byte	$C8
	.byte	$60
L8446	LDA	#$02
	STA	L0451
	CLC
	LDA	L044A
	ADC	#$03
	STA	L044A
	BCC	L8459
	INC	L044B
L8459	LDY	#$01
	RTS
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$70 ; 'p'
	.byte	$8D
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$AD
	.byte	$43 ; 'C'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$8F
	.byte	$0D ; Screen code for '-'
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$8D
	.byte	$43 ; 'C'
	.byte	$04 ; Screen code for '$'
	.byte	$4C ; 'L'
	.byte	$B2
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$4C ; 'L'
	.byte	$EC
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$8D
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$AD
	.byte	$43 ; 'C'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$F0
	.byte	$0D ; Screen code for '-'
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$8D
	.byte	$43 ; 'C'
	.byte	$04 ; Screen code for '$'
	.byte	$4C ; 'L'
	.byte	$A6
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$D0
	.byte	$BF
	.byte	$F0
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$EB
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$07 ; Screen code for '''
	.byte	$60
L8492	LDA	L0401
	STA	DVSTAT+3
	LDA	L0400
	STA	DVSTAT+2
	LDA	L0444
	AND	#$FD
	STA	DVSTAT+1
	LDA	L0445
	AND	#$F1
	STA	DVSTAT
	LDY	#$00
	STY	L0445
	INY
	RTS
	.byte	$20 ; ' ' ; Screen code for '@'
L84B6	TAX
	.byte	$23,$29 ; (undocumented opcode) - RLA (ICBLHZ,X)
	.byte	$EF,$8D,$44 ; (undocumented opcode) - ISC L448D
	.byte	$04,$A0 ; (undocumented opcode) - NOP	$A0
	ORA	(NEWROW,X)
	JSR	L23AA
	LDY	#$01
	RTS
	.byte	$20 ; ' ' ; Screen code for '@'
L84C7	TAX
	.byte	$23,$09 ; (undocumented opcode) - RLA (BOOT,X)
	.byte	$10,$D0 ; data bytes originally disassembled as BPL
	SBC	LAA20
	.byte	$23,$09 ; (undocumented opcode) - RLA (BOOT,X)
	JSR	LE6D0
	JSR	L23AA
	AND	#$DF
	JMP	L221D
	.byte	$20 ; ' ' ; Screen code for '@'
L84DD	TAX
	.byte	$23,$09 ; (undocumented opcode) - RLA (BOOT,X)
	PHP
	.byte	$D0,$D7 ; data bytes originally disassembled as BNE
	JSR	L23AA
	AND	#$F7
	JMP	L221D
	.byte	$20 ; ' ' ; Screen code for '@'
L84EC	TAX
	.byte	$23,$09 ; (undocumented opcode) - RLA (BOOT,X)
	RTI
	.byte	$D0
L84F1	INY
	JSR	L23AA
	AND	#$BF
	JMP	L221D
	.byte	$A2
L84FB	.byte	$04,$20 ; (undocumented opcode) - NOP	ICHIDZ
	LDY	LAD23
	.byte	$44,$04 ; (undocumented opcode) - NOP	RAMLO
	ORA	#$01
	.byte	$D0,$B4 ; data bytes originally disassembled as BNE
	LDX	#$04
	JSR	L23AC
	LDA	L0444
	AND	#$3E
	JMP	L221D
	.byte	$AD
L8514	.byte	$44,$04 ; (undocumented opcode) - NOP	RAMLO
	AND	#$FB
	JMP	L221D
	.byte	$AD
L851C	.byte	$44,$04 ; (undocumented opcode) - NOP	RAMLO
	ORA	#$04
	.byte	$D0,$98 ; data bytes originally disassembled as BNE
	JSR	L23AA
	RTS
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$A8
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$01 ; Screen code for '!'
	.byte	$D0
	.byte	$03 ; Screen code for '#'
L852E	LDY	#$01
	RTS
L8531	TYA
	AND	#$FE
	ORA	#$10
	STA	L0442
	SEI
	JSR	L24D7
	LDA	POKMSK
	ORA	#$20
	STA	IRQEN
	STA	POKMSK
	CLI
	JSR	L2591
	LDX	#$02
	JSR	L23AC
	BCC	L852E
	LDA	L0442
	ORA	#$10
	STA	L0442
	LDX	#$02
	JSR	L23AC
	BCC	L852E
	JSR	L251B
	LDA	L0442
	ORA	#$01
	STA	L0442
	LDY	#$8B
	RTS
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AC
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$B0
	.byte	$F9
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$09 ; Screen code for ')'
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1B ; Screen code for ';'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$A0
	.byte	$EC
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$E7
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$01 ; Screen code for '!'
	.byte	$60
L858F	LDA	L0444
	ASL
	BCS	L8598
	JMP	L244F
L8598	LDA	L0442
	ORA	#$10
	STA	L0442
	JSR	L23AA
	BCC	L85A8
	JMP	L2414
L85A8	INC	L0450
	LDY	#$01
	RTS
	.byte	$29 ; ')' ; Screen code for 'I'
L85AF	.byte	$0F,$C9,$0B ; (undocumented opcode) - SLO L0BC9
	BNE	L85BB
	LDY	#$00
	STY	L0451
	BEQ	L85C9
L85BB	CMP	#$0C
	BNE	L85C9
	LDY	#$B4
	LDX	#$00
	JSR	L2595
	LDY	#$01
	RTS
L85C9	STA	L0452
	STA	L0453
	TAY
	LDA	L0444
	AND	#$04
	BEQ	L85F8
	CPY	#$0B
	BNE	L85F2
	JSR	L24AF
	JSR	L2591
	LDA	#$50
	STA	L0452
	JSR	L23AA
	LDA	L0453
	STA	L0452
L85EF	JMP	L2325
L85F2	JSR	L25C6
	JMP	L2325
L85F8	LDA	L0452
	BNE	L8602
	LDA	#$0A
	STA	L0452
L8602	CMP	#$0C
	BCS	L85EF
	LDX	#$04
	JSR	L23AC
	BCC	L85EF
	LDA	L0444
	ASL
	BCC	L8616
	JMP	L1F4C
L8616	LDA	#$01
	STA	L0451
	LDA	L0452
	STA	L0453
	LDA	L0444
	AND	#$04
	BEQ	L8635
	LDA	#$4F
	STA	L0452
	LDX	#$04
	JSR	L23AC
	JMP	L2399
L8635	LDX	#$04
	JSR	L23AC
	LDA	L0453
	STA	L0452
	LDA	L0444
	ORA	#$01
	STA	L0444
	JMP	L21B2
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$AD
	.byte	$50 ; 'P'
	.byte	$04 ; Screen code for '$'
	.byte	$D0
	.byte	$FB
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$79 ; 'y'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$AD
	.byte	$0E ; Screen code for '.'
	.byte	$D2
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$08 ; Screen code for '('
	.byte	$D0
	.byte	$F9
	.byte	$A9
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D3
	.byte	$85
	.byte	$42 ; 'B'
	.byte	$8D
	.byte	$50 ; 'P'
	.byte	$04 ; Screen code for '$'
	.byte	$78 ; 'x'
	.byte	$AC
	.byte	$49 ; 'I'
	.byte	$04 ; Screen code for '$'
	.byte	$AD
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$99
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B5
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$8D
	.byte	$49 ; 'I'
	.byte	$04 ; Screen code for '$'
	.byte	$EE
	.byte	$01 ; Screen code for '!'
	.byte	$04 ; Screen code for '$'
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$79 ; 'y'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$BC
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$BD
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$AA
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5C
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5B
	.byte	$E8
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$E3
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$AD
	.byte	$50 ; 'P'
	.byte	$04 ; Screen code for '$'
	.byte	$F0
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$AD
	.byte	$4E ; 'N'
	.byte	$04 ; Screen code for '$'
	.byte	$D0
	.byte	$F3
	.byte	$85
	.byte	$42 ; 'B'
	.byte	$8D
	.byte	$51 ; 'Q'
	.byte	$04 ; Screen code for '$'
	.byte	$8D
	.byte	$50 ; 'P'
	.byte	$04 ; Screen code for '$'
	.byte	$A9
	.byte	$3D ; '='
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D3
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$10 ; Screen code for '0'
	.byte	$F0
	.byte	$0D ; Screen code for '-'
	.byte	$AD
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$EF
	.byte	$8D
	.byte	$42 ; 'B'
	.byte	$04 ; Screen code for '$'
	.byte	$AD
	.byte	$44 ; 'D'
	.byte	$04 ; Screen code for '$'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$60
	.byte	$AE
	.byte	$4D ; 'M'
	.byte	$04 ; Screen code for '$'
	.byte	$9A
	.byte	$A0
	.byte	$8B
	.byte	$AD
	.byte	$44 ; 'D'
	.byte	$04 ; Screen code for '$'
	.byte	$60
L86C3	STA	CRITIC
	LDA	#$3D
	STA	PBCTL
	LDA	L0442
	AND	#$EF
	STA	L0442
	LDA	L0444
	CLC
	RTS
	.byte	$08 ; Screen code for '('
	.byte	$00 ; Screen code for ' '
	.byte	$3C ; '<'
	.byte	$00 ; Screen code for ' '
	.byte	$B4
	.byte	$00 ; Screen code for ' '
	.byte	$A8
	.byte	$AD
	.byte	$45 ; 'E'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FE
	.byte	$8D
	.byte	$45 ; 'E'
	.byte	$04 ; Screen code for '$'
	.byte	$98
	.byte	$BA
	.byte	$E8
	.byte	$E8
	.byte	$8E
	.byte	$4D ; 'M'
	.byte	$04 ; Screen code for '$'
	.byte	$60
L86EE	BIT	L0444
	BPL	L86F4
	RTS
L86F4	LDX	L044D
	TXS
	LDA	#$00
	STA	L0451
	LDY	#$88
	RTS
	.byte	$AD
L8701	.byte	$4F,$04,$F0 ; (undocumented opcode) - SRE LF004
	ORA	(NEWROW,X)
	LDX	L044D
	TXS
	INC	L044F
	STA	L0451
	LDA	L0442
	AND	#$EF
	STA	L0442
	LDA	#$3D
	STA	PBCTL
	LDA	#$00
	STA	CRITIC
	LDY	#$80
	RTS
	.byte	$78 ; 'x'
L8725	JSR	L24D7
	LDA	#$00
	STA	L0400
	STA	L0401
	LDY	#$05
L8732	STA	L0444,Y
	DEY
	BPL	L8732
	STA	TSTDAT
	STA	L0451
	LDA	#$C7
	AND	POKMSK
	ORA	#$20
	STA	IRQEN
	STA	POKMSK
	CLI
	RTS
	.byte	$D4
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$0F ; Screen code for '/'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$0F ; Screen code for '/'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$3E ; '>'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$58 ; 'X'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$A9
	.byte	$07 ; Screen code for '''
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$02 ; Screen code for '"'
	.byte	$09 ; Screen code for ')'
	.byte	$70 ; 'p'
	.byte	$8D
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$02 ; Screen code for '"'
	.byte	$8D
	.byte	$0F ; Screen code for '/'
	.byte	$D2
	.byte	$8D
	.byte	$0A ; Screen code for '*'
	.byte	$D2
	.byte	$A9
	.byte	$78 ; 'x'
	.byte	$8D
	.byte	$08 ; Screen code for '('
	.byte	$D2
	.byte	$A2
	.byte	$07 ; Screen code for '''
	.byte	$A9
	.byte	$A0
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$D2
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$FA
	.byte	$A9
	.byte	$0B ; Screen code for '+'
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$D2
	.byte	$8D
	.byte	$06 ; Screen code for '&'
	.byte	$D2
	.byte	$60
L877C	JSR	L24AF
	LDX	#$05
	LDA	VSERIN,X
	STA	L2789,X
	LDA	LE4A5,X
	BIT	FRE+5
	AND	ICBALZ
	STA	VSERIN,X
	DEX
	.byte	$10,$F1 ; data bytes originally disassembled as BPL
	LDX	#$03
L8796	LDA	VPRCED,X
	STA	L278F,X
	LDA	L24AB,X
	STA	VPRCED,X
	DEX
	BPL	L8796
	LDA	PACTL
	ORA	#$01
	STA	PACTL
	LDA	VIMIRQ
	STA	L2793
	LDA	#$BA
	STA	VIMIRQ
	LDA	VIMIRQ+1
	STA	L2794
	LDA	#$20
	STA	VIMIRQ+1
	RTS
	.byte	$78 ; 'x'
L87C5	LDA	L2793
	STA	VIMIRQ
	LDA	L2794
	STA	VIMIRQ+1
	LDY	#$05
L87D3	LDA	L2789,Y
	STA	VSERIN,Y
	DEY
	BPL	L87D3
	LDY	#$03
L87DE	LDA	L278F,Y
	STA	VPRCED,Y
	DEY
	BPL	L87DE
	LDA	PACTL
	AND	#$FE
	STA	PACTL
	LDA	#$C7
	AND	POKMSK
	STA	POKMSK
	STA	IRQEN
	LDX	#$06
	LDA	#$00
L87FC	STA	AUDC1,X
	DEX
	DEX
	BPL	L87FC
	CLI
	RTS
	.byte	$A9
L8806	.byte	$73,$8D ; (undocumented opcode) - RRA (L008D),Y
	ROL	CASINI
	LDA	#$25
	STA	CDTMA1+1
	LDA	#$01
	SEI
	JSR	SETVBV
	LDA	#$01
	STA	L044E
	CLI
	RTS
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$4E ; 'N'
	.byte	$04 ; Screen code for '$'
	.byte	$60
L8822	SEI
	JSR	L2587
	CLI
L8827	JSR	L245B
	LDA	L0401
	BNE	L8827
	RTS
	.byte	$A5
L8831	BPL	L883C
	CLC
	STA	POKMSK
	STA	IRQEN
	RTS
	.byte	$A2
	.byte	$00 ; Screen code for ' '
L883C	LDY	#$03
	JSR	L255C
L8841	JSR	L245B
	LDA	L044E
	BNE	L8841
	RTS
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$4A ; 'J'
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$E8
	.byte	$D0
	.byte	$FA
	.byte	$8A
	.byte	$4A ; 'J'
	.byte	$60
	.byte	$AD
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$8D
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$60
L885E	INY
	TYA
	CMP	#$40
	BCC	L8866
	LDA	#$00
L8866	RTS
	.byte	$C8
L8868	CPY	#$FF
	BCC	L886E
	LDY	#$00
L886E	RTS
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$08 ; Screen code for '('
	.byte	$D2
	.byte	$8D
	.byte	$01 ; Screen code for '!'
	.byte	$D2
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D2
	.byte	$8D
	.byte	$05 ; Screen code for '%'
	.byte	$D2
	.byte	$8D
	.byte	$07 ; Screen code for '''
	.byte	$D2
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$04 ; Screen code for '$'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$03 ; Screen code for '#'
	.byte	$9D
	.byte	$54 ; 'T'
	.byte	$E0
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$DB ; Screen code for '›'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$04 ; Screen code for '$'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$FA
	.byte	$AC
	.byte	$52 ; 'R'
	.byte	$04 ; Screen code for '$'
	.byte	$B9
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$F0
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$48 ; 'H'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$03 ; Screen code for '#'
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$BD
	.byte	$3D ; '='
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$8D
	.byte	$58 ; 'X'
	.byte	$04 ; Screen code for '$'
	.byte	$BD
	.byte	$3E ; '>'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$8D
	.byte	$59 ; 'Y'
	.byte	$04 ; Screen code for '$'
	.byte	$68 ; 'h'
	.byte	$4A ; 'J'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$06 ; Screen code for '&'
	.byte	$AA
	.byte	$BD
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$8D
	.byte	$5A ; 'Z'
	.byte	$04 ; Screen code for '$'
	.byte	$BD
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$8D
	.byte	$5B
	.byte	$04 ; Screen code for '$'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$8E
	.byte	$0E ; Screen code for '.'
	.byte	$D4
	.byte	$08 ; Screen code for '('
	.byte	$D8
	.byte	$78 ; 'x'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$43 ; 'C'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B6
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$A9
	.byte	$C0
	.byte	$8D
	.byte	$0E ; Screen code for '.'
	.byte	$D4
	.byte	$60
	.byte	$0D ; Screen code for '-'
	.byte	$80
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$0A ; Screen code for '*'
	.byte	$0C ; Screen code for ','
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0E ; Screen code for '.'
	.byte	$00 ; Screen code for ' '
	.byte	$B4
	.byte	$16 ; Screen code for '6'
	.byte	$14 ; Screen code for '4'
	.byte	$19 ; Screen code for '9'
	.byte	$C0
	.byte	$1B ; Screen code for ';'
	.byte	$A6
	.byte	$1E ; Screen code for '>'
	.byte	$61 ; 'a'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$83
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$1B ; Screen code for ';'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$8D
	.byte	$5D
	.byte	$04 ; Screen code for '$'
	.byte	$AE
	.byte	$55 ; 'U'
	.byte	$04 ; Screen code for '$'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$54 ; 'T'
	.byte	$04 ; Screen code for '$'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DD
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F3
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$8D
	.byte	$5C
	.byte	$04 ; Screen code for '$'
	.byte	$AE
	.byte	$57 ; 'W'
	.byte	$04 ; Screen code for '$'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$56 ; 'V'
	.byte	$04 ; Screen code for '$'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DD
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F3
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$18 ; Screen code for '8'
	.byte	$6D ; 'm'
	.byte	$5C
	.byte	$04 ; Screen code for '$'
	.byte	$6D ; 'm'
	.byte	$97
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$3C ; '<'
	.byte	$AE
	.byte	$5D
	.byte	$04 ; Screen code for '$'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$07 ; Screen code for '''
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$8D
	.byte	$5E
	.byte	$04 ; Screen code for '$'
	.byte	$90
	.byte	$0B ; Screen code for '+'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$0D ; Screen code for '-'
	.byte	$5E
	.byte	$04 ; Screen code for '$'
	.byte	$AE
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$9D
	.byte	$98
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$D8
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$BD
	.byte	$54 ; 'T'
	.byte	$04 ; Screen code for '$'
	.byte	$18 ; Screen code for '8'
	.byte	$7D
	.byte	$58 ; 'X'
	.byte	$04 ; Screen code for '$'
	.byte	$9D
	.byte	$54 ; 'T'
	.byte	$04 ; Screen code for '$'
	.byte	$BD
	.byte	$55 ; 'U'
	.byte	$04 ; Screen code for '$'
	.byte	$7D
	.byte	$59 ; 'Y'
	.byte	$04 ; Screen code for '$'
	.byte	$9D
	.byte	$55 ; 'U'
	.byte	$04 ; Screen code for '$'
	.byte	$CA
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$E9
	.byte	$AD
	.byte	$5D
	.byte	$04 ; Screen code for '$'
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$5D
	.byte	$04 ; Screen code for '$'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$9B ; '›'
	.byte	$EE
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$D0
	.byte	$96
	.byte	$60
L8963	LDX	#$00
L8965	LDY	L2798,X
	STA	WSYNC
	TYA
	LSR
	LSR
	LSR
	LSR
	ORA	#$10
	STA	WSYNC
	STA	AUDC2
	TYA
	AND	#$0F
	ORA	#$10
	STA	WSYNC
	INX
	STA	WSYNC
	STA	AUDC2
	BNE	L8965
	.byte	$DC,$26,$88 ; (undocumented opcode) - NOP	$8826,X
	.byte	$27,$60 ; (undocumented opcode) - RLA NEWROW
	BPL	L8991
	INX
L8991	TXA
	AND	#$7F
	STA	L26ED
	CMP	#$40
	BCC	L899F
	LDA	#$7F
	SBC	#$00
L899F	TAY
	LDA	L26FC,Y
	RTS
	.byte	$E0
	.byte	$00 ; Screen code for ' '
	.byte	$10 ; Screen code for '0'
	.byte	$04 ; Screen code for '$'
	.byte	$E9
	.byte	$00 ; Screen code for ' '
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$60
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$10 ; Screen code for '0'
	.byte	$11 ; Screen code for '1'
	.byte	$11 ; Screen code for '1'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$42 ; 'B'
	.byte	$43 ; 'C'
	.byte	$43 ; 'C'
	.byte	$53 ; 'S'
	.byte	$53 ; 'S'
	.byte	$54 ; 'T'
	.byte	$64 ; 'd'
	.byte	$64 ; 'd'
	.byte	$64 ; 'd'
	.byte	$74 ; 't'
	.byte	$75 ; 'u'
	.byte	$75 ; 'u'
	.byte	$85
	.byte	$85
	.byte	$86
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$A6
	.byte	$A7
	.byte	$A7
	.byte	$A7
	.byte	$B7
	.byte	$B7
	.byte	$B7
	.byte	$B8
	.byte	$C8
	.byte	$C8
	.byte	$C8
	.byte	$C8
	.byte	$C8
	.byte	$D8
	.byte	$D9
	.byte	$D9
	.byte	$D9
	.byte	$D9
	.byte	$E9
	.byte	$E9
	.byte	$E9
	.byte	$E9
	.byte	$E9
	.byte	$E9
	.byte	$EA
	.byte	$EA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$AD
	.byte	$D8
	.byte	$FC
	.byte	$A2
	.byte	$1B ; Screen code for ';'
	.byte	$C9
	.byte	$A2
	.byte	$F0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$A2
	.byte	$3F ; '?'
	.byte	$8A
	.byte	$4A ; 'J'
	.byte	$A8
	.byte	$B9
	.byte	$69 ; 'i'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$B0
	.byte	$04 ; Screen code for '$'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$5D
	.byte	$FC
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$5D
	.byte	$FC
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$9D
	.byte	$FC
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$E4
	.byte	$A2
	.byte	$1E ; Screen code for '>'
	.byte	$8E
	.byte	$A1
	.byte	$1E ; Screen code for '>'
	.byte	$60
	.byte	$00 ; Screen code for ' '
	.byte	$11 ; Screen code for '1'
	.byte	$12 ; Screen code for '2'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$44 ; 'D'
	.byte	$45 ; 'E'
	.byte	$55 ; 'U'
	.byte	$66 ; 'f'
	.byte	$66 ; 'f'
	.byte	$77 ; 'w'
	.byte	$77 ; 'w'
	.byte	$88
	.byte	$88
	.byte	$99
	.byte	$99
	.byte	$AA
	.byte	$AA
	.byte	$AB
	.byte	$BB
	.byte	$BB
	.byte	$BC
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$CD
	.byte	$DD
	.byte	$DD
	.byte	$DD
	.byte	$DD
	.byte	$DD
	.byte	$E0
	.byte	$02 ; Screen code for '"'
	.byte	$E1
	.byte	$02 ; Screen code for '"'
	.byte	$10 ; Screen code for '0'
	.byte	$1E ; Screen code for '>'
	.byte	$FF
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$50 ; 'P'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$18 ; Screen code for '8'
	.byte	$AD
	.byte	$E7
	.byte	$02 ; Screen code for '"'
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$CE
	.byte	$A8
	.byte	$AA
	.byte	$6D ; 'm'
	.byte	$E8
	.byte	$02 ; Screen code for '"'
	.byte	$85
	.byte	$D0
	.byte	$69 ; 'i'
	.byte	$02 ; Screen code for '"'
	.byte	$85
	.byte	$CF
	.byte	$A9
	.byte	$79 ; 'y'
	.byte	$85
	.byte	$CC
	.byte	$A9
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$85
	.byte	$CD
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$42 ; 'B'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$AA
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$42 ; 'B'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$18 ; Screen code for '8'
	.byte	$65 ; 'e'
	.byte	$D0
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$F0
	.byte	$E8
	.byte	$F0
	.byte	$1A ; Screen code for ':'
	.byte	$CA
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$42 ; 'B'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$E7
	.byte	$91
	.byte	$CE
	.byte	$E6
	.byte	$CE
	.byte	$D0
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$CF
	.byte	$B1
	.byte	$CC
	.byte	$E6
	.byte	$CC
	.byte	$D0
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$CD
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$ED
	.byte	$60
L8A94	LDA	L00CE
	STA	MEMLO
	STA	APPMHI
	LDA	L00CF
	STA	MEMLO+1
	STA	APPMHI+1
	LDA	#$01
	STA	L00CE
	LDX	L00D0
	INX
	INX
	STX	L00CF
	LDA	DOSINI
	STA	(L00CE),Y
	INC	L00CE
	LDA	DOSINI+1
	STA	(L00CE),Y
	INC	L00CE
	STY	DOSINI
	STX	DOSINI+1
	JMP	(L00CE)
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DE
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$4C ; 'L'
	.byte	$DE
	.byte	$04 ; Screen code for '$'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$08 ; Screen code for '('
	.byte	$A0
	.byte	$80
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$CA
	.byte	$D0
	.byte	$FD
	.byte	$88
	.byte	$D0
	.byte	$FA
	.byte	$4A ; 'J'
	.byte	$90
	.byte	$F7
	.byte	$A0
	.byte	$04 ; Screen code for '$'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$99
	.byte	$08 ; Screen code for '('
	.byte	$02 ; Screen code for '"'
	.byte	$07 ; Screen code for '''
	.byte	$88
	.byte	$D0
	.byte	$FA
	.byte	$C8
	.byte	$60
	.byte	$AD
	.byte	$0E ; Screen code for '.'
	.byte	$02 ; Screen code for '"'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$D0
	.byte	$FB
	.byte	$A5
	.byte	$10 ; Screen code for '0'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$CF
	.byte	$85
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$0E ; Screen code for '.'
	.byte	$D2
	.byte	$AD
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$A9
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$08 ; Screen code for '('
	.byte	$D2
	.byte	$8C
	.byte	$02 ; Screen code for '"'
	.byte	$D2
	.byte	$A0
	.byte	$05 ; Screen code for '%'
	.byte	$78 ; 'x'
	.byte	$B9
	.byte	$14 ; Screen code for '4'
	.byte	$02 ; Screen code for '"'
	.byte	$09 ; Screen code for ')'
	.byte	$99
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$58 ; 'X'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$18 ; Screen code for '8'
	.byte	$6E ; 'n'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$05 ; Screen code for '%'
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$60
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$42 ; 'B'
	.byte	$AC
	.byte	$09 ; Screen code for ')'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$CC
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$0C ; Screen code for ','
	.byte	$D0
	.byte	$07 ; Screen code for '''
	.byte	$A5
	.byte	$11 ; Screen code for '1'
	.byte	$D0
	.byte	$EF
	.byte	$A0
	.byte	$80
	.byte	$60
	.byte	$C8
	.byte	$BE
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$8C
	.byte	$09 ; Screen code for ')'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$10 ; Screen code for '0'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D0
	.byte	$1C ; Screen code for '<'
	.byte	$8A
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$C9
	.byte	$0D ; Screen code for '-'
	.byte	$D0
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$9B ; '›'
	.byte	$AA
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$0E ; Screen code for '.'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$10 ; Screen code for '0'
	.byte	$F0
	.byte	$0B ; Screen code for '+'
	.byte	$E0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B0
	.byte	$07 ; Screen code for '''
	.byte	$E0
	.byte	$7D
	.byte	$90
	.byte	$03 ; Screen code for '#'
	.byte	$AE
	.byte	$08 ; Screen code for '('
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$8A
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$60
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$03 ; Screen code for '#'
	.byte	$A0
	.byte	$9A
	.byte	$60
	.byte	$AA
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$12 ; Screen code for '2'
	.byte	$A8
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D0
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$E0
	.byte	$9B ; '›'
	.byte	$D0
	.byte	$0E ; Screen code for '.'
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$98
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$40 ; '@'
	.byte	$F0
	.byte	$1A ; Screen code for ':'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$E4
	.byte	$02 ; Screen code for '"'
	.byte	$19 ; Screen code for '9'
	.byte	$A2
	.byte	$0A ; Screen code for '*'
	.byte	$D0
	.byte	$13 ; Screen code for '3'
	.byte	$98
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$10 ; Screen code for '0'
	.byte	$F0
	.byte	$0A ; Screen code for '*'
	.byte	$E0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$90
	.byte	$49 ; 'I'
	.byte	$E0
	.byte	$7D
	.byte	$B0
	.byte	$45 ; 'E'
	.byte	$90
	.byte	$04 ; Screen code for '$'
	.byte	$8A
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$AA
	.byte	$AD
	.byte	$06 ; Screen code for '&'
	.byte	$02 ; Screen code for '"'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$03 ; Screen code for '#'
	.byte	$08 ; Screen code for '('
	.byte	$A8
	.byte	$8A
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$F0
	.byte	$1E ; Screen code for '>'
	.byte	$C0
	.byte	$03 ; Screen code for '#'
	.byte	$D0
	.byte	$04 ; Screen code for '$'
	.byte	$09 ; Screen code for ')'
	.byte	$80
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$0A ; Screen code for '*'
	.byte	$48 ; 'H'
	.byte	$A0
	.byte	$06 ; Screen code for '&'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$E8
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F9
	.byte	$8A
	.byte	$0A ; Screen code for '*'
	.byte	$4D ; 'M'
	.byte	$06 ; Screen code for '&'
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$68 ; 'h'
	.byte	$6A ; 'j'
	.byte	$AC
	.byte	$0C ; Screen code for ','
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$C8
	.byte	$CC
	.byte	$0B ; Screen code for '+'
	.byte	$02 ; Screen code for '"'
	.byte	$05 ; Screen code for '%'
	.byte	$F0
	.byte	$FB
	.byte	$78 ; 'x'
	.byte	$AE
	.byte	$10 ; Screen code for '0'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$F0
	.byte	$0A ; Screen code for '*'
	.byte	$99
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$8C
	.byte	$0C ; Screen code for ','
	.byte	$02 ; Screen code for '"'
	.byte	$07 ; Screen code for '''
	.byte	$58 ; 'X'
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$60
	.byte	$E8
	.byte	$8E
	.byte	$10 ; Screen code for '0'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$8E
	.byte	$0E ; Screen code for '.'
	.byte	$02 ; Screen code for '"'
	.byte	$0A ; Screen code for '*'
	.byte	$58 ; 'X'
	.byte	$8D
	.byte	$0D ; Screen code for '-'
	.byte	$D2
	.byte	$D0
	.byte	$F0
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$AD
	.byte	$0D ; Screen code for '-'
	.byte	$02 ; Screen code for '"'
	.byte	$07 ; Screen code for '''
	.byte	$8D
	.byte	$EA
	.byte	$02 ; Screen code for '"'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$EF
	.byte	$8D
	.byte	$0D ; Screen code for '-'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$48 ; 'H'
	.byte	$4D ; 'M'
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$02 ; Screen code for '"'
	.byte	$4A ; 'J'
	.byte	$4D ; 'M'
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FD
	.byte	$4D ; 'M'
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$4D ; 'M'
	.byte	$03 ; Screen code for '#'
	.byte	$D3
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FD
	.byte	$4D ; 'M'
	.byte	$03 ; Screen code for '#'
	.byte	$D3
	.byte	$09 ; Screen code for ')'
	.byte	$F0
	.byte	$AA
	.byte	$AD
	.byte	$0F ; Screen code for '/'
	.byte	$D2
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$10 ; Screen code for '0'
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$E8
	.byte	$8E
	.byte	$EB
	.byte	$02 ; Screen code for '"'
	.byte	$68 ; 'h'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7D
	.byte	$8D
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$8C
	.byte	$ED
	.byte	$02 ; Screen code for '"'
	.byte	$10 ; Screen code for '0'
	.byte	$15 ; Screen code for '5'
	.byte	$D8
	.byte	$AD
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$ED
	.byte	$09 ; Screen code for ')'
	.byte	$02 ; Screen code for '"'
	.byte	$05 ; Screen code for '%'
	.byte	$8D
	.byte	$EB
	.byte	$02 ; Screen code for '"'
	.byte	$AD
	.byte	$0C ; Screen code for ','
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$ED
	.byte	$0B ; Screen code for '+'
	.byte	$02 ; Screen code for '"'
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$ED
	.byte	$02 ; Screen code for '"'
	.byte	$8C
	.byte	$EC
	.byte	$02 ; Screen code for '"'
	.byte	$C8
	.byte	$60
	.byte	$A5
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$C9
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$D0
	.byte	$5D
	.byte	$0E ; Screen code for '.'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$6E ; 'n'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$09 ; Screen code for ')'
	.byte	$A9
	.byte	$0D ; Screen code for '-'
	.byte	$85
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$05 ; Screen code for '%'
	.byte	$78 ; 'x'
	.byte	$B9
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$06 ; Screen code for '&'
	.byte	$16 ; Screen code for '6'
	.byte	$99
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$58 ; 'X'
	.byte	$A9
	.byte	$73 ; 's'
	.byte	$8D
	.byte	$0F ; Screen code for '/'
	.byte	$D2
	.byte	$8D
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$78 ; 'x'
	.byte	$8D
	.byte	$08 ; Screen code for '('
	.byte	$D2
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$01 ; Screen code for '!'
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$BD
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$D2
	.byte	$8D
	.byte	$04 ; Screen code for '$'
	.byte	$D2
	.byte	$BD
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$06 ; Screen code for '&'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$D2
	.byte	$8D
	.byte	$06 ; Screen code for '&'
	.byte	$D2
	.byte	$A9
	.byte	$A0
	.byte	$A2
	.byte	$06 ; Screen code for '&'
	.byte	$9D
	.byte	$01 ; Screen code for '!'
	.byte	$D2
	.byte	$CA
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F9
	.byte	$AD
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$F7
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$A5
	.byte	$10 ; Screen code for '0'
	.byte	$09 ; Screen code for ')'
	.byte	$F0
	.byte	$85
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$0E ; Screen code for '.'
	.byte	$D2
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$60
	.byte	$C9
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$D0
	.byte	$1B ; Screen code for ';'
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$45 ; 'E'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$8F
	.byte	$45 ; 'E'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$8D
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$A5
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$8D
	.byte	$06 ; Screen code for '&'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$A5
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$8D
	.byte	$08 ; Screen code for '('
	.byte	$02 ; Screen code for '"'
	.byte	$0B ; Screen code for '+'
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$60
	.byte	$C9
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$D0
	.byte	$0F ; Screen code for '/'
	.byte	$A5
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$6E ; 'n'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$C9
	.byte	$0A ; Screen code for '*'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$0B ; Screen code for '+'
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$60
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$70 ; 'p'
	.byte	$E6
	.byte	$10 ; Screen code for '0'
	.byte	$E4
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$97
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1A ; Screen code for ':'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$A9
	.byte	$13 ; Screen code for '3'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DF
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$14 ; Screen code for '4'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$1D ; Screen code for '='
	.byte	$A0
	.byte	$03 ; Screen code for '#'
	.byte	$C9
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$F0
	.byte	$0A ; Screen code for '*'
	.byte	$A0
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$0D ; Screen code for '-'
	.byte	$F0
	.byte	$04 ; Screen code for '$'
	.byte	$C9
	.byte	$9B ; '›'
	.byte	$D0
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F3
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$A9
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DF
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$A0
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F3
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$4C ; 'L'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$02 ; Screen code for '"'
	.byte	$07 ; Screen code for '''
	.byte	$A0
	.byte	$99
	.byte	$60
	.byte	$98
	.byte	$48 ; 'H'
	.byte	$AC
	.byte	$0B ; Screen code for '+'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$CC
	.byte	$0C ; Screen code for ','
	.byte	$02 ; Screen code for '"'
	.byte	$05 ; Screen code for '%'
	.byte	$F0
	.byte	$0E ; Screen code for '.'
	.byte	$C8
	.byte	$B9
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$8C
	.byte	$0B ; Screen code for '+'
	.byte	$02 ; Screen code for '"'
	.byte	$0B ; Screen code for '+'
	.byte	$8D
	.byte	$0D ; Screen code for '-'
	.byte	$D2
	.byte	$68 ; 'h'
	.byte	$A8
	.byte	$68 ; 'h'
	.byte	$40 ; '@'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$10 ; Screen code for '0'
	.byte	$02 ; Screen code for '"'
	.byte	$0A ; Screen code for '*'
	.byte	$68 ; 'h'
	.byte	$A8
	.byte	$A5
	.byte	$10 ; Screen code for '0'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$D0
	.byte	$0C ; Screen code for ','
	.byte	$AD
	.byte	$10 ; Screen code for '0'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$D0
	.byte	$EC
	.byte	$8D
	.byte	$0E ; Screen code for '.'
	.byte	$02 ; Screen code for '"'
	.byte	$12 ; Screen code for '2'
	.byte	$A5
	.byte	$10 ; Screen code for '0'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$F7
	.byte	$85
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$0E ; Screen code for '.'
	.byte	$D2
	.byte	$68 ; 'h'
	.byte	$40 ; '@'
	.byte	$98
	.byte	$48 ; 'H'
	.byte	$AD
	.byte	$0D ; Screen code for '-'
	.byte	$D2
	.byte	$AC
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$C8
	.byte	$99
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$8C
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$0C ; Screen code for ','
	.byte	$AD
	.byte	$0F ; Screen code for '/'
	.byte	$D2
	.byte	$8D
	.byte	$0A ; Screen code for '*'
	.byte	$D2
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$C0
	.byte	$CC
	.byte	$09 ; Screen code for ')'
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$D0
	.byte	$02 ; Screen code for '"'
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$0D ; Screen code for '-'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$4C ; 'L'
	.byte	$78 ; 'x'
	.byte	$04 ; Screen code for '$'
	.byte	$0A ; Screen code for '*'
	.byte	$AD
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$49 ; 'I'
	.byte	$02 ; Screen code for '"'
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$09 ; Screen code for ')'
	.byte	$02 ; Screen code for '"'
	.byte	$8D
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$68 ; 'h'
	.byte	$40 ; '@'
	.byte	$AD
	.byte	$03 ; Screen code for '#'
	.byte	$D3
	.byte	$49 ; 'I'
	.byte	$02 ; Screen code for '"'
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D3
	.byte	$68 ; 'h'
	.byte	$40 ; '@'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$BD
	.byte	$1A ; Screen code for ':'
	.byte	$03 ; Screen code for '#'
	.byte	$F0
	.byte	$0C ; Screen code for ','
	.byte	$C9
	.byte	$52 ; 'R'
	.byte	$F0
	.byte	$0D ; Screen code for '-'
	.byte	$E8
	.byte	$E8
	.byte	$E8
	.byte	$E0
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$90
	.byte	$F0
	.byte	$60
	.byte	$A9
	.byte	$52 ; 'R'
	.byte	$9D
	.byte	$1A ; Screen code for ':'
	.byte	$03 ; Screen code for '#'
	.byte	$A9
	.byte	$44 ; 'D'
	.byte	$9D
	.byte	$1B ; Screen code for ';'
	.byte	$03 ; Screen code for '#'
	.byte	$A9
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$9D
	.byte	$1C ; Screen code for '<'
	.byte	$03 ; Screen code for '#'
	.byte	$78 ; 'x'
	.byte	$A0
	.byte	$03 ; Screen code for '#'
	.byte	$B9
	.byte	$40 ; '@'
	.byte	$06 ; Screen code for '&'
	.byte	$0E ; Screen code for '.'
	.byte	$99
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$58 ; 'X'
	.byte	$A0
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$09 ; Screen code for ')'
	.byte	$02 ; Screen code for '"'
	.byte	$99
	.byte	$13 ; Screen code for '3'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$88
	.byte	$D0
	.byte	$F7
	.byte	$98
	.byte	$A0
	.byte	$0E ; Screen code for '.'
	.byte	$99
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$05 ; Screen code for '%'
	.byte	$88
	.byte	$D0
	.byte	$FA
	.byte	$EE
	.byte	$13 ; Screen code for '3'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$AD
	.byte	$13 ; Screen code for '3'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$BC
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$6E ; 'n'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$6A ; 'j'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$97
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$6E ; 'n'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1A ; Screen code for ':'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$A9
	.byte	$13 ; Screen code for '3'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DF
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$14 ; Screen code for '4'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$6B ; 'k'
	.byte	$A0
	.byte	$03 ; Screen code for '#'
	.byte	$C9
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$F0
	.byte	$0A ; Screen code for '*'
	.byte	$A0
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$0D ; Screen code for '-'
	.byte	$F0
	.byte	$04 ; Screen code for '$'
	.byte	$C9
	.byte	$9B ; '›'
	.byte	$D0
	.byte	$5B
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F3
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$56 ; 'V'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DF
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$A0
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F3
	.byte	$05 ; Screen code for '%'
	.byte	$09 ; Screen code for ')'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$4A ; 'J'
	.byte	$C9
	.byte	$0A ; Screen code for '*'
	.byte	$D0
	.byte	$B4
	.byte	$D8
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$04 ; Screen code for '$'
	.byte	$4A ; 'J'
	.byte	$08 ; Screen code for '('
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$03 ; Screen code for '#'
	.byte	$48 ; 'H'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$09 ; Screen code for ')'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$AA
	.byte	$68 ; 'h'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$0A ; Screen code for '*'
	.byte	$8D
	.byte	$11 ; Screen code for '1'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$6D ; 'm'
	.byte	$11 ; Screen code for '1'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$8E
	.byte	$11 ; Screen code for '1'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$6D ; 'm'
	.byte	$11 ; Screen code for '1'
	.byte	$02 ; Screen code for '"'
	.byte	$0D ; Screen code for '-'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$69 ; 'i'
	.byte	$63 ; 'c'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$6A ; 'j'
	.byte	$8D
	.byte	$11 ; Screen code for '1'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$A0
	.byte	$09 ; Screen code for ')'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F3
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$11 ; Screen code for '1'
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$10 ; Screen code for '0'
	.byte	$12 ; Screen code for '2'
	.byte	$A9
	.byte	$08 ; Screen code for '('
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DF
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$A0
	.byte	$11 ; Screen code for '1'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F3
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$06 ; Screen code for '&'
	.byte	$CE
	.byte	$13 ; Screen code for '3'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$4C ; 'L'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$02 ; Screen code for '"'
	.byte	$07 ; Screen code for '''
	.byte	$AD
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$09 ; Screen code for ')'
	.byte	$03 ; Screen code for '#'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$11 ; Screen code for '1'
	.byte	$02 ; Screen code for '"'
	.byte	$0E ; Screen code for '.'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$02 ; Screen code for '"'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FD
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$D3
	.byte	$AD
	.byte	$03 ; Screen code for '#'
	.byte	$D3
	.byte	$09 ; Screen code for ')'
	.byte	$03 ; Screen code for '#'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$11 ; Screen code for '1'
	.byte	$02 ; Screen code for '"'
	.byte	$0B ; Screen code for '+'
	.byte	$70 ; 'p'
	.byte	$02 ; Screen code for '"'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FD
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D3
	.byte	$C8
	.byte	$60
	.byte	$8D
	.byte	$0F ; Screen code for '/'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$AC
	.byte	$0F ; Screen code for '/'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$EE
	.byte	$0F ; Screen code for '/'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$B9
	.byte	$1F ; Screen code for '?'
	.byte	$06 ; Screen code for '&'
	.byte	$04 ; Screen code for '$'
	.byte	$F0
	.byte	$05 ; Screen code for '%'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AE
	.byte	$02 ; Screen code for '"'
	.byte	$05 ; Screen code for '%'
	.byte	$10 ; Screen code for '0'
	.byte	$F0
	.byte	$60
	.byte	$8C
	.byte	$0F ; Screen code for '/'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$CE
	.byte	$0F ; Screen code for '/'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$F0
	.byte	$05 ; Screen code for '%'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$10 ; Screen code for '0'
	.byte	$F6
	.byte	$60
	.byte	$AD
	.byte	$0E ; Screen code for '.'
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$D0
	.byte	$FB
	.byte	$85
	.byte	$11 ; Screen code for '1'
	.byte	$8D
	.byte	$12 ; Screen code for '2'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6C ; 'l'
	.byte	$02 ; Screen code for '"'
	.byte	$07 ; Screen code for '''
	.byte	$10 ; Screen code for '0'
	.byte	$09 ; Screen code for ')'
	.byte	$CA
	.byte	$D0
	.byte	$F8
	.byte	$CE
	.byte	$12 ; Screen code for '2'
	.byte	$02 ; Screen code for '"'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$D0
	.byte	$F3
	.byte	$98
	.byte	$08 ; Screen code for '('
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$66 ; 'f'
	.byte	$11 ; Screen code for '1'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$60
	.byte	$41 ; 'A'
	.byte	$54 ; 'T'
	.byte	$53 ; 'S'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$3F ; '?'
	.byte	$0D ; Screen code for '-'
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$54 ; 'T'
	.byte	$4F ; 'O'
	.byte	$0D ; Screen code for '-'
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$54 ; 'T'
	.byte	$48 ; 'H'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0D ; Screen code for '-'
	.byte	$00 ; Screen code for ' '
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$0B ; Screen code for '+'
	.byte	$E3
	.byte	$02 ; Screen code for '"'
	.byte	$9C
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$64 ; 'd'
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$89
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$C2
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$D4
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$6B ; 'k'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$AD
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$03 ; Screen code for '#'
	.byte	$01 ; Screen code for '!'
	.byte	$90
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$4C ; 'L'
	.byte	$10 ; Screen code for '0'
	.byte	$04 ; Screen code for '$'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$E0
	.byte	$02 ; Screen code for '"'
	.byte	$E1
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF

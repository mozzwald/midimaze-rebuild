	opt h-

RTCLOK	= $0012
L0080	= $0080
L0081	= $0081
L0083	= $0083
L0087	= $0087
L0088	= $0088
L008B	= $008B
L00A6	= $00A6
L00AD	= $00AD
L00AE	= $00AE
L00B3	= $00B3
L00B4	= $00B4
L00B5	= $00B5
L00B6	= $00B6
L00B7	= $00B7
L00B8	= $00B8
L00B9	= $00B9
L00BA	= $00BA
L00BB	= $00BB
L00BC	= $00BC
L00BD	= $00BD
L00C0	= $00C0
L00C1	= $00C1
L00C2	= $00C2
L00C3	= $00C3
L00C4	= $00C4
L00C5	= $00C5
L00C6	= $00C6
L00C7	= $00C7
L00C8	= $00C8
L00C9	= $00C9
L00CA	= $00CA
L00CB	= $00CB
L00CC	= $00CC
STICK0	= $0278
STRIG0	= $0284
ICCOM	= $0342
ICBAL	= $0344
ICBAH	= $0345
ICBLL	= $0348
ICBLH	= $0349
ICAX1	= $034A
L0600	= $0600
L0601	= $0601
L0602	= $0602
L0610	= $0610
L061F	= $061F
L0621	= $0621
L0622	= $0622
L10A2	= $10A2
L2B00	= $2B00
L3968	= $3968
L396B	= $396B
L396E	= $396E
L3AF2	= $3AF2
L3B42	= $3B42
L3B52	= $3B52
L3B62	= $3B62
L3CE6	= $3CE6
L3CE7	= $3CE7
L3CE8	= $3CE8
L3CE9	= $3CE9
L3CF9	= $3CF9
L3D09	= $3D09
L3D19	= $3D19
L3D29	= $3D29
L3DD7	= $3DD7
L3DFC	= $3DFC
L3EB9	= $3EB9
L3EBA	= $3EBA
L3EBB	= $3EBB
L3ECB	= $3ECB
L3ECC	= $3ECC
L3ECE	= $3ECE
L3ECF	= $3ECF
L3ED0	= $3ED0
L3ED1	= $3ED1
L3ED2	= $3ED2
L3EE1	= $3EE1
L3EE3	= $3EE3
L3EE4	= $3EE4
L3EE5	= $3EE5
L3EE6	= $3EE6
L3EE7	= $3EE7
L3EE8	= $3EE8
L3EE9	= $3EE9
L3EED	= $3EED
L3EEE	= $3EEE
L3EEF	= $3EEF
L3EF0	= $3EF0
L3F07	= $3F07
L3F0A	= $3F0A
L3F0D	= $3F0D
L414D	= $414D
L4C8C	= $4C8C
L4C9D	= $4C9D
L5DFF	= $5DFF
L5E00	= $5E00
L5E1F	= $5E1F
L5ECF	= $5ECF
L5F80	= $5F80
L5F9F	= $5F9F
L72C1	= $72C1
L72CD	= $72CD
L72CE	= $72CE
L72CF	= $72CF
L72E0	= $72E0
L7300	= $7300
L7320	= $7320
L7340	= $7340
L7341	= $7341
L7342	= $7342
L7343	= $7343
L7360	= $7360
L7361	= $7361
L7362	= $7362
L7363	= $7363
L7370	= $7370
LAF1D	= $AF1D
LAF36	= $AF36
LAF76	= $AF76
LAF82	= $AF82
LAFDA	= $AFDA
LAFDD	= $AFDD
LAFE0	= $AFE0
LAFF6	= $AFF6
LB0AE	= $B0AE
LB0C7	= $B0C7
LB0D5	= $B0D5
CONSOL	= $D01F
CIOV	= $E456
	org $8000
START1	JMP	L8080
	.byte	$4C ; 'L'
L8004	.byte	$2F,$9D,$4C ; (undocumented opcode) - RLA L4C9D
	STX	L0083
	JMP	L88BE
	.byte	$4C ; 'L'
L800D	TYA
	DEY
	JMP	L94F4
	.byte	$4C ; 'L'
L8013	DCP	L4C8C,Y	; (undocumented opcode)
	.byte	$53,$8B ; (undocumented opcode) - SRE (L008B),Y
	JMP	L8048
	.byte	$4C ; 'L'
	.byte	$05 ; Screen code for '%'
	.byte	$92
	.byte	$4C ; 'L'
	.byte	$4B ; 'K'
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$AB
	.byte	$88
	.byte	$4C ; 'L'
	.byte	$6B ; 'k'
	.byte	$95
	.byte	$4C ; 'L'
	.byte	$7B
	.byte	$97
L802A	LDA	RTCLOK+2
	CMP	L3ECE
	BMI	L8047
	CLC
	ADC	#$14
	STA	L3ECE
	LDX	L3ED1
	CPX	#$1D
	BCC	L803F
	DEX
L803F	LDA	L7363,X
	EOR	#$80
	STA	L7363,X
L8047	RTS
L8048	LDX	#$0F
	LDA	#$00
L804C	STA	L7360,X
	STA	L7370,X
	DEX
	BPL	L804C
	LDA	#$1E
	STA	L7360
	STA	L7361
	STA	L7362
	LDX	#$0F
	LDA	#$00
L8064	STA	L3EBB,X
	DEX
	BPL	L8064
	STA	L3EB9
	STA	L3EE7
	STA	L3EE8
	LDA	RTCLOK+2
	STA	L3ECE
	LDA	#$01
	STA	L3EBA
	JMP	LAF36
L8080	LDX	L3EB9
	BEQ	L808E
	DEX
	BNE	L808B
	JMP	L8188
L808B	JMP	L81E4
L808E	LDA	L396B
	STA	L3ECC
	LDA	L3EE8
	BEQ	L80A1
	LDX	#$00
	STX	L3EE8
	JMP	L8115
L80A1	JSR	LAF82
	BEQ	L811F
	JSR	LAF76
	CMP	#$9B
	BNE	L80C5
	LDX	#$1C
	LDA	#$00
L80B1	STA	L7363,X
	DEX
	BPL	L80B1
	LDA	#$00
	STA	L3ED1
	LDA	RTCLOK+2
	STA	L3ECE
	LDA	#$0D
	BNE	L8110
L80C5	CMP	#$7E
	BNE	L80E1
	LDX	L3ED1
	BEQ	L811F
	LDA	#$00
	CPX	#$1D
	BCS	L80D7
	STA	L7363,X
L80D7	STA	L7362,X
	DEC	L3ED1
	LDA	#$08
	BNE	L8110
L80E1	CMP	#$7F
	BNE	L80F0
	LDA	L3CE8
	EOR	#$01
	STA	L3CE8
	JMP	L811F
L80F0	CMP	#$1B
	BNE	L80FC
	LDA	#$01
	STA	L3F0A
	JMP	L811F
L80FC	PHA
	JSR	LAFF6
	LDX	L3ED1
	CPX	#$1D
	BCC	L8108
	DEX
L8108	STA	L7363,X
	INX
	STX	L3ED1
	PLA
L8110	LDX	RTCLOK+2
	STX	L3ECE
L8115	LDX	L3968
	STA	L2B00,X
	LDA	#$80
	BNE	L8129
L811F	LDX	L3968
	LDA	#$FF
	STA	L2B00,X
	LDA	#$00
L8129	STA	L0080
	LDA	STICK0
	EOR	#$0F
	LDX	STRIG0
	BNE	L8137
	ORA	#$10
L8137	TAY
	BNE	L8146
	LDA	L3EE9
	TAY
	AND	#$03
	STA	L3EE9
	TYA
	BPL	L814B
L8146	LDY	#$00
	STY	L3EE9
L814B	ORA	L0080
	LDX	L3968
	STA	L3D29,X
	DEC	L3ECC
	BNE	L815B
	JMP	L821E
L815B	JSR	LAFDD
	BNE	L8185
	LDX	L3968
	LDA	L3D29,X
	BPL	L8170
	LDA	L2B00,X
	JSR	LAFDD
	BNE	L8185
L8170	LDA	L3968
	STA	L3ECB
	INC	L3EB9
	CLC
	LDA	L00B3
	ADC	L3ED0
	STA	L3ECF
	JSR	L802A
L8185	JMP	LAF36
L8188	JSR	LAFE0
	BEQ	L81D2
	CLC
	LDA	L00B3
	ADC	L3ED0
	STA	L3ECF
	JSR	LAFDA
	BNE	L81C0
	LDX	L3ECB
	BNE	L81A3
	LDX	L396B
L81A3	DEX
	STX	L3ECB
	STA	L3D29,X
	TAY
	BMI	L81C3
	LDA	#$FF
	STA	L2B00,X
	DEC	L3ECC
	BEQ	L821E
	TYA
	JSR	LAFDD
	BNE	L81C0
L81BD	JSR	L802A
L81C0	JMP	LAF36
L81C3	INC	L3EB9
	DEC	L3ECC
	BEQ	L81BD
	JSR	LAFDD
	BNE	L81C0
	BEQ	L81BD
L81D2	LDA	L00B3
	CMP	L3ECF
	BMI	L81DE
	LDA	#$C7
	STA	L3ED2
L81DE	JSR	L802A
	JMP	LAF36
L81E4	JSR	LAFE0
	BEQ	L81D2
	CLC
	LDA	L00B3
	ADC	L3ED0
	STA	L3ECF
	JSR	LAFDA
	BNE	L820D
	LDX	L3ECB
	STA	L2B00,X
	LDX	L3ECC
	BEQ	L821E
	JSR	LAFDD
	BNE	L820D
	DEC	L3EB9
	JSR	L802A
L820D	JMP	LAF36
	.byte	$A5
	.byte	$B3
	.byte	$CD
	.byte	$CF
	.byte	$3E ; '>'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$F3
	.byte	$A9
	.byte	$C7
	.byte	$8D
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$EC
L821E	LDX	#$00
	STX	L3EB9
	STX	L3ECB
L8226	LDA	L3D29,X
	BMI	L822E
	JMP	L82B9
L822E	LDA	L82CD,X
	STA	L00B4
	LDA	L82DD,X
	STA	L00B5
	LDA	L2B00,X
	BPL	L8246
	CMP	#$FF
	BEQ	L82B9
	STA	L3EE7
	BNE	L82B9
L8246	CMP	#$08
	BNE	L824F
	DEC	L3EBB,X
	BPL	L82B9
L824F	CMP	#$0D
	BNE	L829F
	LDY	#$1F
L8255	LDA	L7300,Y
	STA	L72E0,Y
	LDA	L7320,Y
	STA	L7300,Y
	LDA	L7340,Y
	STA	L7320,Y
	LDA	#$00
	STA	L7340,Y
	DEY
	BPL	L8255
	INX
	TXA
	CMP	#$0A
	BCC	L827D
	LDX	#$11
	STX	L7340
	SEC
	SBC	#$0A
L827D	ORA	#$10
	STA	L7341
	LDA	#$1A
	STA	L7342
	LDX	L3ECB
	LDA	L3EBB,X
	TAY
	BPL	L8295
L8290	LDA	(L00B4),Y
	STA	L7343,Y
L8295	DEY
	BPL	L8290
	LDA	#$00
	STA	L3EBB,X
	BEQ	L82B9
L829F	JSR	LAFF6
	STA	L0080
	LDX	L3ECB
	LDA	L3EBB,X
	TAY
	CPY	#$1D
	BCC	L82B0
	DEY
L82B0	LDA	L0080
	STA	(L00B4),Y
	INY
	TYA
	STA	L3EBB,X
L82B9	INC	L3ECB
	LDX	L3ECB
	CPX	L396B
	BCS	L82C7
	JMP	L8226
L82C7	JSR	L802A
	JMP	LAF36
L82CD	.byte	$10 ; Screen code for '0'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$4E ; 'N'
	.byte	$6D ; 'm'
	.byte	$8C
	.byte	$AB
	.byte	$CA
	.byte	$E9
	.byte	$08 ; Screen code for '('
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$46 ; 'F'
	.byte	$65 ; 'e'
	.byte	$84
	.byte	$A3
	.byte	$C2
	.byte	$E1
L82DD	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$45 ; 'E'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$83
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$8B
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$4C ; 'L'
	.byte	$83
	.byte	$74 ; 't'
	.byte	$83
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$AB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$52 ; 'R'
	.byte	$83
	.byte	$74 ; 't'
	.byte	$83
	.byte	$01 ; Screen code for '!'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$CB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$5C
	.byte	$83
	.byte	$74 ; 't'
	.byte	$83
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$EB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$63 ; 'c'
	.byte	$83
	.byte	$74 ; 't'
	.byte	$83
	.byte	$03 ; Screen code for '#'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$0B ; Screen code for '+'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$6A ; 'j'
	.byte	$83
	.byte	$74 ; 't'
	.byte	$83
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$65 ; 'e'
	.byte	$6C ; 'l'
	.byte	$65 ; 'e'
	.byte	$63 ; 'c'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$77 ; 'w'
	.byte	$69 ; 'i'
	.byte	$74 ; 't'
	.byte	$68 ; 'h'
	.byte	$00 ; Screen code for ' '
	.byte	$6A ; 'j'
	.byte	$6F ; 'o'
	.byte	$79 ; 'y'
	.byte	$73 ; 's'
	.byte	$74 ; 't'
	.byte	$69 ; 'i'
	.byte	$63 ; 'c'
	.byte	$6B ; 'k'
	.byte	$1A ; Screen code for ':'
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$13 ; Screen code for '3'
	.byte	$10 ; Screen code for '0'
	.byte	$11 ; Screen code for '1'
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$12 ; Screen code for '2'
	.byte	$11 ; Screen code for '1'
	.byte	$12 ; Screen code for '2'
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$11 ; Screen code for '1'
	.byte	$1A ; Screen code for ':'
	.byte	$08 ; Screen code for '('
	.byte	$18 ; Screen code for '8'
	.byte	$15 ; Screen code for '5'
	.byte	$10 ; Screen code for '0'
	.byte	$09 ; Screen code for ')'
	.byte	$FF
	.byte	$A5
	.byte	$C3
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$A5
	.byte	$C6
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A9
	.byte	$ED
	.byte	$85
	.byte	$BC
	.byte	$A9
	.byte	$82
	.byte	$85
	.byte	$BD
	.byte	$A9
	.byte	$06 ; Screen code for '&'
	.byte	$85
	.byte	$B7
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$85
	.byte	$C6
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$E8
	.byte	$E4
	.byte	$B7
	.byte	$90
	.byte	$F8
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9B ; '›'
	.byte	$4C ; 'L'
	.byte	$01 ; Screen code for '!'
	.byte	$9D
L83A7	LDA	#$00
	TAX
L83AA	STA	L0600,X
	INX
	CPX	L00B7
	BCC	L83AA
	LDX	L3968
	LDY	#$02
	LDA	L3D19,X
	CMP	#$0A
	BEQ	L83BF
	INY
L83BF	LDA	#$01
	STA	L0600,Y
	LDY	#$05
	LDA	L3D09,X
	CMP	#$64
	BEQ	L83CE
	INY
L83CE	LDA	#$01
	STA	L0600,Y
	LDY	#$08
	LDA	L3CF9,X
	CMP	#$32
	BEQ	L83DD
	INY
L83DD	LDA	#$01
	STA	L0600,Y
	LDY	#$0B
	LDA	L3CE9,X
	CMP	#$01
	BEQ	L83F1
	INY
	CMP	#$02
	BEQ	L83F1
	INY
L83F1	LDA	#$01
	STA	L0600,Y
	LDY	#$0F
	LDA	L3B42,X
	BEQ	L83FE
	INY
L83FE	LDA	#$01
	STA	L0600,Y
	LDY	#$12
	LDA	L3B52,X
	BEQ	L840B
	INY
L840B	LDA	#$01
	STA	L0600,Y
	LDY	#$15
	LDA	L3B62,X
	CMP	#$08
	BEQ	L841A
	INY
L841A	LDA	#$01
	STA	L0600,Y
	LDY	#$19
	LDA	L3CE6
	BEQ	L8428
	LDY	#$1A
L8428	LDA	#$01
	STA	L0600,Y
	JSR	L9BFE
	JMP	L9D01
	.byte	$0D ; Screen code for '-'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$8F
	.byte	$85
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$1C ; Screen code for '<'
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$96
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$5D
	.byte	$86
	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$5D
	.byte	$86
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$43 ; 'C'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$4F ; 'O'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$9A
	.byte	$86
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$56 ; 'V'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$9A
	.byte	$86
	.byte	$03 ; Screen code for '#'
	.byte	$09 ; Screen code for ')'
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$63 ; 'c'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$AD
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$6F ; 'o'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$D7
	.byte	$86
	.byte	$05 ; Screen code for '%'
	.byte	$0B ; Screen code for '+'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$76 ; 'v'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$D7
	.byte	$86
	.byte	$06 ; Screen code for '&'
	.byte	$0D ; Screen code for '-'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$83
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$C7
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$8F
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$E3
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$92
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$E7
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$0B ; Screen code for '+'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$95
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$EB
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$A3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$EF
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AF
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$92
	.byte	$87
	.byte	$0B ; Screen code for '+'
	.byte	$12 ; Screen code for '2'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$B6
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$92
	.byte	$87
	.byte	$0D ; Screen code for '-'
	.byte	$13 ; Screen code for '3'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$0F ; Screen code for '/'
	.byte	$C3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$FC
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$CF
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$D5
	.byte	$87
	.byte	$0F ; Screen code for '/'
	.byte	$15 ; Screen code for '5'
	.byte	$12 ; Screen code for '2'
	.byte	$13 ; Screen code for '3'
	.byte	$13 ; Screen code for '3'
	.byte	$D6
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$D5
	.byte	$87
	.byte	$10 ; Screen code for '0'
	.byte	$16 ; Screen code for '6'
	.byte	$12 ; Screen code for '2'
	.byte	$13 ; Screen code for '3'
	.byte	$12 ; Screen code for '2'
	.byte	$E3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$09 ; Screen code for ')'
	.byte	$86
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$EF
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$12 ; Screen code for '2'
	.byte	$88
	.byte	$12 ; Screen code for '2'
	.byte	$17 ; Screen code for '7'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$F6
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$12 ; Screen code for '2'
	.byte	$88
	.byte	$13 ; Screen code for '3'
	.byte	$17 ; Screen code for '7'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$15 ; Screen code for '5'
	.byte	$0D ; Screen code for '-'
	.byte	$5F
	.byte	$06 ; Screen code for '&'
	.byte	$13 ; Screen code for '3'
	.byte	$86
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$15 ; Screen code for '5'
	.byte	$18 ; Screen code for '8'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$5F
	.byte	$0E ; Screen code for '.'
	.byte	$1A ; Screen code for ':'
	.byte	$86
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$17 ; Screen code for '7'
	.byte	$19 ; Screen code for '9'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$47 ; 'G'
	.byte	$5F
	.byte	$09 ; Screen code for ')'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$86
	.byte	$4F ; 'O'
	.byte	$88
	.byte	$18 ; Screen code for '8'
	.byte	$1B ; Screen code for ';'
	.byte	$19 ; Screen code for '9'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$52 ; 'R'
	.byte	$5F
	.byte	$07 ; Screen code for '''
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$86
	.byte	$74 ; 't'
	.byte	$88
	.byte	$18 ; Screen code for '8'
	.byte	$1B ; Screen code for ';'
	.byte	$19 ; Screen code for '9'
	.byte	$1A ; Screen code for ':'
	.byte	$19 ; Screen code for '9'
	.byte	$6C ; 'l'
	.byte	$5F
	.byte	$08 ; Screen code for '('
	.byte	$3B ; ';'
	.byte	$86
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$19 ; Screen code for '9'
	.byte	$1C ; Screen code for '<'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$8D
	.byte	$5F
	.byte	$06 ; Screen code for '&'
	.byte	$44 ; 'D'
	.byte	$86
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$1B ; Screen code for ';'
	.byte	$00 ; Screen code for ' '
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$3B ; ';'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$65 ; 'e'
	.byte	$6C ; 'l'
	.byte	$6F ; 'o'
	.byte	$61 ; 'a'
	.byte	$64 ; 'd'
	.byte	$00 ; Screen code for ' '
	.byte	$74 ; 't'
	.byte	$69 ; 'i'
	.byte	$6D ; 'm'
	.byte	$65 ; 'e'
	.byte	$FF
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$65 ; 'e'
	.byte	$67 ; 'g'
	.byte	$65 ; 'e'
	.byte	$6E ; 'n'
	.byte	$00 ; Screen code for ' '
	.byte	$74 ; 't'
	.byte	$69 ; 'i'
	.byte	$6D ; 'm'
	.byte	$65 ; 'e'
	.byte	$FF
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$65 ; 'e'
	.byte	$76 ; 'v'
	.byte	$69 ; 'i'
	.byte	$76 ; 'v'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$74 ; 't'
	.byte	$69 ; 'i'
	.byte	$6D ; 'm'
	.byte	$65 ; 'e'
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$65 ; 'e'
	.byte	$76 ; 'v'
	.byte	$69 ; 'i'
	.byte	$76 ; 'v'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$77 ; 'w'
	.byte	$69 ; 'i'
	.byte	$74 ; 't'
	.byte	$68 ; 'h'
	.byte	$00 ; Screen code for ' '
	.byte	$3B ; ';'
	.byte	$11 ; Screen code for '1'
	.byte	$3D ; '='
	.byte	$3B ; ';'
	.byte	$12 ; Screen code for '2'
	.byte	$3D ; '='
	.byte	$3B ; ';'
	.byte	$13 ; Screen code for '3'
	.byte	$3D ; '='
	.byte	$00 ; Screen code for ' '
	.byte	$6C ; 'l'
	.byte	$69 ; 'i'
	.byte	$76 ; 'v'
	.byte	$65 ; 'e'
	.byte	$73 ; 's'
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$11 ; Screen code for '1'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$12 ; Screen code for '2'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$13 ; Screen code for '3'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$6C ; 'l'
	.byte	$61 ; 'a'
	.byte	$79 ; 'y'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$70 ; 'p'
	.byte	$65 ; 'e'
	.byte	$65 ; 'e'
	.byte	$64 ; 'd'
	.byte	$FF
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$75 ; 'u'
	.byte	$6C ; 'l'
	.byte	$6C ; 'l'
	.byte	$65 ; 'e'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$70 ; 'p'
	.byte	$65 ; 'e'
	.byte	$65 ; 'e'
	.byte	$64 ; 'd'
	.byte	$FF
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$75 ; 'u'
	.byte	$72 ; 'r'
	.byte	$6E ; 'n'
	.byte	$00 ; Screen code for ' '
	.byte	$72 ; 'r'
	.byte	$61 ; 'a'
	.byte	$74 ; 't'
	.byte	$65 ; 'e'
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$08 ; Screen code for '('
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$A5
	.byte	$C6
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$F6
	.byte	$A6
	.byte	$C6
	.byte	$E0
	.byte	$02 ; Screen code for '"'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$03 ; Screen code for '#'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$0A ; Screen code for '*'
	.byte	$D0
	.byte	$14 ; Screen code for '4'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$FF
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$1E ; Screen code for '>'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$9D
	.byte	$19 ; Screen code for '9'
	.byte	$3D ; '='
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$B9
	.byte	$A6
	.byte	$C6
	.byte	$E0
	.byte	$05 ; Screen code for '%'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$64 ; 'd'
	.byte	$D0
	.byte	$14 ; Screen code for '4'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$FF
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$05 ; Screen code for '%'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$C8
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$9D
	.byte	$09 ; Screen code for ')'
	.byte	$3D ; '='
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A6
	.byte	$C6
	.byte	$E0
	.byte	$08 ; Screen code for '('
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$09 ; Screen code for ')'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$D0
	.byte	$14 ; Screen code for '4'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$FF
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$08 ; Screen code for '('
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$64 ; 'd'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$9D
	.byte	$F9
	.byte	$3C ; '<'
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$F6
	.byte	$A6
	.byte	$C6
	.byte	$E0
	.byte	$0B ; Screen code for '+'
	.byte	$D0
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$0B ; Screen code for '+'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$0C ; Screen code for ','
	.byte	$06 ; Screen code for '&'
	.byte	$8D
	.byte	$0D ; Screen code for '-'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$D0
	.byte	$44 ; 'D'
	.byte	$E0
	.byte	$0C ; Screen code for ','
	.byte	$D0
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$0C ; Screen code for ','
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$0B ; Screen code for '+'
	.byte	$06 ; Screen code for '&'
	.byte	$8D
	.byte	$0D ; Screen code for '-'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$0B ; Screen code for '+'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$02 ; Screen code for '"'
	.byte	$D0
	.byte	$1F ; Screen code for '?'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$0D ; Screen code for '-'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$0B ; Screen code for '+'
	.byte	$06 ; Screen code for '&'
	.byte	$8D
	.byte	$0C ; Screen code for ','
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$0B ; Screen code for '+'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$03 ; Screen code for '#'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$9D
	.byte	$E9
	.byte	$3C ; '<'
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A6
	.byte	$C6
	.byte	$E0
	.byte	$0F ; Screen code for '/'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$10 ; Screen code for '0'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$F0
	.byte	$14 ; Screen code for '4'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$FF
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$0F ; Screen code for '/'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$9D
	.byte	$42 ; 'B'
	.byte	$3B ; ';'
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$F6
	.byte	$A6
	.byte	$C6
	.byte	$E0
	.byte	$12 ; Screen code for '2'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$13 ; Screen code for '3'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$F0
	.byte	$14 ; Screen code for '4'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$FF
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$12 ; Screen code for '2'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$9D
	.byte	$52 ; 'R'
	.byte	$3B ; ';'
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$B9
	.byte	$A6
	.byte	$C6
	.byte	$E0
	.byte	$15 ; Screen code for '5'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$16 ; Screen code for '6'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$08 ; Screen code for '('
	.byte	$D0
	.byte	$14 ; Screen code for '4'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$FF
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$15 ; Screen code for '5'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$04 ; Screen code for '$'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$9D
	.byte	$62 ; 'b'
	.byte	$3B ; ';'
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$1B ; Screen code for ';'
	.byte	$8D
	.byte	$E6
	.byte	$3C ; '<'
	.byte	$8D
	.byte	$1A ; Screen code for ':'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$19 ; Screen code for '9'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$1A ; Screen code for ':'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A2
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$F6
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$8D
	.byte	$19 ; Screen code for '9'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$E6
	.byte	$3C ; '<'
	.byte	$8D
	.byte	$1A ; Screen code for ':'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$19 ; Screen code for '9'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A2
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A5
	.byte	$C6
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A9
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$85
	.byte	$BC
	.byte	$A9
	.byte	$84
	.byte	$85
	.byte	$BD
	.byte	$A9
	.byte	$1D ; Screen code for '='
	.byte	$85
	.byte	$B7
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$C6
	.byte	$4C ; 'L'
	.byte	$A7
	.byte	$83
	.byte	$A9
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$85
	.byte	$BC
	.byte	$A9
	.byte	$8A
	.byte	$85
	.byte	$BD
	.byte	$A9
	.byte	$17 ; Screen code for '7'
	.byte	$85
	.byte	$B7
	.byte	$A9
	.byte	$02 ; Screen code for '"'
	.byte	$85
	.byte	$C6
	.byte	$4C ; 'L'
	.byte	$A7
	.byte	$83
L88BE	LDA	#$D1
	STA	L00BC
	LDA	#$88
	STA	L00BD
	LDA	#$1D
	STA	L00B7
	LDA	#$00
	STA	L00C6
	JMP	L83A7
	.byte	$0D ; Screen code for '-'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$8F
	.byte	$85
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$1C ; Screen code for '<'
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$43 ; 'C'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$96
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$4F ; 'O'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$5D
	.byte	$86
	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$56 ; 'V'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$5D
	.byte	$86
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$63 ; 'c'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$6F ; 'o'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$9A
	.byte	$86
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$76 ; 'v'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$9A
	.byte	$86
	.byte	$03 ; Screen code for '#'
	.byte	$09 ; Screen code for ')'
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$83
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$AD
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$8F
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$D7
	.byte	$86
	.byte	$05 ; Screen code for '%'
	.byte	$0B ; Screen code for '+'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$96
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$D7
	.byte	$86
	.byte	$06 ; Screen code for '&'
	.byte	$0D ; Screen code for '-'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$A3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$C7
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AF
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$E3
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$08 ; Screen code for '('
	.byte	$17 ; Screen code for '7'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$B2
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$E7
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$08 ; Screen code for '('
	.byte	$17 ; Screen code for '7'
	.byte	$0B ; Screen code for '+'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$B5
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$EB
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$09 ; Screen code for ')'
	.byte	$17 ; Screen code for '7'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$A3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AF
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$92
	.byte	$87
	.byte	$0B ; Screen code for '+'
	.byte	$12 ; Screen code for '2'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$B6
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$92
	.byte	$87
	.byte	$0D ; Screen code for '-'
	.byte	$13 ; Screen code for '3'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$0F ; Screen code for '/'
	.byte	$C3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$CF
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$D5
	.byte	$87
	.byte	$0F ; Screen code for '/'
	.byte	$15 ; Screen code for '5'
	.byte	$12 ; Screen code for '2'
	.byte	$13 ; Screen code for '3'
	.byte	$13 ; Screen code for '3'
	.byte	$D6
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$D5
	.byte	$87
	.byte	$10 ; Screen code for '0'
	.byte	$16 ; Screen code for '6'
	.byte	$12 ; Screen code for '2'
	.byte	$13 ; Screen code for '3'
	.byte	$12 ; Screen code for '2'
	.byte	$E3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$EF
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$12 ; Screen code for '2'
	.byte	$88
	.byte	$12 ; Screen code for '2'
	.byte	$17 ; Screen code for '7'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$F6
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$12 ; Screen code for '2'
	.byte	$88
	.byte	$13 ; Screen code for '3'
	.byte	$17 ; Screen code for '7'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$15 ; Screen code for '5'
	.byte	$ED
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$13 ; Screen code for '3'
	.byte	$86
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$0B ; Screen code for '+'
	.byte	$18 ; Screen code for '8'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$09 ; Screen code for ')'
	.byte	$5F
	.byte	$0E ; Screen code for '.'
	.byte	$1A ; Screen code for ':'
	.byte	$86
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$17 ; Screen code for '7'
	.byte	$19 ; Screen code for '9'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$5F
	.byte	$09 ; Screen code for ')'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$86
	.byte	$4F ; 'O'
	.byte	$88
	.byte	$18 ; Screen code for '8'
	.byte	$1C ; Screen code for '<'
	.byte	$19 ; Screen code for '9'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$5F
	.byte	$07 ; Screen code for '''
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$86
	.byte	$74 ; 't'
	.byte	$88
	.byte	$18 ; Screen code for '8'
	.byte	$1C ; Screen code for '<'
	.byte	$19 ; Screen code for '9'
	.byte	$1A ; Screen code for ':'
	.byte	$19 ; Screen code for '9'
	.byte	$4C ; 'L'
	.byte	$5F
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$8B
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$6D ; 'm'
	.byte	$5F
	.byte	$06 ; Screen code for '&'
	.byte	$44 ; 'D'
	.byte	$86
	.byte	$4B ; 'K'
	.byte	$86
	.byte	$19 ; Screen code for '9'
	.byte	$00 ; Screen code for ' '
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$08 ; Screen code for '('
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$42 ; 'B'
	.byte	$8B
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$63 ; 'c'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$96
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$6F ; 'o'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$5D
	.byte	$86
	.byte	$15 ; Screen code for '5'
	.byte	$05 ; Screen code for '%'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$76 ; 'v'
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$5D
	.byte	$86
	.byte	$16 ; Screen code for '6'
	.byte	$06 ; Screen code for '&'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$83
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$8F
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$9A
	.byte	$86
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$96
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$9A
	.byte	$86
	.byte	$03 ; Screen code for '#'
	.byte	$09 ; Screen code for ')'
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$A3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$AD
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AF
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$D7
	.byte	$86
	.byte	$05 ; Screen code for '%'
	.byte	$0B ; Screen code for '+'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$B6
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$D7
	.byte	$86
	.byte	$06 ; Screen code for '&'
	.byte	$0D ; Screen code for '-'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$C3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$C7
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$CF
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$E3
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$D2
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$E7
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$0B ; Screen code for '+'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$D5
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$EB
	.byte	$85
	.byte	$1A ; Screen code for ':'
	.byte	$87
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$E3
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$EF
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$EF
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$92
	.byte	$87
	.byte	$0B ; Screen code for '+'
	.byte	$12 ; Screen code for '2'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$F6
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$92
	.byte	$87
	.byte	$0D ; Screen code for '-'
	.byte	$13 ; Screen code for '3'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$0F ; Screen code for '/'
	.byte	$03 ; Screen code for '#'
	.byte	$5F
	.byte	$00 ; Screen code for ' '
	.byte	$FC
	.byte	$85
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$5F
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$D5
	.byte	$87
	.byte	$0F ; Screen code for '/'
	.byte	$15 ; Screen code for '5'
	.byte	$12 ; Screen code for '2'
	.byte	$13 ; Screen code for '3'
	.byte	$13 ; Screen code for '3'
	.byte	$16 ; Screen code for '6'
	.byte	$5F
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$D5
	.byte	$87
	.byte	$10 ; Screen code for '0'
	.byte	$16 ; Screen code for '6'
	.byte	$12 ; Screen code for '2'
	.byte	$13 ; Screen code for '3'
	.byte	$12 ; Screen code for '2'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$5F
	.byte	$00 ; Screen code for ' '
	.byte	$09 ; Screen code for ')'
	.byte	$86
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$5F
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$85
	.byte	$12 ; Screen code for '2'
	.byte	$88
	.byte	$12 ; Screen code for '2'
	.byte	$02 ; Screen code for '"'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$5F
	.byte	$06 ; Screen code for '&'
	.byte	$C0
	.byte	$85
	.byte	$12 ; Screen code for '2'
	.byte	$88
	.byte	$13 ; Screen code for '3'
	.byte	$03 ; Screen code for '#'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$15 ; Screen code for '5'
	.byte	$FF
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$6C ; 'l'
	.byte	$61 ; 'a'
	.byte	$76 ; 'v'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$00 ; Screen code for ' '
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$70 ; 'p'
	.byte	$74 ; 't'
	.byte	$69 ; 'i'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$73 ; 's'
	.byte	$FF
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$B1
	.byte	$85
	.byte	$B2
	.byte	$AD
	.byte	$BA
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$10 ; Screen code for '0'
	.byte	$AE
	.byte	$D1
	.byte	$3E ; '>'
	.byte	$E0
	.byte	$1D ; Screen code for '='
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$CA
	.byte	$BD
	.byte	$63 ; 'c'
	.byte	$73 ; 's'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$9D
	.byte	$63 ; 'c'
	.byte	$73 ; 's'
	.byte	$A2
	.byte	$0A ; Screen code for '*'
	.byte	$A9
	.byte	$3F ; '?'
	.byte	$9D
	.byte	$AC
	.byte	$3E ; '>'
	.byte	$CA
	.byte	$D0
	.byte	$FA
	.byte	$A9
	.byte	$3B ; ';'
	.byte	$8D
	.byte	$AC
	.byte	$3E ; '>'
	.byte	$A9
	.byte	$3D ; '='
	.byte	$8D
	.byte	$B7
	.byte	$3E ; '>'
	.byte	$A9
	.byte	$FF
	.byte	$8D
	.byte	$B8
	.byte	$3E ; '>'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$AE
	.byte	$B0
	.byte	$AA
	.byte	$85
	.byte	$A6
	.byte	$BD
	.byte	$FC
	.byte	$3D ; '='
	.byte	$85
	.byte	$B8
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$E8
	.byte	$10 ; Screen code for '0'
	.byte	$08 ; Screen code for '('
	.byte	$BD
	.byte	$FC
	.byte	$3D ; '='
	.byte	$99
	.byte	$AD
	.byte	$3E ; '>'
	.byte	$E8
	.byte	$C8
	.byte	$C6
	.byte	$B8
	.byte	$10 ; Screen code for '0'
	.byte	$F4
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$E3
	.byte	$3E ; '>'
	.byte	$A9
	.byte	$FF
	.byte	$8D
	.byte	$E5
	.byte	$3E ; '>'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$E8
	.byte	$8A
	.byte	$C9
	.byte	$0A ; Screen code for '*'
	.byte	$90
	.byte	$08 ; Screen code for '('
	.byte	$A2
	.byte	$11 ; Screen code for '1'
	.byte	$8E
	.byte	$E3
	.byte	$3E ; '>'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$E9
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$E4
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9B ; '›'
	.byte	$A9
	.byte	$AF
	.byte	$85
	.byte	$AD
	.byte	$A9
	.byte	$8C
	.byte	$85
	.byte	$AE
	.byte	$A9
	.byte	$85
	.byte	$85
	.byte	$CB
	.byte	$A9
	.byte	$5E
	.byte	$85
	.byte	$CC
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$4F ; 'O'
	.byte	$9C
	.byte	$A9
	.byte	$AC
	.byte	$85
	.byte	$AD
	.byte	$A9
	.byte	$3E ; '>'
	.byte	$85
	.byte	$AE
	.byte	$A9
	.byte	$8A
	.byte	$85
	.byte	$CB
	.byte	$A9
	.byte	$5E
	.byte	$85
	.byte	$CC
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$4F ; 'O'
	.byte	$9C
	.byte	$A9
	.byte	$C1
	.byte	$85
	.byte	$AD
	.byte	$A9
	.byte	$8C
	.byte	$85
	.byte	$AE
	.byte	$A9
	.byte	$05 ; Screen code for '%'
	.byte	$85
	.byte	$CB
	.byte	$A9
	.byte	$5F
	.byte	$85
	.byte	$CC
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$4F ; 'O'
	.byte	$9C
	.byte	$A9
	.byte	$E3
	.byte	$85
	.byte	$AD
	.byte	$A9
	.byte	$3E ; '>'
	.byte	$85
	.byte	$AE
	.byte	$A9
	.byte	$0E ; Screen code for '.'
	.byte	$85
	.byte	$CB
	.byte	$A9
	.byte	$5F
	.byte	$85
	.byte	$CC
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$4F ; 'O'
	.byte	$9C
	.byte	$A6
	.byte	$A6
	.byte	$BD
	.byte	$FC
	.byte	$3D ; '='
	.byte	$85
	.byte	$B8
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$8D
	.byte	$CE
	.byte	$3E ; '>'
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$82
	.byte	$AF
	.byte	$F0
	.byte	$47 ; 'G'
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$8D
	.byte	$CE
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$76 ; 'v'
	.byte	$AF
	.byte	$C9
	.byte	$1B ; Screen code for ';'
	.byte	$F0
	.byte	$1D ; Screen code for '='
	.byte	$C9
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$90
	.byte	$E6
	.byte	$C9
	.byte	$9B ; '›'
	.byte	$F0
	.byte	$52 ; 'R'
	.byte	$C9
	.byte	$7E
	.byte	$D0
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$CB
	.byte	$8C
	.byte	$A6
	.byte	$B8
	.byte	$F0
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$CA
	.byte	$86
	.byte	$B8
	.byte	$A9
	.byte	$3F ; '?'
	.byte	$9D
	.byte	$8B
	.byte	$5E
	.byte	$D0
	.byte	$1E ; Screen code for '>'
	.byte	$A2
	.byte	$09 ; Screen code for ')'
	.byte	$A9
	.byte	$3F ; '?'
	.byte	$9D
	.byte	$8B
	.byte	$5E
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$FA
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$B8
	.byte	$F0
	.byte	$0E ; Screen code for '.'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F6
	.byte	$AF
	.byte	$A8
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$CB
	.byte	$8C
	.byte	$98
	.byte	$9D
	.byte	$8B
	.byte	$5E
	.byte	$E8
	.byte	$86
	.byte	$B8
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$CD
	.byte	$CE
	.byte	$3E ; '>'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$15 ; Screen code for '5'
	.byte	$18 ; Screen code for '8'
	.byte	$69 ; 'i'
	.byte	$14 ; Screen code for '4'
	.byte	$8D
	.byte	$CE
	.byte	$3E ; '>'
	.byte	$A6
	.byte	$B8
	.byte	$E0
	.byte	$0A ; Screen code for '*'
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$CA
	.byte	$BD
	.byte	$8B
	.byte	$5E
	.byte	$49 ; 'I'
	.byte	$80
	.byte	$9D
	.byte	$8B
	.byte	$5E
	.byte	$4C ; 'L'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$8C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$CB
	.byte	$8C
	.byte	$A6
	.byte	$A6
	.byte	$A5
	.byte	$B8
	.byte	$9D
	.byte	$FC
	.byte	$3D ; '='
	.byte	$F0
	.byte	$0F ; Screen code for '/'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$E8
	.byte	$B9
	.byte	$8B
	.byte	$5E
	.byte	$9D
	.byte	$FC
	.byte	$3D ; '='
	.byte	$C8
	.byte	$E8
	.byte	$C6
	.byte	$B8
	.byte	$D0
	.byte	$F4
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$61 ; 'a'
	.byte	$6D ; 'm'
	.byte	$65 ; 'e'
	.byte	$1A ; Screen code for ':'
	.byte	$3B ; ';'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$61 ; 'a'
	.byte	$63 ; 'c'
	.byte	$68 ; 'h'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$03 ; Screen code for '#'
	.byte	$FF
	.byte	$A6
	.byte	$B8
	.byte	$E0
	.byte	$0A ; Screen code for '*'
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$CA
	.byte	$BD
	.byte	$8B
	.byte	$5E
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$9D
	.byte	$8B
	.byte	$5E
	.byte	$60
L8CDB	LDA	#$71
	STA	L00BC
	LDA	#$8D
	STA	L00BD
	LDA	#$13
	STA	L00B7
	LDA	#$00
	STA	L00C6
	LDA	#$00
	TAX
L8CEE	STA	L0600,X
	INX
	CPX	L00B7
	BCC	L8CEE
	LDA	L3CE7
	STA	L0610
	LDA	#$3B
	STA	L3EE3
	LDA	#$00
	STA	L3EE4
	LDA	#$3D
	STA	L3EE5
	LDA	#$FF
	STA	L3EE6
	JSR	L9BFE
	LDX	#$00
	STX	L00A6
L8D17	LDA	L8D51,X
	STA	L00CB
	LDA	L8D61,X
	STA	L00CC
	LDY	#$0A
	LDA	#$3B
	STA	(L00CB),Y
	INY
	LDA	L3AF2,X
	CLC
	ADC	#$11
	STA	(L00CB),Y
	INY
	LDA	#$3D
	STA	(L00CB),Y
	LDY	#$09
	LDA	#$3F
L8D39	STA	(L00CB),Y
	DEY
	BPL	L8D39
	CPX	L396E
	BCS	L8D46
	JSR	L8EB4
L8D46	INC	L00A6
	LDX	L00A6
	CPX	#$10
	BCC	L8D17
	JMP	L9D01
L8D51	.byte	$42 ; 'B'
	.byte	$62 ; 'b'
	.byte	$82
	.byte	$A2
	.byte	$C2
	.byte	$E2
	.byte	$02 ; Screen code for '"'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$51 ; 'Q'
	.byte	$71 ; 'q'
	.byte	$91
	.byte	$B1
	.byte	$D1
	.byte	$F1
	.byte	$11 ; Screen code for '1'
	.byte	$31 ; '1' ; Screen code for 'Q'
L8D61	.byte	$5E
	.byte	$5E
	.byte	$5E
	.byte	$5E
	.byte	$5E
	.byte	$5E
	.byte	$5F
	.byte	$5F
	.byte	$5E
	.byte	$5E
	.byte	$5E
	.byte	$5E
	.byte	$5E
	.byte	$5E
	.byte	$5F
	.byte	$5F
	.byte	$4C ; 'L'
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$11 ; Screen code for '1'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$6C ; 'l'
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$8C
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$01 ; Screen code for '!'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$AC
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$CC
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$03 ; Screen code for '#'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$EC
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$5F
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$05 ; Screen code for '%'
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$0E ; Screen code for '.'
	.byte	$0E ; Screen code for '.'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$5F
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$06 ; Screen code for '&'
	.byte	$10 ; Screen code for '0'
	.byte	$07 ; Screen code for '''
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$5B
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$0F ; Screen code for '/'
	.byte	$09 ; Screen code for ')'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$00 ; Screen code for ' '
	.byte	$7B
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$01 ; Screen code for '!'
	.byte	$09 ; Screen code for ')'
	.byte	$01 ; Screen code for '!'
	.byte	$9B ; '›'
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$09 ; Screen code for ')'
	.byte	$0B ; Screen code for '+'
	.byte	$02 ; Screen code for '"'
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$BB
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$0A ; Screen code for '*'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$0B ; Screen code for '+'
	.byte	$03 ; Screen code for '#'
	.byte	$DB ; Screen code for '›'
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$0B ; Screen code for '+'
	.byte	$0D ; Screen code for '-'
	.byte	$04 ; Screen code for '$'
	.byte	$0C ; Screen code for ','
	.byte	$04 ; Screen code for '$'
	.byte	$FB
	.byte	$5E
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$0C ; Screen code for ','
	.byte	$0E ; Screen code for '.'
	.byte	$05 ; Screen code for '%'
	.byte	$0D ; Screen code for '-'
	.byte	$05 ; Screen code for '%'
	.byte	$1B ; Screen code for ';'
	.byte	$5F
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$0D ; Screen code for '-'
	.byte	$0F ; Screen code for '/'
	.byte	$06 ; Screen code for '&'
	.byte	$0E ; Screen code for '.'
	.byte	$06 ; Screen code for '&'
	.byte	$3B ; ';'
	.byte	$5F
	.byte	$03 ; Screen code for '#'
	.byte	$55 ; 'U'
	.byte	$8E
	.byte	$7A ; 'z'
	.byte	$8E
	.byte	$0E ; Screen code for '.'
	.byte	$10 ; Screen code for '0'
	.byte	$07 ; Screen code for '''
	.byte	$0F ; Screen code for '/'
	.byte	$07 ; Screen code for '''
	.byte	$69 ; 'i'
	.byte	$5F
	.byte	$0F ; Screen code for '/'
	.byte	$56 ; 'V'
	.byte	$8E
	.byte	$98
	.byte	$8E
	.byte	$07 ; Screen code for '''
	.byte	$11 ; Screen code for '1'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$8E
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$66 ; 'f'
	.byte	$8E
	.byte	$AA
	.byte	$8E
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$11 ; Screen code for '1'
	.byte	$11 ; Screen code for '1'
	.byte	$11 ; Screen code for '1'
	.byte	$09 ; Screen code for ')'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$6B ; 'k'
	.byte	$8E
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$72 ; 'r'
	.byte	$69 ; 'i'
	.byte	$65 ; 'e'
	.byte	$6E ; 'n'
	.byte	$64 ; 'd'
	.byte	$6C ; 'l'
	.byte	$79 ; 'y'
	.byte	$00 ; Screen code for ' '
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$69 ; 'i'
	.byte	$72 ; 'r'
	.byte	$65 ; 'e'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$73 ; 's'
	.byte	$73 ; 's'
	.byte	$69 ; 'i'
	.byte	$67 ; 'g'
	.byte	$6E ; 'n'
	.byte	$00 ; Screen code for ' '
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$65 ; 'e'
	.byte	$61 ; 'a'
	.byte	$6D ; 'm'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$14 ; Screen code for '4'
	.byte	$A6
	.byte	$C6
	.byte	$BD
	.byte	$F2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$18 ; Screen code for '8'
	.byte	$69 ; 'i'
	.byte	$01 ; Screen code for '!'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$03 ; Screen code for '#'
	.byte	$9D
	.byte	$F2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$18 ; Screen code for '8'
	.byte	$69 ; 'i'
	.byte	$11 ; Screen code for '1'
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$91
	.byte	$CB
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$F6
	.byte	$AD
	.byte	$E7
	.byte	$3C ; '<'
	.byte	$49 ; 'I'
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$E7
	.byte	$3C ; '<'
	.byte	$8D
	.byte	$10 ; Screen code for '0'
	.byte	$06 ; Screen code for '&'
	.byte	$4C ; 'L'
	.byte	$92
	.byte	$8E
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$E4
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
L8EB4	CPX	L396B
	BCS	L8ED3
	LDA	LB0AE,X
	TAX
	LDA	L3DFC,X
	STA	L0080
	BEQ	L8ED2
	LDY	#$00
	INX
L8EC7	LDA	L3DFC,X
	STA	(L00CB),Y
	INX
	INY
	DEC	L0080
	BNE	L8EC7
L8ED2	RTS
L8ED3	TXA
	STA	L0080
	LDX	#$06
	SEC
	SBC	L396B
	SEC
	SBC	L3EED
	BMI	L8EF4
	LDX	#$0D
	SEC
	SBC	L3EEE
	BMI	L8EF4
	LDX	#$14
	SEC
	SBC	L3EEF
	BMI	L8EF4
	LDX	#$1B
L8EF4	LDY	#$06
L8EF6	LDA	L8F2F,X
	STA	(L00CB),Y
	DEX
	DEY
	BPL	L8EF6
	LDY	#$07
	LDA	L3F0D
	BEQ	L8F22
	INC	L0080
	LDA	L0080
	CMP	#$0A
	BCC	L8F18
	LDA	#$11
	STA	(L00CB),Y
	INY
	SEC
	LDA	L0080
	SBC	#$0A
L8F18	ORA	#$10
	STA	(L00CB),Y
	INY
	LDA	#$09
	STA	(L00CB),Y
	RTS
L8F22	CLC
	LDA	L0080
	ADC	#$21
	STA	(L00CB),Y
	INY
	LDA	#$09
	STA	(L00CB),Y
	RTS
L8F2F	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$61 ; 'a'
	.byte	$72 ; 'r'
	.byte	$67 ; 'g'
	.byte	$65 ; 'e'
	.byte	$74 ; 't'
	.byte	$08 ; Screen code for '('
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$72 ; 'r'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$6A ; 'j'
	.byte	$61 ; 'a'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$61 ; 'a'
	.byte	$73 ; 's'
	.byte	$74 ; 't'
	.byte	$79 ; 'y'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$A9
	.byte	$FD
	.byte	$85
	.byte	$BC
	.byte	$A9
	.byte	$8F
	.byte	$85
	.byte	$BD
	.byte	$A9
	.byte	$11 ; Screen code for '1'
	.byte	$85
	.byte	$B7
	.byte	$A9
	.byte	$08 ; Screen code for '('
	.byte	$85
	.byte	$C6
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$E8
	.byte	$E4
	.byte	$B7
	.byte	$90
	.byte	$F8
	.byte	$AD
	.byte	$E7
	.byte	$3C ; '<'
	.byte	$8D
	.byte	$10 ; Screen code for '0'
	.byte	$06 ; Screen code for '&'
	.byte	$AE
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$E0
	.byte	$09 ; Screen code for ')'
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$A2
	.byte	$08 ; Screen code for '('
	.byte	$BD
	.byte	$BE
	.byte	$B0
	.byte	$8D
	.byte	$11 ; Screen code for '1'
	.byte	$3F ; '?'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F1
	.byte	$91
	.byte	$CD
	.byte	$11 ; Screen code for '1'
	.byte	$3F ; '?'
	.byte	$90
	.byte	$13 ; Screen code for '3'
	.byte	$F0
	.byte	$11 ; Screen code for '1'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$ED
	.byte	$3E ; '>'
	.byte	$8D
	.byte	$EE
	.byte	$3E ; '>'
	.byte	$8D
	.byte	$EF
	.byte	$3E ; '>'
	.byte	$8D
	.byte	$13 ; Screen code for '3'
	.byte	$3F ; '?'
	.byte	$AD
	.byte	$6B ; 'k'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$8D
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9B ; '›'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AB
	.byte	$8F
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B9
	.byte	$8F
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$C7
	.byte	$8F
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D5
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$A9
	.byte	$E3
	.byte	$85
	.byte	$AF
	.byte	$A9
	.byte	$5E
	.byte	$85
	.byte	$B0
	.byte	$AD
	.byte	$ED
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$E0
	.byte	$8F
	.byte	$A9
	.byte	$EB
	.byte	$85
	.byte	$AF
	.byte	$A9
	.byte	$5E
	.byte	$85
	.byte	$B0
	.byte	$AD
	.byte	$EE
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$E0
	.byte	$8F
	.byte	$A9
	.byte	$F3
	.byte	$85
	.byte	$AF
	.byte	$A9
	.byte	$5E
	.byte	$85
	.byte	$B0
	.byte	$AD
	.byte	$EF
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$E0
	.byte	$8F
	.byte	$A9
	.byte	$FB
	.byte	$85
	.byte	$AF
	.byte	$A9
	.byte	$5E
	.byte	$85
	.byte	$B0
	.byte	$AD
	.byte	$13 ; Screen code for '3'
	.byte	$3F ; '?'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$C9
	.byte	$0A ; Screen code for '*'
	.byte	$90
	.byte	$0B ; Screen code for '+'
	.byte	$AA
	.byte	$A9
	.byte	$11 ; Screen code for '1'
	.byte	$91
	.byte	$AF
	.byte	$8A
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$E9
	.byte	$0A ; Screen code for '*'
	.byte	$10 ; Screen code for '0'
	.byte	$06 ; Screen code for '&'
	.byte	$AA
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$91
	.byte	$AF
	.byte	$8A
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$C8
	.byte	$91
	.byte	$AF
	.byte	$60
	.byte	$C2
	.byte	$5E
	.byte	$04 ; Screen code for '$'
	.byte	$F5
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$91
	.byte	$00 ; Screen code for ' '
	.byte	$04 ; Screen code for '$'
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$CA
	.byte	$5E
	.byte	$04 ; Screen code for '$'
	.byte	$F5
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$91
	.byte	$01 ; Screen code for '!'
	.byte	$05 ; Screen code for '%'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$D2
	.byte	$5E
	.byte	$04 ; Screen code for '$'
	.byte	$F5
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$91
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$01 ; Screen code for '!'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$DA
	.byte	$5E
	.byte	$04 ; Screen code for '$'
	.byte	$F5
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$91
	.byte	$03 ; Screen code for '#'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$FA
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$91
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$0A ; Screen code for '*'
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$FA
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$91
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$12 ; Screen code for '2'
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$FA
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$91
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$05 ; Screen code for '%'
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$1A ; Screen code for ':'
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$FA
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$91
	.byte	$03 ; Screen code for '#'
	.byte	$08 ; Screen code for '('
	.byte	$06 ; Screen code for '&'
	.byte	$07 ; Screen code for '''
	.byte	$04 ; Screen code for '$'
	.byte	$6E ; 'n'
	.byte	$5F
	.byte	$04 ; Screen code for '$'
	.byte	$F0
	.byte	$90
	.byte	$D0
	.byte	$91
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$C9
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$62 ; 'b'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$D9
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$69 ; 'i'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$DE
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$71 ; 'q'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$E4
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$79 ; 'y'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$82
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$EB
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$8A
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$EB
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$92
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$EB
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$65 ; 'e'
	.byte	$6C ; 'l'
	.byte	$65 ; 'e'
	.byte	$63 ; 'c'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$72 ; 'r'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$79 ; 'y'
	.byte	$FF
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$6C ; 'l'
	.byte	$61 ; 'a'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$FF
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$6F ; 'o'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$6F ; 'o'
	.byte	$FF
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$75 ; 'u'
	.byte	$6D ; 'm'
	.byte	$62 ; 'b'
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$48 ; 'H'
	.byte	$4A ; 'J'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$CA
	.byte	$C8
	.byte	$3D ; '='
	.byte	$FF
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$61 ; 'a'
	.byte	$73 ; 's'
	.byte	$74 ; 't'
	.byte	$79 ; 'y'
	.byte	$FF
	.byte	$A5
	.byte	$C3
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$E0
	.byte	$91
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A6
	.byte	$C6
	.byte	$F0
	.byte	$15 ; Screen code for '5'
	.byte	$CA
	.byte	$F0
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$CA
	.byte	$F0
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$CA
	.byte	$F0
	.byte	$48 ; 'H'
	.byte	$CA
	.byte	$F0
	.byte	$59 ; 'Y'
	.byte	$CA
	.byte	$F0
	.byte	$6C ; 'l'
	.byte	$CA
	.byte	$F0
	.byte	$7F
	.byte	$4C ; 'L'
	.byte	$BA
	.byte	$91
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F1
	.byte	$91
	.byte	$CD
	.byte	$11 ; Screen code for '1'
	.byte	$3F ; '?'
	.byte	$B0
	.byte	$45 ; 'E'
	.byte	$EE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$EE
	.byte	$ED
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AB
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F1
	.byte	$91
	.byte	$CD
	.byte	$11 ; Screen code for '1'
	.byte	$3F ; '?'
	.byte	$B0
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$EE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$EE
	.byte	$EE
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B9
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F1
	.byte	$91
	.byte	$CD
	.byte	$11 ; Screen code for '1'
	.byte	$3F ; '?'
	.byte	$B0
	.byte	$1D ; Screen code for '='
	.byte	$EE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$EE
	.byte	$EF
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$C7
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F1
	.byte	$91
	.byte	$CD
	.byte	$11 ; Screen code for '1'
	.byte	$3F ; '?'
	.byte	$B0
	.byte	$09 ; Screen code for ')'
	.byte	$EE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$EE
	.byte	$13 ; Screen code for '3'
	.byte	$3F ; '?'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D5
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$AD
	.byte	$ED
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$F8
	.byte	$CE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A2
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$CE
	.byte	$ED
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AB
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$AD
	.byte	$EE
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$E2
	.byte	$CE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A2
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$CE
	.byte	$EE
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B9
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$AD
	.byte	$EF
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$CC
	.byte	$CE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A2
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$CE
	.byte	$EF
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$C7
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$AD
	.byte	$13 ; Screen code for '3'
	.byte	$3F ; '?'
	.byte	$F0
	.byte	$B6
	.byte	$CE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A2
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$CE
	.byte	$13 ; Screen code for '3'
	.byte	$3F ; '?'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D5
	.byte	$8F
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$E0
	.byte	$91
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$B1
	.byte	$C9
	.byte	$10 ; Screen code for '0'
	.byte	$0B ; Screen code for '+'
	.byte	$A0
	.byte	$03 ; Screen code for '#'
	.byte	$B1
	.byte	$C9
	.byte	$49 ; 'I'
	.byte	$80
	.byte	$91
	.byte	$C9
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$AD
	.byte	$6B ; 'k'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$18 ; Screen code for '8'
	.byte	$6D ; 'm'
	.byte	$ED
	.byte	$3E ; '>'
	.byte	$18 ; Screen code for '8'
	.byte	$6D ; 'm'
	.byte	$EE
	.byte	$3E ; '>'
	.byte	$18 ; Screen code for '8'
	.byte	$6D ; 'm'
	.byte	$EF
	.byte	$3E ; '>'
	.byte	$18 ; Screen code for '8'
	.byte	$6D ; 'm'
	.byte	$13 ; Screen code for '3'
	.byte	$3F ; '?'
	.byte	$60
L9205	CPY	#$00
	BNE	L922A
	LDA	#$9F
	STA	L00BC
	LDA	#$94
	STA	L00BD
	LDA	#$03
	STA	L00B7
	LDA	#$00
	STA	L00C6
	LDA	#$00
	STA	L0600
	STA	L0601
	STA	L0602
	JSR	L9BFE
	JMP	L9D01
L922A	LDA	#$4B
	STA	L00BC
	LDA	#$92
	STA	L00BD
	LDA	#$19
	STA	L00B7
	LDA	#$00
	STA	L00C6
	LDA	#$00
	TAX
L923D	STA	L0600,X
	INX
	CPX	L00B7
	BCC	L923D
	JSR	L9BFE
	JMP	L9D01
	.byte	$41 ; 'A'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$83
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$07 ; Screen code for '''
	.byte	$01 ; Screen code for '!'
	.byte	$10 ; Screen code for '0'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$61 ; 'a'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$8E
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$11 ; Screen code for '1'
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$81
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$99
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$01 ; Screen code for '!'
	.byte	$03 ; Screen code for '#'
	.byte	$12 ; Screen code for '2'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$A1
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$A4
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$13 ; Screen code for '3'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$C1
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$AF
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$03 ; Screen code for '#'
	.byte	$05 ; Screen code for '%'
	.byte	$14 ; Screen code for '4'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$E1
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$BA
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$15 ; Screen code for '5'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$01 ; Screen code for '!'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$C5
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$05 ; Screen code for '%'
	.byte	$07 ; Screen code for '''
	.byte	$16 ; Screen code for '6'
	.byte	$0E ; Screen code for '.'
	.byte	$0E ; Screen code for '.'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$D0
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$06 ; Screen code for '&'
	.byte	$00 ; Screen code for ' '
	.byte	$17 ; Screen code for '7'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$4B ; 'K'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$DB ; Screen code for '›'
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$0F ; Screen code for '/'
	.byte	$09 ; Screen code for ')'
	.byte	$00 ; Screen code for ' '
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$6B ; 'k'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$E6
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$01 ; Screen code for '!'
	.byte	$11 ; Screen code for '1'
	.byte	$11 ; Screen code for '1'
	.byte	$8B
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$F1
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$09 ; Screen code for ')'
	.byte	$0B ; Screen code for '+'
	.byte	$02 ; Screen code for '"'
	.byte	$12 ; Screen code for '2'
	.byte	$12 ; Screen code for '2'
	.byte	$AB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$FC
	.byte	$93
	.byte	$8B
	.byte	$94
	.byte	$0A ; Screen code for '*'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$13 ; Screen code for '3'
	.byte	$13 ; Screen code for '3'
	.byte	$CB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$07 ; Screen code for '''
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$0B ; Screen code for '+'
	.byte	$0D ; Screen code for '-'
	.byte	$04 ; Screen code for '$'
	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$EB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$12 ; Screen code for '2'
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$0C ; Screen code for ','
	.byte	$0E ; Screen code for '.'
	.byte	$05 ; Screen code for '%'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$0B ; Screen code for '+'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$1D ; Screen code for '='
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$0D ; Screen code for '-'
	.byte	$0F ; Screen code for '/'
	.byte	$06 ; Screen code for '&'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$0E ; Screen code for '.'
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$55 ; 'U'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$17 ; Screen code for '7'
	.byte	$11 ; Screen code for '1'
	.byte	$08 ; Screen code for '('
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$75 ; 'u'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$3E ; '>'
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$10 ; Screen code for '0'
	.byte	$12 ; Screen code for '2'
	.byte	$09 ; Screen code for ')'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$95
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$49 ; 'I'
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$11 ; Screen code for '1'
	.byte	$13 ; Screen code for '3'
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$B5
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$54 ; 'T'
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$12 ; Screen code for '2'
	.byte	$14 ; Screen code for '4'
	.byte	$0B ; Screen code for '+'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$D5
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$5F
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$13 ; Screen code for '3'
	.byte	$15 ; Screen code for '5'
	.byte	$0C ; Screen code for ','
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$F5
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$6A ; 'j'
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$14 ; Screen code for '4'
	.byte	$16 ; Screen code for '6'
	.byte	$0D ; Screen code for '-'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$15 ; Screen code for '5'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$75 ; 'u'
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$15 ; Screen code for '5'
	.byte	$17 ; Screen code for '7'
	.byte	$0E ; Screen code for '.'
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$80
	.byte	$94
	.byte	$8B
	.byte	$94
	.byte	$16 ; Screen code for '6'
	.byte	$10 ; Screen code for '0'
	.byte	$0F ; Screen code for '/'
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$0B ; Screen code for '+'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$77 ; 'w'
	.byte	$93
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$65 ; 'e'
	.byte	$6C ; 'l'
	.byte	$65 ; 'e'
	.byte	$63 ; 'c'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$61 ; 'a'
	.byte	$7A ; 'z'
	.byte	$65 ; 'e'
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$12 ; Screen code for '2'
	.byte	$14 ; Screen code for '4'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$14 ; Screen code for '4'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$12 ; Screen code for '2'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$12 ; Screen code for '2'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$A5
	.byte	$C3
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A4
	.byte	$C6
	.byte	$A2
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$CA
	.byte	$5E
	.byte	$0B ; Screen code for '+'
	.byte	$D2
	.byte	$94
	.byte	$E5
	.byte	$94
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$5F
	.byte	$06 ; Screen code for '&'
	.byte	$DE
	.byte	$94
	.byte	$E5
	.byte	$94
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$69 ; 'i'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$C3
	.byte	$94
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$6F ; 'o'
	.byte	$61 ; 'a'
	.byte	$64 ; 'd'
	.byte	$00 ; Screen code for ' '
	.byte	$6D ; 'm'
	.byte	$61 ; 'a'
	.byte	$7A ; 'z'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$66 ; 'f'
	.byte	$72 ; 'r'
	.byte	$6F ; 'o'
	.byte	$6D ; 'm'
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$A5
	.byte	$C3
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A4
	.byte	$C6
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
L94F4	LDA	#$15
	STA	L00BC
	LDA	#$95
	STA	L00BD
	LDA	#$03
	STA	L00B7
	LDA	#$00
	STA	L00C6
	LDA	#$00
	STA	L0600
	STA	L0601
	STA	L0602
	JSR	L9BFE
	JMP	L9D01
	.byte	$AD
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$4B ; 'K'
	.byte	$95
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$95
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$ED
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$52 ; 'R'
	.byte	$95
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$95
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$68 ; 'h'
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$59 ; 'Y'
	.byte	$95
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A5
	.byte	$C3
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$A5
	.byte	$C6
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$3B ; ';'
	.byte	$00 ; Screen code for ' '
	.byte	$13 ; Screen code for '3'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$11 ; Screen code for '1'
	.byte	$12 ; Screen code for '2'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$65 ; 'e'
	.byte	$6C ; 'l'
	.byte	$65 ; 'e'
	.byte	$63 ; 'c'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$62 ; 'b'
	.byte	$61 ; 'a'
	.byte	$75 ; 'u'
	.byte	$64 ; 'd'
	.byte	$00 ; Screen code for ' '
	.byte	$72 ; 'r'
	.byte	$61 ; 'a'
	.byte	$74 ; 't'
	.byte	$65 ; 'e'
	.byte	$1A ; Screen code for ':'
	.byte	$FF
	.byte	$98
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$C9
	.byte	$95
	.byte	$A9
	.byte	$8F
	.byte	$85
	.byte	$BC
	.byte	$A9
	.byte	$95
	.byte	$85
	.byte	$BD
	.byte	$A9
	.byte	$02 ; Screen code for '"'
	.byte	$85
	.byte	$B7
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$C6
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$8D
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9B ; '›'
	.byte	$4C ; 'L'
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$8D
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$B9
	.byte	$95
	.byte	$A7
	.byte	$95
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$EC
	.byte	$5E
	.byte	$08 ; Screen code for '('
	.byte	$C0
	.byte	$95
	.byte	$A7
	.byte	$95
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$A5
	.byte	$C3
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$A5
	.byte	$C6
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$3B ; ';'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$69 ; 'i'
	.byte	$61 ; 'a'
	.byte	$6C ; 'l'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$6E ; 'n'
	.byte	$73 ; 's'
	.byte	$77 ; 'w'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$A9
	.byte	$F7
	.byte	$85
	.byte	$BC
	.byte	$A9
	.byte	$95
	.byte	$85
	.byte	$BD
	.byte	$A9
	.byte	$04 ; Screen code for '$'
	.byte	$85
	.byte	$B7
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$85
	.byte	$C6
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$E8
	.byte	$E4
	.byte	$B7
	.byte	$90
	.byte	$F8
	.byte	$A2
	.byte	$01 ; Screen code for '!'
	.byte	$AD
	.byte	$F1
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$E8
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9B ; '›'
	.byte	$4C ; 'L'
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$83
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$96
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$96
	.byte	$48 ; 'H'
	.byte	$96
	.byte	$01 ; Screen code for '!'
	.byte	$03 ; Screen code for '#'
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$94
	.byte	$5E
	.byte	$07 ; Screen code for '''
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$96
	.byte	$48 ; 'H'
	.byte	$96
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$ED
	.byte	$5E
	.byte	$06 ; Screen code for '&'
	.byte	$41 ; 'A'
	.byte	$96
	.byte	$88
	.byte	$96
	.byte	$01 ; Screen code for '!'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$69 ; 'i'
	.byte	$61 ; 'a'
	.byte	$6C ; 'l'
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$6F ; 'o'
	.byte	$64 ; 'd'
	.byte	$65 ; 'e'
	.byte	$1A ; Screen code for ':'
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$75 ; 'u'
	.byte	$6C ; 'l'
	.byte	$73 ; 's'
	.byte	$65 ; 'e'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$3B ; ';'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$69 ; 'i'
	.byte	$61 ; 'a'
	.byte	$6C ; 'l'
	.byte	$3D ; '='
	.byte	$FF
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$A6
	.byte	$C6
	.byte	$E0
	.byte	$01 ; Screen code for '!'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$01 ; Screen code for '!'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$F0
	.byte	$14 ; Screen code for '4'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$FF
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$9C
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$9C
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$F1
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A5
	.byte	$C3
	.byte	$D0
	.byte	$F6
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$B1
	.byte	$85
	.byte	$B2
	.byte	$AD
	.byte	$BA
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$10 ; Screen code for '0'
	.byte	$AE
	.byte	$D1
	.byte	$3E ; '>'
	.byte	$E0
	.byte	$1D ; Screen code for '='
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$CA
	.byte	$BD
	.byte	$63 ; 'c'
	.byte	$73 ; 's'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$9D
	.byte	$63 ; 'c'
	.byte	$73 ; 's'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9B ; '›'
	.byte	$A9
	.byte	$63 ; 'c'
	.byte	$85
	.byte	$AD
	.byte	$A9
	.byte	$97
	.byte	$85
	.byte	$AE
	.byte	$A9
	.byte	$82
	.byte	$85
	.byte	$CB
	.byte	$A9
	.byte	$5E
	.byte	$85
	.byte	$CC
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$4F ; 'O'
	.byte	$9C
	.byte	$A2
	.byte	$13 ; Screen code for '3'
	.byte	$A9
	.byte	$3F ; '?'
	.byte	$9D
	.byte	$89
	.byte	$5E
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$FA
	.byte	$A9
	.byte	$3B ; ';'
	.byte	$8D
	.byte	$88
	.byte	$5E
	.byte	$A9
	.byte	$3D ; '='
	.byte	$8D
	.byte	$9D
	.byte	$5E
	.byte	$AC
	.byte	$F2
	.byte	$3E ; '>'
	.byte	$84
	.byte	$B8
	.byte	$10 ; Screen code for '0'
	.byte	$09 ; Screen code for ')'
	.byte	$B9
	.byte	$F3
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F6
	.byte	$AF
	.byte	$99
	.byte	$89
	.byte	$5E
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F4
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$8D
	.byte	$CE
	.byte	$3E ; '>'
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$82
	.byte	$AF
	.byte	$F0
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$8D
	.byte	$CE
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$76 ; 'v'
	.byte	$AF
	.byte	$C9
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$90
	.byte	$EA
	.byte	$C9
	.byte	$9B ; '›'
	.byte	$F0
	.byte	$42 ; 'B'
	.byte	$C9
	.byte	$7E
	.byte	$D0
	.byte	$11 ; Screen code for '1'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$97
	.byte	$A6
	.byte	$B8
	.byte	$F0
	.byte	$18 ; Screen code for '8'
	.byte	$CA
	.byte	$86
	.byte	$B8
	.byte	$A9
	.byte	$3F ; '?'
	.byte	$9D
	.byte	$89
	.byte	$5E
	.byte	$D0
	.byte	$0E ; Screen code for '.'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F6
	.byte	$AF
	.byte	$A8
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$97
	.byte	$98
	.byte	$9D
	.byte	$89
	.byte	$5E
	.byte	$E8
	.byte	$86
	.byte	$B8
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$CD
	.byte	$CE
	.byte	$3E ; '>'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$15 ; Screen code for '5'
	.byte	$18 ; Screen code for '8'
	.byte	$69 ; 'i'
	.byte	$14 ; Screen code for '4'
	.byte	$8D
	.byte	$CE
	.byte	$3E ; '>'
	.byte	$A6
	.byte	$B8
	.byte	$E0
	.byte	$14 ; Screen code for '4'
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$CA
	.byte	$BD
	.byte	$89
	.byte	$5E
	.byte	$49 ; 'I'
	.byte	$80
	.byte	$9D
	.byte	$89
	.byte	$5E
	.byte	$4C ; 'L'
	.byte	$EC
	.byte	$96
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$97
	.byte	$A5
	.byte	$B8
	.byte	$8D
	.byte	$F2
	.byte	$3E ; '>'
	.byte	$A4
	.byte	$B8
	.byte	$10 ; Screen code for '0'
	.byte	$09 ; Screen code for ')'
	.byte	$B9
	.byte	$89
	.byte	$5E
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$0B ; Screen code for '+'
	.byte	$B0
	.byte	$99
	.byte	$F3
	.byte	$3E ; '>'
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F4
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$75 ; 'u'
	.byte	$6D ; 'm'
	.byte	$62 ; 'b'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$1A ; Screen code for ':'
	.byte	$FF
	.byte	$A6
	.byte	$B8
	.byte	$E0
	.byte	$14 ; Screen code for '4'
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$CA
	.byte	$BD
	.byte	$89
	.byte	$5E
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$9D
	.byte	$89
	.byte	$5E
	.byte	$60
L977B	LDA	L3F07
	BNE	L978A
L9780	LDA	L3DD7
	BNE	L9780
L9785	LDA	L3EE1
	BNE	L9785
L978A	LDA	#$34
	STA	L00BC
	LDA	#$98
	STA	L00BD
	LDA	#$13
	STA	L00B7
	LDA	#$00
	STA	L00C6
	LDA	#$00
	TAX
L979D	STA	L0600,X
	INX
	CPX	L00B7
	BCC	L979D
	JSR	L9BFE
	JSR	L9BD6
	JSR	L9B9C
	BMI	L9826
	LDA	#$00
	STA	L061F
	LDA	#$62
	STA	L0087
	LDA	#$5E
	STA	L0088
L97BD	JSR	L9BE0
	CPY	#$01
	BEQ	L97CE
	CPY	#$03
	BEQ	L9815
	CPY	#$88
	BEQ	L9815
	BNE	L9826
L97CE	LDA	L0621
	CMP	#$20
	BNE	L9815
	LDY	#$07
L97D7	LDA	L0622,Y
	JSR	LAFF6
	STA	(L0087),Y
	DEY
	BPL	L97D7
	INC	L061F
	LDA	L061F
	CMP	#$12
	BEQ	L9815
	CMP	#$06
	BNE	L97FA
	LDA	#$6C
	STA	L0087
	LDA	#$5E
	STA	L0088
	BPL	L97BD
L97FA	CMP	#$0C
	BNE	L9808
	LDA	#$76
	STA	L0087
	LDA	#$5E
	STA	L0088
	BPL	L97BD
L9808	CLC
	LDA	L0087
	ADC	#$20
	STA	L0087
	BCC	L97BD
	INC	L0088
	BNE	L97BD
L9815	JSR	L9BD6
	BMI	L9826
	LDA	L061F
	BNE	L9823
	LDY	#$02
	BNE	L9826
L9823	JMP	L9D01
L9826	STY	L3ED2
	JSR	L9AFE
	LDA	#$FF
	STA	L3ED2
	JMP	LAF36
	.byte	$61 ; 'a'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$05 ; Screen code for '%'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$81
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$A1
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$01 ; Screen code for '!'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$C1
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$E1
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$03 ; Screen code for '#'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$01 ; Screen code for '!'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$04 ; Screen code for '$'
	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$6B ; 'k'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$0B ; Screen code for '+'
	.byte	$07 ; Screen code for '''
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$8B
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$01 ; Screen code for '!'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$AB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$07 ; Screen code for '''
	.byte	$09 ; Screen code for ')'
	.byte	$02 ; Screen code for '"'
	.byte	$0E ; Screen code for '.'
	.byte	$0E ; Screen code for '.'
	.byte	$CB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$03 ; Screen code for '#'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$EB
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$09 ; Screen code for ')'
	.byte	$0B ; Screen code for '+'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$0B ; Screen code for '+'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$0A ; Screen code for '*'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$11 ; Screen code for '1'
	.byte	$11 ; Screen code for '1'
	.byte	$75 ; 'u'
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$11 ; Screen code for '1'
	.byte	$0D ; Screen code for '-'
	.byte	$06 ; Screen code for '&'
	.byte	$0C ; Screen code for ','
	.byte	$00 ; Screen code for ' '
	.byte	$95
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$0C ; Screen code for ','
	.byte	$0E ; Screen code for '.'
	.byte	$07 ; Screen code for '''
	.byte	$0D ; Screen code for '-'
	.byte	$01 ; Screen code for '!'
	.byte	$B5
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$0D ; Screen code for '-'
	.byte	$0F ; Screen code for '/'
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$02 ; Screen code for '"'
	.byte	$D5
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$0E ; Screen code for '.'
	.byte	$10 ; Screen code for '0'
	.byte	$09 ; Screen code for ')'
	.byte	$0F ; Screen code for '/'
	.byte	$03 ; Screen code for '#'
	.byte	$F5
	.byte	$5E
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$0F ; Screen code for '/'
	.byte	$11 ; Screen code for '1'
	.byte	$0A ; Screen code for '*'
	.byte	$10 ; Screen code for '0'
	.byte	$04 ; Screen code for '$'
	.byte	$15 ; Screen code for '5'
	.byte	$5F
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$99
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$99
	.byte	$10 ; Screen code for '0'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$11 ; Screen code for '1'
	.byte	$05 ; Screen code for '%'
	.byte	$0C ; Screen code for ','
	.byte	$5E
	.byte	$00 ; Screen code for ' '
	.byte	$18 ; Screen code for '8'
	.byte	$99
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$1A ; Screen code for ':'
	.byte	$0A ; Screen code for '*'
	.byte	$0E ; Screen code for '.'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FF
	.byte	$A5
	.byte	$C3
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$87
	.byte	$9C
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$A4
	.byte	$C6
	.byte	$CC
	.byte	$1F ; Screen code for '?'
	.byte	$06 ; Screen code for '&'
	.byte	$90
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$9D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6B ; 'k'
	.byte	$9C
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$3F ; '?'
	.byte	$D0
	.byte	$0A ; Screen code for '*'
	.byte	$AD
	.byte	$D7
	.byte	$3D ; '='
	.byte	$D0
	.byte	$FB
	.byte	$AD
	.byte	$E1
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$FB
	.byte	$A9
	.byte	$44 ; 'D'
	.byte	$8D
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$06 ; Screen code for '&'
	.byte	$A9
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$8D
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$06 ; Screen code for '&'
	.byte	$A0
	.byte	$01 ; Screen code for '!'
	.byte	$B1
	.byte	$CB
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$0B ; Screen code for '+'
	.byte	$B0
	.byte	$C9
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$99
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$06 ; Screen code for '&'
	.byte	$C8
	.byte	$10 ; Screen code for '0'
	.byte	$EF
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$BD
	.byte	$8A
	.byte	$99
	.byte	$99
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$06 ; Screen code for '&'
	.byte	$E8
	.byte	$C8
	.byte	$E0
	.byte	$05 ; Screen code for '%'
	.byte	$90
	.byte	$F4
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$BD
	.byte	$9B ; '›'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$8F
	.byte	$99
	.byte	$8C
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9A
	.byte	$A9
	.byte	$FF
	.byte	$8D
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$4D ; 'M'
	.byte	$41 ; 'A'
	.byte	$5A ; 'Z'
	.byte	$9B ; '›'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$FF
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$E8
	.byte	$D0
	.byte	$E5
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$E0
	.byte	$9B ; '›'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$1F ; Screen code for '?'
	.byte	$AD
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$90
	.byte	$16 ; Screen code for '6'
	.byte	$C9
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$B0
	.byte	$12 ; Screen code for '2'
	.byte	$AD
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$90
	.byte	$0B ; Screen code for '+'
	.byte	$C9
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$B0
	.byte	$07 ; Screen code for '''
	.byte	$AD
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$9B ; '›'
	.byte	$F0
	.byte	$13 ; Screen code for '3'
	.byte	$A0
	.byte	$03 ; Screen code for '#'
	.byte	$8C
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9A
	.byte	$A9
	.byte	$FF
	.byte	$8D
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D6
	.byte	$9B ; '›'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$AD
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$06 ; Screen code for '&'
	.byte	$E9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0A ; Screen code for '*'
	.byte	$85
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$18 ; Screen code for '8'
	.byte	$65 ; 'e'
	.byte	$80
	.byte	$85
	.byte	$80
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$AD
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$06 ; Screen code for '&'
	.byte	$E9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$18 ; Screen code for '8'
	.byte	$65 ; 'e'
	.byte	$80
	.byte	$4A ; 'J'
	.byte	$8D
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$A8
	.byte	$A9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$85
	.byte	$A9
	.byte	$A9
	.byte	$C0
	.byte	$85
	.byte	$AD
	.byte	$A9
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$85
	.byte	$AE
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$A6
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$84
	.byte	$A7
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$E0
	.byte	$9B ; '›'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$B5
	.byte	$AD
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$BD
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$9B ; '›'
	.byte	$D0
	.byte	$A7
	.byte	$A5
	.byte	$A7
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$BD
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$58 ; 'X'
	.byte	$F0
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$C9
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$D0
	.byte	$98
	.byte	$A4
	.byte	$A7
	.byte	$B1
	.byte	$A8
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$EF
	.byte	$91
	.byte	$A8
	.byte	$88
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$06 ; Screen code for '&'
	.byte	$B1
	.byte	$A8
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$DF
	.byte	$91
	.byte	$A8
	.byte	$C8
	.byte	$A5
	.byte	$A6
	.byte	$F0
	.byte	$0F ; Screen code for '/'
	.byte	$B1
	.byte	$AD
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$BF
	.byte	$91
	.byte	$AD
	.byte	$88
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$06 ; Screen code for '&'
	.byte	$B1
	.byte	$AD
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$91
	.byte	$AD
	.byte	$A5
	.byte	$A7
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$BD
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$58 ; 'X'
	.byte	$F0
	.byte	$16 ; Screen code for '6'
	.byte	$C9
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$D0
	.byte	$7F
	.byte	$A4
	.byte	$A7
	.byte	$B1
	.byte	$A8
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FE
	.byte	$91
	.byte	$A8
	.byte	$A5
	.byte	$A6
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$B1
	.byte	$AD
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FB
	.byte	$91
	.byte	$AD
	.byte	$E6
	.byte	$A7
	.byte	$A4
	.byte	$A7
	.byte	$CC
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$90
	.byte	$A2
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$E0
	.byte	$9B ; '›'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$61 ; 'a'
	.byte	$AD
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$BD
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$9B ; '›'
	.byte	$D0
	.byte	$53 ; 'S'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$84
	.byte	$A7
	.byte	$A5
	.byte	$A7
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$BD
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$06 ; Screen code for '&'
	.byte	$C9
	.byte	$58 ; 'X'
	.byte	$F0
	.byte	$16 ; Screen code for '6'
	.byte	$C9
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$D0
	.byte	$40 ; '@'
	.byte	$A4
	.byte	$A7
	.byte	$F0
	.byte	$08 ; Screen code for '('
	.byte	$88
	.byte	$B1
	.byte	$A8
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$FD
	.byte	$91
	.byte	$A8
	.byte	$C8
	.byte	$B1
	.byte	$A8
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$F7
	.byte	$91
	.byte	$A8
	.byte	$E6
	.byte	$A7
	.byte	$A4
	.byte	$A7
	.byte	$CC
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$90
	.byte	$D6
	.byte	$A5
	.byte	$A8
	.byte	$85
	.byte	$AD
	.byte	$A5
	.byte	$A9
	.byte	$85
	.byte	$AE
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$A8
	.byte	$69 ; 'i'
	.byte	$40 ; '@'
	.byte	$85
	.byte	$A8
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$A9
	.byte	$E6
	.byte	$A6
	.byte	$A5
	.byte	$A6
	.byte	$CD
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$B0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$14 ; Screen code for '4'
	.byte	$9A
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D6
	.byte	$9B ; '›'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A0
	.byte	$03 ; Screen code for '#'
	.byte	$8C
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$FE
	.byte	$9A
	.byte	$A9
	.byte	$FF
	.byte	$8D
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D6
	.byte	$9B ; '›'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
L9AFE	JSR	LB0C7
	LDX	L3ED2
	BEQ	L9B27
	STX	L3EF0
	CPX	#$02
	BCC	L9B40
	CPX	#$04
	BCS	L9B40
	LDA	L9B66+1,X
	STA	L0080
	LDA	L9B69,X
	STA	L0081
	LDY	#$00
L9B1D	LDA	(L0080),Y
	BMI	L9B27
	STA	L72CD,Y
	INY
	BNE	L9B1D
L9B27	LDX	#$0A
L9B29	LDA	L9B6D,X
	STA	L72C1,X
	DEX
	BPL	L9B29
	JSR	LB0D5
	LDA	#$04
	STA	L3DD7
	LDA	#$00
	STA	L3ED2
	RTS
L9B40	LDX	#$10
	LDA	L3ED2
L9B45	CMP	#$64
	BCC	L9B4F
	SEC
	SBC	#$64
	INX
	BNE	L9B45
L9B4F	STX	L72CD
	LDX	#$10
L9B54	CMP	#$0A
	BCC	L9B5E
	SEC
	SBC	#$0A
	INX
	BNE	L9B54
L9B5E	STX	L72CE
	ORA	#$10
	STA	L72CF
L9B66	JMP	L9B27
L9B69	.byte	$78 ; 'x'
	.byte	$8A
	.byte	$9B ; '›'
	.byte	$9B ; '›'
L9B6D	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$00 ; Screen code for ' '
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$1A ; Screen code for ':'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$6F ; 'o'
	.byte	$00 ; Screen code for ' '
	.byte	$6D ; 'm'
	.byte	$61 ; 'a'
	.byte	$7A ; 'z'
	.byte	$65 ; 'e'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$00 ; Screen code for ' '
	.byte	$64 ; 'd'
	.byte	$69 ; 'i'
	.byte	$73 ; 's'
	.byte	$6B ; 'k'
	.byte	$01 ; Screen code for '!'
	.byte	$FF
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$61 ; 'a'
	.byte	$7A ; 'z'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$66 ; 'f'
	.byte	$6F ; 'o'
	.byte	$72 ; 'r'
	.byte	$6D ; 'm'
	.byte	$61 ; 'a'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$72 ; 'r'
	.byte	$6F ; 'o'
	.byte	$72 ; 'r'
	.byte	$FF
L9B9C	LDX	#$10
	LDA	#$03
	STA	ICCOM,X
	LDA	#$B5
	STA	ICBAL,X
	LDA	#$9B
	STA	ICBAH,X
	LDA	#$06
	STA	ICAX1,X
	JMP	CIOV
	.byte	$44 ; 'D'
L9BB6	.byte	$3A ; (undocumented opcode) - NOP
	ROL
	ROL	L414D
	.byte	$5A ; (undocumented opcode) - NOP
	SHS	L10A2,Y	; (undocumented opcode)
	LDA	#$03
	STA	ICCOM,X
	LDA	#$20
	STA	ICBAL,X
	LDA	#$06
	STA	ICBAH,X
	LDA	#$04
	STA	ICAX1,X
	JMP	CIOV
L9BD6	LDX	#$10
	LDA	#$0C
	STA	ICCOM,X
	JMP	CIOV
L9BE0	LDX	#$10
	LDA	#$05
	STA	ICCOM,X
	LDA	#$20
	STA	ICBAL,X
	LDA	#$06
	STA	ICBAH,X
	LDA	#$80
	STA	ICBLL,X
	LDA	#$00
	STA	ICBLH,X
	JMP	CIOV
L9BFE	LDA	#$00
	LDX	#$D0
L9C02	STA	L5DFF,X
	STA	L5ECF,X
	DEX
	BNE	L9C02
	LDA	#$52
	LDX	#$1E
L9C0F	STA	L5E00,X
	STA	L5F80,X
	DEX
	BNE	L9C0F
	LDA	#$20
	STA	L0080
	LDA	#$5E
	STA	L0081
	LDX	#$0B
L9C22	LDA	#$7C
	LDY	#$00
	STA	(L0080),Y
	LDY	#$1F
	STA	(L0080),Y
	CLC
	LDA	L0080
	ADC	#$20
	STA	L0080
	BCC	L9C37
	INC	L0081
L9C37	DEX
	BNE	L9C22
	LDA	#$51
	STA	L5E00
	LDA	#$45
	STA	L5E1F
	LDA	#$5A
	STA	L5F80
	LDA	#$43
	STA	L5F9F
	RTS
L9C4F	LDY	#$00
L9C51	LDA	(L00AD),Y
	CMP	#$FF
	BEQ	L9C5C
	STA	(L00CB),Y
	INY
	BNE	L9C51
L9C5C	RTS
	.byte	$A4
L9C5E	CLV
	BPL	L9C67
L9C61	LDA	(L00CB),Y
	AND	#$7F
	STA	(L00CB),Y
L9C67	DEY
	BPL	L9C61
	RTS
L9C6B	LDY	L00B8
	BPL	L9C75
L9C6F	LDA	(L00CB),Y
	ORA	#$80
	STA	(L00CB),Y
L9C75	DEY
	BPL	L9C6F
	RTS
L9C79	LDY	L00B8
	BPL	L9C83
L9C7D	LDA	(L00CB),Y
	EOR	#$80
	STA	(L00CB),Y
L9C83	DEY
	BPL	L9C7D
	RTS
	.byte	$A6
	.byte	$C5
	.byte	$BD
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$D0
	.byte	$0E ; Screen code for '.'
	.byte	$A4
	.byte	$B9
	.byte	$10 ; Screen code for '0'
	.byte	$06 ; Screen code for '&'
	.byte	$B1
	.byte	$C9
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$7F
	.byte	$91
	.byte	$C9
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$60
L9C9C	LDY	L00B9
	BPL	L9CA6
L9CA0	LDA	(L00C9),Y
	ORA	#$80
	STA	(L00C9),Y
L9CA6	DEY
	BPL	L9CA0
	RTS
L9CAA	STA	L00BA
	LDX	#$00
	STX	L00BB
	CLC
	ADC	L00BA
	BCC	L9CB7
	INC	L00BB
L9CB7	CLC
	ADC	L00BA
	BCC	L9CBE
	INC	L00BB
L9CBE	ASL
	ROL	L00BB
	ASL
	ROL	L00BB
	CLC
	ADC	L00BC
	STA	L00BA
	LDA	L00BB
	ADC	L00BD
	STA	L00BB
	LDY	#$00
	LDA	L00B8
	STA	L00B9
	LDA	L00CB
	STA	L00C9
	LDA	L00CC
	STA	L00CA
	LDA	(L00BA),Y
	INY
	STA	L00CB
	LDA	(L00BA),Y
	INY
	STA	L00CC
	LDA	(L00BA),Y
	INY
	STA	L00B8
	LDA	(L00BA),Y
	INY
	STA	L00AD
	LDA	(L00BA),Y
	INY
	STA	L00AE
	LDA	(L00BA),Y
	INY
	STA	L00C0
	LDA	(L00BA),Y
	INY
	STA	L00C1
	RTS
L9D01	LDA	#$00
	STA	L00B6
L9D05	JSR	L9CAA
	JSR	L9C4F
	LDX	L00B6
	LDA	L0600,X
	BEQ	L9D15
	JSR	L9C6B
L9D15	INC	L00B6
	LDA	L00B6
	CMP	L00B7
	BCC	L9D05
	LDA	STRIG0
	EOR	#$01
	STA	L00C4
	BNE	L9D2F
	LDA	CONSOL
	AND	#$01
	EOR	#$01
	STA	L00C4
L9D2F	LDA	L00C6
	STA	L00C5
	JSR	L9CAA
	LDA	RTCLOK+2
	STA	L00C8
L9D3A	CLC
	LDA	RTCLOK+2
	ADC	#$08
	STA	L00C7
L9D41	LDA	RTCLOK+2
	CMP	L00C8
	BMI	L9D4F
	CLC
	ADC	#$08
	STA	L00C8
	JSR	L9C79
L9D4F	LDX	#$0D
	JSR	LAF1D
	LDA	L3EBA
	BEQ	L9D6B
	LDX	#$13
	JSR	LAF1D
	LDA	L3ED2
	BNE	L9D68
	LDA	L3EE7
	BEQ	L9D6B
L9D68	JMP	LAF36
L9D6B	LDA	RTCLOK+2
	CMP	L00C7
	BMI	L9D41
	STA	L00C7
	LDA	STICK0
	EOR	#$0F
	STA	L00C2
	LDA	STRIG0
	STA	L0080
	BEQ	L9D88
	LDA	CONSOL
	AND	#$01
	STA	L0080
L9D88	ORA	L00C4
	STA	L00C3
	LDA	L0080
	EOR	#$01
	STA	L00C4
	LDA	L00C3
	BNE	L9DA0
	LDA	#$04
	STA	L3DD7
	LDA	L00C6
	JMP	L9DD6
L9DA0	LDA	L00C2
	LDY	#$07
	CMP	#$01
	BEQ	L9DCB
	INY
	CMP	#$02
	BEQ	L9DCB
	INY
	CMP	#$04
	BEQ	L9DCB
	INY
	CMP	#$08
	BEQ	L9DCB
	INY
	LDA	CONSOL
	AND	#$04
	BEQ	L9DCB
	LDY	#$08
	LDA	CONSOL
	AND	#$02
	BEQ	L9DCB
	JMP	L9D41
L9DCB	LDA	(L00BA),Y
	STA	L00C6
	CMP	L00C5
	BNE	L9DD6
	JMP	L9D3A
L9DD6	JSR	L9CAA
	JMP	(L00C0)
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

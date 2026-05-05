	opt h-

	icl "include/atari_os.inc"
	icl "include/hardware.inc"
	icl "include/cartridge.inc"
	icl "include/game_ram.inc"
	icl "include/fixed_bank.inc"

; Bank 13: switchable 8KB cartridge bank, mapped at $8000-$9FFF.
; Contains game support code and data tables.
; Generated Lxxxx symbols are preserved until their meaning is proven.
; Hardware/OS constants are named where confidently identified.
; Bank map (working):
;   $8000-$9FFF  Mixed code and embedded data; subranges still being identified.

L0080	= $0080
L0081	= $0081
L0095	= $0095
L00A6	= $00A6
L00A7	= $00A7
L00AC	= $00AC
L00AD	= $00AD
L00AE	= $00AE
L00AF	= $00AF
L00B0	= $00B0
L00B3	= $00B3
L00B6	= $00B6
L00B7	= $00B7
L00B8	= $00B8
L00B9	= $00B9
L00BA	= $00BA
L00BB	= $00BB
L00BC	= $00BC
L00BD	= $00BD
L00BE	= $00BE
L00BF	= $00BF
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
L00CD	= $00CD
L00CE	= $00CE
L00CF	= $00CF
L00D0	= $00D0
L00D1	= $00D1
L00D2	= $00D2
L00D3	= $00D3
L29BD	= $29BD
L3968	= $3968
L3969	= $3969
L396A	= $396A
L396B	= $396B
L396C	= $396C
L396D	= $396D
L396E	= $396E
L396F	= $396F
L3970	= $3970
L3971	= $3971
L39B2	= $39B2
L39C2	= $39C2
L39D2	= $39D2
L39E2	= $39E2
L39F2	= $39F2
L3A02	= $3A02
L3A12	= $3A12
L3A22	= $3A22
L3A32	= $3A32
L3A42	= $3A42
L3A52	= $3A52
L3A72	= $3A72
L3A82	= $3A82
L3A92	= $3A92
L3AA2	= $3AA2
L3AB2	= $3AB2
L3AC2	= $3AC2
L3AD2	= $3AD2
L3AE2	= $3AE2
L3AF2	= $3AF2
L3B02	= $3B02
L3B12	= $3B12
L3B22	= $3B22
L3B32	= $3B32
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
L3D39	= $3D39
L3DB6	= $3DB6
L3DB7	= $3DB7
L3DD7	= $3DD7
L3EAC	= $3EAC
L3EAD	= $3EAD
L3EB3	= $3EB3
L3EB4	= $3EB4
L3ECD	= $3ECD
L3ED2	= $3ED2
L3EE7	= $3EE7
L3EE8	= $3EE8
L3EEC	= $3EEC
L3EED	= $3EED
L3EEE	= $3EEE
L3EEF	= $3EEF
L3F0D	= $3F0D
L5C63	= $5C63
L5C64	= $5C64
L5C65	= $5C65
L5C66	= $5C66
L5D00	= $5D00
L5E00	= $5E00
L5F00	= $5F00
L6000	= $6000
L6100	= $6100
L6200	= $6200
L6280	= $6280
LAD00	= $AD00
LAD6F	= $AD6F
LAE8B	= $AE8B
LAEB0	= $AEB0
LC785	= $C785
	org $8000
START1	LDA	#$01
	STA	L396D
	LDA	#$30
	STA	L0081
	LDA	#$20
	STA	L0080
	LDX	#$1F
L800F	LDY	#$1F
	LDA	#$FF
L8013	STA	(L0080),Y
	DEY
	BPL	L8013
	CLC
	LDA	L0080
	ADC	#$40
	STA	L0080
	BCC	L8023
	INC	L0081
L8023	DEX
	BPL	L800F
	LDA	#$00
	STA	L3970
	TAX
L802C	STA	L3A72,X
	INX
	CPX	L396E
	BCC	L802C
	STA	FR1+2
L8037	JSR	L806F
	BEQ	L806A
	LDX	FR1+2
	LDA	#$03
	STA	L3A72,X
	LDA	#$00
	STA	L3AA2,X
	LDA	#$00
	STA	L3AB2,X
	LDA	#$00
	STA	L3AC2,X
	LDA	#$00
	STA	L3A92,X
	LDA	#$00
	STA	L3A82,X
	INC	FR1+2
	LDA	FR1+2
	CMP	L396E
	BCC	L8037
	LDA	#$01
	JMP	BANK_RETURN
L806A	LDA	#$00
	JMP	BANK_RETURN
L806F	LDY	#$14
	LDA	L396C
	BNE	L8078
	LDY	#$02
L8078	STY	FR2
	LDA	#$00
	STA	FR2+3
	LDA	#$05
	STA	FR2+4
	LDA	#$9A
	STA	FR1+3
	LDA	#$02
	STA	FR1+4
L808A	LDA	L396F
	ASL
	JSR	LAEB0
	LSR
	STA	L00A6
	LDA	L396F
	ASL
	JSR	LAEB0
	LSR
	STA	L00A7
	JSR	LAD00
	CMP	#$FF
	BNE	L80AC
	TXA
	AND	#$0F
	CMP	#$0F
	BNE	L80AF
L80AC	JMP	L8169
L80AF	LDX	FR1+2
	LDA	L00A6
	STA	L39D2,X
	LDA	L00A7
	STA	L3A12,X
	LDA	#$80
	STA	L39B2,X
	STA	L39F2,X
	LDX	#$00
	STX	FR1+5
L80C7	CPX	FR1+2
	BEQ	L8132
	LDA	L3A72,X
	BEQ	L8132
	SEC
	LDY	FR1+2
	LDA	L39B2,X
	SBC	L39B2,Y
	STA	FR2+1
	LDA	L39D2,X
	SBC	L39D2,Y
	STA	FR2+2
	BPL	L80F6
	SEC
	LDA	FR2+1
	EOR	#$FF
	ADC	#$00
	STA	FR2+1
	LDA	FR2+2
	EOR	#$FF
	ADC	#$00
	STA	FR2+2
L80F6	CMP	FR2+4
	BMI	L8169
	BNE	L8102
	LDA	FR2+1
	CMP	FR2+3
	BCC	L8169
L8102	SEC
	LDA	L39F2,X
	SBC	L39F2,Y
	STA	FR2+1
	LDA	L3A12,X
	SBC	L3A12,Y
	STA	FR2+2
	BPL	L8126
	SEC
	LDA	FR2+1
	EOR	#$FF
	ADC	#$00
	STA	FR2+1
	LDA	FR2+2
	EOR	#$FF
	ADC	#$00
	STA	FR2+2
L8126	CMP	FR2+4
	BMI	L8169
	BNE	L8132
	LDA	FR2+1
	CMP	FR2+3
	BCC	L8169
L8132	INC	FR1+5
	LDX	FR1+5
	CPX	L396E
	BCC	L80C7
	LDA	FR1+2
	STA	L3971
	JSR	LAD6F
	LDX	FR1+2
	LDA	#$FF
	STA	L3A52,X
	JSR	LAE8B
	LDA	L396A
	ASL
	ASL
	ASL
	ASL
	STA	L0080
	LDA	L3969
	LSR
	LSR
	LSR
	LSR
	ORA	L0080
	AND	#$C0
	LDX	FR1+2
	STA	L3A32,X
	LDA	#$01
	RTS
L8169	DEC	FR2
	BNE	L8173
	LDA	#$14
	STA	FR2
	DEC	FR2+4
L8173	LDA	FR1+3
	BNE	L8179
	DEC	FR1+4
L8179	DEC	FR1+3
	BNE	L8181
	LDA	FR1+4
	BEQ	L8184
L8181	JMP	L808A
L8184	RTS
	.byte	$A6
L8186	LDY	L29BD
	AND	LC785,X
	LDA	L3AA2,X
	BEQ	L81DF
	DEC	L3AA2,X
	BNE	L81DF
	INC	L3A72,X
	LDA	L3A72,X
	TAY
	CPY	#$03
	BCS	L81A7
	LDA	L3D09,X
	STA	L3AA2,X
L81A7	CPY	#$01
	BNE	L81D0
	LDA	L3CE9,X
	STA	L3A72,X
	CMP	#$03
	BNE	L81BA
	LDA	#$00
	STA	L3AA2,X
L81BA	STX	FR1+2
	JSR	L806F
	BNE	L81C4
	JMP	BANK_RETURN
L81C4	LDX	L00AC
	CPX	L3968
	BNE	L81D0
	LDA	#$00
	STA	L3CE8
L81D0	CPX	L3968
	BNE	L81DF
	LDA	#$01
	STA	L3DD7
	LDX	#$08
	JSR	BANK_CALL_INDEXED
L81DF	LDX	L00AC
	LDA	L3A72,X
	BNE	L81FD
	LDA	L3A82,X
	BEQ	L81EE
	JSR	L85F2
L81EE	LDX	L00AC
	LDA	L3AB2,X
	BEQ	L81F8
	DEC	L3AB2,X
L81F8	LDA	#$01
	JMP	BANK_RETURN
L81FD	LDA	L39B2,X
	STA	L00B6
	LDA	L39D2,X
	STA	L00B7
	LDA	L39F2,X
	STA	L00B8
	LDA	L3A12,X
	STA	L00B9
	LDA	L3A32,X
	STA	L00BA
	LDA	L00C7
	AND	#$04
	BEQ	L8227
	SEC
	LDA	L00BA
	SBC	L3B62,X
	STA	L00BA
	JMP	L8235
L8227	LDA	L00C7
	AND	#$08
	BEQ	L8235
	CLC
	LDA	L00BA
	ADC	L3B62,X
	STA	L00BA
L8235	LDA	L00C7
	AND	#$10
	BEQ	L8273
	LDA	L3AB2,X
	BNE	L8273
	CPX	L3968
	BNE	L824C
	LDA	#$02
	STA	L3DD7
	LDX	L00AC
L824C	LDA	#$0A
	STA	L3A82,X
	LDA	L00B6
	STA	L39C2,X
	LDA	L00B7
	STA	L39E2,X
	LDA	L00B8
	STA	L3A02,X
	LDA	L00B9
	STA	L3A22,X
	LDA	L00BA
	STA	L3A42,X
	JSR	L85B0
	LDA	L3D19,X
	STA	L3AB2,X
L8273	LDA	L3A82,X
	BEQ	L827D
	JSR	L85F2
	LDX	L00AC
L827D	LDA	L3AB2,X
	BEQ	L8285
	DEC	L3AB2,X
L8285	LDY	#$00
	LDA	L00C7
	AND	#$01
	BEQ	L82AE
	SEC
	LDA	#$C0
	SBC	L00BA
	TAX
	LDA	L87EA,X
	STA	L00C3
	BPL	L829B
	DEY
L829B	STY	L00C4
	LDY	#$00
	LDX	L00BA
	LDA	L87EA,X
	STA	L00C5
	BPL	L82A9
	DEY
L82A9	STY	L00C6
	JMP	L82E7
L82AE	LDA	L00C7
	AND	#$02
	BEQ	L82DF
	SEC
	LDA	#$C0
	SBC	L00BA
	TAX
	LDA	L87EA,X
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L00C3
	BPL	L82C7
	DEY
L82C7	STY	L00C4
	LDY	#$00
	LDX	L00BA
	LDA	L87EA,X
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L00C5
	BPL	L82DA
	DEY
L82DA	STY	L00C6
	JMP	L82E7
L82DF	STY	L00C3
	STY	L00C4
	STY	L00C5
	STY	L00C6
L82E7	LDX	L00AC
	LDA	L3B42,X
	BEQ	L82FC
	LDA	L00C4
	ASL
	ROR	L00C4
	ROR	L00C3
	LDA	L00C6
	ASL
	ROR	L00C6
	ROR	L00C5
L82FC	CLC
	LDA	L39B2,X
	ADC	L00C3
	STA	L00B6
	LDA	L39D2,X
	ADC	L00C4
	STA	L00B7
	STA	L00A6
	CLC
	LDA	L39F2,X
	ADC	L00C5
	STA	L00B8
	LDA	L3A12,X
	ADC	L00C6
	STA	L00B9
	STA	L00C8
	DEC	L00A6
	DEC	L00C8
	LDA	#$00
	STA	L00BD
	LDA	#$03
	STA	L00BB
L832A	LDA	L00A6
	BMI	L8368
	CMP	L396F
	BCS	L8368
	LDA	L00C8
	STA	L00A7
	LDA	#$03
	STA	L00BC
L833B	LDA	L00A7
	BMI	L8362
	CMP	L396F
	BCS	L8362
	JSR	LAD00
	STA	L00C2
L8349	CMP	#$FF
	BEQ	L8362
	CMP	#$10
	BCS	L8358
	CMP	L00AC
	BEQ	L8358
	JMP	L8471
L8358	LDX	L00C2
	LDA	L3A52,X
	STA	L00C2
	JMP	L8349
L8362	INC	L00A7
	DEC	L00BC
	BNE	L833B
L8368	INC	L00A6
	DEC	L00BB
	BNE	L832A
	LDA	L00B7
	STA	L00A6
	LDA	L00B9
	STA	L00A7
	LDA	#$00
	STA	L00BB
	STA	L00BC
	LDA	L00B6
	CMP	#$41
	BCS	L8386
	LDA	#$01
	STA	L00BB
L8386	CMP	#$C0
	BCC	L838E
	LDA	#$04
	STA	L00BB
L838E	LDA	L00B8
	CMP	#$41
	BCS	L8398
	LDA	#$08
	STA	L00BC
L8398	CMP	#$C0
	BCC	L83A0
	LDA	#$02
	STA	L00BC
L83A0	JSR	LAD00
	TXA
	AND	L00BB
	BEQ	L83B4
	LDY	#$41
	AND	#$01
	BNE	L83B0
	LDY	#$BF
L83B0	STY	L00B6
	INC	L00BD
L83B4	TXA
	AND	L00BC
	BEQ	L83C5
	LDY	#$41
	AND	#$08
	BNE	L83C1
	LDY	#$BF
L83C1	STY	L00B8
	INC	L00BD
L83C5	LDA	L00BD
	BNE	L842B
	LDA	L00BB
	BEQ	L842B
	LDA	L00BC
	BEQ	L842B
	LDA	#$10
	STA	L0080
	LDA	L00BB
	AND	#$04
	BEQ	L83DF
	ASL	L0080
	ASL	L0080
L83DF	LDA	L00BC
	AND	#$02
	BEQ	L83E7
	ASL	L0080
L83E7	TXA
	AND	L0080
	BEQ	L842B
	LDX	L00B8
	LDA	L00BC
	AND	#$08
	BNE	L83FB
	TXA
	EOR	#$FF
	SEC
	ADC	#$00
	TAX
L83FB	STX	L0080
	LDX	L00B6
	LDA	L00BB
	AND	#$01
	BNE	L840C
	TXA
	EOR	#$FF
	SEC
	ADC	#$00
	TAX
L840C	TXA
	CMP	L0080
	BCC	L841F
	LDX	#$41
	LDA	L00BB
	AND	#$01
	BNE	L841B
	LDX	#$BF
L841B	STX	L00B6
	BNE	L842B
L841F	LDX	#$41
	LDA	L00BC
	AND	#$08
	BNE	L8429
	LDX	#$BF
L8429	STX	L00B8
L842B	LDX	L00AC
	LDA	L00B6
	STA	L39B2,X
	LDA	L00B7
	STA	L39D2,X
	STA	L00A6
	LDA	L00B8
	STA	L39F2,X
	LDA	L00B9
	STA	L3A12,X
	STA	L00A7
	LDA	L00BA
	STA	L3A32,X
	LDA	L00A6
	CMP	L396F
	BCS	L8462
	LDA	L00A7
	CMP	L396F
	BCS	L8462
	JSR	LAD00
	TXA
	AND	#$0F
	CMP	#$0F
	BNE	L846C
L8462	LDA	L00AC
	STA	FR1+2
	JSR	L806F
	JMP	BANK_RETURN
L846C	LDA	#$01
	JMP	BANK_RETURN
L8471	LDY	L00C2
	SEC
	LDA	L39B2,Y
	SBC	L00B6
	STA	L00BE
	LDA	L39D2,Y
	SBC	L00B7
	STA	L00BF
	BPL	L8495
	LDA	L00BE
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L00BE
	LDA	L00BF
	EOR	#$FF
	ADC	#$00
	STA	L00BF
L8495	BNE	L849D
	LDA	L00BE
	CMP	#$60
	BCC	L84A0
L849D	JMP	L8358
L84A0	SEC
	LDA	L39F2,Y
	SBC	L00B8
	STA	L00C0
	LDA	L3A12,Y
	SBC	L00B9
	STA	L00C1
	BPL	L84C2
	LDA	L00C0
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L00C0
	LDA	L00C1
	EOR	#$FF
	ADC	#$00
	STA	L00C1
L84C2	BNE	L849D
	LDA	L00C0
	CMP	#$60
	BCS	L849D
	LDX	L00AC
	SEC
	LDA	L39B2,Y
	SBC	L39B2,X
	STA	L00C9
	LDA	L39D2,Y
	SBC	L39D2,X
	STA	L00CA
	BPL	L84F0
	LDA	L00C9
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L00C9
	LDA	L00CA
	EOR	#$FF
	ADC	#$00
	STA	L00CA
L84F0	BNE	L8529
	LDA	L00C9
	CMP	#$60
	BCS	L8529
L84F8	SEC
	LDA	#$60
	SBC	L00C0
	STA	L0080
	LDA	#$00
	SBC	L00C1
	STA	L0081
	LDA	L00C6
	BPL	L8519
	CLC
	LDA	L00C5
	ADC	L0080
	STA	L00C5
	LDA	L00C6
	ADC	L0081
	STA	L00C6
	JMP	L858F
L8519	SEC
	LDA	L00C5
	SBC	L0080
	STA	L00C5
	LDA	L00C6
	SBC	L0081
	STA	L00C6
	JMP	L858F
L8529	SEC
	LDA	L39F2,Y
	SBC	L39F2,X
	STA	L00CB
	LDA	L3A12,Y
	SBC	L3A12,X
	STA	L00CC
	BPL	L854D
	LDA	L00CB
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L00CB
	LDA	L00CC
	EOR	#$FF
	ADC	#$00
	STA	L00CC
L854D	BNE	L8586
	LDA	L00CB
	CMP	#$60
	BCS	L8586
L8555	SEC
	LDA	#$60
	SBC	L00BE
	STA	L0080
	LDA	#$00
	SBC	L00BF
	STA	L0081
	LDA	L00C4
	BPL	L8576
	CLC
	LDA	L00C3
	ADC	L0080
	STA	L00C3
	LDA	L00C4
	ADC	L0081
	STA	L00C4
	JMP	L858F
L8576	SEC
	LDA	L00C3
	SBC	L0080
	STA	L00C3
	LDA	L00C4
	SBC	L0081
	STA	L00C4
	JMP	L858F
L8586	LDA	L00C0
	CMP	L00BE
	BCC	L8555
	JMP	L84F8
L858F	CLC
	LDA	L39B2,X
	ADC	L00C3
	STA	L00B6
	LDA	L39D2,X
	ADC	L00C4
	STA	L00B7
	CLC
	LDA	L39F2,X
	ADC	L00C5
	STA	L00B8
	LDA	L3A12,X
	ADC	L00C6
	STA	L00B9
	JMP	L8358
L85B0	LDA	#$00
	STA	L3B12,X
	SEC
	LDA	#$C0
	SBC	L00BA
	TAY
	LDA	L87EA,Y
	STA	L3B02,X
	BPL	L85C6
	DEC	L3B12,X
L85C6	LDA	#$00
	STA	L3B32,X
	LDY	L00BA
	LDA	L87EA,Y
	STA	L3B22,X
	BPL	L85D8
	DEC	L3B32,X
L85D8	LDA	L3B52,X
	BEQ	L85F1
	LDA	L3B12,X
	ASL
	ROR	L3B12,X
	ROR	L3B02,X
	LDA	L3B32,X
	ASL
	ROR	L3B32,X
	ROR	L3B22,X
L85F1	RTS
L85F2	LDA	L39C2,X
	STA	FR0+1
	LDA	L39E2,X
	STA	FR0+2
	STA	L00CF
	LDA	L3A02,X
	STA	FR0+3
	LDA	L3A22,X
	STA	FR0+4
	STA	L00D0
	LDA	L3A42,X
	STA	FR0+5
	LDA	L3B02,X
	STA	FRE
	LDA	L3B12,X
	STA	FRE+1
	LDA	L3B22,X
	STA	FRE+2
	LDA	L3B32,X
	STA	FRE+3
	LDA	#$01
	STA	L00CD
	LDA	#$03
	STA	L00D1
L862B	LDX	L00AC
	CLC
	LDA	FRE
	ADC	FR0+1
	STA	FR0+1
	LDA	FRE+1
	ADC	FR0+2
	STA	FR0+2
	CLC
	LDA	FRE+2
	ADC	FR0+3
	STA	FR0+3
	LDA	FRE+3
	ADC	FR0+4
	STA	FR0+4
	SEC
	LDA	FR0+2
	SBC	L00CF
	STA	L0080
	INC	L0080
	SEC
	LDA	FR0+4
	SBC	L00D0
	SEC
	ADC	L0080
	CLC
	ADC	L0080
	ADC	L0080
	TAY
	LDA	L86FD,Y
	BEQ	L867F
	STA	L00CE
	LDA	L00CF
	STA	L00A6
	LDA	L00D0
	STA	L00A7
	JSR	LAD00
	TXA
	AND	L00CE
	BEQ	L867F
	LDX	L00AC
	LDA	#$00
	STA	L3A82,X
	JMP	L86E6
L867F	LDA	FR0+2
	STA	L00CF
	STA	L00A6
	LDA	FR0+4
	STA	L00D0
	STA	FR0
	DEC	L00A6
	DEC	FR0
	LDA	#$03
	STA	L00D2
L8693	LDA	L00CD
	BEQ	L86DF
	LDA	L00A6
	BMI	L86D9
	CMP	L396F
	BCS	L86D9
	LDA	FR0
	STA	L00A7
	LDA	#$03
	STA	L00D3
L86A8	LDA	L00CD
	BEQ	L86DF
	LDA	L00A7
	BMI	L86D3
	CMP	L396F
	BCS	L86D3
	JSR	LAD00
	STA	L00C2
L86BA	CMP	#$FF
	BEQ	L86D3
	CMP	#$10
	BCS	L86C9
	CMP	L00AC
	BEQ	L86C9
	JMP	L8706
L86C9	LDX	L00C2
	LDA	L3A52,X
	STA	L00C2
	JMP	L86BA
L86D3	INC	L00A7
	DEC	L00D3
	BNE	L86A8
L86D9	INC	L00A6
	DEC	L00D2
	BNE	L8693
L86DF	DEC	L00D1
	BEQ	L86E6
	JMP	L862B
L86E6	LDX	L00AC
	LDA	FR0+1
	STA	L39C2,X
	LDA	FR0+2
	STA	L39E2,X
	LDA	FR0+3
	STA	L3A02,X
	LDA	FR0+4
	STA	L3A22,X
	RTS
L86FD	.byte	$10 ; Screen code for '0'
	.byte	$01 ; Screen code for '!'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$08 ; Screen code for '('
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$40 ; '@'
	.byte	$04 ; Screen code for '$'
	.byte	$80
L8706	LDY	L00C2
	LDA	L3A72,Y
	BEQ	L8737
	SEC
	LDA	L39B2,Y
	SBC	FR0+1
	STA	FRE+4
	LDA	L39D2,Y
	SBC	FR0+2
	STA	FRE+5
	BPL	L872F
	LDA	FRE+4
	EOR	#$FF
	SEC
	ADC	#$00
	STA	FRE+4
	LDA	FRE+5
	EOR	#$FF
	ADC	#$00
	STA	FRE+5
L872F	BNE	L8737
	LDA	#$30
	CMP	FRE+4
	BCS	L873A
L8737	JMP	L86C9
L873A	SEC
	LDA	L39F2,Y
	SBC	FR0+3
	STA	FR1
	LDA	L3A12,Y
	SBC	FR0+4
	STA	FR1+1
	BPL	L875C
	LDA	FR1
	EOR	#$FF
	SEC
	ADC	#$00
	STA	FR1
	LDA	FR1+1
	EOR	#$FF
	ADC	#$00
	STA	FR1+1
L875C	BNE	L8737
	LDA	#$30
	CMP	FR1
	BCC	L8737
	LDX	L00AC
	CPX	L3968
	BNE	L8770
	LDA	#$03
	STA	L3DD7
L8770	LDX	L00C2
	LDY	L00AC
	LDA	#$01
	STA	L3A92,X
	LDA	L00AC
	STA	L3AD2,X
	LDA	L3CE6
	BEQ	L8797
	LDA	L3AF2,X
	CMP	L3AF2,Y
	BNE	L8797
	LDA	L3CE7
	BNE	L87D4
	LDA	L3A72,X
	CMP	#$01
	BEQ	L87D4
L8797	LDA	L3D09,X
	STA	L3AA2,X
	DEC	L3A72,X
	BNE	L87CF
	LDA	L3CF9,X
	STA	L3AA2,X
	LDX	L00AC
	INC	L3AC2,X
	LDX	L00C2
	LDA	L3CE6
	BEQ	L87C3
	LDX	L3AF2,Y
	INC	L3D39,X
	LDA	L3D39,X
	CMP	#$0A
	BEQ	L87CA
	BNE	L87CF
L87C3	LDA	L3AC2,Y
	CMP	#$0A
	BNE	L87CF
L87CA	LDA	#$00
	STA	L396D
L87CF	LDA	L00C2
	STA	L3AE2,Y
L87D4	LDA	#$00
	STA	L3A82,Y
	LDA	L00C2
	CMP	L3968
	BNE	L87E5
	LDX	#$08
	JSR	BANK_CALL_INDEXED
L87E5	DEC	L00CD
	JMP	L86C9
L87EA	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0B ; Screen code for '+'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0D ; Screen code for '-'
	.byte	$0E ; Screen code for '.'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$11 ; Screen code for '1'
	.byte	$11 ; Screen code for '1'
	.byte	$12 ; Screen code for '2'
	.byte	$13 ; Screen code for '3'
	.byte	$13 ; Screen code for '3'
	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$15 ; Screen code for '5'
	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$13 ; Screen code for '3'
	.byte	$13 ; Screen code for '3'
	.byte	$12 ; Screen code for '2'
	.byte	$11 ; Screen code for '1'
	.byte	$11 ; Screen code for '1'
	.byte	$10 ; Screen code for '0'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FE
	.byte	$FD
	.byte	$FD
	.byte	$FC
	.byte	$FB
	.byte	$FA
	.byte	$F9
	.byte	$F9
	.byte	$F8
	.byte	$F7
	.byte	$F6
	.byte	$F6
	.byte	$F5
	.byte	$F4
	.byte	$F4
	.byte	$F3
	.byte	$F2
	.byte	$F1
	.byte	$F1
	.byte	$F0
	.byte	$EF
	.byte	$EF
	.byte	$EE
	.byte	$ED
	.byte	$ED
	.byte	$EC
	.byte	$EC
	.byte	$EB
	.byte	$EA
	.byte	$EA
	.byte	$E9
	.byte	$E9
	.byte	$E8
	.byte	$E8
	.byte	$E7
	.byte	$E7
	.byte	$E6
	.byte	$E6
	.byte	$E5
	.byte	$E5
	.byte	$E5
	.byte	$E4
	.byte	$E4
	.byte	$E4
	.byte	$E3
	.byte	$E3
	.byte	$E3
	.byte	$E2
	.byte	$E2
	.byte	$E2
	.byte	$E2
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E0
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E1
	.byte	$E2
	.byte	$E2
	.byte	$E2
	.byte	$E2
	.byte	$E3
	.byte	$E3
	.byte	$E3
	.byte	$E4
	.byte	$E4
	.byte	$E4
	.byte	$E5
	.byte	$E5
	.byte	$E5
	.byte	$E6
	.byte	$E6
	.byte	$E7
	.byte	$E7
	.byte	$E8
	.byte	$E8
	.byte	$E9
	.byte	$E9
	.byte	$EA
	.byte	$EA
	.byte	$EB
	.byte	$EC
	.byte	$EC
	.byte	$ED
	.byte	$ED
	.byte	$EE
	.byte	$EF
	.byte	$EF
	.byte	$F0
	.byte	$F1
	.byte	$F1
	.byte	$F2
	.byte	$F3
	.byte	$F4
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$F6
	.byte	$F7
	.byte	$F8
	.byte	$F9
	.byte	$F9
	.byte	$FA
	.byte	$FB
	.byte	$FC
	.byte	$FD
	.byte	$FD
	.byte	$FE
	.byte	$FF
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
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$D0
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$B6
	.byte	$3D ; '='
	.byte	$8D
	.byte	$E8
	.byte	$3C ; '<'
	.byte	$A2
	.byte	$0F ; Screen code for '/'
	.byte	$A9
	.byte	$FF
	.byte	$9D
	.byte	$B7
	.byte	$3D ; '='
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$C2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F3
	.byte	$A9
	.byte	$FF
	.byte	$8D
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$3D ; '='
	.byte	$8D
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$3D ; '='
	.byte	$8D
	.byte	$3B ; ';'
	.byte	$3D ; '='
	.byte	$8D
	.byte	$3C ; '<'
	.byte	$3D ; '='
	.byte	$AE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$10 ; Screen code for '0'
	.byte	$09 ; Screen code for ')'
	.byte	$BD
	.byte	$F2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$A8
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$99
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$3D ; '='
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F4
	.byte	$A2
	.byte	$0C ; Screen code for ','
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$08 ; Screen code for '('
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$3D ; '='
	.byte	$3D ; '='
	.byte	$A2
	.byte	$0E ; Screen code for '.'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$0B ; Screen code for '+'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$6C ; 'l'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$0D ; Screen code for '-'
	.byte	$A9
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$79 ; 'y'
	.byte	$8D
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$17 ; Screen code for '7'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$B3
	.byte	$69 ; 'i'
	.byte	$4B ; 'K'
	.byte	$8D
	.byte	$CD
	.byte	$3E ; '>'
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A5
	.byte	$B3
	.byte	$CD
	.byte	$CD
	.byte	$3E ; '>'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$F4
	.byte	$A2
	.byte	$0E ; Screen code for '.'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$A9
	.byte	$AD
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$B2
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$85
	.byte	$A1
	.byte	$BD
	.byte	$D2
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$85
	.byte	$A2
	.byte	$BD
	.byte	$F2
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$85
	.byte	$A3
	.byte	$BD
	.byte	$12 ; Screen code for '2'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$85
	.byte	$A4
	.byte	$BD
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$85
	.byte	$A5
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$BD
	.byte	$92
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$F0
	.byte	$07 ; Screen code for '''
	.byte	$A0
	.byte	$0E ; Screen code for '.'
	.byte	$A9
	.byte	$03 ; Screen code for '#'
	.byte	$8D
	.byte	$D7
	.byte	$3D ; '='
	.byte	$8C
	.byte	$C8
	.byte	$02 ; Screen code for '"'
	.byte	$BD
	.byte	$72 ; 'r'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$F0
	.byte	$69 ; 'i'
	.byte	$AD
	.byte	$E8
	.byte	$3C ; '<'
	.byte	$D0
	.byte	$45 ; 'E'
	.byte	$A2
	.byte	$05 ; Screen code for '%'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$B2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$F0
	.byte	$17 ; Screen code for '7'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$74 ; 't'
	.byte	$5B
	.byte	$8D
	.byte	$75 ; 'u'
	.byte	$5B
	.byte	$8D
	.byte	$76 ; 'v'
	.byte	$5B
	.byte	$8D
	.byte	$77 ; 'w'
	.byte	$5B
	.byte	$8D
	.byte	$78 ; 'x'
	.byte	$5B
	.byte	$8D
	.byte	$79 ; 'y'
	.byte	$5B
	.byte	$4C ; 'L'
	.byte	$9E
	.byte	$8A
	.byte	$A9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$8D
	.byte	$74 ; 't'
	.byte	$5B
	.byte	$A9
	.byte	$78 ; 'x'
	.byte	$8D
	.byte	$75 ; 'u'
	.byte	$5B
	.byte	$A9
	.byte	$48 ; 'H'
	.byte	$8D
	.byte	$76 ; 'v'
	.byte	$5B
	.byte	$A9
	.byte	$48 ; 'H'
	.byte	$8D
	.byte	$77 ; 'w'
	.byte	$5B
	.byte	$A9
	.byte	$78 ; 'x'
	.byte	$8D
	.byte	$78 ; 'x'
	.byte	$5B
	.byte	$A9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$8D
	.byte	$79 ; 'y'
	.byte	$5B
	.byte	$4C ; 'L'
	.byte	$9E
	.byte	$8A
	.byte	$A2
	.byte	$0B ; Screen code for '+'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$74 ; 't'
	.byte	$5B
	.byte	$8D
	.byte	$75 ; 'u'
	.byte	$5B
	.byte	$8D
	.byte	$76 ; 'v'
	.byte	$5B
	.byte	$8D
	.byte	$77 ; 'w'
	.byte	$5B
	.byte	$8D
	.byte	$78 ; 'x'
	.byte	$5B
	.byte	$8D
	.byte	$79 ; 'y'
	.byte	$5B
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$C7
	.byte	$B0
	.byte	$4C ; 'L'
	.byte	$AF
	.byte	$8A
	.byte	$A2
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$74 ; 't'
	.byte	$5B
	.byte	$8D
	.byte	$75 ; 'u'
	.byte	$5B
	.byte	$8D
	.byte	$76 ; 'v'
	.byte	$5B
	.byte	$8D
	.byte	$77 ; 'w'
	.byte	$5B
	.byte	$8D
	.byte	$78 ; 'x'
	.byte	$5B
	.byte	$8D
	.byte	$79 ; 'y'
	.byte	$5B
	.byte	$A2
	.byte	$0F ; Screen code for '/'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$D8
	.byte	$3D ; '='
	.byte	$8D
	.byte	$E8
	.byte	$3D ; '='
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$D2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$9E
	.byte	$8C
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$A4
	.byte	$80
	.byte	$B9
	.byte	$3B ; ';'
	.byte	$8C
	.byte	$A8
	.byte	$10 ; Screen code for '0'
	.byte	$08 ; Screen code for '('
	.byte	$BD
	.byte	$AC
	.byte	$3E ; '>'
	.byte	$99
	.byte	$D8
	.byte	$3D ; '='
	.byte	$E8
	.byte	$C8
	.byte	$C6
	.byte	$80
	.byte	$10 ; Screen code for '0'
	.byte	$F4
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$C0
	.byte	$09 ; Screen code for ')'
	.byte	$90
	.byte	$12 ; Screen code for '2'
	.byte	$A9
	.byte	$16 ; Screen code for '6'
	.byte	$85
	.byte	$80
	.byte	$BD
	.byte	$46 ; 'F'
	.byte	$8C
	.byte	$99
	.byte	$D8
	.byte	$3D ; '='
	.byte	$E8
	.byte	$C8
	.byte	$C6
	.byte	$80
	.byte	$D0
	.byte	$F4
	.byte	$F0
	.byte	$10 ; Screen code for '0'
	.byte	$A9
	.byte	$18 ; Screen code for '8'
	.byte	$85
	.byte	$80
	.byte	$BD
	.byte	$5C
	.byte	$8C
	.byte	$99
	.byte	$D8
	.byte	$3D ; '='
	.byte	$E8
	.byte	$C8
	.byte	$C6
	.byte	$80
	.byte	$D0
	.byte	$F4
	.byte	$A2
	.byte	$1F ; Screen code for '?'
	.byte	$BD
	.byte	$D8
	.byte	$3D ; '='
	.byte	$09 ; Screen code for ')'
	.byte	$80
	.byte	$9D
	.byte	$D8
	.byte	$3D ; '='
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F5
	.byte	$A2
	.byte	$0F ; Screen code for '/'
	.byte	$BD
	.byte	$D8
	.byte	$3D ; '='
	.byte	$9D
	.byte	$C0
	.byte	$72 ; 'r'
	.byte	$BD
	.byte	$E8
	.byte	$3D ; '='
	.byte	$9D
	.byte	$D0
	.byte	$72 ; 'r'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F1
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$C2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$CD
	.byte	$B6
	.byte	$3D ; '='
	.byte	$F0
	.byte	$0B ; Screen code for '+'
	.byte	$EE
	.byte	$B6
	.byte	$3D ; '='
	.byte	$A2
	.byte	$0F ; Screen code for '/'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$4C ; 'L'
	.byte	$B4
	.byte	$8A
	.byte	$AD
	.byte	$6D ; 'm'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$1D ; Screen code for '='
	.byte	$8B
	.byte	$A2
	.byte	$11 ; Screen code for '1'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$AE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$91
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$CA
	.byte	$D0
	.byte	$FA
	.byte	$AD
	.byte	$3D ; '='
	.byte	$3D ; '='
	.byte	$85
	.byte	$AC
	.byte	$A2
	.byte	$03 ; Screen code for '#'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$D0
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A6
	.byte	$AC
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$AE
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$CA
	.byte	$86
	.byte	$AC
	.byte	$EC
	.byte	$3D ; '='
	.byte	$3D ; '='
	.byte	$D0
	.byte	$E5
	.byte	$EE
	.byte	$3D ; '='
	.byte	$3D ; '='
	.byte	$AD
	.byte	$3D ; '='
	.byte	$3D ; '='
	.byte	$CD
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$3D ; '='
	.byte	$3D ; '='
	.byte	$4C ; 'L'
	.byte	$81
	.byte	$89
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$C8
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$C7
	.byte	$B0
	.byte	$AD
	.byte	$E6
	.byte	$3C ; '<'
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$BF
	.byte	$8B
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$BD
	.byte	$C2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$C9
	.byte	$0A ; Screen code for '*'
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$E8
	.byte	$D0
	.byte	$F6
	.byte	$FE
	.byte	$C7
	.byte	$3D ; '='
	.byte	$BD
	.byte	$C7
	.byte	$3D ; '='
	.byte	$C9
	.byte	$0A ; Screen code for '*'
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$C7
	.byte	$3D ; '='
	.byte	$EC
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A2
	.byte	$07 ; Screen code for '''
	.byte	$BD
	.byte	$7A ; 'z'
	.byte	$8C
	.byte	$9D
	.byte	$CC
	.byte	$72 ; 'r'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D5
	.byte	$B0
	.byte	$A2
	.byte	$09 ; Screen code for ')'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$4C ; 'L'
	.byte	$9A
	.byte	$8B
	.byte	$8A
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$9E
	.byte	$8C
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$0A ; Screen code for '*'
	.byte	$D0
	.byte	$08 ; Screen code for '('
	.byte	$BD
	.byte	$AC
	.byte	$3E ; '>'
	.byte	$99
	.byte	$C0
	.byte	$72 ; 'r'
	.byte	$E8
	.byte	$C8
	.byte	$C6
	.byte	$80
	.byte	$10 ; Screen code for '0'
	.byte	$F4
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$BD
	.byte	$74 ; 't'
	.byte	$8C
	.byte	$99
	.byte	$C0
	.byte	$72 ; 'r'
	.byte	$E8
	.byte	$C8
	.byte	$E0
	.byte	$06 ; Screen code for '&'
	.byte	$90
	.byte	$F4
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D5
	.byte	$B0
	.byte	$A2
	.byte	$07 ; Screen code for '''
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$6C ; 'l'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$0D ; Screen code for '-'
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$79 ; 'y'
	.byte	$8D
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$64 ; 'd'
	.byte	$8D
	.byte	$A2
	.byte	$0F ; Screen code for '/'
	.byte	$BD
	.byte	$C7
	.byte	$3D ; '='
	.byte	$9D
	.byte	$C2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$BD
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$3D ; '='
	.byte	$C9
	.byte	$0A ; Screen code for '*'
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$E8
	.byte	$D0
	.byte	$F6
	.byte	$FE
	.byte	$C7
	.byte	$3D ; '='
	.byte	$BD
	.byte	$C7
	.byte	$3D ; '='
	.byte	$C9
	.byte	$0A ; Screen code for '*'
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$C7
	.byte	$3D ; '='
	.byte	$8A
	.byte	$AC
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D9
	.byte	$F2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$A2
	.byte	$0E ; Screen code for '.'
	.byte	$BD
	.byte	$82
	.byte	$8C
	.byte	$9D
	.byte	$C8
	.byte	$72 ; 'r'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D5
	.byte	$B0
	.byte	$A2
	.byte	$09 ; Screen code for ')'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$4C ; 'L'
	.byte	$13 ; Screen code for '3'
	.byte	$8C
	.byte	$A0
	.byte	$0C ; Screen code for ','
	.byte	$B9
	.byte	$91
	.byte	$8C
	.byte	$99
	.byte	$CA
	.byte	$72 ; 'r'
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$E8
	.byte	$8A
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$D0
	.byte	$72 ; 'r'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D5
	.byte	$B0
	.byte	$A2
	.byte	$07 ; Screen code for '''
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$6C ; 'l'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$64 ; 'd'
	.byte	$8D
	.byte	$4C ; 'L'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$8C
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$79 ; 'y'
	.byte	$8D
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A2
	.byte	$03 ; Screen code for '#'
	.byte	$BD
	.byte	$C7
	.byte	$3D ; '='
	.byte	$9D
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$3D ; '='
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$61 ; 'a'
	.byte	$79 ; 'y'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$61 ; 'a'
	.byte	$76 ; 'v'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$61 ; 'a'
	.byte	$00 ; Screen code for ' '
	.byte	$6E ; 'n'
	.byte	$69 ; 'i'
	.byte	$63 ; 'c'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$64 ; 'd'
	.byte	$61 ; 'a'
	.byte	$79 ; 'y'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$61 ; 'a'
	.byte	$79 ; 'y'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$61 ; 'a'
	.byte	$76 ; 'v'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$61 ; 'a'
	.byte	$00 ; Screen code for ' '
	.byte	$6E ; 'n'
	.byte	$69 ; 'i'
	.byte	$63 ; 'c'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$64 ; 'd'
	.byte	$61 ; 'a'
	.byte	$79 ; 'y'
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$77 ; 'w'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$73 ; 's'
	.byte	$01 ; Screen code for '!'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$6F ; 'o'
	.byte	$75 ; 'u'
	.byte	$00 ; Screen code for ' '
	.byte	$77 ; 'w'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$01 ; Screen code for '!'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$6F ; 'o'
	.byte	$75 ; 'u'
	.byte	$72 ; 'r'
	.byte	$00 ; Screen code for ' '
	.byte	$74 ; 't'
	.byte	$65 ; 'e'
	.byte	$61 ; 'a'
	.byte	$6D ; 'm'
	.byte	$00 ; Screen code for ' '
	.byte	$77 ; 'w'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$73 ; 's'
	.byte	$01 ; Screen code for '!'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$65 ; 'e'
	.byte	$61 ; 'a'
	.byte	$6D ; 'm'
	.byte	$00 ; Screen code for ' '
	.byte	$03 ; Screen code for '#'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$77 ; 'w'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$73 ; 's'
	.byte	$01 ; Screen code for '!'
	.byte	$CD
	.byte	$6B ; 'k'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$B0
	.byte	$1E ; Screen code for '>'
	.byte	$AA
	.byte	$BD
	.byte	$AE
	.byte	$B0
	.byte	$AA
	.byte	$BD
	.byte	$FC
	.byte	$3D ; '='
	.byte	$85
	.byte	$80
	.byte	$85
	.byte	$81
	.byte	$E8
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$F0
	.byte	$08 ; Screen code for '('
	.byte	$BD
	.byte	$FC
	.byte	$3D ; '='
	.byte	$99
	.byte	$AC
	.byte	$3E ; '>'
	.byte	$E8
	.byte	$C8
	.byte	$C6
	.byte	$81
	.byte	$10 ; Screen code for '0'
	.byte	$F4
	.byte	$60
L8CC1	STA	L0081
	SEC
	SBC	L396B
	SEC
	SBC	L3EED
	BPL	L8CDA
	LDX	#$06
L8CCF	LDA	L8D48,X
	STA	L3EAC,X
	DEX
	BPL	L8CCF
	BMI	L8D0B
L8CDA	SEC
	SBC	L3EEE
	BPL	L8CED
	LDX	#$06
L8CE2	LDA	L8D4F,X
	STA	L3EAC,X
	DEX
	BPL	L8CE2
	BMI	L8D0B
L8CED	SEC
	SBC	L3EEF
	BPL	L8D00
	LDX	#$06
L8CF5	LDA	L8D56,X
	STA	L3EAC,X
	DEX
	BPL	L8CF5
	BMI	L8D0B
L8D00	LDX	#$06
L8D02	LDA	L8D5D,X
	STA	L3EAC,X
	DEX
	BPL	L8D02
L8D0B	LDX	#$07
	LDA	L3F0D
	BEQ	L8D36
	LDA	#$09
	STA	L0080
	INC	L0081
	LDA	L0081
	CMP	#$0A
	BCC	L8D2B
	INC	L0080
	LDA	#$11
	STA	L3EAC,X
	INX
	SEC
	LDA	L0081
	SBC	#$0A
L8D2B	ORA	#$10
	STA	L3EAC,X
	LDA	#$09
	STA	L3EAD,X
	RTS
L8D36	LDA	#$09
	STA	L0080
	CLC
	LDA	L0081
	ADC	#$21
	STA	L3EB3
	LDA	#$09
	STA	L3EB4
	RTS
L8D48	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$61 ; 'a'
	.byte	$72 ; 'r'
	.byte	$67 ; 'g'
	.byte	$65 ; 'e'
	.byte	$74 ; 't'
	.byte	$08 ; Screen code for '('
L8D4F	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$72 ; 'r'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
L8D56	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$6A ; 'j'
	.byte	$61 ; 'a'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
L8D5D	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$61 ; 'a'
	.byte	$73 ; 's'
	.byte	$74 ; 't'
	.byte	$79 ; 'y'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$69 ; 'i'
	.byte	$3C ; '<'
	.byte	$8D
	.byte	$CD
	.byte	$3E ; '>'
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$CD
	.byte	$CD
	.byte	$3E ; '>'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$F4
	.byte	$60
L8D79	CLC
	ADC	L00B3
	STA	L3ECD
	LDA	L3968
	BNE	L8D9F
L8D84	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L8DB3
	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDA	L00B3
	CMP	L3ECD
	BMI	L8D84
	LDA	#$84
	STA	L3EE8
L8D9F	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L8DB3
	LDA	L3EE7
	BEQ	L8D9F
	LDA	#$00
	STA	L3EE7
L8DB3	RTS
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
	.byte	$A9
	.byte	$80
	.byte	$85
	.byte	$80
	.byte	$A9
	.byte	$73 ; 's'
	.byte	$85
	.byte	$81
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$19 ; Screen code for '9'
	.byte	$8E
	.byte	$A9
	.byte	$80
	.byte	$85
	.byte	$80
	.byte	$A9
	.byte	$63 ; 'c'
	.byte	$85
	.byte	$81
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$19 ; Screen code for '9'
	.byte	$8E
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$80
	.byte	$69 ; 'i'
	.byte	$80
	.byte	$85
	.byte	$AF
	.byte	$A5
	.byte	$81
	.byte	$69 ; 'i'
	.byte	$01 ; Screen code for '!'
	.byte	$85
	.byte	$B0
	.byte	$A9
	.byte	$46 ; 'F'
	.byte	$85
	.byte	$AD
	.byte	$A9
	.byte	$93
	.byte	$85
	.byte	$AE
	.byte	$A2
	.byte	$4C ; 'L'
	.byte	$A0
	.byte	$05 ; Screen code for '%'
	.byte	$B1
	.byte	$AD
	.byte	$91
	.byte	$AF
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F9
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$AD
	.byte	$69 ; 'i'
	.byte	$06 ; Screen code for '&'
	.byte	$85
	.byte	$AD
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$AE
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$AF
	.byte	$69 ; 'i'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$85
	.byte	$AF
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$B0
	.byte	$CA
	.byte	$D0
	.byte	$DE
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$80
	.byte	$69 ; 'i'
	.byte	$BA
	.byte	$85
	.byte	$AF
	.byte	$A5
	.byte	$81
	.byte	$69 ; 'i'
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$B0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$7F
	.byte	$8E
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$AF
	.byte	$69 ; 'i'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$85
	.byte	$AF
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$B0
	.byte	$CA
	.byte	$F0
	.byte	$0D ; Screen code for '-'
	.byte	$A0
	.byte	$05 ; Screen code for '%'
	.byte	$B9
	.byte	$90
	.byte	$8E
	.byte	$91
	.byte	$AF
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F8
	.byte	$4C ; 'L'
	.byte	$64 ; 'd'
	.byte	$8E
	.byte	$A0
	.byte	$05 ; Screen code for '%'
	.byte	$B9
	.byte	$8A
	.byte	$8E
	.byte	$91
	.byte	$AF
	.byte	$88
	.byte	$10 ; Screen code for '0'
	.byte	$F8
	.byte	$60
	.byte	$3F ; '?'
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$03 ; Screen code for '#'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
L8E98	LDA	L9C80,X
	STA	L6000,X
L8E9E	LDA	L9D80,X
	STA	L6100,X
	LDA	L9E80,X
	STA	L6200,X
	LDA	L9F00,X
	STA	L6280,X
	INX
	BNE	L8E98
	LDA	#$FF
L8EB5	STA	L3DB7,X
	INX
	CPX	#$10
	BCC	L8EB5
	JMP	BANK_RETURN
	.byte	$AD
L8EC1	INC	NOCKSM
	BEQ	L8EC8
	JMP	L8F87
L8EC8	LDA	L396E
	BNE	L8ED0
	JMP	L8F84
L8ED0	LDX	#$00
	STX	L3EEC
L8ED5	LDA	L3DB7,X
	CMP	L3AC2,X
	BNE	L8EEE
	CPX	L3968
	BEQ	L8EE5
	JMP	L8F76
L8EE5	LDA	RTCLOK+2
	AND	#$20
	BNE	L8F26
	LDA	L3DB7,X
L8EEE	TAX
	BMI	L8F26
	CLC
	LDA	L907A,X
	ADC	L3EEC
	STA	L00AF
	LDA	L9085,X
	STA	L00B0
	LDA	L9047,X
	TAX
	LDY	#$00
	LDA	L9052,X
	STA	(L00AF),Y
	LDY	#$20
	LDA	L9053,X
	STA	(L00AF),Y
	LDY	#$40
	LDA	L9054,X
	STA	(L00AF),Y
	LDY	#$60
	LDA	L9055,X
	STA	(L00AF),Y
	LDY	#$80
	LDA	L9056,X
	STA	(L00AF),Y
L8F26	LDX	L3EEC
	CPX	L3968
	BNE	L8F34
	LDA	RTCLOK+2
	AND	#$20
	BEQ	L8F76
L8F34	LDA	L3AC2,X
	TAX
	CLC
	LDA	L907A,X
	ADC	L3EEC
	STA	L00AF
	LDA	L9085,X
	STA	L00B0
	LDA	L9047,X
	TAX
	LDY	#$00
	LDA	L9066,X
	STA	(L00AF),Y
	LDY	#$20
	LDA	L9067,X
	STA	(L00AF),Y
	LDY	#$40
	LDA	L9068,X
	STA	(L00AF),Y
	LDY	#$60
	LDA	L9069,X
	STA	(L00AF),Y
	LDY	#$80
	LDA	L906A,X
	STA	(L00AF),Y
	LDX	L3EEC
	LDA	L3AC2,X
	STA	L3DB7,X
L8F76	INC	L3EEC
	LDX	L3EEC
	CPX	L396E
	BCS	L8F84
	JMP	L8ED5
L8F84	JMP	BANK_RETURN
L8F87	LDX	#$00
	STX	L3EEC
L8F8C	LDA	L3DB7,X
	CMP	L3D39,X
	BNE	L8FA9
	TXA
	LDY	L3968
	CMP	L3AF2,Y
	BEQ	L8FA0
	JMP	L9037
L8FA0	LDA	RTCLOK+2
	AND	#$20
	BNE	L8FE1
	LDA	L3DB7,X
L8FA9	TAX
	BMI	L8FE1
	CLC
	LDA	L907A,X
	ADC	L3EEC
	STA	L00AF
	LDA	L9085,X
	STA	L00B0
	LDA	L9047,X
	TAX
	LDY	#$00
	LDA	L9052,X
	STA	(L00AF),Y
	LDY	#$20
	LDA	L9053,X
	STA	(L00AF),Y
	LDY	#$40
	LDA	L9054,X
	STA	(L00AF),Y
	LDY	#$60
	LDA	L9055,X
	STA	(L00AF),Y
	LDY	#$80
	LDA	L9056,X
	STA	(L00AF),Y
L8FE1	LDA	L3EEC
	LDX	L3968
	CMP	L3AF2,X
	BNE	L8FF2
	LDA	RTCLOK+2
	AND	#$20
	BEQ	L9037
L8FF2	LDX	L3EEC
	LDA	L3D39,X
	TAX
	CLC
	LDA	L907A,X
	ADC	L3EEC
	STA	L00AF
	LDA	L9085,X
	STA	L00B0
	LDA	L9047,X
	TAX
	LDY	#$00
	LDA	L9066,X
	STA	(L00AF),Y
	LDY	#$20
	LDA	L9067,X
	STA	(L00AF),Y
	LDY	#$40
	LDA	L9068,X
	STA	(L00AF),Y
	LDY	#$60
	LDA	L9069,X
	STA	(L00AF),Y
	LDY	#$80
	LDA	L906A,X
	STA	(L00AF),Y
	LDX	L3EEC
	LDA	L3D39,X
	STA	L3DB7,X
L9037	INC	L3EEC
	LDX	L3EEC
	CPX	#$04
	BCS	L9044
	JMP	L8F8C
L9044	JMP	BANK_RETURN
L9047	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$0A ; Screen code for '*'
	.byte	$05 ; Screen code for '%'
	.byte	$0A ; Screen code for '*'
	.byte	$05 ; Screen code for '%'
	.byte	$0A ; Screen code for '*'
	.byte	$05 ; Screen code for '%'
	.byte	$0A ; Screen code for '*'
	.byte	$05 ; Screen code for '%'
	.byte	$0F ; Screen code for '/'
L9052	.byte	$FF
L9053	.byte	$00 ; Screen code for ' '
L9054	.byte	$00 ; Screen code for ' '
L9055	.byte	$00 ; Screen code for ' '
L9056	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
L9066	.byte	$23 ; '#' ; Screen code for 'C'
L9067	.byte	$88
L9068	.byte	$A8
L9069	.byte	$88
L906A	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$88
	.byte	$AB
	.byte	$88
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$88
	.byte	$A8
	.byte	$88
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$88
	.byte	$A8
	.byte	$88
	.byte	$23 ; '#' ; Screen code for 'C'
L907A	.byte	$A9
	.byte	$69 ; 'i'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$E9
	.byte	$A9
	.byte	$69 ; 'i'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$E9
	.byte	$A9
	.byte	$69 ; 'i'
	.byte	$29 ; ')' ; Screen code for 'I'
L9085	.byte	$62 ; 'b'
	.byte	$62 ; 'b'
	.byte	$62 ; 'b'
	.byte	$61 ; 'a'
	.byte	$61 ; 'a'
	.byte	$61 ; 'a'
	.byte	$61 ; 'a'
	.byte	$60
	.byte	$60
	.byte	$60
	.byte	$60
L9090	LDX	#$73
	JSR	L90CA
	LDX	#$63
	JSR	L90CA
	LDX	L3968
	LDA	L3A72,X
	BEQ	L90B3
	LDA	#$00
	STA	L5C63
	STA	L5C64
	STA	L5C65
	STA	L5C66
	JMP	BANK_RETURN
L90B3	LDA	#$05
	STA	L5C63
	LDA	#$07
	STA	L5C64
	LDA	#$07
	STA	L5C65
	LDA	#$02
	STA	L5C66
	JMP	BANK_RETURN
L90CA	CLC
	LDA	#$80
	ADC	#$61
	STA	L00AF
	TXA
	ADC	#$04
	STA	L00B0
	LDX	L3968
	LDA	L3A72,X
	TAX
	LDA	L910D,X
	STA	L00AD
	LDA	L9110+1,X
	STA	L00AE
	LDY	#$63
L90E9	LDA	(L00AD),Y
	STA	(L00AF),Y
	DEY
	LDA	(L00AD),Y
	STA	(L00AF),Y
	DEY
	LDA	(L00AD),Y
	STA	(L00AF),Y
	DEY
	LDA	(L00AD),Y
	STA	(L00AF),Y
	DEY
	BMI	L910C
	SEC
	LDA	L00AF
	SBC	#$1C
	STA	L00AF
	BCS	L90E9
	DEC	L00B0
	BNE	L90E9
L910C	RTS
L910D	.byte	$3A ; ':' ; Screen code for 'Z'
L910E	DEC	COLAC,X
L9110	ASL	L9596
	STA	L0095,X
	LDX	L3DB6
	BEQ	L9157
	DEX
	CPX	#$05
	BCS	L9137
	LDA	L91B5,X
	TAX
	LDY	#$0E
L9125	LDA	L91BA,Y
	STA	L5D00,X
	LDA	L91C9,Y
	STA	L5E00,X
	DEX
	DEY
	BPL	L9125
	BMI	L914D
L9137	LDA	L91B0,X
	TAX
	LDY	#$0E
L913D	LDA	L91D8,Y
	STA	L5E00,X
	LDA	L91E7,Y
	STA	L5F00,X
	DEX
	DEY
	BPL	L913D
L914D	LDY	#$73
	JSR	L915A
	LDY	#$63
	JSR	L915A
L9157	JMP	BANK_RETURN
L915A	LDX	L3DB6
	DEX
	CLC
	LDA	#$80
	ADC	L91A1,X
	STA	L00AF
	TYA
	ADC	L91AB,X
	STA	L00B0
	LDA	#$9E
	STA	L00AD
	LDA	#$96
	STA	L00AE
	CPX	#$05
	BCC	L9180
	LDA	#$C5
	STA	L00AD
	LDA	#$96
	STA	L00AE
L9180	LDY	#$26
L9182	LDA	(L00AD),Y
	STA	(L00AF),Y
	DEY
	LDA	(L00AD),Y
	STA	(L00AF),Y
	DEY
	LDA	(L00AD),Y
	STA	(L00AF),Y
	DEY
	BMI	L91A0
	SEC
	LDA	L00AF
	SBC	#$1D
	STA	L00AF
	BCS	L9182
	DEC	L00B0
	BNE	L9182
L91A0	RTS
L91A1	.byte	$97
	.byte	$B7
	.byte	$D7
	.byte	$F7
	.byte	$17 ; Screen code for '7'
	.byte	$99
	.byte	$B9
	.byte	$D9
	.byte	$F9
	.byte	$19 ; Screen code for '9'
L91AB	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
L91B0	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
L91B5	.byte	$5A ; 'Z'
	.byte	$6B ; 'k'
	.byte	$7C ; '|'
	.byte	$8D
	.byte	$9E
L91BA	.byte	$1C ; Screen code for '<'
	.byte	$3E ; '>'
	.byte	$63 ; 'c'
	.byte	$41 ; 'A'
	.byte	$E1
	.byte	$F0
	.byte	$B8
	.byte	$9C
	.byte	$8E
	.byte	$87
	.byte	$C3
	.byte	$41 ; 'A'
	.byte	$63 ; 'c'
	.byte	$3E ; '>'
	.byte	$1C ; Screen code for '<'
L91C9	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L91D8	.byte	$07 ; Screen code for '''
	.byte	$0F ; Screen code for '/'
	.byte	$18 ; Screen code for '8'
	.byte	$10 ; Screen code for '0'
	.byte	$B8
	.byte	$BC
	.byte	$AE
	.byte	$A7
	.byte	$A3
	.byte	$A1
	.byte	$B0
	.byte	$10 ; Screen code for '0'
	.byte	$18 ; Screen code for '8'
	.byte	$0F ; Screen code for '/'
	.byte	$07 ; Screen code for '''
L91E7	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$C0
	.byte	$40 ; '@'
	.byte	$60
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$A0
	.byte	$E0
	.byte	$E0
	.byte	$40 ; '@'
	.byte	$C0
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$73 ; 's'
	.byte	$A5
	.byte	$8D
	.byte	$F0
	.byte	$02 ; Screen code for '"'
	.byte	$A2
	.byte	$63 ; 'c'
	.byte	$18 ; Screen code for '8'
	.byte	$A9
	.byte	$80
	.byte	$69 ; 'i'
	.byte	$4A ; 'J'
	.byte	$85
	.byte	$AF
	.byte	$8A
	.byte	$69 ; 'i'
	.byte	$09 ; Screen code for ')'
	.byte	$85
	.byte	$B0
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$72 ; 'r'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$F0
	.byte	$0E ; Screen code for '.'
	.byte	$BD
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$18 ; Screen code for '8'
	.byte	$69 ; 'i'
	.byte	$10 ; Screen code for '0'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$AA
	.byte	$10 ; Screen code for '0'
	.byte	$02 ; Screen code for '"'
	.byte	$A2
	.byte	$08 ; Screen code for '('
	.byte	$BD
	.byte	$4A ; 'J'
	.byte	$92
	.byte	$85
	.byte	$AD
	.byte	$BD
	.byte	$53 ; 'S'
	.byte	$92
	.byte	$85
	.byte	$AE
	.byte	$A0
	.byte	$19 ; Screen code for '9'
	.byte	$B1
	.byte	$AD
	.byte	$91
	.byte	$AF
	.byte	$88
	.byte	$B1
	.byte	$AD
	.byte	$91
	.byte	$AF
	.byte	$88
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0D ; Screen code for '-'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$AF
	.byte	$E9
	.byte	$1E ; Screen code for '>'
	.byte	$85
	.byte	$AF
	.byte	$B0
	.byte	$EB
	.byte	$C6
	.byte	$B0
	.byte	$D0
	.byte	$E7
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$5C
	.byte	$76 ; 'v'
	.byte	$90
	.byte	$AA
	.byte	$C4
	.byte	$DE
	.byte	$F8
	.byte	$12 ; Screen code for '2'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$93
	.byte	$93
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$80
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$A2
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$82
	.byte	$08 ; Screen code for '('
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$A8
	.byte	$02 ; Screen code for '"'
	.byte	$88
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$08 ; Screen code for '('
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$08 ; Screen code for '('
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$02 ; Screen code for '"'
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$08 ; Screen code for '('
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$02 ; Screen code for '"'
	.byte	$88
	.byte	$00 ; Screen code for ' '
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$A8
	.byte	$0A ; Screen code for '*'
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$82
	.byte	$08 ; Screen code for '('
	.byte	$A2
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$0A ; Screen code for '*'
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$08 ; Screen code for '('
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$80
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$80
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$A8
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$00 ; Screen code for ' '
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$80
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$80
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$08 ; Screen code for '('
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
	.byte	$FC
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C3
	.byte	$FF
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$FC
	.byte	$CF
	.byte	$0C ; Screen code for ','
	.byte	$C3
	.byte	$0C ; Screen code for ','
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$0C ; Screen code for ','
	.byte	$C3
	.byte	$CC
	.byte	$FC
	.byte	$CC
	.byte	$CF
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$C3
	.byte	$0C ; Screen code for ','
	.byte	$C3
	.byte	$CC
	.byte	$CC
	.byte	$CF
	.byte	$CF
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
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
	.byte	$FC
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$3C ; '<'
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$F0
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$CC
	.byte	$F0
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$F0
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$F3
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$F3
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$CC
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$CC
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$8A
	.byte	$8A
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$8A
	.byte	$8A
	.byte	$80
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$AA
	.byte	$8A
	.byte	$8A
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$A2
	.byte	$AA
	.byte	$AA
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$A2
	.byte	$AA
	.byte	$AA
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$A0
	.byte	$AA
	.byte	$A8
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$A8
	.byte	$AA
	.byte	$A8
	.byte	$A8
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$A0
	.byte	$0A ; Screen code for '*'
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$8A
	.byte	$8A
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$8A
	.byte	$8A
	.byte	$80
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
L9596	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$AA
	.byte	$8A
	.byte	$8A
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$A8
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$AA
	.byte	$A8
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$AA
	.byte	$AA
	.byte	$A0
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$8A
	.byte	$8A
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$8A
	.byte	$8A
	.byte	$80
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$AA
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$AA
	.byte	$8A
	.byte	$8A
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A8
	.byte	$AA
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$A8
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$A0
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$AA
	.byte	$A8
	.byte	$A0
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$AA
	.byte	$AA
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$8A
	.byte	$8A
	.byte	$A0
	.byte	$AA
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A8
	.byte	$AA
	.byte	$A0
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A8
	.byte	$AA
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$A8
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$08 ; Screen code for '('
	.byte	$82
	.byte	$A0
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$A0
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$AA
	.byte	$A8
	.byte	$A0
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$AA
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$8A
	.byte	$88
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A8
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$03 ; Screen code for '#'
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$83
	.byte	$0A ; Screen code for '*'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$83
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$83
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$83
	.byte	$0A ; Screen code for '*'
	.byte	$AA
	.byte	$83
	.byte	$08 ; Screen code for '('
	.byte	$A8
	.byte	$83
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$83
	.byte	$02 ; Screen code for '"'
	.byte	$8A
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$A8
	.byte	$03 ; Screen code for '#'
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
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$0F ; Screen code for '/'
	.byte	$9D
	.byte	$C0
	.byte	$72 ; 'r'
	.byte	$9D
	.byte	$D0
	.byte	$72 ; 'r'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$A5
	.byte	$8D
	.byte	$D0
	.byte	$0A ; Screen code for '*'
	.byte	$A9
	.byte	$80
	.byte	$85
	.byte	$80
	.byte	$A9
	.byte	$73 ; 's'
	.byte	$85
	.byte	$81
	.byte	$D0
	.byte	$08 ; Screen code for '('
	.byte	$A9
	.byte	$80
	.byte	$85
	.byte	$80
	.byte	$A9
	.byte	$63 ; 'c'
	.byte	$85
	.byte	$81
	.byte	$A2
	.byte	$64 ; 'd'
	.byte	$A9
	.byte	$FF
	.byte	$A0
	.byte	$06 ; Screen code for '&'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$80
	.byte	$69 ; 'i'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$85
	.byte	$80
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$81
	.byte	$CA
	.byte	$D0
	.byte	$B3
	.byte	$A0
	.byte	$74 ; 't'
	.byte	$A5
	.byte	$8D
	.byte	$F0
	.byte	$02 ; Screen code for '"'
	.byte	$A0
	.byte	$64 ; 'd'
	.byte	$84
	.byte	$B9
	.byte	$A9
	.byte	$A9
	.byte	$85
	.byte	$B8
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$BD
	.byte	$D2
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$E9
	.byte	$04 ; Screen code for '$'
	.byte	$85
	.byte	$A6
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$BD
	.byte	$12 ; Screen code for '2'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$E9
	.byte	$04 ; Screen code for '$'
	.byte	$85
	.byte	$A7
	.byte	$A9
	.byte	$3F ; '?'
	.byte	$85
	.byte	$C3
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$BF
	.byte	$85
	.byte	$C0
	.byte	$A9
	.byte	$FF
	.byte	$85
	.byte	$C4
	.byte	$85
	.byte	$C1
	.byte	$85
	.byte	$C2
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$F2
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$18 ; Screen code for '8'
	.byte	$69 ; 'i'
	.byte	$10 ; Screen code for '0'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$A8
	.byte	$4A ; 'J'
	.byte	$AA
	.byte	$B9
	.byte	$61 ; 'a'
	.byte	$9B ; '›'
	.byte	$F0
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$A7
	.byte	$BD
	.byte	$71 ; 'q'
	.byte	$9B ; '›'
	.byte	$F0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$66 ; 'f'
	.byte	$C3
	.byte	$66 ; 'f'
	.byte	$C4
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$66 ; 'f'
	.byte	$C3
	.byte	$66 ; 'f'
	.byte	$C4
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$66 ; 'f'
	.byte	$BF
	.byte	$66 ; 'f'
	.byte	$C0
	.byte	$66 ; 'f'
	.byte	$C1
	.byte	$66 ; 'f'
	.byte	$C2
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$66 ; 'f'
	.byte	$BF
	.byte	$66 ; 'f'
	.byte	$C0
	.byte	$66 ; 'f'
	.byte	$C1
	.byte	$66 ; 'f'
	.byte	$C2
	.byte	$CA
	.byte	$D0
	.byte	$E1
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$B2
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$18 ; Screen code for '8'
	.byte	$69 ; 'i'
	.byte	$10 ; Screen code for '0'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$A8
	.byte	$4A ; 'J'
	.byte	$AA
	.byte	$B9
	.byte	$61 ; 'a'
	.byte	$9B ; '›'
	.byte	$F0
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$A6
	.byte	$BD
	.byte	$79 ; 'y'
	.byte	$9B ; '›'
	.byte	$85
	.byte	$BA
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$B8
	.byte	$FD
	.byte	$81
	.byte	$9B ; '›'
	.byte	$85
	.byte	$B8
	.byte	$A5
	.byte	$B9
	.byte	$FD
	.byte	$89
	.byte	$9B ; '›'
	.byte	$85
	.byte	$B9
	.byte	$A9
	.byte	$09 ; Screen code for ')'
	.byte	$85
	.byte	$BC
	.byte	$A9
	.byte	$09 ; Screen code for ')'
	.byte	$85
	.byte	$BD
	.byte	$A9
	.byte	$FE
	.byte	$85
	.byte	$BB
	.byte	$A5
	.byte	$B8
	.byte	$85
	.byte	$B6
	.byte	$A5
	.byte	$B9
	.byte	$85
	.byte	$B7
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$3C ; '<'
	.byte	$9B ; '›'
	.byte	$86
	.byte	$80
	.byte	$A5
	.byte	$BA
	.byte	$C9
	.byte	$55 ; 'U'
	.byte	$B0
	.byte	$3C ; '<'
	.byte	$A5
	.byte	$80
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$01 ; Screen code for '!'
	.byte	$F0
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$A5
	.byte	$BF
	.byte	$A4
	.byte	$BB
	.byte	$C0
	.byte	$0E ; Screen code for '.'
	.byte	$F0
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$B0
	.byte	$04 ; Screen code for '$'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B6
	.byte	$91
	.byte	$B6
	.byte	$C8
	.byte	$C0
	.byte	$0E ; Screen code for '.'
	.byte	$B0
	.byte	$06 ; Screen code for '&'
	.byte	$B1
	.byte	$B6
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$C0
	.byte	$91
	.byte	$B6
	.byte	$A5
	.byte	$C1
	.byte	$C8
	.byte	$C0
	.byte	$0E ; Screen code for '.'
	.byte	$F0
	.byte	$0E ; Screen code for '.'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B6
	.byte	$91
	.byte	$B6
	.byte	$C8
	.byte	$B1
	.byte	$B6
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$C2
	.byte	$91
	.byte	$B6
	.byte	$4C ; 'L'
	.byte	$67 ; 'g'
	.byte	$9A
	.byte	$09 ; Screen code for ')'
	.byte	$3F ; '?'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B6
	.byte	$91
	.byte	$B6
	.byte	$A5
	.byte	$C1
	.byte	$A5
	.byte	$80
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$08 ; Screen code for '('
	.byte	$F0
	.byte	$5C
	.byte	$A9
	.byte	$0D ; Screen code for '-'
	.byte	$85
	.byte	$BE
	.byte	$A5
	.byte	$BA
	.byte	$85
	.byte	$80
	.byte	$A4
	.byte	$BB
	.byte	$C0
	.byte	$0E ; Screen code for '.'
	.byte	$F0
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$B0
	.byte	$48 ; 'H'
	.byte	$A5
	.byte	$BA
	.byte	$C9
	.byte	$55 ; 'U'
	.byte	$B0
	.byte	$0E ; Screen code for '.'
	.byte	$B1
	.byte	$B6
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$C3
	.byte	$91
	.byte	$B6
	.byte	$C8
	.byte	$B1
	.byte	$B6
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$C4
	.byte	$91
	.byte	$B6
	.byte	$88
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$B6
	.byte	$69 ; 'i'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$85
	.byte	$B6
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$B7
	.byte	$E6
	.byte	$BA
	.byte	$C6
	.byte	$BE
	.byte	$D0
	.byte	$DB ; Screen code for '›'
	.byte	$F0
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$A5
	.byte	$C3
	.byte	$09 ; Screen code for ')'
	.byte	$3F ; '?'
	.byte	$AA
	.byte	$A5
	.byte	$BA
	.byte	$C9
	.byte	$55 ; 'U'
	.byte	$B0
	.byte	$05 ; Screen code for '%'
	.byte	$8A
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B6
	.byte	$91
	.byte	$B6
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$B6
	.byte	$69 ; 'i'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$85
	.byte	$B6
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$B7
	.byte	$E6
	.byte	$BA
	.byte	$C6
	.byte	$BE
	.byte	$D0
	.byte	$E4
	.byte	$A5
	.byte	$80
	.byte	$85
	.byte	$BA
	.byte	$A5
	.byte	$B8
	.byte	$85
	.byte	$B6
	.byte	$A5
	.byte	$B9
	.byte	$85
	.byte	$B7
	.byte	$E6
	.byte	$BB
	.byte	$E6
	.byte	$BB
	.byte	$E6
	.byte	$A7
	.byte	$C6
	.byte	$BD
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$18 ; Screen code for '8'
	.byte	$9A
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$A7
	.byte	$E9
	.byte	$09 ; Screen code for ')'
	.byte	$85
	.byte	$A7
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$B8
	.byte	$69 ; 'i'
	.byte	$80
	.byte	$85
	.byte	$B8
	.byte	$A5
	.byte	$B9
	.byte	$69 ; 'i'
	.byte	$01 ; Screen code for '!'
	.byte	$85
	.byte	$B9
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$BA
	.byte	$69 ; 'i'
	.byte	$0C ; Screen code for ','
	.byte	$85
	.byte	$BA
	.byte	$E6
	.byte	$A6
	.byte	$C6
	.byte	$BC
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$10 ; Screen code for '0'
	.byte	$9A
	.byte	$A0
	.byte	$79 ; 'y'
	.byte	$A5
	.byte	$8D
	.byte	$F0
	.byte	$02 ; Screen code for '"'
	.byte	$A0
	.byte	$69 ; 'i'
	.byte	$84
	.byte	$B7
	.byte	$A9
	.byte	$A0
	.byte	$85
	.byte	$B6
	.byte	$A2
	.byte	$09 ; Screen code for ')'
	.byte	$BD
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$9B ; '›'
	.byte	$A8
	.byte	$BD
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$9B ; '›'
	.byte	$51 ; 'Q'
	.byte	$B6
	.byte	$91
	.byte	$B6
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F2
	.byte	$A2
	.byte	$01 ; Screen code for '!'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$4F ; 'O'
	.byte	$50 ; 'P'
	.byte	$6F ; 'o'
	.byte	$70 ; 'p'
	.byte	$8F
	.byte	$90
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$01 ; Screen code for '!'
	.byte	$D0
	.byte	$01 ; Screen code for '!'
	.byte	$50 ; 'P'
	.byte	$01 ; Screen code for '!'
	.byte	$D0
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$A5
	.byte	$A6
	.byte	$CD
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$F0
	.byte	$0E ; Screen code for '.'
	.byte	$B0
	.byte	$19 ; Screen code for '9'
	.byte	$A5
	.byte	$A7
	.byte	$CD
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$F0
	.byte	$0F ; Screen code for '/'
	.byte	$B0
	.byte	$10 ; Screen code for '0'
	.byte	$4C ; 'L'
	.byte	$00 ; Screen code for ' '
	.byte	$AD
	.byte	$A5
	.byte	$A7
	.byte	$CD
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$B0
	.byte	$06 ; Screen code for '&'
	.byte	$A2
	.byte	$01 ; Screen code for '!'
	.byte	$60
	.byte	$A2
	.byte	$08 ; Screen code for '('
	.byte	$60
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$60
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$FA
	.byte	$F9
	.byte	$F7
	.byte	$F6
	.byte	$F4
	.byte	$FF
	.byte	$FD
	.byte	$FC
	.byte	$C0
	.byte	$E0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$40 ; '@'
	.byte	$80
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$60
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
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
L9C80	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0D ; Screen code for '-'
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
	.byte	$05 ; Screen code for '%'
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
	.byte	$35 ; '5' ; Screen code for 'U'
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
	.byte	$11 ; Screen code for '1'
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
	.byte	$11 ; Screen code for '1'
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
	.byte	$3F ; '?'
	.byte	$DD
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
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
	.byte	$11 ; Screen code for '1'
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
	.byte	$11 ; Screen code for '1'
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
L9D80	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$15 ; Screen code for '5'
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
	.byte	$3F ; '?'
	.byte	$D7
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
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
	.byte	$14 ; Screen code for '4'
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
	.byte	$50 ; 'P'
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
	.byte	$01 ; Screen code for '!'
	.byte	$50 ; 'P'
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
	.byte	$3D ; '='
	.byte	$55 ; 'U'
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
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
	.byte	$05 ; Screen code for '%'
	.byte	$15 ; Screen code for '5'
	.byte	$40 ; '@'
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
	.byte	$04 ; Screen code for '$'
	.byte	$54 ; 'T'
	.byte	$40 ; '@'
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
L9E80	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$04 ; Screen code for '$'
	.byte	$44 ; 'D'
	.byte	$40 ; '@'
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
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$77 ; 'w'
	.byte	$7F
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
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
	.byte	$04 ; Screen code for '$'
	.byte	$44 ; 'D'
	.byte	$40 ; '@'
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
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$40 ; '@'
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
L9F00	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$55 ; 'U'
	.byte	$C0
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
	.byte	$3F ; '?'
	.byte	$D7
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
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
	.byte	$04 ; Screen code for '$'
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
	.byte	$44 ; 'D'
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
	.byte	$01 ; Screen code for '!'
	.byte	$44 ; 'D'
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
	.byte	$01 ; Screen code for '!'
	.byte	$44 ; 'D'
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
	.byte	$50 ; 'P'
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

	opt h-

	icl "include/atari_os.inc"
	icl "include/hardware.inc"
	icl "include/cartridge.inc"

; Bank 12: switchable 8KB cartridge bank, mapped at $8000-$9FFF.
; Contains display/input/game support code with embedded data tables.
; Generated Lxxxx symbols are preserved until their meaning is proven.
; Hardware/OS constants are named where confidently identified.
; Bank map (working):
;   $8000-$9FFF  Display/input support code mixed with data tables.

L0080	= $0080
L0081	= $0081
L0087	= $0087
L0088	= $0088
L0089	= $0089
L008C	= $008C
L0093	= $0093
L0096	= $0096
L0097	= $0097
L0098	= $0098
L0099	= $0099
L00A6	= $00A6
L00A7	= $00A7
L00A8	= $00A8
L00A9	= $00A9
L00AD	= $00AD
L00AE	= $00AE
L00B1	= $00B1
L00B2	= $00B2
L00B3	= $00B3
L13D0	= $13D0
L3000	= $3000
L3040	= $3040
L3080	= $3080
L30C0	= $30C0
L3100	= $3100
L3140	= $3140
L3180	= $3180
L3200	= $3200
L3300	= $3300
L3400	= $3400
L3500	= $3500
L3600	= $3600
L3700	= $3700
L3968	= $3968
L3969	= $3969
L396A	= $396A
L396B	= $396B
L396C	= $396C
L396E	= $396E
L396F	= $396F
L39B2	= $39B2
L39C2	= $39C2
L39D2	= $39D2
L39E2	= $39E2
L39F2	= $39F2
L3A02	= $3A02
L3A12	= $3A12
L3A22	= $3A22
L3A32	= $3A32
L3A72	= $3A72
L3A82	= $3A82
L3A92	= $3A92
L3AA2	= $3AA2
L3AB2	= $3AB2
L3AC2	= $3AC2
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
L3D3E	= $3D3E
L3D66	= $3D66
L3D8E	= $3D8E
L3DB6	= $3DB6
L3DC7	= $3DC7
L3DD7	= $3DD7
L3DFC	= $3DFC
L3EB9	= $3EB9
L3EBA	= $3EBA
L3ECE	= $3ECE
L3ED0	= $3ED0
L3ED1	= $3ED1
L3ED2	= $3ED2
L3ED3	= $3ED3
L3ED4	= $3ED4
L3ED5	= $3ED5
L3ED6	= $3ED6
L3ED7	= $3ED7
L3ED8	= $3ED8
L3ED9	= $3ED9
L3EDA	= $3EDA
L3EDB	= $3EDB
L3EDC	= $3EDC
L3EDD	= $3EDD
L3EDE	= $3EDE
L3EDF	= $3EDF
L3EE0	= $3EE0
L3EE1	= $3EE1
L3EE7	= $3EE7
L3EE8	= $3EE8
L3EE9	= $3EE9
L3EEA	= $3EEA
L3EEB	= $3EEB
L3EED	= $3EED
L3EEE	= $3EEE
L3EEF	= $3EEF
L3EF0	= $3EF0
L3EF1	= $3EF1
L3EF2	= $3EF2
L3EF3	= $3EF3
L3F07	= $3F07
L3F08	= $3F08
L3F09	= $3F09
L3F0A	= $3F0A
L3F0C	= $3F0C
L3F0D	= $3F0D
L3F0E	= $3F0E
L3F0F	= $3F0F
L3F10	= $3F10
L3F12	= $3F12
L3F13	= $3F13
L4CAF	= $4CAF
L6C61	= $6C61
L6D00	= $6D00
L6E61	= $6E61
L72C0	= $72C0
L72C1	= $72C1
L72C3	= $72C3
L72C4	= $72C4
L72C8	= $72C8
L72C9	= $72C9
L72CA	= $72CA
L72CE	= $72CE
L72CF	= $72CF
L72D0	= $72D0
L72D1	= $72D1
L72E0	= $72E0
L7300	= $7300
L7320	= $7320
L7340	= $7340
L7360	= $7360
L7A61	= $7A61
LAD00	= $AD00
LAD2F	= $AD2F
LAD4F	= $AD4F
BANK_CALL_INDEXED	= $AF1D
BANK_RETURN	= $AF36
LAF87	= $AF87
LAFAE	= $AFAE
LAFDA	= $AFDA
LAFDD	= $AFDD
LAFE0	= $AFE0
LAFE3	= $AFE3
LAFE9	= $AFE9
LAFEC	= $AFEC
LAFEF	= $AFEF
LAFF6	= $AFF6
LB00B	= $B00B
LB0AE	= $B0AE
LB0BE	= $B0BE
LB0C7	= $B0C7
LB0D5	= $B0D5
LB0E5	= $B0E5
LB113	= $B113
LB147	= $B147
LB15B	= $B15B
LB16D	= $B16D
LB193	= $B193
LB224	= $B224
LB359	= $B359
LB900	= $B900
LBE00	= $BE00
LBE04	= $BE04
LBE05	= $BE05
LBE07	= $BE07
LBE08	= $BE08
LBE0A	= $BE0A
LBE0B	= $BE0B
LBE0D	= $BE0D
LBE0E	= $BE0E
LBE10	= $BE10
LBE11	= $BE11
LC4B5	= $C4B5
	org $8000
START1	CLD
	LDA	CONSOL
	AND	#$07
	CMP	#$02
	BNE	L800D
	JMP	LBE00
L800D	CMP	#$01
	BNE	L8014
	JMP	LB900
L8014	LDX	#$00
	LDA	KBCODE
	CMP	#$EC
	BNE	L801E
	INX
L801E	STX	L3F0D
	LDA	MEMLO
	STA	L3F0F
	LDA	MEMLO+1
	STA	L3F10
	JSR	LB0C7
	LDA	#$00
	STA	L3DD7
	STA	L3EE1
	STA	L3F07
	STA	L3EF2
	STA	L3F09
	STA	L3EF0
	SEI
	LDA	#$BE
	STA	VKEYBD
	LDA	#$B8
	STA	VKEYBD+1
	CLI
L8050	LDA	#$00
	STA	L3ED2
	STA	L3EBA
	STA	L3ED1
	STA	L00B1
	STA	L00B2
	STA	SHFLOK
	STA	L3EE9
	STA	L3EEA
	STA	TSTDAT
	STA	L3EE7
	STA	L3EE8
	LDA	L3F07
	BEQ	L80B3
	LDA	L3F09
	BEQ	L80B3
	LDA	L3F07
	CMP	#$01
	BNE	L8098
	LDA	L3EF0
	CMP	#$88
	BNE	L808F
	LDA	#$00
	STA	L3F09
	BEQ	L80B3
L808F	JMP	L863D
L8092	JSR	L92B3
	JMP	L8050
L8098	JSR	LB15B
	BNE	L8092
	JSR	LB0E5
	BNE	L8092
	JSR	LB113
	BNE	L8092
	LDA	DVSTAT+1
	AND	#$08
	BNE	L808F
	LDA	#$00
	STA	L3F09
L80B3	LDA	#$00
	STA	L396B
	STA	L396E
	STA	L3EED
	STA	L3EEE
	STA	L3EEF
	STA	L3F13
	STA	L3EF1
	CLC
	LDA	L00B3
	ADC	#$64
	STA	L3EEB
	SEI
	LDA	POKMSK
	AND	#$7F
	STA	POKMSK
	STA	IRQEN
	CLI
	LDX	#$1F
L80DF	LDA	#$00
	STA	L7360,X
	LDA	L9174,X
	STA	L72E0,X
	LDA	L9194,X
	STA	L7300,X
	LDA	L91B4,X
	STA	L7320,X
	LDA	L91D4,X
	STA	L7340,X
	DEX
	BPL	L80DF
	LDX	#$00
L8101	TXA
	AND	#$03
	STA	L3AF2,X
	INX
	CPX	#$10
	BCC	L8101
	LDA	RANDOM
	STA	L3969
	LDA	RANDOM
	STA	L396A
	LDA	#$00
	STA	L396E
	LDX	#$0F
L811F	LDA	#$0A
	STA	L3D19,X
	LDA	#$64
	STA	L3D09,X
	LDA	#$32
	STA	L3CF9,X
	LDA	#$02
	STA	L3CE9,X
	LDA	#$00
	STA	L3B42,X
	STA	L3B52,X
	LDA	#$08
	STA	L3B62,X
	LDA	#$00
	STA	L3DC7,X
	DEX
	BPL	L811F
	LDA	#$00
	STA	L3CE6
	LDA	#$00
	STA	L3CE7
	LDA	#$00
	STA	L3CE8
	JSR	L91FE
	LDA	#$07
	STA	L396F
	LDX	#$00
	LDA	#$FF
L8163	STA	L3000,X
	STA	L3100,X
	STA	L3200,X
	STA	L3300,X
	STA	L3400,X
	STA	L3500,X
	STA	L3600,X
	STA	L3700,X
	INX
	BNE	L8163
	LDX	#$06
L8180	LDA	L9143,X
	STA	L3000,X
	LDA	L914A,X
	STA	L3040,X
	LDA	L9151,X
	STA	L3080,X
	LDA	L9158,X
	STA	L30C0,X
	LDA	L915F,X
	STA	L3100,X
	LDA	L9166,X
	STA	L3140,X
	LDA	L916D,X
	STA	L3180,X
	DEX
	BPL	L8180
	LDX	#$0C
	JSR	BANK_CALL_INDEXED
	JSR	LB224
L81B5	LDX	#$15
	JSR	BANK_CALL_INDEXED
	STA	L00A6
	JSR	LB0C7
	LDX	L00A6
	DEX
	BNE	L81C7
	JMP	L8589
L81C7	DEX
	BNE	L81CD
	JMP	L85DF
L81CD	DEX
	BNE	L81D3
	JMP	L81E2
L81D3	DEX
	BNE	L81D9
	JMP	L8299
L81D9	DEX
	BNE	L81DF
	JMP	L8292
L81DF	JMP	L81B5
L81E2	LDA	#$01
	STA	L3F07
	LDA	#$35
	STA	L3ED3
	LDA	#$B1
	STA	L3ED4
	LDA	#$47
	STA	L3ED5
	LDA	#$B1
	STA	L3ED6
	LDA	#$31
	STA	L3ED7
	LDA	#$B1
	STA	L3ED8
	LDA	#$5A
	STA	L3ED9
	LDA	#$AF
	STA	L3EDA
	LDA	#$5B
	STA	L3EDB
	LDA	#$B1
	STA	L3EDC
	LDA	#$C6
	STA	L3EDF
	LDA	#$B1
	STA	L3EE0
	LDA	#$AE
	STA	L3EDD
	LDA	#$B1
	STA	L3EDE
	LDA	#$0A
	STA	L3ED0
	LDA	L3F0F
	STA	MEMLO
	LDA	L3F10
	STA	MEMLO+1
	LDY	#$00
	LDX	#$20
	JSR	BANK_CALL_INDEXED
	JSR	LB15B
	BNE	L8288
	JSR	LB0E5
	BNE	L8288
	LDA	#$01
	STA	TSTDAT
	LDA	#$1B
	JSR	LB147
	BNE	L8288
	LDA	#$4D
	JSR	LB147
	BNE	L8288
	LDA	#$01
	STA	TSTDAT
	LDA	#$1B
	JSR	LB147
	BNE	L8288
	LDA	#$41
	JSR	LB147
	BNE	L8288
	LDA	#$30
	JSR	LB147
	BNE	L8288
	LDA	#$00
	JSR	LB147
	BNE	L8288
	LDA	#$00
	STA	TSTDAT
	JMP	L83B2
L8288	LDA	#$00
	STA	TSTDAT
	JSR	L92B3
	JMP	L8050
L8292	LDA	#$03
	STA	L3F07
	BNE	L829E
L8299	LDA	#$02
	STA	L3F07
L829E	LDA	#$35
	STA	L3ED3
	LDA	#$B1
	STA	L3ED4
	LDA	#$47
	STA	L3ED5
	LDA	#$B1
	STA	L3ED6
	LDA	#$25
	STA	L3ED7
	LDA	#$B1
	STA	L3ED8
	LDA	#$93
	STA	L3ED9
	LDA	#$B1
	STA	L3EDA
	LDA	#$5B
	STA	L3EDB
	LDA	#$B1
	STA	L3EDC
	LDA	#$A5
	STA	L3EDF
	LDA	#$B1
	STA	L3EE0
	LDA	#$5B
	STA	L3EDD
	LDA	#$B1
	STA	L3EDE
	LDA	#$0A
	STA	L3ED0
	LDA	L3F07
	CMP	#$02
	BNE	L8303
	LDA	L3F0F
	STA	MEMLO
	LDA	L3F10
	STA	MEMLO+1
	LDY	#$01
	LDX	#$20
	JSR	BANK_CALL_INDEXED
L8303	JSR	LB15B
	JSR	LB0E5
	BNE	L8367
	LDA	L3F07
	CMP	#$03
	BNE	L8323
	LDX	#$20
	LDA	#$22
	STA	ICCOM,X
	LDA	#$C0
	STA	ICAX1,X
	JSR	CIOV
	BMI	L8364
L8323	LDX	#$20
	LDA	#$26
	STA	ICCOM,X
	LDA	#$20
	STA	ICAX1,X
	JSR	CIOV
	BMI	L8364
	JSR	LB193
	BNE	L8367
	LDA	#$2B
	JSR	LB147
	BNE	L8367
	LDA	#$2B
	JSR	LB147
	BNE	L8367
	LDA	#$2B
	JSR	LB147
	BNE	L8367
	LDX	#$64
L8350	JSR	LAFEF
	DEX
	BNE	L8350
	JSR	LAFAE
	BEQ	L836D
	LDA	L3ED2
	CMP	#$C7
	BNE	L8367
	LDY	#$8B
L8364	STY	L3ED2
L8367	JSR	L92B3
	JMP	L8050
L836D	LDA	#$0D
	JSR	LB147
	BNE	L8367
	LDA	#$41
	JSR	LB147
	BNE	L8367
	LDA	#$54
	JSR	LB147
	BNE	L8367
	LDA	#$48
	JSR	LB147
	BNE	L8367
	LDA	#$0D
	JSR	LB147
	BNE	L8367
	LDX	#$3C
L8392	JSR	LAFEF
	DEX
	BNE	L8392
	JSR	LB15B
	BNE	L8367
	JSR	LB0E5
	BNE	L8367
	LDX	#$18
	JSR	BANK_CALL_INDEXED
	STA	L3F0E
	JSR	LB16D
	BNE	L8367
	JMP	L83B2
L83B2	LDY	#$00
	LDX	#$1F
	JSR	BANK_CALL_INDEXED
	STA	L3F08
	CMP	#$00
	BEQ	L83C3
	JMP	L83F0
L83C3	LDY	#$01
	LDX	#$1F
	JSR	BANK_CALL_INDEXED
	JSR	LAFE3
	BNE	L83EA
	JSR	L8481
	LDX	#$3C
L83D4	JSR	LAFEF
	DEX
	BNE	L83D4
	LDA	L3ED2
	BNE	L83EA
	JSR	L8530
	LDA	L3ED2
	BNE	L83EA
	JMP	L863D
L83EA	JSR	L92B3
	JMP	L8050
L83F0	JSR	LB0C7
	LDA	#$37
	STA	L72CE
	LDA	#$21
	STA	L72CF
	LDA	#$29
	STA	L72D0
	LDA	#$34
	STA	L72D1
	JSR	LB0D5
	LDA	L3F07
	CMP	#$01
	BEQ	L8463
	JSR	LAFE3
	BNE	L845D
	LDA	#$41
	JSR	LB147
	BNE	L845D
	LDA	#$54
	JSR	LB147
	BNE	L845D
	LDA	#$53
	JSR	LB147
	BNE	L845D
	LDA	#$30
	JSR	LB147
	BNE	L845D
	LDA	#$3D
	JSR	LB147
	BNE	L845D
	LDA	#$31
	JSR	LB147
	BNE	L845D
	LDA	#$0D
	JSR	LB147
	BNE	L845D
	LDX	#$3C
L8449	JSR	LAFEF
	DEX
	BNE	L8449
L844F	JSR	L8530
	LDA	L3ED2
	BNE	L845D
	JMP	L863D
	.byte	$8C
	.byte	$D2
	.byte	$3E ; '>'
L845D	JSR	L92B3
	JMP	L8050
L8463	LDA	#$01
	STA	TSTDAT
	LDA	#$1B
	JSR	LB147
	BNE	L847B
	LDA	#$47
	JSR	LB147
	BNE	L847B
	LDA	#$00
	STA	TSTDAT
	BEQ	L844F
L847B	LDA	#$00
	STA	TSTDAT
	BEQ	L845D
L8481	LDA	L3F07
	CMP	#$02
	BCS	L848B
	JMP	L84D8
L848B	LDA	#$0D
	JSR	LB147
	BNE	L84D4
	LDA	#$41
	JSR	LB147
	BNE	L84D4
	LDA	#$54
	JSR	LB147
	BNE	L84D4
	LDA	#$44
	JSR	LB147
	BNE	L84D4
	LDA	#$54
	LDX	L3EF1
	BEQ	L84B0
	LDA	#$50
L84B0	JSR	LB147
	BNE	L84D4
	LDX	#$00
	STX	L00A6
	BEQ	L84C5
L84BB	LDA	L3EF3,X
	JSR	LB147
	BNE	L84D4
	INC	L00A6
L84C5	LDX	L00A6
	CPX	L3EF2
	BCC	L84BB
	LDA	#$0D
	JSR	LB147
	BNE	L84D4
	RTS
L84D4	STY	L3ED2
	RTS
L84D8	LDA	#$01
	STA	TSTDAT
	LDA	#$1B
	JSR	LB147
	BNE	L8528
	SEC
	LDA	#$4F
	SBC	L3EF1
	JSR	LB147
	BNE	L8528
	LDA	#$1B
	JSR	LB147
	BNE	L8528
	LDA	#$4B
	JSR	LB147
	BNE	L8528
	LDX	#$00
	STX	L00A6
	BEQ	L851C
L8502	LDA	L3EF3,X
	CMP	#$2C
	BNE	L850D
	LDA	#$0C
	BNE	L8515
L850D	CMP	#$30
	BCC	L851A
	CMP	#$3A
	BCS	L851A
L8515	JSR	LB147
	BNE	L8528
L851A	INC	L00A6
L851C	LDX	L00A6
	CPX	L3EF2
	BCC	L8502
	LDA	#$9B
	JSR	LB147
L8528	LDA	#$00
	STA	TSTDAT
	LDY	L3ED2
	RTS
L8530	LDA	L3F07
	CMP	#$02
	BCS	L853A
	JMP	L8558
L853A	JSR	LB15B
	BNE	L8557
	JSR	LB0E5
	BNE	L8557
L8544	JSR	LB113
	BNE	L8557
	LDA	DVSTAT+1
	AND	#$08
	BEQ	L8544
	JMP	L8562
	.byte	$60
	.byte	$8C
	.byte	$D2
	.byte	$3E ; '>'
L8557	RTS
L8558	JSR	LB113
	BNE	L8578
	LDA	DVSTAT+1
	BPL	L8558
L8562	LDA	#$01
	STA	L3F09
	JSR	LB0C7
	LDX	#$0F
L856C	LDA	L8579,X
	STA	L72C8,X
	DEX
	BPL	L856C
	JSR	LB0D5
L8578	RTS
L8579	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$61 ; 'a'
	.byte	$72 ; 'r'
	.byte	$72 ; 'r'
	.byte	$69 ; 'i'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$00 ; Screen code for ' '
	.byte	$64 ; 'd'
	.byte	$65 ; 'e'
	.byte	$74 ; 't'
	.byte	$65 ; 'e'
	.byte	$63 ; 'c'
	.byte	$74 ; 't'
	.byte	$65 ; 'e'
	.byte	$64 ; 'd'
L8589	LDA	#$00
	STA	L3F07
	STA	AUDCTL
	LDA	#$62
	STA	L3ED3
	LDA	#$AF
	STA	L3ED4
	LDA	#$6C
	STA	L3ED5
	LDA	#$AF
	STA	L3ED6
	LDA	#$5D
	STA	L3ED7
	LDA	#$AF
	STA	L3ED8
	LDA	#$51
	STA	L3ED9
	LDA	#$AF
	STA	L3EDA
	LDA	#$5A
	STA	L3EDB
	LDA	#$AF
	STA	L3EDC
	LDA	#$5A
	STA	L3EDF
	LDA	#$AF
	STA	L3EE0
	LDA	#$5A
	STA	L3EDD
	LDA	#$AF
	STA	L3EDE
	LDA	#$02
	STA	L3ED0
	JMP	L863D
L85DF	LDA	#$00
	STA	L3F07
	LDA	LBE04
	STA	L3ED3
	LDA	LBE05
	STA	L3ED4
	LDA	LBE07
	STA	L3ED5
	LDA	LBE08
	STA	L3ED6
	LDA	LBE0A
	STA	L3ED7
	LDA	LBE0B
	STA	L3ED8
	LDA	LBE0D
	STA	L3ED9
	LDA	LBE0E
	STA	L3EDA
	LDA	LBE10
	STA	L3EDB
	LDA	LBE11
	STA	L3EDC
	LDA	LBE0D
	STA	L3EDF
	LDA	LBE0E
	STA	L3EE0
	LDA	LBE10
	STA	L3EDD
	LDA	LBE11
	STA	L3EDE
	LDA	#$06
	STA	L3ED0
L863D	LDX	#$11
	LDA	#$07
	STA	L3D3E,X
	LDA	#$90
	STA	L3D66,X
	LDA	L008C
	STA	L3D8E,X
	LDX	#$1B
	LDA	#$36
	STA	L3D3E,X
	LDA	#$AF
	STA	L3D66,X
	LDX	#$13
	LDA	#$36
	STA	L3D3E,X
	LDA	#$AF
	STA	L3D66,X
	JSR	LAFE3
	BNE	L86B4
	LDA	#$00
	STA	L00B1
	STA	L00B2
	STA	SHFLOK
	STA	L3ED2
	LDA	L3F07
	BNE	L867F
	JMP	L86DE
L867F	JSR	LAF87
	BNE	L86B4
	LDA	L3F08
	BEQ	L868C
	JMP	L86BA
L868C	LDA	#$A0
	JSR	LAFDD
	BNE	L86B4
	JSR	LAFAE
	BEQ	L86AD
	LDY	L3ED2
	CPY	#$C7
	BNE	L86B4
	JSR	LAFAE
	BEQ	L86AD
	LDY	L3ED2
	CPY	#$C7
	BNE	L86B4
	BEQ	L868C
L86AD	CMP	#$A1
	BNE	L868C
	JMP	L86D3
L86B4	JSR	L92B3
	JMP	L8050
L86BA	JSR	LAFAE
	BEQ	L86C8
	LDY	L3ED2
	CPY	#$C7
	BNE	L86B4
	BEQ	L86BA
L86C8	CMP	#$A0
	BNE	L86BA
	LDA	#$A1
	JSR	LAFDD
	BNE	L86B4
L86D3	LDA	L3F08
	STA	L3968
	BEQ	L86F5
	JMP	L8B81
L86DE	JSR	LAF87
	LDA	L3ED2
	BNE	L86B4
	LDA	#$00
	JSR	LAFDD
	BNE	L86B4
	JSR	LAFAE
	BEQ	L86F5
	JMP	L8B81
L86F5	LDA	#$01
	STA	L396C
	LDA	#$00
	STA	L3968
	STA	L3ED2
	JSR	LB0C7
	LDX	#$19
L8707	LDA	L8784,X
	STA	L72C3,X
	DEX
	BPL	L8707
	JSR	LB0D5
	JSR	LAF87
	LDA	L3ED2
	BNE	L877E
	LDA	#$80
	JSR	LAFDD
	BNE	L877E
	JSR	LAFAE
	BNE	L877E
	LDA	#$01
	JSR	LAFDD
	BNE	L877E
	JSR	LAFAE
	BNE	L877E
	CMP	#$11
	BCC	L873F
	LDA	#$05
	STA	L3ED2
	JMP	L877E
L873F	JSR	LAFDD
	BNE	L877E
	JSR	LAFAE
	BNE	L877E
	STA	L396B
	JSR	L9277
	LDA	#$80
	JSR	LAFDD
	BNE	L877E
	JSR	LAFAE
	BNE	L877E
	LDA	#$91
	JSR	LAFDD
	BNE	L877E
	JSR	LAFAE
	BNE	L877E
	SEC
	SBC	#$90
	CMP	L396B
	BNE	L8781
	LDA	#$87
	JSR	LAFDD
	BNE	L877E
	JSR	LAFAE
	BNE	L877E
	JMP	L93F8
L877E	JSR	L92B3
L8781	JMP	L87EE
L8784	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$68 ; 'h'
	.byte	$69 ; 'i'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$69 ; 'i'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$74 ; 't'
	.byte	$68 ; 'h'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$6D ; 'm'
	.byte	$61 ; 'a'
	.byte	$73 ; 's'
	.byte	$74 ; 't'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$00 ; Screen code for ' '
	.byte	$6D ; 'm'
	.byte	$61 ; 'a'
	.byte	$63 ; 'c'
	.byte	$68 ; 'h'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
L879E	LDX	#$14
	JSR	BANK_CALL_INDEXED
	JMP	L87FB
L87A6	LDA	#$00
	STA	L3ED2
L87AB	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDA	CONSOL
	AND	#$01
	BNE	L87C1
	LDA	#$04
	STA	L3DD7
	LDA	#$00
	JMP	L87FB
L87C1	LDA	CONSOL
	AND	#$02
	BEQ	L87DB
	LDA	CONSOL
	AND	#$04
	BEQ	L87DB
	LDA	STRIG0
	BNE	L87AB
	LDA	#$04
	STA	L3DD7
	BNE	L87EE
L87DB	LDA	#$04
	STA	L3DD7
L87E0	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDA	CONSOL
	AND	#$07
	CMP	#$07
	BNE	L87E0
L87EE	LDA	#$00
	STA	L3ED2
	JSR	LB224
	LDX	#$16
	JSR	BANK_CALL_INDEXED
L87FB	STA	L00A6
	JSR	LAF87
	LDA	L3ED2
	BNE	L8863
	LDA	L00A6
	BEQ	L880C
	JMP	L8903
L880C	JSR	LB0C7
	LDX	#$0C
	JSR	BANK_CALL_INDEXED
	JSR	LB359
	LDA	#$80
	JSR	LAFDD
	BNE	L8863
	JSR	LAFAE
	BNE	L8863
	LDA	#$01
	JSR	LAFDD
	BNE	L8863
	JSR	LAFAE
	BNE	L8863
	CMP	#$11
	BCC	L8836
	JMP	L88FC
L8836	JSR	LAFDD
	BNE	L8863
	JSR	LAFAE
	BNE	L8863
	STA	L396B
	LDA	#$80
	JSR	LAFDD
	BNE	L8863
	JSR	LAFAE
	BNE	L8863
	LDA	#$84
	JSR	LAFDD
	BNE	L8863
	JSR	LAFAE
	BNE	L8863
	JSR	L89F8
	LDY	L3ED2
	BEQ	L8869
L8863	JSR	L92B3
	JMP	L87EE
L8869	LDA	L396A
	JSR	LAFDD
	BNE	L8863
	LDA	L3969
	JSR	LAFDD
	BNE	L8863
	JSR	LAFAE
	BNE	L8863
	STA	L396A
	JSR	LAFAE
	BNE	L8863
	STA	L3969
	LDX	#$0F
L888B	LDA	L3D19
	STA	L3D19,X
	LDA	L3D09
	STA	L3D09,X
	LDA	L3CF9
	STA	L3CF9,X
	LDA	L3CE9
	STA	L3CE9,X
	DEX
	BNE	L888B
	LDX	#$04
	JSR	BANK_CALL_INDEXED
	JSR	L9277
	JSR	L99B5
	LDX	#$21
	JSR	BANK_CALL_INDEXED
	LDA	#$01
	STA	L3EEA
	JSR	L999E
	JSR	L9979
	LDX	#$10
	JSR	BANK_CALL_INDEXED
	STA	L3ED2
	LDA	#$00
	STA	L3EEA
	CLC
	LDA	L00B3
	ADC	#$64
	STA	L3EEB
	LDX	#$0F
L88D8	LDA	L3DC7,X
	STA	L3AC2,X
	DEX
	BPL	L88D8
	LDX	#$03
L88E3	LDA	L3DC7,X
	STA	L3D39,X
	DEX
	BPL	L88E3
	LDA	#$01
	STA	L3DD7
	LDA	L3ED2
	BEQ	L88F9
L88F6	JSR	L92B3
L88F9	JMP	L87A6
L88FC	LDA	#$05
	STA	L3ED2
	BNE	L88F6
L8903	CMP	#$17
	BNE	L8958
	JSR	LB0C7
	JSR	L9EB7
	BEQ	L894B
	LDY	#$00
	LDX	#$1C
	JSR	BANK_CALL_INDEXED
	CPY	#$00
	BEQ	L894B
	JSR	LAFE9
	BNE	L88F6
L891F	LDX	#$24
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BEQ	L8940
	LDA	#$00
	STA	L3ED2
	LDY	#$00
	LDX	#$1C
	JSR	BANK_CALL_INDEXED
	CPY	#$01
	BEQ	L891F
	LDY	#$01
	LDX	#$1C
	JSR	BANK_CALL_INDEXED
L8940	JSR	L9277
	JSR	LAFEC
	BNE	L88F6
	JMP	L87EE
L894B	LDY	#$01
	LDX	#$1C
	JSR	BANK_CALL_INDEXED
	JSR	L9277
	JMP	L87EE
L8958	CMP	#$18
	BNE	L8989
	JSR	LB0C7
	LDA	#$81
	JSR	LAFDD
	BNE	L8983
	JSR	LAFAE
	BNE	L8983
	LDX	#$0F
	LDA	#$00
L896F	STA	L3DC7,X
	STA	L3AC2,X
	DEX
	BPL	L896F
	LDX	#$03
L897A	STA	L3D39,X
	DEX
	BPL	L897A
	JMP	L879E
L8983	JSR	L92B3
	JMP	L879E
L8989	CMP	#$1A
	BNE	L8998
	JSR	LB0C7
	LDX	#$19
	JSR	BANK_CALL_INDEXED
	JMP	L87EE
L8998	CMP	#$1B
	BNE	L89A7
	JSR	LB0C7
	LDX	#$1D
	JSR	BANK_CALL_INDEXED
	JMP	L87EE
L89A7	CMP	#$1C
	BNE	L89F5
	JSR	LB0C7
	JSR	LAF87
	LDA	L3ED2
	BNE	L89EF
	LDA	#$86
	JSR	LAFDD
	BNE	L89EF
	JSR	LAFAE
	BNE	L89EF
	LDA	#$01
	JSR	LAFDD
	JSR	LAFAE
	BNE	L89EF
	CMP	#$11
	BCC	L89D7
	LDA	#$05
	STA	L3ED2
	BNE	L89EF
L89D7	STA	L396B
	JSR	LAFDD
	BNE	L89EF
	JSR	L9277
	JSR	LAFAE
	BNE	L89EF
	JSR	L8F57
	LDA	L3ED2
	BEQ	L89F2
L89EF	JSR	L92B3
L89F2	JMP	L87EE
L89F5	JMP	L879E
L89F8	LDA	#$83
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	CMP	#$83
	BNE	L8A15
	LDA	#$00
	STA	L0089
	JSR	L8F9A
	LDA	L3ED2
	BEQ	L8A1B
L8A14	RTS
L8A15	LDA	#$04
	STA	L3ED2
	RTS
L8A1B	LDA	L396F
	ASL
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	LDA	L3D19
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	STA	L3D19
	LDA	L3D09
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	STA	L3D09
	LDA	L3CF9
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	STA	L3CF9
	LDA	L3CE9
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	STA	L3CE9
	LDA	#$00
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	LDA	#$00
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	LDA	#$00
	JSR	LAFDD
	BNE	L8A14
	JSR	LAFAE
	BNE	L8A14
	JMP	L8A91
L8A90	RTS
L8A91	LDA	L396C
	BNE	L8A99
	JMP	L8B4F
L8A99	LDA	#$00
	STA	L00A8
	LDA	#$30
	STA	L00A9
	LDA	#$00
	STA	L00A6
L8AA5	LDY	#$00
	STY	L00A7
L8AA9	LDA	(L00A8),Y
	STA	L0096
	LDX	#$FF
	AND	#$10
	BEQ	L8AB5
	LDX	#$01
L8AB5	TXA
	JSR	LAFDD
	BNE	L8A90
	JSR	LAFAE
	BNE	L8A90
	LDX	#$FF
	LDA	L0096
	AND	#$01
	BEQ	L8ACA
	LDX	#$01
L8ACA	TXA
	JSR	LAFDD
	BNE	L8B4E
	JSR	LAFAE
	BNE	L8B4E
	INC	L00A7
	LDY	L00A7
	CPY	#$20
	BCC	L8AA9
	LDY	#$00
	STY	L00A7
L8AE1	LDA	(L00A8),Y
	LDX	#$FF
	AND	#$08
	BEQ	L8AEB
	LDX	#$01
L8AEB	TXA
	JSR	LAFDD
	BNE	L8B4E
	JSR	LAFAE
	BNE	L8B4E
	LDA	#$FF
	JSR	LAFDD
	BNE	L8B4E
	JSR	LAFAE
	BNE	L8B4E
	INC	L00A7
	LDY	L00A7
	CPY	#$20
	BCC	L8AE1
	CLC
	LDA	L00A8
	ADC	#$40
	STA	L00A8
	BCC	L8B15
	INC	L00A9
L8B15	INC	L00A6
	LDA	L00A6
	CMP	#$20
	BCC	L8AA5
L8B1D	LDA	L3CE6
	JSR	LAFDD
	BNE	L8B4E
	LDX	#$00
	STX	L00A6
L8B29	LDA	L3AF2,X
	JSR	LAFDD
	BNE	L8B4E
	INC	L00A6
	LDX	L00A6
	CPX	#$10
	BCC	L8B29
	LDA	L3CE7
	JSR	LAFDD
	BNE	L8B4E
	LDA	#$12
	STA	L00A6
L8B45	JSR	LAFAE
	BNE	L8B4E
	DEC	L00A6
	BNE	L8B45
L8B4E	RTS
L8B4F	LDA	#$00
	STA	L00A6
L8B53	LDA	#$00
	STA	L00A7
L8B57	JSR	LAD00
	TXA
	CLC
	ADC	L0089
	STA	L0089
	TXA
	JSR	LAFDD
	BNE	L8B80
	JSR	LAFAE
	BNE	L8B80
	INC	L00A7
	LDA	L00A7
	CMP	L396F
	BCC	L8B57
	INC	L00A6
	LDA	L00A6
	CMP	L396F
	BCC	L8B53
	JMP	L8B1D
L8B80	RTS
L8B81	LDA	#$01
	STA	L396C
	LDX	#$0C
	JSR	BANK_CALL_INDEXED
	JSR	LB359
	JSR	LB0C7
	LDX	#$16
L8B93	LDA	L8BA2,X
	STA	L72C4,X
	DEX
	BPL	L8B93
	JSR	LB0D5
	JMP	L8BC7
L8BA2	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$68 ; 'h'
	.byte	$69 ; 'i'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$69 ; 'i'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$61 ; 'a'
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$6C ; 'l'
	.byte	$61 ; 'a'
	.byte	$76 ; 'v'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$6D ; 'm'
	.byte	$61 ; 'a'
	.byte	$63 ; 'c'
	.byte	$68 ; 'h'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
L8BB9	JSR	LAF87
	LDA	L3ED2
	BEQ	L8BC7
	JSR	L92B3
	JMP	L8BB9
L8BC7	LDA	#$00
	STA	L3ED2
L8BCC	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	JSR	LAFE0
	BEQ	L8BCC
	JSR	LAFDA
	BEQ	L8BDE
	JMP	L8C59
L8BDE	CMP	#$90
	BCS	L8C12
	CMP	#$87
	BEQ	L8C1D
	STA	L0080
	JSR	LAFDD
	BNE	L8C59
	LDA	L0080
	CMP	#$00
	BEQ	L8BC7
	CMP	#$81
	BNE	L8C25
	JSR	LB0C7
	LDX	#$0F
	LDA	#$00
L8BFE	STA	L3DC7,X
	STA	L3AC2,X
	DEX
	BPL	L8BFE
	LDX	#$03
L8C09	STA	L3D39,X
	DEX
	BPL	L8C09
	JMP	L8BC7
L8C12	CLC
	ADC	#$01
	JSR	LAFDD
	BNE	L8C59
	JMP	L8BC7
L8C1D	JSR	LAFDD
	BNE	L8C59
	JMP	L9504
L8C25	CMP	#$80
	BNE	L8C5F
	JSR	LB0C7
	JSR	LAFAE
	BNE	L8C59
	STA	L3968
	CLC
	ADC	#$01
	JSR	LAFDD
	BNE	L8C59
	JSR	LAFAE
	BNE	L8C59
	STA	L396B
	JSR	LAFDD
	BNE	L8C59
	JSR	L9277
	JSR	LAFDA
	BNE	L8C59
	JSR	LAFDD
	BNE	L8C59
	JMP	L8BC7
L8C59	JSR	L92B3
	JMP	L8BB9
L8C5F	CMP	#$84
	BEQ	L8C6D
	CMP	#$86
	BNE	L8C6A
	JMP	L8D0B
L8C6A	JMP	L8BB9
L8C6D	JSR	LB0C7
	JSR	L8D3F
	LDA	L3ED2
	BNE	L8C59
	JSR	LAFAE
	BNE	L8C59
	STA	L396A
	JSR	LAFDD
	BNE	L8C59
	JSR	LAFAE
	BNE	L8C59
	STA	L3969
	JSR	LAFDD
	BNE	L8C59
	LDX	#$0F
L8C94	LDA	L3D19
	STA	L3D19,X
	LDA	L3D09
	STA	L3D09,X
	LDA	L3CF9
	STA	L3CF9,X
	LDA	L3CE9
	STA	L3CE9,X
	DEX
	BNE	L8C94
	LDX	#$04
	JSR	BANK_CALL_INDEXED
	JSR	LB359
	JSR	L9277
	JSR	L99B5
	LDX	#$21
	JSR	BANK_CALL_INDEXED
	LDA	#$01
	STA	L3EEA
	JSR	L999E
	JSR	L9979
	LDX	#$10
	JSR	BANK_CALL_INDEXED
	STA	L3ED2
	LDA	#$00
	STA	L3EEA
	CLC
	LDA	L00B3
	ADC	#$64
	STA	L3EEB
	LDX	#$0F
L8CE4	LDA	L3DC7,X
	STA	L3AC2,X
	DEX
	BPL	L8CE4
	LDX	#$03
L8CEF	LDA	L3DC7,X
	STA	L3D39,X
	DEX
	BPL	L8CEF
	LDA	L3ED2
	BNE	L8D05
	LDA	#$01
	STA	L3DD7
	JMP	L8BC7
L8D05	JSR	L92B3
	JMP	L8BB9
L8D0B	JSR	LB0C7
	JSR	LAFAE
	BNE	L8D05
	STA	L3968
	CLC
	ADC	#$01
	JSR	LAFDD
	BNE	L8D05
	JSR	LAFAE
	BNE	L8D05
	STA	L396B
	JSR	LAFDD
	BNE	L8D05
	JSR	L9277
	JSR	LB224
	JSR	L8F57
	JSR	LB359
	LDA	L3ED2
	BNE	L8D05
	JMP	L8BC7
L8D3F	JSR	LAFAE
	BNE	L8D4D
	CMP	#$83
	BEQ	L8D4E
	LDA	#$04
	STA	L3ED2
L8D4D	RTS
L8D4E	JSR	LAFDD
	BNE	L8D4D
	LDA	#$00
	STA	L0089
	JSR	L8F9A
	LDA	L3ED2
	BNE	L8DDB
	JSR	LAFAE
	BNE	L8DDB
	STA	L396F
	JSR	LAFDD
	BNE	L8DDB
	LSR	L396F
	JSR	LAFAE
	BNE	L8DDB
	STA	L3D19
	JSR	LAFDD
	BNE	L8DDB
	JSR	LAFAE
	BNE	L8DDB
	STA	L3D09
	JSR	LAFDD
	BNE	L8DDB
	JSR	LAFAE
	BNE	L8DDB
	STA	L3CF9
	JSR	LAFDD
	BNE	L8DDB
	JSR	LAFAE
	BNE	L8DDB
	STA	L3CE9
	JSR	LAFDD
	BNE	L8DDB
	JSR	LAFAE
	BNE	L8DDB
	STA	L0080
	JSR	LAFDD
	BNE	L8DDB
	LDA	L0080
	BNE	L8DD6
	JSR	LAFAE
	BNE	L8DDB
	STA	L0080
	JSR	LAFDD
	BNE	L8DDB
	LDA	L0080
	BNE	L8DD6
	JSR	LAFAE
	BNE	L8DDB
	STA	L0080
	JSR	LAFDD
	BNE	L8DDB
	LDA	L0080
	BNE	L8DD6
	JMP	L8DDC
L8DD6	LDA	#$06
	STA	L3ED2
L8DDB	RTS
L8DDC	LDX	#$00
	LDA	#$FF
L8DE0	STA	L3000,X
	STA	L3100,X
	STA	L3200,X
	STA	L3300,X
	STA	L3400,X
	STA	L3500,X
	STA	L3600,X
	STA	L3700,X
	INX
	BNE	L8DE0
	LDA	L396C
	BNE	L8E04
	JMP	L8F12
L8E03	RTS
L8E04	LDA	#$00
	STA	L00A8
	LDA	#$30
	STA	L00A9
	LDA	#$C0
	STA	L00AD
	LDA	#$2F
	STA	L00AE
	LDA	#$00
	STA	L00A6
L8E18	LDY	#$00
	STY	L00A7
L8E1C	JSR	LAFAE
	BEQ	L8E24
	JMP	L8E03
L8E24	STA	L0080
	JSR	LAFDD
	BNE	L8E03
	LDA	L0080
	CMP	#$01
	BEQ	L8E57
	LDY	L00A7
	LDA	(L00A8),Y
	AND	#$EF
	STA	(L00A8),Y
	DEY
	BMI	L8E42
	LDA	(L00A8),Y
	AND	#$DF
	STA	(L00A8),Y
L8E42	INY
	LDA	L00A6
	BEQ	L8E57
	LDA	(L00AD),Y
	AND	#$BF
	STA	(L00AD),Y
	DEY
	BMI	L8E56
	LDA	(L00AD),Y
	AND	#$7F
	STA	(L00AD),Y
L8E56	INY
L8E57	JSR	LAFAE
	BNE	L8EDB
	STA	L0080
	JSR	LAFDD
	BNE	L8EDB
	LDA	L0080
	CMP	#$01
	BEQ	L8E7B
	LDY	L00A7
	LDA	(L00A8),Y
	AND	#$FE
	STA	(L00A8),Y
	LDA	L00A6
	BEQ	L8E7B
	LDA	(L00AD),Y
	AND	#$FB
	STA	(L00AD),Y
L8E7B	INC	L00A7
	LDY	L00A7
	CPY	#$20
	BCC	L8E1C
	LDY	#$00
	STY	L00A7
L8E87	JSR	LAFAE
	BNE	L8EDB
	STA	L0080
	JSR	LAFDD
	BNE	L8EDB
	LDA	L0080
	CMP	#$01
	BEQ	L8EAB
	LDY	L00A7
	BEQ	L8EA5
	DEY
	LDA	(L00A8),Y
	AND	#$FD
	STA	(L00A8),Y
	INY
L8EA5	LDA	(L00A8),Y
	AND	#$F7
	STA	(L00A8),Y
L8EAB	JSR	LAFAE
	BNE	L8EDB
	JSR	LAFDD
	BNE	L8EDB
	INC	L00A7
	LDY	L00A7
	CPY	#$20
	BCC	L8E87
	LDA	L00A8
	STA	L00AD
	LDA	L00A9
	STA	L00AE
	CLC
	LDA	L00A8
	ADC	#$40
	STA	L00A8
	BCC	L8ED0
	INC	L00A9
L8ED0	INC	L00A6
	LDA	L00A6
	CMP	#$20
	BCS	L8EDC
	JMP	L8E18
L8EDB	RTS
L8EDC	JSR	LAFAE
	BNE	L8EDB
	STA	L3CE6
L8EE4	JSR	LAFDD
	BNE	L8EDB
	LDA	#$00
	STA	L00A6
L8EED	JSR	LAFAE
	BNE	L8EDB
	LDX	L00A6
	STA	L3AF2,X
	JSR	LAFDD
	BNE	L8EDB
	INC	L00A6
	LDA	L00A6
	CMP	#$10
	BCC	L8EED
	JSR	LAFAE
	BNE	L8EDB
	STA	L3CE7
	JSR	LAFDD
	BNE	L8EDB
	RTS
L8F12	LDA	#$00
	STA	L00A6
L8F16	LDA	#$00
	STA	L00A7
L8F1A	JSR	LAFAE
	BNE	L8F56
	STA	L0080
	CLC
	ADC	L0089
	STA	L0089
	LDA	L0080
	JSR	LAFDD
	BNE	L8F56
	LDX	L00A6
	LDA	LAD2F,X
	ORA	L00A7
	STA	L00A8
	LDA	LAD4F,X
	STA	L00A9
	LDA	L0080
	LDY	#$00
	STA	(L00A8),Y
	INC	L00A7
	LDA	L00A7
	CMP	L396F
	BCC	L8F1A
	INC	L00A6
	LDA	L00A6
	CMP	L396F
	BCC	L8F16
	JMP	L8EDC
L8F56	RTS
L8F57	JSR	LB0C7
	LDA	#$37
	STA	L72CE
	LDA	#$21
	STA	L72CF
	LDA	#$29
	STA	L72D0
	LDA	#$34
	STA	L72D1
	JSR	LB0D5
	LDX	#$1A
	JSR	BANK_CALL_INDEXED
	LDA	L396B
	STA	L0080
L8F7B	LDA	#$00
	JSR	LAFDD
	BNE	L8F99
	JSR	LAFDA
	BNE	L8F99
	DEC	L0080
	BNE	L8F7B
	JSR	LB224
	JSR	LB0C7
	JSR	L8F9A
	LDA	RTCLOK+2
	STA	L3ECE
L8F99	RTS
L8F9A	LDA	L3968
	STA	L0096
L8F9F	LDX	L0096
	LDA	LB0AE,X
	TAX
	STA	L0098
	LDA	L3DFC,X
	STA	L0097
	BPL	L8FBD
L8FAE	INC	L0098
	LDX	L0098
	LDA	L3DFC,X
	JSR	LB00B
	JSR	LAFDD
	BNE	L9006
L8FBD	DEC	L0097
	BPL	L8FAE
	LDA	#$00
	JSR	LAFDD
	BNE	L9006
	DEC	L0096
	BPL	L8FD2
	LDX	L396B
	DEX
	STX	L0096
L8FD2	LDX	L0096
	LDA	LB0AE,X
	TAX
	STX	L0099
	INX
	STX	L0098
	LDA	#$00
	STA	L0097
L8FE1	JSR	LAFAE
	BNE	L9006
	CMP	#$00
	BEQ	L8FF8
	JSR	LAFF6
	LDX	L0098
	STA	L3DFC,X
	INC	L0098
	INC	L0097
	BNE	L8FE1
L8FF8	LDA	L0097
	LDX	L0099
	STA	L3DFC,X
	LDA	L0096
	CMP	L3968
	BNE	L8F9F
L9006	RTS
	.byte	$AD
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$09 ; Screen code for ')'
	.byte	$AD
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$07 ; Screen code for '''
	.byte	$C9
	.byte	$07 ; Screen code for '''
	.byte	$D0
	.byte	$1F ; Screen code for '?'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$82
	.byte	$AF
	.byte	$F0
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$76 ; 'v'
	.byte	$AF
	.byte	$C9
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D0
	.byte	$0A ; Screen code for '*'
	.byte	$AD
	.byte	$E8
	.byte	$3C ; '<'
	.byte	$49 ; 'I'
	.byte	$01 ; Screen code for '!'
	.byte	$8D
	.byte	$E8
	.byte	$3C ; '<'
	.byte	$10 ; Screen code for '0'
	.byte	$12 ; Screen code for '2'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$0D ; Screen code for '-'
	.byte	$C9
	.byte	$1B ; Screen code for ';'
	.byte	$F0
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$04 ; Screen code for '$'
	.byte	$8D
	.byte	$D7
	.byte	$3D ; '='
	.byte	$A9
	.byte	$82
	.byte	$D0
	.byte	$0C ; Screen code for ','
	.byte	$AD
	.byte	$78 ; 'x'
	.byte	$02 ; Screen code for '"'
	.byte	$49 ; 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$AE
	.byte	$84
	.byte	$02 ; Screen code for '"'
	.byte	$D0
	.byte	$02 ; Screen code for '"'
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$AE
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$9D
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$3D ; '='
	.byte	$86
	.byte	$80
	.byte	$BD
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$3D ; '='
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DD
	.byte	$AF
	.byte	$D0
	.byte	$1B ; Screen code for ';'
	.byte	$A6
	.byte	$80
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$AE
	.byte	$6B ; 'k'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$CA
	.byte	$86
	.byte	$80
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AE
	.byte	$AF
	.byte	$D0
	.byte	$0C ; Screen code for ','
	.byte	$A6
	.byte	$80
	.byte	$9D
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$3D ; '='
	.byte	$EC
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$DF
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$AD
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$3D ; '='
	.byte	$C9
	.byte	$82
	.byte	$D0
	.byte	$F6
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$3D ; '='
	.byte	$8D
	.byte	$C8
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$C7
	.byte	$B0
	.byte	$AD
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$0D ; Screen code for '-'
	.byte	$A2
	.byte	$1F ; Screen code for '?'
	.byte	$BD
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$91
	.byte	$9D
	.byte	$C0
	.byte	$72 ; 'r'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0B ; Screen code for '+'
	.byte	$A2
	.byte	$04 ; Screen code for '$'
	.byte	$BD
	.byte	$1E ; Screen code for '>'
	.byte	$91
	.byte	$9D
	.byte	$CD
	.byte	$72 ; 'r'
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$D5
	.byte	$B0
	.byte	$AD
	.byte	$68 ; 'h'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$D0
	.byte	$4D ; 'M'
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$07 ; Screen code for '''
	.byte	$C9
	.byte	$07 ; Screen code for '''
	.byte	$D0
	.byte	$F2
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$84
	.byte	$AD
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$02 ; Screen code for '"'
	.byte	$F0
	.byte	$0B ; Screen code for '+'
	.byte	$A2
	.byte	$82
	.byte	$AD
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$04 ; Screen code for '$'
	.byte	$F0
	.byte	$02 ; Screen code for '"'
	.byte	$D0
	.byte	$E7
	.byte	$86
	.byte	$80
	.byte	$A9
	.byte	$04 ; Screen code for '$'
	.byte	$8D
	.byte	$D7
	.byte	$3D ; '='
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$07 ; Screen code for '''
	.byte	$C9
	.byte	$07 ; Screen code for '''
	.byte	$D0
	.byte	$F2
	.byte	$A5
	.byte	$80
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DD
	.byte	$AF
	.byte	$D0
	.byte	$07 ; Screen code for '''
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AE
	.byte	$AF
	.byte	$D0
	.byte	$02 ; Screen code for '"'
	.byte	$F0
	.byte	$1B ; Screen code for ';'
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$E0
	.byte	$AF
	.byte	$F0
	.byte	$F6
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DA
	.byte	$AF
	.byte	$D0
	.byte	$EE
	.byte	$85
	.byte	$80
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$DD
	.byte	$AF
	.byte	$D0
	.byte	$E7
	.byte	$A5
	.byte	$80
	.byte	$C9
	.byte	$84
	.byte	$F0
	.byte	$E1
	.byte	$A9
	.byte	$02 ; Screen code for '"'
	.byte	$8D
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$DA
L911E	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$25 ; '%' ; Screen code for 'E'
L9123	.byte	$3B ; ';'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$3D ; '='
	.byte	$63 ; 'c'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$74 ; 't'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$75 ; 'u'
	.byte	$65 ; 'e'
	.byte	$73 ; 's'
	.byte	$0C ; Screen code for ','
	.byte	$00 ; Screen code for ' '
	.byte	$3B ; ';'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$3D ; '='
	.byte	$71 ; 'q'
	.byte	$75 ; 'u'
	.byte	$69 ; 'i'
	.byte	$74 ; 't'
	.byte	$73 ; 's'
L9143	.byte	$F9
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F3
L914A	.byte	$FA
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F2
L9151	.byte	$FA
	.byte	$FA
	.byte	$FF
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$FA
L9158	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$90
	.byte	$C4
	.byte	$E2
	.byte	$FA
L915F	.byte	$FA
	.byte	$DC
	.byte	$C4
	.byte	$E2
	.byte	$FF
	.byte	$FA
	.byte	$FA
L9166	.byte	$F8
	.byte	$F5
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$FA
L916D	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F6
L9174	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$75 ; 'u'
	.byte	$6C ; 'l'
	.byte	$74 ; 't'
	.byte	$69 ; 'i'
	.byte	$0D ; Screen code for '-'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$61 ; 'a'
	.byte	$63 ; 'c'
	.byte	$68 ; 'h'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$61 ; 'a'
	.byte	$7A ; 'z'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$61 ; 'a'
	.byte	$79 ; 'y'
	.byte	$68 ; 'h'
	.byte	$65 ; 'e'
	.byte	$6D ; 'm'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L9194	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$6D ; 'm'
	.byte	$61 ; 'a'
	.byte	$7A ; 'z'
	.byte	$65 ; 'e'
	.byte	$0F ; Screen code for '/'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$00 ; Screen code for ' '
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$73 ; 's'
	.byte	$69 ; 'i'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$00 ; Screen code for ' '
	.byte	$11 ; Screen code for '1'
	.byte	$0E ; Screen code for '.'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L91B4	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$6F ; 'o'
	.byte	$70 ; 'p'
	.byte	$79 ; 'y'
	.byte	$72 ; 'r'
	.byte	$69 ; 'i'
	.byte	$67 ; 'g'
	.byte	$68 ; 'h'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$63 ; 'c'
	.byte	$09 ; Screen code for ')'
	.byte	$00 ; Screen code for ' '
	.byte	$11 ; Screen code for '1'
	.byte	$19 ; Screen code for '9'
	.byte	$18 ; Screen code for '8'
	.byte	$19 ; Screen code for '9'
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$0F ; Screen code for '/'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L91D4	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$63 ; 'c'
	.byte	$09 ; Screen code for ')'
	.byte	$00 ; Screen code for ' '
	.byte	$11 ; Screen code for '1'
	.byte	$19 ; Screen code for '9'
	.byte	$18 ; Screen code for '8'
	.byte	$19 ; Screen code for '9'
	.byte	$00 ; Screen code for ' '
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$00 ; Screen code for ' '
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$6F ; 'o'
	.byte	$72 ; 'r'
	.byte	$70 ; 'p'
	.byte	$0E ; Screen code for '.'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L91F4	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$6C ; 'l'
	.byte	$61 ; 'a'
	.byte	$79 ; 'y'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$00 ; Screen code for ' '
	.byte	$03 ; Screen code for '#'
	.byte	$6E ; 'n'
	.byte	$6E ; 'n'
L91FE	LDA	L3F0D
	BEQ	L9245
	LDA	#$01
	STA	L0080
	LDX	#$00
L9209	LDA	#$0A
	STA	L3DFC,X
	INX
	LDY	#$00
	LDA	#$08
	STA	L0081
L9215	LDA	L91F4,Y
	STA	L3DFC,X
	INX
	INY
	DEC	L0081
	BNE	L9215
	LDY	#$00
	LDA	L0080
	CMP	#$0A
	BCC	L922E
	LDY	#$11
	SEC
	SBC	#$0A
L922E	PHA
	TYA
	STA	L3DFC,X
	INX
	PLA
	CLC
	ADC	#$10
	STA	L3DFC,X
	INX
	INC	L0080
	LDA	L0080
	CMP	#$11
	BCC	L9209
	RTS
L9245	LDA	#$00
	STA	L0080
	LDX	#$00
L924B	LDA	#$08
	STA	L3DFC,X
	INX
	LDY	#$00
	LDA	#$07
	STA	L0081
L9257	LDA	L91F4,Y
	STA	L3DFC,X
	INX
	INY
	DEC	L0081
	BNE	L9257
	CLC
	LDA	L0080
	ADC	#$21
	STA	L3DFC,X
	INX
	INX
	INX
	INC	L0080
	LDA	L0080
	CMP	#$10
	BCC	L924B
	RTS
L9277	LDX	L396F
	CPX	#$09
	BCC	L9280
	LDX	#$08
L9280	LDA	LB0BE,X
	STA	L0080
	LDA	L396B
	CLC
	ADC	L3EED
	CLC
	ADC	L3EEE
	CLC
	ADC	L3EEF
	CLC
	ADC	L3F13
	CMP	L0080
	BCC	L92AF
	BEQ	L92AF
	LDA	#$00
	STA	L3EED
	STA	L3EEE
	STA	L3EEF
	STA	L3F13
	LDA	L396B
L92AF	STA	L396E
	RTS
L92B3	JSR	LB0C7
	LDX	L3ED2
	BEQ	L92EC
	CPX	#$8B
	BNE	L92C1
	LDX	#$08
L92C1	CPX	#$82
	BNE	L92C7
	LDX	#$09
L92C7	STX	L3EF0
	CPX	#$02
	BCC	L9305
	CPX	#$0B
	BCS	L9305
	LDA	L9339+1,X
	STA	L0080
	LDA	L9342+1,X
	STA	L0081
L92DC	LDY	#$00
L92DE	LDA	(L0080),Y
	BMI	L92E8
	STA	L72C8,Y
	INY
	BNE	L92DE
L92E8	CPX	#$02
	BEQ	L92F7
L92EC	LDX	#$05
L92EE	LDA	L93CF,X
	STA	L72C1,X
	DEX
	BPL	L92EE
L92F7	JSR	LB0D5
	LDA	#$04
	STA	L3DD7
	LDA	#$00
	STA	L3ED2
	RTS
L9305	CPX	#$C7
	BNE	L9313
	LDA	#$71
	STA	L0080
	LDA	#$93
	STA	L0081
	BNE	L92DC
L9313	LDX	#$10
	LDA	L3ED2
L9318	CMP	#$64
	BCC	L9322
	SEC
	SBC	#$64
	INX
	BNE	L9318
L9322	STX	L72C8
	LDX	#$10
L9327	CMP	#$0A
	BCC	L9331
	SEC
	SBC	#$0A
	INX
	BNE	L9327
L9331	STX	L72C9
	ORA	#$10
	STA	L72CA
L9339	JMP	L92EC
	.byte	$D5
L933D	ADC	(COUNTR,X)
	LSR	L8EE4+1
L9342	.byte	$9F,$B5,$C4 ; (undocumented opcode) - SHA LC4B5,Y
	.byte	$93,$93 ; (undocumented opcode) - SHA (L0093),Y
	.byte	$93,$93 ; (undocumented opcode) - SHA (L0093),Y
	.byte	$93,$93 ; (undocumented opcode) - SHA (L0093),Y
	.byte	$93,$93 ; (undocumented opcode) - SHA (L0093),Y
	.byte	$93,$34 ; (undocumented opcode) - SHA (BFENLO),Y
	.byte	$6F,$6F,$00 ; data bytes originally disassembled as RRA SHFAMT
	ADC	L6E61
	ADC	L6D00,Y
	ADC	(LOGCOL,X)
	PLA
	ADC	#$6E
	ADC	COLAC+1
	ORA	(FPTR2+1,X)
	AND	L7A61
	ADC	LINZBS
; Text/message data begins here; some bytes still look like code to the disassembler.
	.byte	$74,$6F ; (undocumented opcode) - NOP	SHFAMT,X
	.byte	$6F,$00,$73 ; data bytes originally disassembled as RRA L7300
	ADC	L6C61
	JMP	($FF1F)
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$00 ; Screen code for ' '
	.byte	$74 ; 't'
	.byte	$69 ; 'i'
	.byte	$6D ; 'm'
	.byte	$65 ; 'e'
	.byte	$6F ; 'o'
	.byte	$75 ; 'u'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$65 ; 'e'
	.byte	$74 ; 't'
	.byte	$77 ; 'w'
	.byte	$6F ; 'o'
	.byte	$72 ; 'r'
	.byte	$6B ; 'k'
	.byte	$00 ; Screen code for ' '
	.byte	$62 ; 'b'
	.byte	$6F ; 'o'
	.byte	$6F ; 'o'
	.byte	$0D ; Screen code for '-'
	.byte	$62 ; 'b'
	.byte	$6F ; 'o'
	.byte	$6F ; 'o'
	.byte	$FF
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$68 ; 'h'
	.byte	$65 ; 'e'
	.byte	$63 ; 'c'
	.byte	$6B ; 'k'
	.byte	$73 ; 's'
	.byte	$75 ; 'u'
	.byte	$6D ; 'm'
	.byte	$00 ; Screen code for ' '
	.byte	$62 ; 'b'
	.byte	$6F ; 'o'
	.byte	$6F ; 'o'
	.byte	$0D ; Screen code for '-'
	.byte	$62 ; 'b'
	.byte	$6F ; 'o'
	.byte	$6F ; 'o'
	.byte	$FF
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$65 ; 'e'
	.byte	$76 ; 'v'
	.byte	$69 ; 'i'
	.byte	$63 ; 'c'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$6E ; 'n'
	.byte	$6F ; 'o'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$72 ; 'r'
	.byte	$65 ; 'e'
	.byte	$73 ; 's'
	.byte	$70 ; 'p'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$64 ; 'd'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$67 ; 'g'
	.byte	$FF
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$6F ; 'o'
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$75 ; 'u'
	.byte	$63 ; 'c'
	.byte	$68 ; 'h'
	.byte	$00 ; Screen code for ' '
	.byte	$64 ; 'd'
	.byte	$65 ; 'e'
	.byte	$76 ; 'v'
	.byte	$69 ; 'i'
	.byte	$63 ; 'c'
	.byte	$65 ; 'e'
	.byte	$FF
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$61 ; 'a'
	.byte	$6E ; 'n'
	.byte	$07 ; Screen code for '''
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$79 ; 'y'
	.byte	$6E ; 'n'
	.byte	$63 ; 'c'
	.byte	$FF
L93CF	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$1A ; Screen code for ':'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$61 ; 'a'
	.byte	$6D ; 'm'
	.byte	$65 ; 'e'
	.byte	$00 ; Screen code for ' '
	.byte	$74 ; 't'
	.byte	$65 ; 'e'
	.byte	$72 ; 'r'
	.byte	$6D ; 'm'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$61 ; 'a'
	.byte	$74 ; 't'
	.byte	$65 ; 'e'
	.byte	$64 ; 'd'
	.byte	$FF
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$6F ; 'o'
	.byte	$00 ; Screen code for ' '
	.byte	$64 ; 'd'
	.byte	$72 ; 'r'
	.byte	$6F ; 'o'
	.byte	$6E ; 'n'
	.byte	$65 ; 'e'
	.byte	$73 ; 's'
	.byte	$00 ; Screen code for ' '
	.byte	$61 ; 'a'
	.byte	$6C ; 'l'
	.byte	$6C ; 'l'
	.byte	$6F ; 'o'
	.byte	$77 ; 'w'
	.byte	$65 ; 'e'
	.byte	$64 ; 'd'
	.byte	$01 ; Screen code for '!'
	.byte	$FF
L93F8	LDA	#$00
	STA	L396C
	LDX	#$11
	LDA	#$15
	STA	L3D3E,X
	LDA	#$9A
	STA	L3D66,X
	LDA	L008C
	STA	L3D8E,X
	LDX	#$1B
	LDA	#$18
	STA	L3D3E,X
	LDA	#$80
	STA	L3D66,X
	LDX	#$13
	LDA	#$00
	STA	L3D3E,X
	LDA	#$80
	STA	L3D66,X
	LDX	#$1B
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L945F
L9430	LDX	#$17
	JSR	BANK_CALL_INDEXED
L9435	LDX	L3ED2
	BNE	L9459
	LDX	L3EE7
	BEQ	L947E
	JSR	L9598
	LDA	L3ED2
	BNE	L9459
	LDA	L3EE7
	LDX	#$00
	STX	L3EE7
	CMP	#$84
	BEQ	L9462
	JSR	LB224
	JMP	L9430
L9459	JSR	LB224
	JSR	L92B3
L945F	JMP	L8050
L9462	LDA	#$84
	STA	L3EE8
L9467	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9459
	LDA	L3EE7
	BEQ	L9467
	JMP	L9435
L947E	CMP	#$00
	BNE	L948A
	LDA	#$84
	STA	L3EE8
	JMP	L94FC
L948A	CMP	#$17
	BNE	L94B3
	JSR	L9EB7
	BEQ	L94A6
	LDY	#$00
	LDX	#$1C
	JSR	BANK_CALL_INDEXED
	CPY	#$00
	BEQ	L94A6
	LDA	#$82
	STA	L3EE8
	JMP	L94FC
L94A6	LDY	#$01
	LDX	#$1C
	JSR	BANK_CALL_INDEXED
	JSR	L9277
	JMP	L9430
L94B3	CMP	#$18
	BNE	L94BF
	LDA	#$81
	STA	L3EE8
	JMP	L94FC
L94BF	CMP	#$1A
	BNE	L94D3
	JSR	LB0C7
	LDX	#$19
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L94F6
	JMP	L9430
L94D3	CMP	#$1B
	BNE	L94E7
	JSR	LB0C7
	LDX	#$1D
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L94F6
	JMP	L9430
L94E7	CMP	#$1C
	BNE	L94F3
	LDA	#$86
	STA	L3EE8
	JMP	L94FC
L94F3	JMP	L9430
L94F6	JSR	L92B3
	JMP	L8050
L94FC	LDX	#$14
	JSR	BANK_CALL_INDEXED
	JMP	L9435
L9504	LDA	#$00
	STA	L396C
	LDX	#$11
	LDA	#$15
	STA	L3D3E,X
	LDA	#$9A
	STA	L3D66,X
	LDA	L008C
	STA	L3D8E,X
	LDX	#$1B
	LDA	#$18
	STA	L3D3E,X
	LDA	#$80
	STA	L3D66,X
	LDX	#$13
	LDA	#$00
	STA	L3D3E,X
	LDA	#$80
	STA	L3D66,X
	JSR	LB224
	LDX	#$1B
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9568
L953F	LDX	#$1E
	JSR	BANK_CALL_INDEXED
L9544	LDA	L3ED2
	BNE	L9568
	LDA	L3EE7
	BEQ	L958D
	JSR	L9598
	LDA	L3ED2
	BNE	L9568
	LDA	L3EE7
	LDX	#$00
	STX	L3EE7
	CMP	#$84
	BEQ	L9571
	JSR	LB224
	JMP	L953F
L9568	JSR	LB224
	JSR	L92B3
	JMP	L8050
L9571	LDA	#$84
	STA	L3EE8
L9576	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9568
	LDA	L3EE7
	BEQ	L9576
	JMP	L9544
L958D	JMP	L953F
	.byte	$A2
L9591	.byte	$14,$20 ; (undocumented opcode) - NOP	$20,X
	ORA	L4CAF,X
	.byte	$44,$95 ; (undocumented opcode) - NOP	$95
L9598	JSR	LB0C7
	LDA	L3EE7
	LDX	#$00
	STX	L3EE7
	CMP	#$81
	BNE	L95BD
	LDX	#$0F
	LDA	#$00
L95AB	STA	L3DC7,X
	STA	L3AC2,X
	DEX
	BPL	L95AB
	LDX	#$03
L95B6	STA	L3D39,X
	DEX
	BPL	L95B6
	RTS
L95BD	CMP	#$86
	BNE	L95C4
	JMP	L8F57
L95C4	CMP	#$82
	BEQ	L95CB
	JMP	L9652
L95CB	JSR	LB0C7
	LDX	#$0A
L95D0	LDA	L9657,X
	STA	L72CA,X
	DEX
	BPL	L95D0
	JSR	LB0D5
	LDA	L3968
	BNE	L963D
	LDX	#$13
	LDA	#$36
	STA	L3D3E,X
	LDA	#$AF
	STA	L3D66,X
	JSR	LAFE9
	BNE	L963C
L95F2	LDX	#$24
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BEQ	L9613
	LDA	#$00
	STA	L3ED2
	LDY	#$00
	LDX	#$1C
	JSR	BANK_CALL_INDEXED
	CPY	#$01
	BEQ	L95F2
	LDY	#$01
	LDX	#$1C
	JSR	BANK_CALL_INDEXED
L9613	JSR	L9277
	JSR	LAFEC
	BNE	L963C
	LDX	#$13
	LDA	#$00
	STA	L3D3E,X
	LDA	#$80
	STA	L3D66,X
	LDA	L3ED2
	BNE	L963C
	LDA	#$80
	JSR	LAFDD
	JSR	LAFAE
	LDA	RTCLOK+2
	STA	L3ECE
	JSR	LB0C7
L963C	RTS
L963D	JSR	LAFDA
	BNE	L9651
	CMP	#$80
	BNE	L963D
	JSR	LAFDD
	LDA	RTCLOK+2
	STA	L3ECE
	JSR	LB0C7
L9651	RTS
L9652	CMP	#$84
	BEQ	L9662
	RTS
L9657	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$24 ; '$' ; Screen code for 'D'
L9662	JSR	LB0C7
	LDA	#$22
	STA	L72CE
	LDA	#$35
	STA	L72CF
	LDA	#$33
	STA	L72D0
	LDA	#$39
	STA	L72D1
	JSR	LB0D5
	LDA	L3968
	BEQ	L9684
	JMP	L96D9
L9684	JSR	L89F8
	LDA	L3ED2
	BNE	L96D6
	LDA	L396A
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	LDA	L3969
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	LDA	L3EED
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	LDA	L3EEE
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	LDA	L3F13
	ASL
	ASL
	ASL
	ASL
	ORA	L3EEF
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	BEQ	L9734
L96D6	JMP	L980F
L96D9	JSR	L8D3F
	LDA	L3ED2
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	STA	L396A
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	STA	L3969
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	STA	L3EED
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	STA	L3EEE
	JSR	LAFDD
	BNE	L96D6
	JSR	LAFAE
	BNE	L96D6
	STA	L3EEF
	JSR	LAFDD
	BNE	L96D6
	LDA	L3EEF
	LSR
	LSR
	LSR
	LSR
	STA	L3F13
	LDA	L3EEF
	AND	#$0F
	STA	L3EEF
L9734	LDX	L396B
L9737	LDA	#$0A
	STA	L3D19,X
	LDA	#$64
	STA	L3D09,X
	LDA	#$32
	STA	L3CF9,X
	LDA	#$02
	STA	L3CE9,X
	LDA	#$00
	STA	L3B42,X
	STA	L3B52,X
	LDA	#$08
	STA	L3B62,X
	INX
	CPX	#$10
	BCC	L9737
	LDA	#$00
	STA	L3CE8
	LDA	L3968
	STA	L00A6
	LDA	L396B
	STA	L00A7
	JMP	L9808
L976F	JMP	L980F
L9772	LDX	L00A6
	LDA	L3D19,X
	JSR	LAFDD
	BNE	L976F
	LDX	L00A6
	LDA	L3D09,X
	JSR	LAFDD
	BNE	L976F
	LDX	L00A6
	LDA	L3CF9,X
	JSR	LAFDD
	BNE	L976F
	LDX	L00A6
	LDA	L3CE9,X
	JSR	LAFDD
	BNE	L980F
	LDX	L00A6
	LDA	L3B42,X
	JSR	LAFDD
	BNE	L980F
	LDX	L00A6
	LDA	L3B52,X
	JSR	LAFDD
	BNE	L980F
	LDX	L00A6
	LDA	L3B62,X
	JSR	LAFDD
	BNE	L980F
	LDX	L00A6
	BNE	L97BF
	LDX	L396B
L97BF	DEX
	STX	L00A6
	JSR	LAFAE
	BNE	L980F
	LDX	L00A6
	STA	L3D19,X
	JSR	LAFAE
	BNE	L980F
	LDX	L00A6
	STA	L3D09,X
	JSR	LAFAE
	BNE	L980F
	LDX	L00A6
	STA	L3CF9,X
	JSR	LAFAE
	BNE	L980F
	LDX	L00A6
	STA	L3CE9,X
	JSR	LAFAE
	BNE	L980F
	LDX	L00A6
	STA	L3B42,X
	JSR	LAFAE
	BNE	L980F
	LDX	L00A6
	STA	L3B52,X
	JSR	LAFAE
	BNE	L980F
	LDX	L00A6
	STA	L3B62,X
L9808	DEC	L00A7
	BEQ	L9815
	JMP	L9772
L980F	LDA	RTCLOK+2
	STA	L3ECE
	RTS
L9815	LDA	L3F07
	BEQ	L9857
	LDA	L3968
	BNE	L9838
	JSR	L993B
	JSR	LAFDD
	BNE	L9835
	JSR	LAFAE
	BNE	L9835
	CMP	#$00
	BEQ	L9857
	LDA	#$07
	STA	L3ED2
L9835	JMP	L980F
L9838	JSR	L993B
	JSR	LAFAE
	BNE	L9835
	CMP	L0089
	BEQ	L9850
	LDA	#$FF
	JSR	LAFDD
	BNE	L9835
	LDA	#$07
	STA	L3ED2
L9850	LDA	#$00
	JSR	LAFDD
	BNE	L9835
L9857	LDX	#$04
	JSR	BANK_CALL_INDEXED
	JSR	L9277
	JSR	L99B5
	LDX	#$21
	JSR	BANK_CALL_INDEXED
	LDA	#$01
	STA	L3EEA
	JSR	LB359
	JSR	L999E
	JSR	L9979
	LDA	RTCLOK+2
	STA	L3ECE
	LDA	#$00
	STA	L3F0A
	STA	L3F0C
	LDX	#$10
	JSR	BANK_CALL_INDEXED
	STA	L3ED2
	LDA	#$00
	STA	L3EEA
	CLC
	LDA	L00B3
	ADC	#$64
	STA	L3EEB
	LDX	#$0F
L9899	LDA	L3DC7,X
	STA	L3AC2,X
	DEX
	BPL	L9899
	LDX	#$03
L98A4	LDA	L3DC7,X
	STA	L3D39,X
	DEX
	BPL	L98A4
	LDA	L3ED2
	BEQ	L98BE
	CMP	#$02
	BEQ	L98BB
	CMP	#$03
	BEQ	L98BB
	RTS
L98BB	JSR	L92B3
L98BE	LDA	#$01
	STA	L3DD7
	LDA	L3968
	BEQ	L98CB
	JMP	L9926
L98CB	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L993A
	LDA	CONSOL
	AND	#$01
	BNE	L98EA
	LDA	#$04
	STA	L3DD7
	LDY	#$84
	BNE	L9923
L98EA	LDA	CONSOL
	AND	#$02
	BEQ	L9904
	LDA	CONSOL
	AND	#$04
	BEQ	L9904
	LDA	STRIG0
	BNE	L98CB
	LDA	#$04
	STA	L3DD7
	BNE	L9921
L9904	LDA	#$04
	STA	L3DD7
L9909	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L993A
	LDA	CONSOL
	AND	#$07
	CMP	#$07
	BNE	L9909
L9921	LDY	#$80
L9923	STY	L3EE8
L9926	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L993A
	LDA	L3EE7
	BEQ	L9926
L993A	RTS
L993B	CLC
	LDA	L0089
	ADC	L396F
	ADC	L3969
	ADC	L396A
	ADC	L3EED
	ADC	L3EEE
	ADC	L3EEF
	ADC	L3F13
	ADC	L3CE6
	LDX	#$0F
L9958	ADC	L3AF2,X
	ADC	L3CE7,X
	ADC	L3D19,X
	ADC	L3D09,X
	ADC	L3CF9,X
	ADC	L3CE9,X
	ADC	L3B42,X
	ADC	L3B52,X
	ADC	L3B62,X
	DEX
	BPL	L9958
	STA	L0089
	RTS
L9979	LDA	#$30
	STA	L0088
	LDA	#$20
	STA	L0087
	STA	L0080
L9983	LDY	#$1F
	LDA	#$FF
L9987	STA	(L0087),Y
	DEY
	BPL	L9987
	DEC	L0080
	BEQ	L999D
	CLC
	LDA	L0087
	ADC	#$40
	STA	L0087
	BCC	L9983
	INC	L0088
	BNE	L9983
L999D	RTS
L999E	LDX	#$0F
	LDA	#$00
L99A2	STA	L39C2,X
	STA	L39E2,X
	STA	L3A02,X
	STA	L3A22,X
	STA	L3A82,X
	DEX
	BPL	L99A2
	RTS
L99B5	LDA	#$16
	STA	L0087
	LDA	#$3F
	STA	L0088
	LDX	#$02
	LDY	#$00
	TYA
L99C2	STA	(L0087),Y
	INY
	BNE	L99C2
	INC	L0088
	DEX
	BNE	L99C2
	LDY	#$EB
L99CE	STA	(L0087),Y
	DEY
	BNE	L99CE
	STA	(L0087),Y
	RTS
L99D6	CLC
L99D7	LDA	#$00
	ADC	L3969
	ADC	L396A
	LDX	#$00
L99E1	ADC	L39B2,X
	ADC	L39D2,X
	ADC	L39F2,X
	ADC	L3A12,X
	ADC	L3A32,X
	ADC	L3A72,X
	ADC	L3A92,X
	ADC	L3AA2,X
	ADC	L3AB2,X
	ADC	L3AC2,X
	ADC	L39C2,X
	ADC	L39E2,X
	ADC	L3A02,X
	ADC	L3A22,X
	ADC	L3A82,X
	INX
	CPX	L396E
	BCC	L99E1
	RTS
	.byte	$AD
L9A16	PLA
	AND	L13D0,Y
	LDA	L3F0A
	BNE	L9A28
	LDA	CONSOL
	AND	#$07
	CMP	#$07
	BEQ	L9A2D
L9A28	LDA	#$82
	STA	L3EE8
L9A2D	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9A58
	LDA	L3EE7
	BNE	L9A5B
	LDA	L3EB9
	BNE	L9A2D
	LDX	#$22
	JSR	BANK_CALL_INDEXED
	DEC	L3F0C
	BPL	L9A58
	LDA	#$14
	STA	L3F0C
	LDA	#$00
	STA	L3F12
	JMP	L9B3C
L9A58	JMP	BANK_RETURN
L9A5B	LDA	#$04
	STA	L3DD7
	LDA	#$00
	STA	L3EE7
	STA	COLOR4
	JSR	LB0C7
	LDA	L3968
	BEQ	L9A73
	JMP	L9B09
L9A73	LDX	#$1F
L9A75	LDA	L9123,X
	STA	L72C0,X
	DEX
	BPL	L9A75
	JSR	LB0D5
L9A81	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9A58
	LDA	CONSOL
	AND	#$07
	CMP	#$07
	BNE	L9A81
L9A99	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9A58
	LDA	CONSOL
	AND	#$02
	BNE	L9AB5
	LDA	#$84
	STA	L0096
	BNE	L9AC2
L9AB5	LDA	CONSOL
	AND	#$04
	BNE	L9A99
	LDA	#$82
	STA	L0096
	BNE	L9AC2
L9AC2	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9B39
	LDA	CONSOL
	AND	#$07
	CMP	#$07
	BNE	L9AC2
	LDA	L0096
	STA	L3EE8
L9ADF	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9B39
	LDA	L3EE7
	BEQ	L9ADF
	LDX	#$00
	STX	L3EE7
	STX	L3EE8
	STX	L3F0A
	CMP	#$84
	BEQ	L9B39
	LDA	#$02
	STA	L3ED2
	BNE	L9B39
L9B09	LDX	#$04
L9B0B	LDA	L911E,X
	STA	L72CE,X
	DEX
	BPL	L9B0B
	JSR	LB0D5
L9B17	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9B39
	LDA	L3EE7
	BEQ	L9B17
	LDX	#$00
	STX	L3EE7
	CMP	#$84
	BEQ	L9B39
	LDA	#$02
	STA	L3ED2
L9B39	JMP	BANK_RETURN
L9B3C	LDA	L3F12
	CMP	#$03
	BCC	L9B4B
	LDA	#$0A
	STA	L3ED2
	JMP	BANK_RETURN
L9B4B	INC	L3F12
	LDA	L3968
	BNE	L9B7A
	JSR	L99D6
	STA	L0089
	JSR	LAFDD
	BNE	L9BA2
	JSR	LAFAE
	BNE	L9BA2
	LDX	#$00
	CMP	L0089
	BEQ	L9B69
	DEX
L9B69	TXA
	JSR	LAFDD
	BNE	L9BA2
	JSR	LAFAE
	BNE	L9BA2
	CMP	#$00
	BEQ	L9BA2
	BNE	L9BA5
L9B7A	JSR	LAFAE
	BNE	L9BA2
	STA	L0089
	JSR	L99D6
	CMP	L0089
	BEQ	L9B8A
	ADC	#$01
L9B8A	JSR	LAFDD
	BNE	L9BA2
	JSR	LAFAE
	BNE	L9BA2
	STA	L0089
	JSR	LAFDD
	BNE	L9BA2
	LDA	L0089
	BEQ	L9BA2
	JMP	L9BA5
L9BA2	JMP	BANK_RETURN
L9BA5	JSR	LB0C7
	LDX	#$17
L9BAA	LDA	L9E80,X
	STA	L72C4,X
	DEX
	BPL	L9BAA
	JSR	LB0D5
	JSR	L9979
	LDA	L3968
	BEQ	L9BC4
	JMP	L9D22
L9BC1	JMP	BANK_RETURN
L9BC4	LDA	L3969
	JSR	LAFDD
	BNE	L9BC1
	JSR	LAFAE
	BNE	L9BC1
	LDA	L396A
	JSR	LAFDD
	BNE	L9BC1
	JSR	LAFAE
	BNE	L9BC1
	LDA	#$00
	STA	L00A6
L9BE2	LDX	L00A6
	LDA	L39B2,X
	JSR	LAFDD
	BNE	L9BC1
	JSR	LAFAE
	BNE	L9BC1
	LDX	L00A6
	LDA	L39D2,X
	JSR	LAFDD
	BNE	L9BC1
	JSR	LAFAE
	BNE	L9BC1
	LDX	L00A6
	LDA	L39F2,X
	JSR	LAFDD
	BNE	L9BC1
	JSR	LAFAE
	BNE	L9BC1
	LDX	L00A6
	LDA	L3A12,X
	JSR	LAFDD
	BNE	L9BC1
	JSR	LAFAE
	BNE	L9BC1
	LDX	L00A6
	LDA	L3A32,X
	JSR	LAFDD
	BNE	L9BC1
	JSR	LAFAE
	BNE	L9BC1
	LDX	L00A6
	LDA	L3A72,X
	JSR	LAFDD
	BNE	L9BC1
	JSR	LAFAE
	BNE	L9BC1
	LDX	L00A6
	LDA	L3A92,X
	JSR	LAFDD
	BNE	L9C99
	JSR	LAFAE
	BNE	L9C99
	LDX	L00A6
	LDA	L3AA2,X
	JSR	LAFDD
	BNE	L9C99
	JSR	LAFAE
	BNE	L9C99
	LDX	L00A6
	LDA	L3AB2,X
	JSR	LAFDD
	BNE	L9C99
	JSR	LAFAE
	BNE	L9C99
	LDX	L00A6
	LDA	L3AC2,X
	JSR	LAFDD
	BNE	L9C99
	JSR	LAFAE
	BNE	L9C99
	LDX	L00A6
	LDA	L39C2,X
	JSR	LAFDD
	BNE	L9C99
	JSR	LAFAE
	BNE	L9C99
	LDX	L00A6
	LDA	L39E2,X
	JSR	LAFDD
	BNE	L9C99
	JSR	LAFAE
	BNE	L9C99
	JMP	L9C9C
L9C99	JMP	BANK_RETURN
L9C9C	LDX	L00A6
	LDA	L3A02,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	LDA	L3A22,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	LDA	L3A82,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	LDA	L3B02,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	LDA	L3B12,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	LDA	L3B22,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	LDA	L3B32,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	INC	L00A6
	LDA	L00A6
	CMP	L396E
	BCS	L9D11
	JMP	L9BE2
L9D11	JSR	L9E98
	JSR	L99B5
	LDX	#$21
	JSR	BANK_CALL_INDEXED
	JMP	L9B3C
L9D1F	JMP	BANK_RETURN
L9D22	JSR	LAFAE
	BNE	L9D1F
	STA	L3969
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	STA	L396A
	JSR	LAFDD
	BNE	L9D1F
	LDA	#$00
	STA	L00A6
L9D40	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	STA	L39B2,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	STA	L39D2,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	STA	L39F2,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	STA	L3A12,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	STA	L3A32,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9D1F
	LDX	L00A6
	STA	L3A72,X
	JSR	LAFDD
	BNE	L9D1F
	JSR	LAFAE
	BNE	L9DF7
	LDX	L00A6
	STA	L3A92,X
	JSR	LAFDD
	BNE	L9DF7
	JSR	LAFAE
	BNE	L9DF7
	LDX	L00A6
	STA	L3AA2,X
	JSR	LAFDD
	BNE	L9DF7
	JSR	LAFAE
	BNE	L9DF7
	LDX	L00A6
	STA	L3AB2,X
	JSR	LAFDD
	BNE	L9DF7
	JSR	LAFAE
	BNE	L9DF7
	LDX	L00A6
	STA	L3AC2,X
	JSR	LAFDD
	BNE	L9DF7
	JSR	LAFAE
	BNE	L9DF7
	LDX	L00A6
	STA	L39C2,X
	JSR	LAFDD
	BNE	L9DF7
	JSR	LAFAE
	BNE	L9DF7
	LDX	L00A6
	STA	L39E2,X
	JSR	LAFDD
	BNE	L9DF7
	JMP	L9DFA
L9DF7	JMP	BANK_RETURN
L9DFA	JSR	LAFAE
	BNE	L9E7D
	LDX	L00A6
	STA	L3A02,X
	JSR	LAFDD
	BNE	L9E7D
	JSR	LAFAE
	BNE	L9E7D
	LDX	L00A6
	STA	L3A22,X
	JSR	LAFDD
	BNE	L9E7D
	JSR	LAFAE
	BNE	L9E7D
	LDX	L00A6
	STA	L3A82,X
	JSR	LAFDD
	BNE	L9E7D
	JSR	LAFAE
	BNE	L9E7D
	LDX	L00A6
	STA	L3B02,X
	JSR	LAFDD
	BNE	L9E7D
	JSR	LAFAE
	BNE	L9E7D
	LDX	L00A6
	STA	L3B12,X
	JSR	LAFDD
	BNE	L9E7D
	JSR	LAFAE
	BNE	L9E7D
	LDX	L00A6
	STA	L3B22,X
	JSR	LAFDD
	BNE	L9E7D
	JSR	LAFAE
	BNE	L9E7D
	LDX	L00A6
	STA	L3B32,X
	JSR	LAFDD
	BNE	L9E7D
	INC	L00A6
	LDA	L00A6
	CMP	L396E
	BCS	L9E6F
	JMP	L9D40
L9E6F	JSR	L9E98
	JSR	L99B5
	LDX	#$21
	JSR	BANK_CALL_INDEXED
	JMP	L9B3C
L9E7D	JMP	BANK_RETURN
L9E80	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$68 ; 'h'
	.byte	$61 ; 'a'
	.byte	$74 ; 't'
	.byte	$00 ; Screen code for ' '
	.byte	$73 ; 's'
	.byte	$79 ; 'y'
	.byte	$6E ; 'n'
	.byte	$63 ; 'c'
	.byte	$07 ; Screen code for '''
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$67 ; 'g'
	.byte	$00 ; Screen code for ' '
	.byte	$66 ; 'f'
	.byte	$65 ; 'e'
	.byte	$65 ; 'e'
	.byte	$6C ; 'l'
	.byte	$69 ; 'i'
	.byte	$6E ; 'n'
	.byte	$67 ; 'g'
	.byte	$0E ; Screen code for '.'
	.byte	$0E ; Screen code for '.'
	.byte	$0E ; Screen code for '.'
L9E98	JSR	LB359
	LDA	#$00
	STA	L3DB6
L9EA0	LDX	L3968
	LDA	L3AC2,X
	CMP	L3DB6
	BEQ	L9EB6
	INC	L3DB6
	LDX	#$0F
	JSR	BANK_CALL_INDEXED
	JMP	L9EA0
L9EB6	RTS
L9EB7	LDA	#$08
	STA	CONSOL
	LDA	CONSOL
	AND	#$07
	CMP	#$07
	BEQ	L9ED6
	LDX	#$00
	LDY	#$0C
	LDA	#$44
L9ECB	CMP	HATABS,X
	BEQ	L9ED9
	INX
	INX
	INX
	DEY
	BNE	L9ECB
L9ED6	LDA	#$00
	RTS
L9ED9	LDA	#$01
	RTS
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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

	opt h-

	icl "include/atari_os.inc"
	icl "include/hardware.inc"
	icl "include/cartridge.inc"
	icl "include/game_ram.inc"
	icl "include/fixed_bank.inc"

; Bank 00: switchable 8KB cartridge bank, mapped at $8000-$9FFF.
; This bank is mostly executable game logic with embedded tables.
; Generated Lxxxx symbols are preserved until their meaning is proven.
; Hardware/OS constants are named where confidently identified.
; Bank map (working):
;   $8000-$8003  Bank-call slot $22 entry stub, called from bank 12 gameplay loop.
;   $8004-$8025  Preserved console-key wait/debounce helper; no active caller proven yet.
;   $8026-$82AD  Per-player gameplay state dispatcher and local control update.
;   $82AE-$82E5  Mixed preserved bytes plus MIDI_TX_BUFFER save/restore helper at $82BA.
;   $82E6-$8975  Facing/input resolution and movement-choice helpers.
;   $8976-$8995  Preserved byte run; nearby disassembly is not yet proven executable.
;   $8996-$8C52  Per-player transient control state and movement-direction gating.
;   $8C53-$8C6A  Preserved byte run before a random-bit helper.
;   $8C6B-$8F6B  Target selection, line-of-sight checks, and fire/facing control.
;   $8F6C-$9329  Relative-angle/math helpers used by target selection.
;   $932A-$9FFF  Angle lookup table and trailing fill bytes.

L0080	= $0080
L0083	= $0083
L0085	= $0085
L0096	= $0096
L0097	= $0097
L0099	= $0099
L009A	= $009A
L009C	= $009C
L009D	= $009D
L009E	= $009E
L009F	= $009F
L00A0	= $00A0
L00A6	= $00A6
L00A7	= $00A7
L0600	= $0600
L3F26	= $3F26
L3F36	= $3F36
L3F46	= $3F46
L3F56	= $3F56
L3F66	= $3F66
L3F76	= $3F76
L3F86	= $3F86
L3FA6	= $3FA6
L3FB6	= $3FB6
L401A	= $401A
L403A	= $403A
L405A	= $405A
L407A	= $407A
L40CA	= $40CA
L40CB	= $40CB
L40CD	= $40CD
L40CE	= $40CE
L40CF	= $40CF
L40D0	= $40D0
L40D1	= $40D1
L40DC	= $40DC
L40DD	= $40DD
L40DE	= $40DE
L40DF	= $40DF
L40E0	= $40E0
L40E1	= $40E1
L40E2	= $40E2
L40E3	= $40E3
L40E4	= $40E4
L40E5	= $40E5
L40E6	= $40E6
L40E7	= $40E7
L40E8	= $40E8
L40E9	= $40E9
L40EA	= $40EA
L40EB	= $40EB
L40EC	= $40EC
L40ED	= $40ED
L40EE	= $40EE
L40EF	= $40EF
L40F0	= $40F0
L40F1	= $40F1
L40F2	= $40F2
L40F3	= $40F3
L40F4	= $40F4
L40F5	= $40F5
L40F6	= $40F6
L40F7	= $40F7
L40F8	= $40F8
L40F9	= $40F9
L4103	= $4103
L4111	= $4111
L4112	= $4112
L4113	= $4113
L4114	= $4114
L4115	= $4115
L4116	= $4116
L4117	= $4117
L4118	= $4118
L4119	= $4119
LAD00	= $AD00
LAD6F	= $AD6F
LAEB0	= $AEB0
LAF41	= $AF41
LBE06	= $BE06
LBE0C	= $BE0C
	org $8000
BANK0_GAMEPLAY_UPDATE_ENTRY	JMP	L8026	; bank-call slot $22
	.byte	$48 ; 'H'
; Preserved console-key wait/debounce helper. No active caller has been proven;
; keep adjacent bytes/layout untouched.
L8004	TXA
	PHA
L8006	LDA	CONSOL
	AND	#$07
	CMP	#$07
	BEQ	L8006
	LDX	#$00
L8011	NOP
	NOP
	NOP
	NOP
	NOP
	INX
	BNE	L8011
L8019	LDA	CONSOL
	AND	#$07
	CMP	#$07
	BNE	L8019
	PLA
	TAX
	PLA
	RTS
; Main bank 0 gameplay update. Bank 12 calls this once per gameplay loop after
; servicing bank 4 network state. It walks player slots from HUMAN_PLAYER_COUNT
; through TOTAL_PLAYER_COUNT and dispatches on PLAYER_BOT_TYPE,X.
L8026	LDX	HUMAN_PLAYER_COUNT
	TXA
	STA	L40CB
	LDX	L40CB
L8030	LDA	PLAYER_BOT_TYPE,X
	CMP	#$FF
	BNE	L803A
	JMP	L8096
L803A	LDA	L3F56,X
	BNE	L804F
	LDA	PLAYER_STATE,X
	BNE	L806D
	LDA	#$01
	STA	L3F56,X
	JSR	L8A07
	JMP	L8096
L804F	LDA	PLAYER_STATE,X
	BNE	L8062
	JSR	L8A07
	LDX	L40CB
	LDA	#$01
	STA	L3F56,X
	JMP	L8096
L8062	JSR	L823C
	LDX	L40CB
	LDA	#$00
	STA	L3F56,X
L806D	LDX	L40CB
	LDA	PLAYER_BOT_TYPE,X
	BNE	L807B
	JSR	L80A4
	JMP	L8096
L807B	CMP	#$01
	BNE	L8085
	JSR	L80F2
	JMP	L8096
L8085	CMP	#$02
	BNE	L808F
	JSR	L819C
	JMP	L8096
L808F	CMP	#$03
	BNE	L8096
	JSR	L81EC
L8096	INC	L40CB
	LDX	L40CB
	CPX	TOTAL_PLAYER_COUNT
	BCC	L8030
	JMP	BANK_RETURN
L80A4	LDY	#$03
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDA	L40CA
	CMP	#$FF
	BEQ	L80D8
	LDY	#$0C
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDA	L40CA
	CMP	#$FF
	BNE	L80CA
	JSR	L87C2
	JMP	L80D8
L80CA	JSR	L85C5
	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
	JMP	L80F1
L80D8	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
	JSR	L89A8
	LDA	L40CA
	BNE	L80F1
	JSR	L87A7
	JSR	L8ABA
	JSR	L82E6
L80F1	RTS
L80F2	LDX	L40CB
	LDA	L3F76,X
	BNE	L8120
	LDY	#$03
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDA	L40CA
	CMP	#$FF
	BEQ	L8118
	JSR	L85C5
	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
	JMP	L819B
L8118	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
L8120	JSR	L89A8
	LDA	L40CA
	BNE	L819B
	JSR	L8C76
	LDX	L40CB
	LDA	L3FA6,X
	CMP	#$FF
	BEQ	L815F
	LDA	L3FB6,X
	CMP	#$28
	BCS	L8152
	INC	L3FB6,X
	LDX	L40CB
	LDA	L3F86,X
	CMP	L3FA6,X
	BNE	L815F
	LDA	#$00
	STA	L3F76,X
	JMP	L815F
L8152	LDX	L40CB
	LDA	#$00
	STA	L3FB6,X
	LDA	#$FF
	STA	L3FA6,X
L815F	LDA	L3F76,X
	BEQ	L8185
	LDA	L3F86,X
	CMP	#$FF
	BEQ	L8185
	TAY
	LDA	PLAYER_STATE,Y
	BEQ	L8185
	JSR	L8996
	LDY	#$06
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDA	L40CA
	BEQ	L819B
	JMP	L8198
L8185	LDX	L40CB
	LDA	#$00
	STA	L3F76,X
	LDA	#$FF
	STA	L3F86,X
	JSR	L87A7
	JSR	L8ABA
L8198	JSR	L82E6
L819B	RTS
L819C	LDY	#$03
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDA	L40CA
	CMP	#$FF
	BEQ	L81BA
	JSR	L85C5
	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
	JMP	L81EB
L81BA	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
	JSR	L89A8
	LDA	L40CA
	BNE	L81EB
	JSR	L8C76
	LDX	L40CB
	LDA	L3F76,X
	BEQ	L81E2
	LDA	L3F86,X
	CMP	#$FF
	BEQ	L81E2
	TAY
	LDA	PLAYER_STATE,Y
	BNE	L81EB
L81E2	JSR	L87A7
	JSR	L8ABA
	JSR	L82E6
L81EB	RTS
L81EC	LDY	#$03
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDA	L40CA
	CMP	#$FF
	BEQ	L820A
	JSR	L85C5
	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
	JMP	L823B
L820A	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
	JSR	L89A8
	LDA	L40CA
	BNE	L823B
	JSR	L8C76
	LDX	L40CB
	LDA	L3F76,X
	BEQ	L8232
	LDA	L3F86,X
	CMP	#$FF
	BEQ	L8232
	TAY
	LDA	PLAYER_STATE,Y
	BNE	L823B
L8232	JSR	L87A7
	JSR	L8ABA
	JSR	L82E6
L823B	RTS
L823C	LDX	L40CB
	JSR	L87A7
	LDX	L40CB
	LDA	PLAYER_FACING_ANGLE,X
	STA	L40F8
	LDA	L40E7
	BEQ	L8257
	LDA	L40F8
	CMP	#$00
	BEQ	L82AD
L8257	LDA	L40E8
	BEQ	L8263
	LDA	L40F8
	CMP	#$40
	BEQ	L82AD
L8263	LDA	L40E9
	BEQ	L826F
	LDA	L40F8
	CMP	#$80
	BEQ	L82AD
L826F	LDA	L40EA
	BEQ	L827B
	LDA	L40F8
	CMP	#$C0
	BEQ	L82AD
L827B	LDA	#$FF
	STA	L40F9
	JSR	L88B8
	LDA	L40F4
	CMP	#$11
	BNE	L829B
	LDA	#$00
	STA	L40F4
	STA	L40EF
	STA	L40F9
	STA	L40F5
	JMP	L82AD
L829B	LDX	L40CB
	LDA	L40F5
	STA	L3F36,X
	LDA	L40F4
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
L82AD	RTS
	.byte	$85
L82AF	.byte	$80,$A5 ; (undocumented opcode) - NOP	#$A5
	.byte	$83,$85 ; (undocumented opcode) - SAX (L0085,X)
	INC	L85A5,X
	STA	FPTR2+1
	LDX	#$00
L82BA	LDA	MIDI_TX_BUFFER,X
	STA	L0600,X
	INX
	BNE	L82BA
	JSR	LBE0C
	LDA	L0080
	JSR	LBE06
	LDX	#$00
L82CD	NOP
	NOP
	INX
	BNE	L82CD
	LDA	FPTR2
	STA	L0083
	LDA	FPTR2+1
	STA	L0085
	LDX	#$00
L82DC	LDA	L0600,X
	STA	MIDI_TX_BUFFER,X
	INX
	BNE	L82DC
	RTS
; Resolve facing angle and local obstacle/input flags into the live
; PLAYER_INPUT_STATUS byte for the current player.
L82E6	LDX	L40CB
	LDA	PLAYER_FACING_ANGLE,X
	BEQ	L830E
	CMP	#$18
	BCC	L830E
	CMP	#$38
	BCC	L831A
	CMP	#$58
	BCC	L8311
	CMP	#$78
	BCC	L831D
	CMP	#$98
	BCC	L8314
	CMP	#$B8
	BCC	L8320
	CMP	#$D8
	BCC	L8317
	CMP	#$F8
	BCC	L8323
L830E	JMP	L8326
L8311	JMP	L8357
L8314	JMP	L8388
L8317	JMP	L83B9
L831A	JMP	L83EA
L831D	JMP	L8411
L8320	JMP	L8438
L8323	JMP	L845F
L8326	LDA	L40E7
	BEQ	L833B
	LDA	L3F76,X
	BNE	L8335
	LDA	#$00
	STA	PLAYER_FACING_ANGLE,X
L8335	JSR	L8495
	JMP	L8483
L833B	LDA	L40E8
	BEQ	L8346
	JSR	L853A
	JMP	L8483
L8346	LDA	L40EA
	BEQ	L8351
	JSR	L84AF
	JMP	L8483
L8351	JSR	L85C5
	JMP	L8483
L8357	LDA	L40E8
	BEQ	L836C
	LDA	L3F76,X
	BNE	L8366
	LDA	#$40
	STA	PLAYER_FACING_ANGLE,X
L8366	JSR	L8495
	JMP	L8483
L836C	LDA	L40E7
	BEQ	L8377
	JSR	L84AF
	JMP	L8483
L8377	LDA	L40E9
	BEQ	L8382
	JSR	L853A
	JMP	L8483
L8382	JSR	L85C5
	JMP	L8483
L8388	LDA	L40E9
	BEQ	L839D
	LDA	L3F76,X
	BNE	L8397
	LDA	#$80
	STA	PLAYER_FACING_ANGLE,X
L8397	JSR	L8495
	JMP	L8483
L839D	LDA	L40E8
	BEQ	L83A8
	JSR	L84AF
	JMP	L8483
L83A8	LDA	L40EA
	BEQ	L83B3
	JSR	L853A
	JMP	L8483
L83B3	JSR	L85C5
	JMP	L8483
L83B9	LDA	L40EA
	BEQ	L83CE
	LDA	L3F76,X
	BNE	L83C8
	LDA	#$C0
	STA	PLAYER_FACING_ANGLE,X
L83C8	JSR	L8495
	JMP	L8483
L83CE	LDA	L40E7
	BEQ	L83D9
	JSR	L853A
	JMP	L8483
L83D9	LDA	L40E9
	BEQ	L83E4
	JSR	L84AF
	JMP	L8483
L83E4	JSR	L85C5
	JMP	L8483
L83EA	LDA	L40EC
	BEQ	L83F5
	JSR	L8495
	JMP	L8483
L83F5	LDA	L40E7
	BEQ	L8400
	JSR	L84AF
	JMP	L8483
L8400	LDA	L40E8
	BEQ	L840B
	JSR	L853A
	JMP	L8483
L840B	JSR	L85C5
	JMP	L8483
L8411	LDA	L40EE
	BEQ	L841C
	JSR	L8495
	JMP	L8483
L841C	LDA	L40E8
	BEQ	L8427
	JSR	L84AF
	JMP	L8483
L8427	LDA	L40E9
	BEQ	L8432
	JSR	L853A
	JMP	L8483
L8432	JSR	L85C5
	JMP	L8483
L8438	LDA	L40ED
	BEQ	L8443
	JSR	L8495
	JMP	L8483
L8443	LDA	L40E9
	BEQ	L844E
	JSR	L84AF
	JMP	L8483
L844E	LDA	L40EA
	BEQ	L8459
	JSR	L853A
	JMP	L8483
L8459	JSR	L85C5
	JMP	L8483
L845F	LDA	L40EB
	BEQ	L846A
	JSR	L8495
	JMP	L8483
L846A	LDA	L40EA
	BEQ	L8475
	JSR	L84AF
	JMP	L8483
L8475	LDA	L40E7
	BEQ	L8480
	JSR	L853A
	JMP	L8483
L8480	JSR	L85C5
L8483	RTS
L8484	LDX	L40CB
	LDA	L3F76,X
	BEQ	L8494
	LDA	L3F46,X
	ORA	#$10
	STA	L3F46,X
L8494	RTS
L8495	LDX	L40CB
	LDA	#$01
	STA	L3F46,X
	JSR	L8484
	LDA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	LDA	#$FF
	STA	L3F26,X
	STA	L3F36,X
	RTS
L84AF	LDX	L40CB
	LDA	#$05
	STA	L3F46,X
	JSR	L8484
	LDA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	LDA	L40F3
	CMP	#$C0
	BEQ	L850D
	CMP	#$04
	BEQ	L84DF
	CMP	#$03
	BEQ	L84D6
	CMP	#$01
	BEQ	L8504
	JMP	L84FF
L84D6	LDX	L40CB
	LDA	PLAYER_Y_LO,X
	JMP	L84E5
L84DF	LDX	L40CB
	LDA	PLAYER_X_LO,X
L84E5	LDY	#$05
	CMP	#$C0
	BEQ	L8530
	DEY
	CMP	#$A0
	BEQ	L8530
	DEY
	CMP	#$80
	BEQ	L8530
	DEY
	CMP	#$60
	BEQ	L8530
	DEY
	CMP	#$40
	BEQ	L8530
L84FF	LDY	#$03
	JMP	L8530
L8504	LDX	L40CB
	LDA	PLAYER_Y_LO,X
	JMP	L8513
L850D	LDX	L40CB
	LDA	PLAYER_X_LO,X
L8513	LDY	#$05
	CMP	#$40
	BEQ	L8530
	DEY
	CMP	#$60
	BEQ	L8530
	DEY
	CMP	#$80
	BEQ	L8530
	DEY
	CMP	#$A0
	BEQ	L8530
	DEY
	CMP	#$C0
	BEQ	L8530
	JMP	L84FF
L8530	TYA
	STA	L3F26,X
	LDA	#$FF
	STA	L3F36,X
	RTS
L853A	LDX	L40CB
	LDA	#$09
	STA	L3F46,X
	JSR	L8484
	LDA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	LDA	L40F3
	CMP	#$C0
	BEQ	L856A
	CMP	#$04
	BEQ	L8598
	CMP	#$03
	BEQ	L858F
	CMP	#$01
	BEQ	L8561
	JMP	L858A
L8561	LDX	L40CB
	LDA	PLAYER_Y_LO,X
	JMP	L8570
L856A	LDX	L40CB
	LDA	PLAYER_X_LO,X
L8570	LDY	#$05
	CMP	#$C0
	BEQ	L85BB
	DEY
	CMP	#$A0
	BEQ	L85BB
	DEY
	CMP	#$80
	BEQ	L85BB
	DEY
	CMP	#$60
	BEQ	L85BB
	DEY
	CMP	#$40
	BEQ	L85BB
L858A	LDY	#$03
	JMP	L85BB
L858F	LDX	L40CB
	LDA	PLAYER_Y_LO,X
	JMP	L859E
L8598	LDX	L40CB
	LDA	PLAYER_X_LO,X
L859E	LDY	#$05
	CMP	#$40
	BEQ	L85BB
	DEY
L85A5	CMP	#$60
	BEQ	L85BB
	DEY
	CMP	#$80
	BEQ	L85BB
	DEY
	CMP	#$A0
	BEQ	L85BB
	DEY
	CMP	#$C0
	BEQ	L85BB
	JMP	L858A
L85BB	TYA
	STA	L3F26,X
	LDA	#$FF
	STA	L3F36,X
	RTS
L85C5	LDY	#$0F
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDA	#$00
	STA	L40F3
	LDA	L40DC
	BEQ	L85DD
	LDA	#$01
	STA	L40F3
L85DD	LDA	L40DD
	BEQ	L85EB
	LDA	L40F3
	CLC
	ADC	#$02
	STA	L40F3
L85EB	LDA	L40DE
	BEQ	L85F9
	LDA	L40F3
	CLC
	ADC	#$04
	STA	L40F3
L85F9	LDA	L40DF
	BEQ	L8607
	LDA	L40F3
	CLC
	ADC	#$08
	STA	L40F3
L8607	LDA	L40F3
	CMP	#$0F
	BEQ	L863C
	CMP	#$0D
	BEQ	L864C
	CMP	#$0C
	BEQ	L865C
	CMP	#$07
	BEQ	L862D
	CMP	#$05
	BEQ	L8630
	CMP	#$04
	BEQ	L8633
	CMP	#$03
	BEQ	L8636
	CMP	#$01
	BEQ	L8639
	JMP	L878D
L862D	JMP	L868C
L8630	JMP	L86E2
L8633	JMP	L86FA
L8636	JMP	L872A
L8639	JMP	L875A
L863C	LDA	L40E7
	BEQ	L8644
	JMP	L86A4
L8644	LDA	L40EA
	BEQ	L86B0
	JMP	L86AD
L864C	LDA	L40EA
	BEQ	L8654
	JMP	L86AD
L8654	LDA	L40E9
	BEQ	L86B0
	JMP	L86A7
L865C	LDA	L40E7
	BEQ	L8674
	LDX	L40CB
	LDA	#$07
	STA	L3F36,X
	LDA	#$08
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L86A4
L8674	LDA	L40E9
	BEQ	L86B0
	LDX	L40CB
	LDA	#$07
	STA	L3F36,X
	LDA	#$04
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L86A7
L868C	LDA	L40E7
	BEQ	L8694
	JMP	L86A4
L8694	LDA	L40E8
	BEQ	L869C
	JMP	L86AA
L869C	LDA	L40E9
	BEQ	L86B0
	JMP	L86A7
L86A4	JMP	L878D
L86A7	JMP	L878D
L86AA	JMP	L878D
L86AD	JMP	L878D
L86B0	LDA	#$00
	JSR	L8A54
	JSR	L8AAD
	JSR	L8796
	LDY	L40CA
	LDA	L90C1,Y
	STA	L40F6
	JSR	L88B8
	LDX	L40CB
	LDA	L40F5
	STA	L3F36,X
	LDA	L40F4
	STA	L3F46,X
	JSR	L8484
	LDA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L878D
L86E2	LDA	L40E8
	BEQ	L86EA
	JMP	L86AA
L86EA	LDA	L40E9
	BEQ	L86F2
	JMP	L86A7
L86F2	LDA	L40EA
	BEQ	L86B0
	JMP	L86AD
L86FA	LDA	L40E7
	BEQ	L8712
	LDX	L40CB
	LDA	#$07
	STA	L3F36,X
	LDA	#$04
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L86A4
L8712	LDA	L40E9
	BEQ	L86B0
	LDX	L40CB
	LDA	#$07
	STA	L3F36,X
	LDA	#$08
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L86A7
L872A	LDA	L40EA
	BEQ	L8742
	LDX	L40CB
	LDA	#$07
	STA	L3F36,X
	LDA	#$04
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L86AD
L8742	LDA	L40E8
	BEQ	L878A
	LDX	L40CB
	LDA	#$07
	STA	L3F36,X
	LDA	#$08
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L86AA
L875A	LDA	L40EA
	BEQ	L8772
	LDX	L40CB
	LDA	#$07
	STA	L3F36,X
	LDA	#$08
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L86AD
L8772	LDA	L40E8
	BEQ	L878A
	LDX	L40CB
	LDA	#$07
	STA	L3F36,X
	LDA	#$04
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	JMP	L86AA
L878A	JMP	L86B0
L878D	LDX	L40CB
	LDA	#$FF
	STA	L3F26,X
	RTS
L8796	LDY	L40CA
	LDA	L90B9,Y
	TAY
	STA	L40CA
	LDA	L90A1,Y
	STA	L40F9
	RTS
L87A7	JSR	L89EC
	LDX	L40CB
	LDA	PLAYER_X_HI,X
	STA	L00A6
	LDA	PLAYER_Y_HI,X
	STA	L00A7
	JSR	LAD00
	TXA
	STA	L40CD
	JSR	L8867
	RTS
L87C2	LDX	L40CB
	LDA	PLAYER_X_LO,X
	CLC
	ADC	#$20
	STA	PLAYER_X_LO,X
	STA	L401A,X
	LDY	#$06
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDX	L40CB
	LDA	PLAYER_X_LO,X
	CMP	L401A,X
	BNE	L87E8
	JMP	L8854
L87E8	LDA	PLAYER_Y_LO,X
	CLC
	ADC	#$20
	STA	PLAYER_Y_LO,X
	STA	L405A,X
	LDY	#$06
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDX	L40CB
	LDA	PLAYER_Y_LO,X
	CMP	L405A,X
	BNE	L880B
	JMP	L8854
L880B	LDA	PLAYER_X_LO,X
	SEC
	SBC	#$20
	STA	PLAYER_X_LO,X
	BPL	L881E
	EOR	#$FF
	SEC
	ADC	#$00
	STA	PLAYER_X_LO,X
L881E	STA	L401A,X
	LDY	#$06
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDA	PLAYER_X_LO,X
	CMP	L401A,X
	BNE	L8835
	JMP	L8854
L8835	LDA	PLAYER_Y_LO,X
	SEC
	SBC	#$20
	STA	PLAYER_Y_LO,X
	BPL	L8848
	EOR	#$FF
	SEC
	ADC	#$00
	STA	PLAYER_Y_LO,X
L8848	STA	L405A,X
	LDY	#$06
	LDX	#$80
	LDA	#$01
	JSR	LAF41
L8854	RTS
	.byte	$AD
L8856	SBX	#$40	; (undocumented opcode)
	STA	MAZE_LINK_PLAYER_INDEX
	JSR	LAD6F
	LDX	MAZE_LINK_PLAYER_INDEX
	LDA	#$FF
	STA	MAZE_CELL_PLAYER_NEXT,X
	RTS
L8867	LDA	#$01
	BIT	L40CD
	BNE	L8871
	STA	L40E7
L8871	LDA	#$02
	BIT	L40CD
	BNE	L887B
	STA	L40E8
L887B	LDA	#$04
	BIT	L40CD
	BNE	L8885
	STA	L40E9
L8885	LDA	#$08
	BIT	L40CD
	BNE	L888F
	STA	L40EA
L888F	LDA	#$10
	BIT	L40CD
	BNE	L8899
	STA	L40EB
L8899	LDA	#$20
	BIT	L40CD
	BNE	L88A3
	STA	L40EC
L88A3	LDA	#$40
	BIT	L40CD
	BNE	L88AD
	STA	L40ED
L88AD	LDA	#$80
	BIT	L40CD
	BNE	L88B7
	STA	L40EE
L88B7	RTS
L88B8	LDA	#$11
	STA	L40EF
	STA	L40F4
	LDA	#$00
	STA	L40F0
	LDX	L40CB
	LDA	PLAYER_FACING_ANGLE,X
	STA	L40F7
	LDA	L40F9
	CMP	#$FF
	BNE	L88DA
	LDY	#$00
	JMP	L88F0
L88DA	LDA	L40F6
	CLC
	ADC	L40F7
	TAY
	LDA	L8FA1,Y
	STA	L40F5
	INY
	LDA	L8FA1,Y
	STA	L40F4
	RTS
L88F0	LDA	L40E7,Y
	BNE	L88FD
L88F5	INY
	CPY	#$04
	BCS	L8975
	JMP	L88F0
L88FD	CPY	#$00
	BEQ	L8910
	CPY	#$01
	BEQ	L891B
	CPY	#$02
	BEQ	L8928
	CPY	#$03
	BEQ	L8935
	JMP	L8975
L8910	LDA	#$00
	STA	L40F6
	STA	L40F9
	JMP	L893F
L891B	LDA	#$02
	STA	L40F6
	LDA	#$40
	STA	L40F9
	JMP	L893F
L8928	LDA	#$04
	STA	L40F6
	LDA	#$80
	STA	L40F9
	JMP	L893F
L8935	LDA	#$06
	STA	L40F6
	LDA	#$C0
	STA	L40F9
L893F	LDA	L40F7
	CLC
	ADC	L40F6
	TAX
	LDA	L8FA1,X
	BNE	L894F
	JMP	L88F5
L894F	CMP	L40EF
	BCS	L8961
	STA	L40EF
	INX
	LDA	L8FA1,X
	STA	L40F4
	JMP	L88F5
L8961	CMP	L40F0
	BCC	L88F5
	BEQ	L88F5
	STA	L40F0
	INX
	LDA	L8FA1,X
	STA	L40F4
	JMP	L88F5
L8975	LDA	L40EF
	STA	L40F5
	RTS
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$FC
	.byte	$40 ; '@'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$CD
	.byte	$FB
	.byte	$40 ; '@'
	.byte	$90
	.byte	$06 ; Screen code for '&'
	.byte	$ED
	.byte	$FB
	.byte	$40 ; '@'
	.byte	$EE
	.byte	$FC
	.byte	$40 ; '@'
	.byte	$CA
	.byte	$D0
	.byte	$EE
	.byte	$8D
	.byte	$FD
	.byte	$40 ; '@'
	.byte	$60
L8996	LDA	#$FF
	LDX	L40CB
	STA	L401A,X
	STA	L403A,X
	STA	L405A,X
	STA	L407A,X
	RTS
; Replay pending transient input/status timers for the current player. Returns
; L40CA nonzero when a timer-fed status byte was emitted.
L89A8	LDX	L40CB
	LDA	L3F76,X
	BNE	L89E6
	LDA	L3F26,X
	CMP	#$FF
	BEQ	L89C8
	LDX	L40CB
	LDA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	DEC	L3F26,X
	BMI	L89E3
	JMP	L89DD
L89C8	LDX	L40CB
	LDA	L3F36,X
	CMP	#$FF
	BEQ	L89E6
	LDA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	DEC	L3F36,X
	BMI	L89E3
L89DD	LDA	#$01
	STA	L40CA
	RTS
L89E3	JSR	L8A3E
L89E6	LDA	#$00
	STA	L40CA
	RTS
L89EC	LDA	#$00
	STA	L40E7
	STA	L40E8
	STA	L40E9
	STA	L40EA
	STA	L40EB
	STA	L40EC
	STA	L40ED
	STA	L40EE
	RTS
L8A07	LDX	L40CB
	LDA	#$00
	STA	L3F66,X
	STA	L3F46,X
	STA	L3F76,X
	STA	PLAYER_INPUT_STATUS,X
	LDA	#$FF
	STA	L3F26,X
	STA	L3F36,X
	STA	L3F86,X
	STA	L3FA6,X
	JSR	L8996
	RTS
	.byte	$AE
L8A2B	SBX	#$40	; (undocumented opcode)
	LDA	#$FF
	STA	L3F26,X
	STA	L3F36,X
	LDA	#$00
	STA	L3F76,X
	STA	L3FA6,X
	RTS
L8A3E	LDX	L40CB
	LDA	L3F76,X
	BNE	L8A53
	LDA	#$FF
	STA	L3F36,X
	STA	L3F26,X
	LDA	#$00
	JSR	L8996
L8A53	RTS
L8A54	LDX	L40CB
	LDY	#$00
	CMP	#$FF
	BEQ	L8A85
	LDA	PLAYER_FACING_ANGLE,X
	LDY	#$00
L8A62	CMP	L90A1,Y
	BEQ	L8A71
	INY
	CPY	#$08
	BCC	L8A62
	LDY	#$00
	JMP	L8A76
L8A71	TYA
L8A72	STA	L40CA
	RTS
L8A76	CMP	L90A9,Y
	BCC	L8A71
	INY
	CPY	#$08
	BCC	L8A76
	LDA	#$00
	JMP	L8A72
L8A85	LDA	L90A9,Y
	CLC
	ADC	#$10
	CMP	PLAYER_FACING_ANGLE,X
	BCC	L8A9C
	TYA
	CLC
	ADC	#$02
	TAY
	CPY	#$08
	BCC	L8A85
	JMP	L8A72
L8A9C	TYA
	JMP	L8A72
	.byte	$AC
	.byte	$CA
	.byte	$40 ; '@'
	.byte	$AE
	.byte	$CB
	.byte	$40 ; '@'
	.byte	$B9
	.byte	$A1
	.byte	$90
	.byte	$9D
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$60
L8AAD	LDY	L40CA
	LDA	L90B1,Y
	TAY
	LDA	#$00
	STA	L40E7,Y
	RTS
L8ABA	JSR	L89EC
	JSR	L87A7
	LDA	L3F26,X
	CMP	#$FF
	BEQ	L8ACA
	JMP	L8B4D
L8ACA	LDA	L3F36,X
	CMP	#$FF
	BEQ	L8AD4
	JMP	L8B4D
L8AD4	LDX	L40CB
	LDA	PLAYER_FACING_ANGLE,X
	BNE	L8ADF
	JMP	L8AF7
L8ADF	CMP	#$40
	BNE	L8AE6
	JMP	L8B50
L8AE6	CMP	#$80
	BNE	L8AED
	JMP	L8BA6
L8AED	CMP	#$C0
	BNE	L8AF4
	JMP	L8BFC
L8AF4	JMP	L8C52
L8AF7	LDA	L40E7
	BNE	L8B09
	LDA	L40EA
	BNE	L8B45
L8B01	LDA	L40E8
	BNE	L8B29
	JMP	L8C52
L8B09	LDA	L40EA
	BEQ	L8B01
	LDA	L40E8
	BNE	L8B16
	JMP	L8B37
L8B16	JSR	L8C6B
	LDA	L40CA
	BNE	L8B21
	JMP	L8C52
L8B21	JSR	L8C6B
	LDA	L40CA
	BEQ	L8B37
L8B29	LDA	#$00
	STA	L40E7
	STA	L40EA
	INC	L40E8
	JMP	L8C52
L8B37	LDA	#$00
	STA	L40E7
	STA	L40E8
	INC	L40EA
	JMP	L8C52
L8B45	LDA	L40E8
	BNE	L8B21
	JMP	L8B37
L8B4D	JMP	L8C52
L8B50	LDA	L40E8
	BNE	L8B62
	LDA	L40E7
	BNE	L8B9E
L8B5A	LDA	L40E9
	BNE	L8B82
	JMP	L8C52
L8B62	LDA	L40E7
	BEQ	L8B5A
	LDA	L40E9
	BNE	L8B6F
	JMP	L8B90
L8B6F	JSR	L8C6B
	LDA	L40CA
	BNE	L8B7A
	JMP	L8C52
L8B7A	JSR	L8C6B
	LDA	L40CA
	BEQ	L8B90
L8B82	LDA	#$00
	STA	L40E8
	STA	L40E7
	INC	L40E9
	JMP	L8C52
L8B90	LDA	#$00
	STA	L40E8
	STA	L40E9
	INC	L40E7
	JMP	L8C52
L8B9E	LDA	L40E9
	BNE	L8B7A
	JMP	L8B90
L8BA6	LDA	L40E9
	BNE	L8BB8
	LDA	L40EA
	BNE	L8BF4
L8BB0	LDA	L40E8
	BNE	L8BD8
	JMP	L8C52
L8BB8	LDA	L40EA
	BEQ	L8BB0
	LDA	L40E8
	BNE	L8BC5
	JMP	L8C52
L8BC5	JSR	L8C6B
	LDA	L40CA
	BNE	L8BD0
	JMP	L8C52
L8BD0	JSR	L8C6B
	LDA	L40CA
	BEQ	L8BE6
L8BD8	LDA	#$00
	STA	L40E9
	STA	L40EA
	INC	L40E8
	JMP	L8C52
L8BE6	LDA	#$00
	STA	L40E9
	STA	L40E8
	INC	L40EA
	JMP	L8C52
L8BF4	LDA	L40E8
	BNE	L8BD0
	JMP	L8BE6
L8BFC	LDA	L40EA
	BNE	L8C0E
	LDA	L40E7
	BNE	L8C4A
L8C06	LDA	L40E9
	BNE	L8C2E
	JMP	L8C52
L8C0E	LDA	L40E7
	BEQ	L8C06
	LDA	L40E9
	BNE	L8C1B
	JMP	L8C3C
L8C1B	JSR	L8C6B
	LDA	L40CA
	BNE	L8C26
	JMP	L8C52
L8C26	JSR	L8C6B
	LDA	L40CA
	BEQ	L8C3C
L8C2E	LDA	#$00
	STA	L40EA
	STA	L40E7
	INC	L40E9
	JMP	L8C52
L8C3C	LDA	#$00
	STA	L40EA
	STA	L40E9
	INC	L40E7
	JMP	L8C52
L8C4A	LDA	L40E9
	BNE	L8C26
	JMP	L8C3C
L8C52	RTS
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$08 ; Screen code for '('
	.byte	$4E ; 'N'
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$90
	.byte	$04 ; Screen code for '$'
	.byte	$18 ; Screen code for '8'
	.byte	$6D ; 'm'
	.byte	$FF
	.byte	$40 ; '@'
	.byte	$4A ; 'J'
	.byte	$6E ; 'n'
	.byte	$01 ; Screen code for '!'
	.byte	$41 ; 'A'
	.byte	$CA
	.byte	$D0
	.byte	$F0
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$41 ; 'A'
	.byte	$60
L8C6B	LDA	#$32
	JSR	LAEB0
	AND	#$01
	STA	L40CA
	RTS
; Choose or maintain the current target player, then adjust firing/facing state.
; Team play builds an exclusion list from PLAYER_TEAM_INDEX before distance checks.
L8C76	LDX	L40CB
	LDA	PLAYER_HIT_FLAG,X
	BEQ	L8C95
	LDY	PLAYER_HIT_BY_INDEX,X
	LDA	PLAYER_STATE,Y
	BEQ	L8C95
	LDX	L40CB
	LDA	PLAYER_HIT_BY_INDEX,X
	STA	L3F86,X
	STA	L40CF
	JMP	L8C98
L8C95	JMP	L8CA6
L8C98	JSR	L8F51
	LDX	L40CB
	LDA	L3F76,X
	BEQ	L8CA6
	JMP	L8E6B
L8CA6	LDA	SETUP_TEAM_PLAY_FLAG
	BNE	L8CAE
	JMP	L8CDB
L8CAE	LDX	L40CB
	LDA	PLAYER_TEAM_INDEX,X
	STA	L4103
	LDX	#$00
	LDY	#$00
	LDA	#$FF
	STA	L4119,Y
L8CC0	LDA	PLAYER_TEAM_INDEX,X
	CMP	L4103
	BEQ	L8CD2
	TXA
	STA	L4119,Y
	INY
	LDA	#$FF
	STA	L4119,Y
L8CD2	INX
	CPX	TOTAL_PLAYER_COUNT
	BCC	L8CC0
	JMP	L8D3A
L8CDB	LDA	#$FF
	STA	L40EF
	LDA	#$00
	STA	L40F1
	STA	L40F2
	LDX	L40F1
	LDY	L40F2
	LDA	#$FF
	STA	L4119,X
L8CF3	CPX	L40CB
	BEQ	L8D2F
	LDA	PLAYER_BOT_TYPE,X
	CMP	#$01
	BNE	L8D05
	TXA
	CMP	L3FA6,X
	BEQ	L8D2F
L8D05	LDA	L40F1
	STA	L40CF
	JSR	L8F51
	LDX	L40CB
	LDA	L3F76,X
	BEQ	L8D2F
	LDA	#$00
	STA	L3F76,X
	LDA	L40CF
	LDY	L40F2
	STA	L4119,Y
	INC	L40F2
	LDA	#$FF
	LDY	L40F2
	STA	L4119,Y
L8D2F	INC	L40F1
	LDX	L40F1
	CPX	TOTAL_PLAYER_COUNT
	BCC	L8CF3
L8D3A	LDA	L4119
	CMP	#$FF
	BNE	L8D4A
	LDX	L40CB
	STA	L3F86,X
	JMP	L8F42
L8D4A	STA	L40EF
	LDX	L40CB
	LDY	L40EF
	LDA	PLAYER_X_LO,X
	SEC
	SBC	PLAYER_X_LO,Y
	STA	L4111
	LDA	PLAYER_X_HI,X
	SBC	PLAYER_X_HI,Y
	STA	L4112
	BPL	L8D7D
	LDA	L4111
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L4111
	LDA	L4112
	EOR	#$FF
	ADC	#$00
	STA	L4112
L8D7D	LDA	PLAYER_Y_LO,X
	SEC
	SBC	PLAYER_Y_LO,Y
	STA	L4113
	LDA	PLAYER_Y_HI,X
	SBC	PLAYER_Y_HI,Y
	STA	L4114
	BPL	L8DA7
	LDA	L4113
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L4113
	LDA	L4114
	EOR	#$FF
	ADC	#$00
	STA	L4114
L8DA7	LDX	L40CB
	LDA	#$01
	STA	L40CE
	LDY	L40CE
L8DB2	LDA	L4119,Y
	CMP	#$FF
	BNE	L8DBC
	JMP	L8E62
L8DBC	TAY
	LDX	L40CB
	LDA	PLAYER_X_LO,X
	SEC
	SBC	PLAYER_X_LO,Y
	STA	L4115
	LDA	PLAYER_X_HI,X
	SBC	PLAYER_X_HI,Y
	STA	L4116
	BPL	L8DEA
	LDA	L4115
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L4115
	LDA	L4116
	EOR	#$FF
	ADC	#$00
	STA	L4116
L8DEA	LDA	PLAYER_Y_LO,X
	SEC
	SBC	PLAYER_Y_LO,Y
	STA	L4117
	LDA	PLAYER_Y_HI,X
	SBC	PLAYER_Y_HI,Y
	STA	L4118
	BPL	L8E14
	LDA	L4117
	EOR	#$FF
	SEC
	ADC	#$00
	STA	L4113
	LDA	L4114
	EOR	#$FF
	ADC	#$00
	STA	L4114
L8E14	LDA	L4111
	SEC
	SBC	L4115
	LDA	L4112
	SBC	L4116
	BCS	L8E26
	JMP	L8E59
L8E26	LDA	L4113
	SEC
	SBC	L4117
	LDA	L4114
	SBC	L4118
	BCS	L8E38
	JMP	L8E59
L8E38	LDA	L4115
	STA	L4111
	LDA	L4116
	STA	L4112
	LDA	L4113
	STA	L4117
	LDA	L4114
	STA	L4118
	LDY	L40CE
	LDA	L4119,Y
	STA	L40EF
L8E59	INC	L40CE
	LDY	L40CE
	JMP	L8DB2
L8E62	LDA	L40EF
	LDX	L40CB
	STA	L3F86,X
L8E6B	LDX	L40CB
	LDA	L3F86,X
	STA	L40CF
	STA	L40D1
	JSR	L8F6C
	STA	L40D0
	LDX	L40CB
	LDA	PLAYER_BOT_TYPE,X
	BEQ	L8EA0
	LDA	PLAYER_BOT_TYPE,X
	CMP	#$03
	BEQ	L8EF8
	CMP	#$01
	BEQ	L8EA3
	CMP	#$02
	BNE	L8EA0
	LDA	#$32
	JSR	LAEB0
	CMP	#$0C
	BCS	L8ED7
	JMP	L8ECE
L8EA0	JMP	L8F50
L8EA3	LDX	L40CB
	LDA	L3FA6,X
	CMP	#$FF
	BEQ	L8EB0
	JMP	L8EC5
L8EB0	LDA	#$32
	JSR	LAEB0
	CMP	#$01
	BCS	L8EC5
	LDX	L40CB
	LDA	L40CF
	STA	L3FA6,X
	JMP	L8EA0
L8EC5	LDA	#$32
	JSR	LAEB0
	CMP	#$1B
	BCS	L8ED7
L8ECE	LDA	L40D0
	CLC
	ADC	#$08
	STA	L40D0
L8ED7	LDX	L40CB
	LDY	L40CF
	LDA	PLAYER_STATE,Y
	BNE	L8EE5
	JMP	L8F42
L8EE5	LDX	L40CB
	LDA	L3FA6,X
	CMP	L40CF
	BNE	L8EF8
	LDA	#$00
	STA	L3F76,X
	JMP	L8F42
L8EF8	LDY	#$09
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	LDX	L40CB
	LDA	L3F76,X
	BNE	L8F0C
	JMP	L8F42
L8F0C	LDA	PROJECTILE_ACTIVE_TIMER,X
	BNE	L8F42
	JMP	L8F14
L8F14	LDX	L40CB
	LDA	L3F76,X
	BEQ	L8F42
	LDX	L40CB
	LDA	L3F46,X
	AND	#$10
	BNE	L8F36
	LDA	#$11
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
	LDA	#$FF
	STA	L3F26,X
	STA	L3F36,X
L8F36	LDX	L40CB
	LDA	L40D0
	STA	PLAYER_FACING_ANGLE,X
	JMP	L8F50
L8F42	LDX	L40CB
	LDA	L3F46,X
	AND	#$EF
	STA	L3F46,X
	STA	PLAYER_INPUT_STATUS,X
L8F50	RTS
L8F51	JSR	L8F6C
	STA	L40D0
	LDY	#$09
	LDX	#$80
	LDA	#$01
	JSR	LAF41
	JMP	L8F6B
	.byte	$AE
L8F64	SBX	#$40	; (undocumented opcode)
	LDA	#$00
	STA	L3F76,X
L8F6B	RTS
; Compute relative angle from current player to candidate target in L40CF.
L8F6C	LDX	L40CB
	LDY	L40CF
	LDA	PLAYER_STATE,Y
	BEQ	L8FA0
	LDA	PLAYER_X_LO,Y
	SEC
	SBC	PLAYER_X_LO,X
	STA	L40E2
	LDA	PLAYER_X_HI,Y
	SBC	PLAYER_X_HI,X
	STA	L40E3
	SEC
	LDA	PLAYER_Y_LO,Y
	SBC	PLAYER_Y_LO,X
	STA	L40E4
	LDA	PLAYER_Y_HI,Y
	SBC	PLAYER_Y_HI,X
	STA	L40E5
	JSR	L9277
L8FA0	RTS
L8FA1	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$10 ; Screen code for '0'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$04 ; Screen code for '$'
	.byte	$07 ; Screen code for '''
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$04 ; Screen code for '$'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$08 ; Screen code for '('
	.byte	$0D ; Screen code for '-'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$0C ; Screen code for ','
	.byte	$08 ; Screen code for '('
	.byte	$0C ; Screen code for ','
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
	.byte	$08 ; Screen code for '('
	.byte	$0D ; Screen code for '-'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$04 ; Screen code for '$'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$04 ; Screen code for '$'
	.byte	$07 ; Screen code for '''
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$04 ; Screen code for '$'
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$10 ; Screen code for '0'
	.byte	$04 ; Screen code for '$'
	.byte	$09 ; Screen code for ')'
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$04 ; Screen code for '$'
	.byte	$07 ; Screen code for '''
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$04 ; Screen code for '$'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$08 ; Screen code for '('
	.byte	$0D ; Screen code for '-'
	.byte	$08 ; Screen code for '('
	.byte	$0C ; Screen code for ','
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$0C ; Screen code for ','
	.byte	$08 ; Screen code for '('
	.byte	$0D ; Screen code for '-'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$04 ; Screen code for '$'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$04 ; Screen code for '$'
	.byte	$07 ; Screen code for '''
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$10 ; Screen code for '0'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$04 ; Screen code for '$'
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$04 ; Screen code for '$'
	.byte	$07 ; Screen code for '''
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$04 ; Screen code for '$'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$0D ; Screen code for '-'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$08 ; Screen code for '('
	.byte	$0C ; Screen code for ','
	.byte	$08 ; Screen code for '('
	.byte	$0C ; Screen code for ','
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
	.byte	$08 ; Screen code for '('
	.byte	$0D ; Screen code for '-'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$04 ; Screen code for '$'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$04 ; Screen code for '$'
	.byte	$07 ; Screen code for '''
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$10 ; Screen code for '0'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$04 ; Screen code for '$'
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$07 ; Screen code for '''
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$04 ; Screen code for '$'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$08 ; Screen code for '('
	.byte	$0D ; Screen code for '-'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$0C ; Screen code for ','
	.byte	$08 ; Screen code for '('
	.byte	$0C ; Screen code for ','
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$08 ; Screen code for '('
	.byte	$0B ; Screen code for '+'
	.byte	$08 ; Screen code for '('
	.byte	$0D ; Screen code for '-'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$04 ; Screen code for '$'
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$0F ; Screen code for '/'
	.byte	$04 ; Screen code for '$'
	.byte	$07 ; Screen code for '''
	.byte	$04 ; Screen code for '$'
; Small math/projection lookup tables.
L90A1	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$40 ; '@'
	.byte	$60
	.byte	$80
	.byte	$A0
	.byte	$C0
	.byte	$E0
L90A9	.byte	$18 ; Screen code for '8'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$58 ; 'X'
	.byte	$78 ; 'x'
	.byte	$98
	.byte	$B8
	.byte	$D8
	.byte	$F8
L90B1	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$01 ; Screen code for '!'
	.byte	$07 ; Screen code for '''
	.byte	$02 ; Screen code for '"'
	.byte	$06 ; Screen code for '&'
	.byte	$03 ; Screen code for '#'
	.byte	$04 ; Screen code for '$'
L90B9	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$06 ; Screen code for '&'
	.byte	$07 ; Screen code for '''
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
L90C1	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
; Fixed-point multiply/divide helpers used by the relative-angle code.
L90C9	LDA	#$00
	STA	L009E
	STA	L009F
	LDX	#$08
L90D1	LSR	L0099
	BCC	L90E2
	CLC
	LDA	L009E
	ADC	L0096
	STA	L009E
	LDA	L009F
	ADC	L0097
	STA	L009F
L90E2	LSR	L009F
	ROR	L009E
	ROR	L009C
	DEX
	BNE	L90D1
	LDX	#$08
L90ED	LSR	L009A
	BCC	L90FE
	CLC
	LDA	L009E
	ADC	L0096
	STA	L009E
	LDA	L009F
	ADC	L0097
	STA	L009F
L90FE	LSR	L009F
	ROR	L009E
	ROR	L009D
	DEX
	BNE	L90ED
	RTS
L9108	SEC
	LDA	L0096
	EOR	#$FF
	ADC	#$00
	STA	L0096
	LDA	L0097
	EOR	#$FF
	ADC	#$00
	STA	L0097
	RTS
L911A	SEC
	LDA	L0099
	EOR	#$FF
	ADC	#$00
	STA	L0099
	LDA	L009A
	EOR	#$FF
	ADC	#$00
	STA	L009A
	RTS
L912C	SEC
	LDA	L40E0
	EOR	#$FF
	ADC	#$00
	STA	L40E0
	LDA	L40E1
	EOR	#$FF
	ADC	#$00
	STA	L40E1
	RTS
L9142	SEC
	LDA	L009C
	EOR	#$FF
	ADC	#$00
	STA	L009C
	LDA	L009D
	EOR	#$FF
	ADC	#$00
	STA	L009D
	RTS
L9154	SEC
	LDA	L009E
	EOR	#$FF
	ADC	#$00
	STA	L009E
	LDA	L009F
	EOR	#$FF
	ADC	#$00
	STA	L009F
	RTS
L9166	LDA	#$00
	STA	L00A0
	LDA	L0097
	BPL	L9173
	INC	L00A0
	JSR	L9108
L9173	LDA	L009A
	BPL	L917C
	INC	L00A0
	JSR	L911A
L917C	LDA	L00A0
	ASL	L00A0
	LSR
	ROR	L00A0
	LDA	L40E1
	BPL	L918D
	INC	L00A0
	JSR	L912C
L918D	JSR	L90C9
	JSR	L91A2
	LDA	L00A0
	BPL	L919A
	JSR	L9154
L919A	ROR	L00A0
	BCC	L91A1
	JSR	L9142
L91A1	RTS
L91A2	ASL	L009C
	ROL	L009D
	ROL	L009E
	ROL	L009F
	LDX	#$08
	SEC
	LDA	L009E
	SBC	L40E0
	STA	L009E
	LDA	L009F
	SBC	L40E1
	STA	L009F
L91BB	LDA	L009F
	BPL	L91DA
	CLC
	ROL	L009D
	ROL	L009E
	ROL	L009F
	CLC
	LDA	L009E
	ADC	L40E0
	STA	L009E
	LDA	L009F
	ADC	L40E1
	STA	L009F
	DEX
	BNE	L91BB
	BEQ	L91F3
L91DA	SEC
	ROL	L009D
	ROL	L009E
	ROL	L009F
	SEC
	LDA	L009E
	SBC	L40E0
	STA	L009E
	LDA	L009F
	SBC	L40E1
	STA	L009F
	DEX
	BNE	L91BB
L91F3	LDX	#$08
L91F5	LDA	L009F
	BPL	L9214
	CLC
	ROL	L009C
	ROL	L009E
	ROL	L009F
	CLC
	LDA	L009E
	ADC	L40E0
	STA	L009E
	LDA	L009F
	ADC	L40E1
	STA	L009F
	DEX
	BNE	L91F5
	BEQ	L922D
L9214	SEC
	ROL	L009C
	ROL	L009E
	ROL	L009F
	SEC
	LDA	L009E
	SBC	L40E0
	STA	L009E
	LDA	L009F
	SBC	L40E1
	STA	L009F
	DEX
	BNE	L91F5
L922D	CLC
	LDA	L009E
	ADC	L40E0
	STA	L009E
	LDA	L009F
	ADC	L40E1
	LSR
	STA	L009F
	ROR	L009E
	RTS
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$A0
	.byte	$85
	.byte	$9E
	.byte	$85
	.byte	$9F
	.byte	$A5
	.byte	$97
	.byte	$10 ; Screen code for '0'
	.byte	$05 ; Screen code for '%'
	.byte	$E6
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$08 ; Screen code for '('
	.byte	$91
	.byte	$A5
	.byte	$96
	.byte	$85
	.byte	$9C
	.byte	$A5
	.byte	$97
	.byte	$85
	.byte	$9D
	.byte	$A5
	.byte	$A0
	.byte	$F0
	.byte	$04 ; Screen code for '$'
	.byte	$A9
	.byte	$81
	.byte	$85
	.byte	$A0
	.byte	$A5
	.byte	$9A
	.byte	$10 ; Screen code for '0'
	.byte	$05 ; Screen code for '%'
	.byte	$E6
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1A ; Screen code for ':'
	.byte	$91
	.byte	$A5
	.byte	$99
	.byte	$8D
	.byte	$E0
	.byte	$40 ; '@'
	.byte	$A5
	.byte	$9A
	.byte	$8D
	.byte	$E1
	.byte	$40 ; '@'
	.byte	$4C ; 'L'
	.byte	$90
	.byte	$91
; Convert signed X/Y deltas in L40E2-L40E5 into an angle/status byte.
L9277	LDY	#$03
	LDA	L40E3
	BPL	L9295
	SEC
	LDA	L40E2
	EOR	#$FF
	ADC	#$00
	STA	L40E2
	LDA	L40E3
	EOR	#$FF
	ADC	#$00
	STA	L40E3
	LDY	#$01
L9295	LDA	L40E5
	BPL	L92B0
	SEC
	LDA	L40E4
	EOR	#$FF
	ADC	#$00
	STA	L40E4
	LDA	L40E5
	EOR	#$FF
	ADC	#$00
	STA	L40E5
	DEY
L92B0	STY	L40E6
	LDA	#$20
	STA	L0096
	LDA	#$00
	STA	L0097
	LDA	L40E3
	CMP	L40E5
	BMI	L92ED
	BNE	L92CD
	LDA	L40E2
	CMP	L40E4
	BCC	L92ED
L92CD	LDA	L40E4
	STA	L0099
	LDA	L40E5
	STA	L009A
	LDA	L40E2
	STA	L40E0
	LDA	L40E3
	STA	L40E1
	JSR	L9166
	LDX	L009C
	LDA	L932A,X
	BPL	L930E
L92ED	LDA	L40E2
	STA	L0099
	LDA	L40E3
	STA	L009A
	LDA	L40E4
	STA	L40E0
	LDA	L40E5
	STA	L40E1
	JSR	L9166
	LDX	L009C
	SEC
	LDA	#$40
	SBC	L932A,X
L930E	LDX	L40E6
	BEQ	L931F
	DEX
	BEQ	L9325
	DEX
	BEQ	L9326
	SEC
	EOR	#$FF
	ADC	#$80
	RTS
L931F	SEC
	EOR	#$FF
	ADC	#$00
	RTS
L9325	RTS
L9326	SEC
	SBC	#$80
	RTS
; Lookup table used by the preceding adjustment routine.
L932A	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$07 ; Screen code for '''
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$0A ; Screen code for '*'
	.byte	$0C ; Screen code for ','
	.byte	$0D ; Screen code for '-'
	.byte	$0E ; Screen code for '.'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$11 ; Screen code for '1'
	.byte	$12 ; Screen code for '2'
	.byte	$13 ; Screen code for '3'
	.byte	$14 ; Screen code for '4'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$17 ; Screen code for '7'
	.byte	$18 ; Screen code for '8'
	.byte	$19 ; Screen code for '9'
	.byte	$1A ; Screen code for ':'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1C ; Screen code for '<'
	.byte	$1D ; Screen code for '='
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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

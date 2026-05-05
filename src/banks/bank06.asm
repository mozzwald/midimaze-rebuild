	opt h-

	icl "include/atari_os.inc"
	icl "include/hardware.inc"
	icl "include/cartridge.inc"

; Bank 06: switchable 8KB cartridge bank, mapped at $8000-$9FFF.
; Starts by clearing/initializing RAM regions and then branches into data/code.
; Generated Lxxxx symbols are preserved until their meaning is proven.
; Hardware/OS constants are named where confidently identified.
; Bank map (working):
;   $8000-$9FFF  RAM setup and data/code used by fixed-bank entry points.

L0080	= $0080
L00AD	= $00AD
L00AE	= $00AE
L00AF	= $00AF
L00B0	= $00B0
L3000	= $3000
L3100	= $3100
L3200	= $3200
L3300	= $3300
L3400	= $3400
L3500	= $3500
L3600	= $3600
L3700	= $3700
L396F	= $396F
BANK_RETURN	= $AF36
	org $8000
START1	STY	L0080
	LDX	L0080
	LDA	L806B,X
	STA	L396F
	LDX	#$00
	LDA	#$FF
L800E	STA	L3000,X
	STA	L3100,X
	STA	L3200,X
	STA	L3300,X
	STA	L3400,X
	STA	L3500,X
	STA	L3600,X
	STA	L3700,X
	INX
	BNE	L800E
	LDA	#$00
	STA	L00AF
	LDA	#$30
	STA	L00B0
	ASL	L0080
	LDX	L0080
	LDA	L8083,X
	STA	L00AD
	LDA	L8084,X
	STA	L00AE
	LDX	L396F
L8042	LDY	L396F
	BPL	L804B
L8047	LDA	(L00AD),Y
	STA	(L00AF),Y
L804B	DEY
	BPL	L8047
	CLC
	LDA	L00AD
	ADC	L396F
	STA	L00AD
	BCC	L805A
	INC	L00AE
L805A	CLC
	LDA	L00AF
	ADC	#$40
	STA	L00AF
	BCC	L8065
	INC	L00B0
L8065	DEX
	BNE	L8042
	JMP	BANK_RETURN
L806B	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$10 ; Screen code for '0'
	.byte	$0C ; Screen code for ','
	.byte	$0A ; Screen code for '*'
	.byte	$07 ; Screen code for '''
	.byte	$0C ; Screen code for ','
	.byte	$07 ; Screen code for '''
	.byte	$0C ; Screen code for ','
	.byte	$07 ; Screen code for '''
	.byte	$0C ; Screen code for ','
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$07 ; Screen code for '''
L8083	.byte	$B3
L8084	.byte	$80
	.byte	$43 ; 'C'
	.byte	$81
	.byte	$D3
	.byte	$81
	.byte	$D3
	.byte	$82
	.byte	$63 ; 'c'
	.byte	$83
	.byte	$C7
	.byte	$83
	.byte	$F8
	.byte	$83
	.byte	$88
	.byte	$84
	.byte	$B9
	.byte	$84
	.byte	$49 ; 'I'
	.byte	$85
	.byte	$7A ; 'z'
	.byte	$85
	.byte	$0A ; Screen code for '*'
	.byte	$86
	.byte	$3B ; ';'
	.byte	$86
	.byte	$6C ; 'l'
	.byte	$86
	.byte	$9D
	.byte	$86
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$87
	.byte	$BD
	.byte	$87
	.byte	$4D ; 'M'
	.byte	$88
	.byte	$7E
	.byte	$88
	.byte	$AF
	.byte	$88
	.byte	$E0
	.byte	$88
	.byte	$F9
	.byte	$88
	.byte	$09 ; Screen code for ')'
	.byte	$89
	.byte	$09 ; Screen code for ')'
	.byte	$8A
	.byte	$F9
	.byte	$F1
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FA
	.byte	$FC
	.byte	$F3
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FA
	.byte	$F8
	.byte	$F3
	.byte	$FC
	.byte	$F3
	.byte	$F9
	.byte	$F3
	.byte	$F9
	.byte	$F3
	.byte	$F9
	.byte	$F2
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$F8
	.byte	$F3
	.byte	$FC
	.byte	$F6
	.byte	$FC
	.byte	$F6
	.byte	$FC
	.byte	$F6
	.byte	$FA
	.byte	$FA
	.byte	$F8
	.byte	$F4
	.byte	$F6
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F6
	.byte	$FA
	.byte	$FC
	.byte	$F1
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F1
	.byte	$F1
	.byte	$F6
	.byte	$F9
	.byte	$F6
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$F9
	.byte	$F5
	.byte	$F5
	.byte	$F6
	.byte	$FC
	.byte	$F3
	.byte	$FA
	.byte	$79 ; 'y'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$FA
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$E6
	.byte	$FA
	.byte	$FC
	.byte	$F3
	.byte	$DC
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E6
	.byte	$F9
	.byte	$F6
	.byte	$FD
	.byte	$F4
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F4
	.byte	$F7
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FB
	.byte	$FA
	.byte	$FA
	.byte	$FB
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FB
	.byte	$FA
	.byte	$F8
	.byte	$F1
	.byte	$F0
	.byte	$F4
	.byte	$F2
	.byte	$FC
	.byte	$F6
	.byte	$F8
	.byte	$F1
	.byte	$F0
	.byte	$F4
	.byte	$F2
	.byte	$FA
	.byte	$FE
	.byte	$F8
	.byte	$F7
	.byte	$F8
	.byte	$F5
	.byte	$F5
	.byte	$F2
	.byte	$FE
	.byte	$F8
	.byte	$F7
	.byte	$FA
	.byte	$F8
	.byte	$F5
	.byte	$F4
	.byte	$F1
	.byte	$F4
	.byte	$F1
	.byte	$F3
	.byte	$F8
	.byte	$F1
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$FA
	.byte	$FD
	.byte	$F3
	.byte	$FA
	.byte	$F9
	.byte	$F6
	.byte	$FC
	.byte	$F2
	.byte	$FA
	.byte	$F9
	.byte	$F5
	.byte	$F3
	.byte	$FC
	.byte	$F5
	.byte	$F6
	.byte	$FA
	.byte	$F8
	.byte	$F3
	.byte	$F9
	.byte	$F6
	.byte	$FA
	.byte	$FC
	.byte	$F7
	.byte	$FA
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F4
	.byte	$F2
	.byte	$FC
	.byte	$F4
	.byte	$F1
	.byte	$F4
	.byte	$F1
	.byte	$F5
	.byte	$F2
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FB
	.byte	$F8
	.byte	$F5
	.byte	$F5
	.byte	$F2
	.byte	$FD
	.byte	$F2
	.byte	$FB
	.byte	$FA
	.byte	$F8
	.byte	$F1
	.byte	$F0
	.byte	$F4
	.byte	$F2
	.byte	$F9
	.byte	$F3
	.byte	$F8
	.byte	$F1
	.byte	$F0
	.byte	$F4
	.byte	$F2
	.byte	$FA
	.byte	$FE
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FE
	.byte	$FA
	.byte	$FA
	.byte	$FE
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FC
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$FC
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F3
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FA
	.byte	$F8
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F6
	.byte	$FA
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$F9
	.byte	$F5
	.byte	$F2
	.byte	$F8
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F6
	.byte	$F8
	.byte	$F7
	.byte	$FA
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$F9
	.byte	$F5
	.byte	$F6
	.byte	$F9
	.byte	$F2
	.byte	$F8
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F6
	.byte	$FC
	.byte	$F5
	.byte	$F7
	.byte	$FA
	.byte	$FE
	.byte	$F8
	.byte	$F3
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$F8
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FC
	.byte	$F3
	.byte	$FE
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F2
	.byte	$F9
	.byte	$F6
	.byte	$F9
	.byte	$F3
	.byte	$FC
	.byte	$F5
	.byte	$F6
	.byte	$F9
	.byte	$F4
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FF
	.byte	$FE
	.byte	$FC
	.byte	$F5
	.byte	$F6
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$FC
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$71 ; 'q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$F9
	.byte	$F6
	.byte	$79 ; 'y'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B2
	.byte	$79 ; 'y'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$DC
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E6
	.byte	$DC
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E4
	.byte	$F6
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FB
	.byte	$FA
	.byte	$FA
	.byte	$FB
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FB
	.byte	$FA
	.byte	$F8
	.byte	$71 ; 'q'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$B0
	.byte	$F2
	.byte	$FA
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$C4
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$E6
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$60
	.byte	$B3
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$D8
	.byte	$E4
	.byte	$50 ; 'P'
	.byte	$A2
	.byte	$D8
	.byte	$E4
	.byte	$D4
	.byte	$E2
	.byte	$D8
	.byte	$C0
	.byte	$C4
	.byte	$E2
	.byte	$FC
	.byte	$71 ; 'q'
	.byte	$10 ; Screen code for '0'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$B2
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$FA
	.byte	$F9
	.byte	$D4
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$C4
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$10 ; Screen code for '0'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B2
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$79 ; 'y'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$D8
	.byte	$C0
	.byte	$C0
	.byte	$C4
	.byte	$E0
	.byte	$D0
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
	.byte	$C0
	.byte	$C4
	.byte	$E2
	.byte	$FA
	.byte	$FE
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FA
	.byte	$D8
	.byte	$E2
	.byte	$FE
	.byte	$FA
	.byte	$FD
	.byte	$F2
	.byte	$FC
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F4
	.byte	$F4
	.byte	$F6
	.byte	$FC
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$F9
	.byte	$F5
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$F8
	.byte	$F5
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F5
	.byte	$F2
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$F8
	.byte	$F5
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F5
	.byte	$F2
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FF
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F5
	.byte	$F6
	.byte	$FD
	.byte	$71 ; 'q'
	.byte	$B1
	.byte	$F5
	.byte	$71 ; 'q'
	.byte	$B1
	.byte	$F7
	.byte	$F9
	.byte	$D4
	.byte	$E0
	.byte	$F1
	.byte	$D0
	.byte	$E4
	.byte	$F3
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$F8
	.byte	$F5
	.byte	$F4
	.byte	$F0
	.byte	$F4
	.byte	$F5
	.byte	$F2
	.byte	$FC
	.byte	$F1
	.byte	$F3
	.byte	$FE
	.byte	$F9
	.byte	$F1
	.byte	$F6
	.byte	$F9
	.byte	$F2
	.byte	$FC
	.byte	$F5
	.byte	$F6
	.byte	$F8
	.byte	$F3
	.byte	$FE
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F6
	.byte	$FE
	.byte	$F9
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$79 ; 'y'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$B3
	.byte	$FA
	.byte	$F8
	.byte	$50 ; 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$E4
	.byte	$50 ; 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$F2
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$F8
	.byte	$50 ; 'P'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$71 ; 'q'
	.byte	$10 ; Screen code for '0'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$A0
	.byte	$F2
	.byte	$FA
	.byte	$D8
	.byte	$E6
	.byte	$D8
	.byte	$C4
	.byte	$E2
	.byte	$D8
	.byte	$C4
	.byte	$E2
	.byte	$DC
	.byte	$E2
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$B0
	.byte	$F1
	.byte	$F6
	.byte	$79 ; 'y'
	.byte	$B0
	.byte	$70 ; 'p'
	.byte	$B3
	.byte	$FC
	.byte	$F1
	.byte	$70 ; 'p'
	.byte	$B2
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$90
	.byte	$E2
	.byte	$D8
	.byte	$60
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$A0
	.byte	$D4
	.byte	$40 ; '@'
	.byte	$A2
	.byte	$78 ; 'x'
	.byte	$B2
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$E4
	.byte	$50 ; 'P'
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$A0
	.byte	$F3
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$90
	.byte	$60
	.byte	$10 ; Screen code for '0'
	.byte	$A2
	.byte	$F9
	.byte	$50 ; 'P'
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$FC
	.byte	$50 ; 'P'
	.byte	$80
	.byte	$E6
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$A0
	.byte	$F6
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$DC
	.byte	$E4
	.byte	$F5
	.byte	$D4
	.byte	$E4
	.byte	$F5
	.byte	$F5
	.byte	$D4
	.byte	$E4
	.byte	$F5
	.byte	$D4
	.byte	$E6
	.byte	$FB
	.byte	$FD
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$F8
	.byte	$F5
	.byte	$70 ; 'p'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$79 ; 'y'
	.byte	$B2
	.byte	$F8
	.byte	$F3
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$D4
	.byte	$E2
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$10 ; Screen code for '0'
	.byte	$80
	.byte	$60
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$F8
	.byte	$D4
	.byte	$C0
	.byte	$E6
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$E2
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$90
	.byte	$E6
	.byte	$FA
	.byte	$DC
	.byte	$E4
	.byte	$D4
	.byte	$C4
	.byte	$E4
	.byte	$F5
	.byte	$F6
	.byte	$F9
	.byte	$F5
	.byte	$71 ; 'q'
	.byte	$B1
	.byte	$F1
	.byte	$71 ; 'q'
	.byte	$B1
	.byte	$F1
	.byte	$F1
	.byte	$F1
	.byte	$F1
	.byte	$F7
	.byte	$F8
	.byte	$F5
	.byte	$D4
	.byte	$E2
	.byte	$FA
	.byte	$D8
	.byte	$E6
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$FC
	.byte	$F1
	.byte	$71 ; 'q'
	.byte	$B0
	.byte	$F6
	.byte	$F8
	.byte	$F1
	.byte	$F4
	.byte	$F4
	.byte	$F0
	.byte	$D0
	.byte	$E6
	.byte	$F9
	.byte	$F2
	.byte	$58 ; 'X'
	.byte	$A0
	.byte	$F1
	.byte	$F2
	.byte	$FA
	.byte	$F9
	.byte	$F5
	.byte	$F6
	.byte	$FC
	.byte	$F3
	.byte	$FA
	.byte	$FC
	.byte	$D0
	.byte	$E2
	.byte	$FA
	.byte	$FC
	.byte	$F0
	.byte	$F6
	.byte	$FB
	.byte	$F9
	.byte	$F1
	.byte	$F6
	.byte	$F8
	.byte	$F5
	.byte	$F6
	.byte	$78 ; 'x'
	.byte	$B0
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$70 ; 'p'
	.byte	$B2
	.byte	$FC
	.byte	$F3
	.byte	$F8
	.byte	$F5
	.byte	$F5
	.byte	$D4
	.byte	$E4
	.byte	$F7
	.byte	$FD
	.byte	$F1
	.byte	$D4
	.byte	$E0
	.byte	$F7
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$F9
	.byte	$F0
	.byte	$F7
	.byte	$FA
	.byte	$D8
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E4
	.byte	$F2
	.byte	$F8
	.byte	$F5
	.byte	$F2
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B1
	.byte	$71 ; 'q'
	.byte	$B1
	.byte	$F3
	.byte	$FA
	.byte	$FA
	.byte	$F9
	.byte	$F6
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$F8
	.byte	$F2
	.byte	$FE
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$DC
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E4
	.byte	$D4
	.byte	$E4
	.byte	$F6
	.byte	$FC
	.byte	$F5
	.byte	$D4
	.byte	$E6
	.byte	$79 ; 'y'
	.byte	$B1
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F1
	.byte	$F3
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$FA
	.byte	$FA
	.byte	$D8
	.byte	$60
	.byte	$90
	.byte	$C4
	.byte	$E2
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$D8
	.byte	$E0
	.byte	$F5
	.byte	$70 ; 'p'
	.byte	$B2
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$90
	.byte	$60
	.byte	$B2
	.byte	$FA
	.byte	$FA
	.byte	$DC
	.byte	$C4
	.byte	$E2
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$FC
	.byte	$F4
	.byte	$F5
	.byte	$F5
	.byte	$F4
	.byte	$D4
	.byte	$E6
	.byte	$F9
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F3
	.byte	$F9
	.byte	$F5
	.byte	$F3
	.byte	$F9
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FC
	.byte	$F1
	.byte	$F6
	.byte	$F8
	.byte	$F4
	.byte	$F3
	.byte	$FC
	.byte	$F2
	.byte	$F8
	.byte	$F1
	.byte	$F6
	.byte	$F8
	.byte	$F1
	.byte	$F4
	.byte	$F5
	.byte	$F0
	.byte	$F7
	.byte	$FC
	.byte	$F1
	.byte	$70 ; 'p'
	.byte	$B2
	.byte	$FC
	.byte	$F3
	.byte	$FA
	.byte	$FC
	.byte	$F1
	.byte	$F5
	.byte	$F2
	.byte	$F9
	.byte	$F5
	.byte	$F2
	.byte	$DC
	.byte	$E0
	.byte	$F5
	.byte	$F2
	.byte	$F8
	.byte	$F5
	.byte	$F4
	.byte	$F3
	.byte	$FC
	.byte	$F0
	.byte	$F3
	.byte	$F8
	.byte	$F1
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$F8
	.byte	$F5
	.byte	$F1
	.byte	$F0
	.byte	$F1
	.byte	$F6
	.byte	$FC
	.byte	$F2
	.byte	$F8
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$FC
	.byte	$F5
	.byte	$F6
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$F9
	.byte	$F4
	.byte	$F2
	.byte	$FC
	.byte	$F5
	.byte	$F2
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F4
	.byte	$D0
	.byte	$E0
	.byte	$F4
	.byte	$F3
	.byte	$FC
	.byte	$F1
	.byte	$F5
	.byte	$F2
	.byte	$F8
	.byte	$F5
	.byte	$F2
	.byte	$F9
	.byte	$F2
	.byte	$FC
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F2
	.byte	$F9
	.byte	$F6
	.byte	$F8
	.byte	$F3
	.byte	$F8
	.byte	$F6
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$F9
	.byte	$F6
	.byte	$F9
	.byte	$F4
	.byte	$F0
	.byte	$F3
	.byte	$FA
	.byte	$FC
	.byte	$F4
	.byte	$F3
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B2
	.byte	$F9
	.byte	$F4
	.byte	$F3
	.byte	$FA
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F4
	.byte	$D4
	.byte	$C4
	.byte	$E4
	.byte	$F4
	.byte	$F5
	.byte	$F4
	.byte	$F4
	.byte	$F6
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F1
	.byte	$F3
	.byte	$FA
	.byte	$F9
	.byte	$F4
	.byte	$71 ; 'q'
	.byte	$B1
	.byte	$F6
	.byte	$FA
	.byte	$F8
	.byte	$F4
	.byte	$71 ; 'q'
	.byte	$10 ; Screen code for '0'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$F2
	.byte	$FA
	.byte	$79 ; 'y'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$E6
	.byte	$FA
	.byte	$F8
	.byte	$D4
	.byte	$C0
	.byte	$C0
	.byte	$E0
	.byte	$F5
	.byte	$F2
	.byte	$FA
	.byte	$F9
	.byte	$F2
	.byte	$FA
	.byte	$FC
	.byte	$71 ; 'q'
	.byte	$B2
	.byte	$FC
	.byte	$F6
	.byte	$FC
	.byte	$F4
	.byte	$F5
	.byte	$D4
	.byte	$E6
	.byte	$79 ; 'y'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$DC
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E6
	.byte	$F9
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F2
	.byte	$FA
	.byte	$FA
	.byte	$FF
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$FA
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$90
	.byte	$C4
	.byte	$E2
	.byte	$FA
	.byte	$FA
	.byte	$DC
	.byte	$C4
	.byte	$E2
	.byte	$FF
	.byte	$FA
	.byte	$FA
	.byte	$F8
	.byte	$F5
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F6
	.byte	$79 ; 'y'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$C4
	.byte	$E2
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$D8
	.byte	$E6
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$E4
	.byte	$71 ; 'q'
	.byte	$B2
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$B3
	.byte	$79 ; 'y'
	.byte	$10 ; Screen code for '0'
	.byte	$80
	.byte	$C4
	.byte	$E0
	.byte	$F5
	.byte	$D0
	.byte	$E6
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$90
	.byte	$C4
	.byte	$E0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$70 ; 'p'
	.byte	$B3
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B0
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$D0
	.byte	$E6
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B0
	.byte	$F5
	.byte	$70 ; 'p'
	.byte	$B3
	.byte	$D8
	.byte	$E2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$D4
	.byte	$E2
	.byte	$FA
	.byte	$F8
	.byte	$50 ; 'P'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$F8
	.byte	$F2
	.byte	$D8
	.byte	$E2
	.byte	$D8
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$B2
	.byte	$F8
	.byte	$F2
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FC
	.byte	$D4
	.byte	$E4
	.byte	$F6
	.byte	$FC
	.byte	$D4
	.byte	$E6
	.byte	$DC
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E6
	.byte	$F9
	.byte	$71 ; 'q'
	.byte	$B1
	.byte	$F5
	.byte	$71 ; 'q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B1
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$79 ; 'y'
	.byte	$B3
	.byte	$FA
	.byte	$FA
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$90
	.byte	$E6
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$C4
	.byte	$E2
	.byte	$D8
	.byte	$E2
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$A2
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$C4
	.byte	$E6
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$78 ; 'x'
	.byte	$B2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$C4
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$D8
	.byte	$60
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$79 ; 'y'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$DC
	.byte	$C4
	.byte	$C4
	.byte	$E6
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$D4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E6
	.byte	$79 ; 'y'
	.byte	$B1
	.byte	$71 ; 'q'
	.byte	$B1
	.byte	$71 ; 'q'
	.byte	$B3
	.byte	$79 ; 'y'
	.byte	$B3
	.byte	$79 ; 'y'
	.byte	$B1
	.byte	$71 ; 'q'
	.byte	$B3
	.byte	$DC
	.byte	$E2
	.byte	$DC
	.byte	$E2
	.byte	$D8
	.byte	$E4
	.byte	$D0
	.byte	$E4
	.byte	$D0
	.byte	$E6
	.byte	$DC
	.byte	$E2
	.byte	$79 ; 'y'
	.byte	$B2
	.byte	$79 ; 'y'
	.byte	$B2
	.byte	$78 ; 'x'
	.byte	$B1
	.byte	$70 ; 'p'
	.byte	$B1
	.byte	$70 ; 'p'
	.byte	$B3
	.byte	$79 ; 'y'
	.byte	$B2
	.byte	$D8
	.byte	$E4
	.byte	$D4
	.byte	$E0
	.byte	$D4
	.byte	$E2
	.byte	$DC
	.byte	$E2
	.byte	$DC
	.byte	$E0
	.byte	$D4
	.byte	$E2
	.byte	$78 ; 'x'
	.byte	$B1
	.byte	$71 ; 'q'
	.byte	$B0
	.byte	$71 ; 'q'
	.byte	$B2
	.byte	$79 ; 'y'
	.byte	$B0
	.byte	$71 ; 'q'
	.byte	$B2
	.byte	$79 ; 'y'
	.byte	$B2
	.byte	$D8
	.byte	$E6
	.byte	$D8
	.byte	$E6
	.byte	$D8
	.byte	$E4
	.byte	$D4
	.byte	$E2
	.byte	$D8
	.byte	$E4
	.byte	$D0
	.byte	$E6
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$78 ; 'x'
	.byte	$B1
	.byte	$71 ; 'q'
	.byte	$B0
	.byte	$70 ; 'p'
	.byte	$B3
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$DC
	.byte	$E0
	.byte	$D0
	.byte	$E4
	.byte	$D4
	.byte	$E2
	.byte	$D8
	.byte	$E6
	.byte	$D8
	.byte	$E4
	.byte	$D0
	.byte	$E6
	.byte	$79 ; 'y'
	.byte	$B2
	.byte	$78 ; 'x'
	.byte	$B1
	.byte	$71 ; 'q'
	.byte	$B2
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$DC
	.byte	$E0
	.byte	$D4
	.byte	$E2
	.byte	$D8
	.byte	$E4
	.byte	$D0
	.byte	$E4
	.byte	$D0
	.byte	$E4
	.byte	$D4
	.byte	$E2
	.byte	$79 ; 'y'
	.byte	$B0
	.byte	$71 ; 'q'
	.byte	$B2
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$78 ; 'x'
	.byte	$B1
	.byte	$70 ; 'p'
	.byte	$B1
	.byte	$71 ; 'q'
	.byte	$B2
	.byte	$DC
	.byte	$E6
	.byte	$DC
	.byte	$E4
	.byte	$D4
	.byte	$E4
	.byte	$D4
	.byte	$E6
	.byte	$DC
	.byte	$E6
	.byte	$DC
	.byte	$E6
	.byte	$FD
	.byte	$F3
	.byte	$F9
	.byte	$F5
	.byte	$F3
	.byte	$F9
	.byte	$F7
	.byte	$FD
	.byte	$F0
	.byte	$F2
	.byte	$FB
	.byte	$F8
	.byte	$F0
	.byte	$F3
	.byte	$FB
	.byte	$FA
	.byte	$FC
	.byte	$F0
	.byte	$F6
	.byte	$FA
	.byte	$FE
	.byte	$F8
	.byte	$F4
	.byte	$F3
	.byte	$F8
	.byte	$F5
	.byte	$F0
	.byte	$F3
	.byte	$FA
	.byte	$F9
	.byte	$F4
	.byte	$F2
	.byte	$F9
	.byte	$F6
	.byte	$FA
	.byte	$FC
	.byte	$F2
	.byte	$FD
	.byte	$F0
	.byte	$F2
	.byte	$79 ; 'y'
	.byte	$B2
	.byte	$FD
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$FC
	.byte	$D4
	.byte	$E6
	.byte	$FD
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$F9
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FA
	.byte	$F9
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$F9
	.byte	$F7
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F6
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F6
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F6
	.byte	$79 ; 'y'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B1
	.byte	$F1
	.byte	$71 ; 'q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B3
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FE
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$80
	.byte	$E4
	.byte	$F1
	.byte	$D4
	.byte	$40 ; '@'
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$A0
	.byte	$F7
	.byte	$FA
	.byte	$FD
	.byte	$50 ; 'P'
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$F4
	.byte	$71 ; 'q'
	.byte	$10 ; Screen code for '0'
	.byte	$A2
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FB
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$DC
	.byte	$C4
	.byte	$E4
	.byte	$F4
	.byte	$D4
	.byte	$C4
	.byte	$E6
	.byte	$F9
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$F8
	.byte	$F5
	.byte	$F0
	.byte	$F5
	.byte	$F2
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FF
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F4
	.byte	$F5
	.byte	$F6
	.byte	$F9
	.byte	$F5
	.byte	$71 ; 'q'
	.byte	$B3
	.byte	$FA
	.byte	$FF
	.byte	$D8
	.byte	$E2
	.byte	$78 ; 'x'
	.byte	$B1
	.byte	$F6
	.byte	$FA
	.byte	$DC
	.byte	$E4
	.byte	$F5
	.byte	$F6
	.byte	$F9
	.byte	$F1
	.byte	$F5
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FC
	.byte	$F3
	.byte	$FC
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F2
	.byte	$F8
	.byte	$F3
	.byte	$FC
	.byte	$F3
	.byte	$FC
	.byte	$71 ; 'q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B1
	.byte	$F6
	.byte	$FA
	.byte	$F8
	.byte	$F3
	.byte	$FC
	.byte	$F3
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$FA
	.byte	$FA
	.byte	$78 ; 'x'
	.byte	$B3
	.byte	$FC
	.byte	$F3
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$FC
	.byte	$F3
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$FC
	.byte	$F3
	.byte	$DC
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$FC
	.byte	$F3
	.byte	$DC
	.byte	$C0
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E2
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$FC
	.byte	$F3
	.byte	$FC
	.byte	$F1
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$FC
	.byte	$F3
	.byte	$FC
	.byte	$71 ; 'q'
	.byte	$B3
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$58 ; 'X'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B3
	.byte	$FC
	.byte	$F3
	.byte	$DC
	.byte	$E2
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$D8
	.byte	$C0
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$C4
	.byte	$E0
	.byte	$F3
	.byte	$FC
	.byte	$F3
	.byte	$FC
	.byte	$F2
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F3
	.byte	$F9
	.byte	$F5
	.byte	$F6
	.byte	$FC
	.byte	$F3
	.byte	$FC
	.byte	$F3
	.byte	$FC
	.byte	$F2
	.byte	$FA
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F2
	.byte	$F8
	.byte	$F5
	.byte	$F5
	.byte	$F5
	.byte	$F4
	.byte	$F7
	.byte	$FC
	.byte	$F3
	.byte	$FA
	.byte	$FA
	.byte	$FA
	.byte	$F9
	.byte	$F3
	.byte	$F9
	.byte	$F3
	.byte	$F8
	.byte	$F2
	.byte	$F9
	.byte	$F3
	.byte	$F9
	.byte	$F3
	.byte	$F9
	.byte	$F3
	.byte	$FC
	.byte	$F2
	.byte	$FC
	.byte	$F4
	.byte	$F6
	.byte	$FC
	.byte	$F6
	.byte	$FC
	.byte	$F6
	.byte	$FC
	.byte	$F6
	.byte	$FC
	.byte	$F6
	.byte	$FC
	.byte	$F6
	.byte	$FC
	.byte	$F5
	.byte	$F6
	.byte	$F9
	.byte	$F5
	.byte	$71 ; 'q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B1
	.byte	$F5
	.byte	$F3
	.byte	$FA
	.byte	$F9
	.byte	$D0
	.byte	$C4
	.byte	$E0
	.byte	$F3
	.byte	$FA
	.byte	$F8
	.byte	$F2
	.byte	$78 ; 'x'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B2
	.byte	$F8
	.byte	$F2
	.byte	$FA
	.byte	$F8
	.byte	$50 ; 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$A0
	.byte	$F2
	.byte	$FA
	.byte	$F8
	.byte	$F2
	.byte	$D8
	.byte	$C4
	.byte	$E2
	.byte	$F8
	.byte	$F2
	.byte	$FA
	.byte	$FC
	.byte	$70 ; 'p'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$B0
	.byte	$F6
	.byte	$FA
	.byte	$FC
	.byte	$F5
	.byte	$D4
	.byte	$C4
	.byte	$E4
	.byte	$F5
	.byte	$F6
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF

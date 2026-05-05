	opt h-

	icl "include/atari_os.inc"
	icl "include/hardware.inc"
	icl "include/cartridge.inc"
	icl "include/game_ram.inc"

; Bank 14: switchable 8KB cartridge bank, mapped at $8000-$9FFF.
; Contains drawing/game support code and data tables.
; Generated Lxxxx symbols are preserved until their meaning is proven.
; Hardware/OS constants are named where confidently identified.
; Bank map (working):
;   $8000-$9FFF  Drawing/game support code mixed with data tables.

L0080	= $0080
L0081	= $0081
L0083	= $0083
L0084	= $0084
L008A	= $008A
L008E	= $008E
L008F	= $008F
L0090	= $0090
L0091	= $0091
L0092	= $0092
L0093	= $0093
L0094	= $0094
L0095	= $0095
L0096	= $0096
L0097	= $0097
L0098	= $0098
L0099	= $0099
L009C	= $009C
L009D	= $009D
L009E	= $009E
L00A1	= $00A1
L00A2	= $00A2
L00A3	= $00A3
L00A4	= $00A4
L00A5	= $00A5
L00A9	= $00A9
L00AF	= $00AF
L00B0	= $00B0
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
L1B30	= $1B30
L2DF6	= $2DF6
L3800	= $3800
L3801	= $3801
L3812	= $3812
L3813	= $3813
L381A	= $381A
L381B	= $381B
L3824	= $3824
L3836	= $3836
L3848	= $3848
L385A	= $385A
L386C	= $386C
L387E	= $387E
L3890	= $3890
L38A2	= $38A2
L38B4	= $38B4
L38B5	= $38B5
L38C6	= $38C6
L38C7	= $38C7
L38CE	= $38CE
L38CF	= $38CF
L3968	= $3968
L396F	= $396F
L39B2	= $39B2
L39D2	= $39D2
L39F2	= $39F2
L3A12	= $3A12
L3A32	= $3A32
L3A52	= $3A52
L3A92	= $3A92
L3B72	= $3B72
L3B9A	= $3B9A
L3BC2	= $3BC2
L3BEA	= $3BEA
L3C12	= $3C12
L3C3A	= $3C3A
L3C44	= $3C44
L3C4E	= $3C4E
L3C58	= $3C58
L3C62	= $3C62
L3C6C	= $3C6C
L3C76	= $3C76
L3C7F	= $3C7F
L3C80	= $3C80
L3C93	= $3C93
L3C94	= $3C94
L3CA8	= $3CA8
L3CA9	= $3CA9
L3CAF	= $3CAF
L3CB0	= $3CB0
L3CB1	= $3CB1
L3CB2	= $3CB2
L3CB8	= $3CB8
L3CB9	= $3CB9
L3CBA	= $3CBA
L3CBB	= $3CBB
L3CC1	= $3CC1
L3CC2	= $3CC2
L3CC3	= $3CC3
L3CC4	= $3CC4
L3CCA	= $3CCA
L3CCB	= $3CCB
L3CCC	= $3CCC
L3CCD	= $3CCD
L3CCE	= $3CCE
L3CCF	= $3CCF
L3CD0	= $3CD0
L3CD1	= $3CD1
L3CD2	= $3CD2
L3CD3	= $3CD3
L3CD4	= $3CD4
L3CD5	= $3CD5
L3CD6	= $3CD6
L3CD7	= $3CD7
L3CD8	= $3CD8
L3CD9	= $3CD9
L3CDA	= $3CDA
L3CDB	= $3CDB
L3CDC	= $3CDC
L3CDD	= $3CDD
L3CDE	= $3CDE
L3CDF	= $3CDF
L3CE0	= $3CE0
L3CE1	= $3CE1
L3CE2	= $3CE2
L3CE3	= $3CE3
L3CE4	= $3CE4
L3CE5	= $3CE5
L3DD8	= $3DD8
L3DE8	= $3DE8
L3ECD	= $3ECD
L3ED2	= $3ED2
L3F0D	= $3F0D
L3FFF	= $3FFF
LA2A7	= $A2A7
LA858	= $A858
LA85C	= $A85C
LA888	= $A888
LAB2D	= $AB2D
BANK_CALL_INDEXED	= $AF1D
BANK_RETURN	= $AF36
LB1B6	= $B1B6
LC003	= $C003
LCA85	= $CA85
LCFD4	= $CFD4
	org $8000
START1	LDA	#$00
	STA	L3CB0
	STA	L3CB9
	STA	L3CC2
	STA	L3CCB
	JMP	BANK_RETURN
	.byte	$A2
L8012	.byte	$0F,$A9,$00 ; (undocumented opcode) - SLO L00A9
L8015	STA	L3DD8,X
	STA	L3DE8,X
	DEX
	BPL	L8015
	JSR	L882D
	LDX	#$00
	JSR	BANK_CALL_INDEXED
	DEC	L00B6
	BMI	L8061
L802A	LDX	L00B6
	LDA	L3B72,X
	BMI	L805A
	LDY	L3B9A,X
	STY	L0080
	LDY	L3BC2,X
	LDX	L0080
	JSR	LA888
	LDX	L00B6
	LDA	L3B9A,X
	STA	L0080
	LDA	L3BEA,X
	TAY
	LDA	L3B72,X
	LDX	L0080
	JSR	LAB2D
	JSR	L8069
	DEC	L00B6
	BPL	L802A
	BMI	L8061
L805A	JSR	L992C
	DEC	L00B6
	BPL	L802A
L8061	LDX	#$01
	JSR	BANK_CALL_INDEXED
	JMP	BANK_RETURN
L8069	LDA	L3F0D
	BEQ	L8071
	JMP	L80BA
L8071	LDX	L00B6
	LDA	L3C12,X
	CMP	#$10
	BCS	L80A1
	CLC
	ADC	#$21
	STA	L0080
	LDA	L3B72,X
	TAY
	CLC
	LDA	L3B9A,X
	ADC	L80A2,Y
	BMI	L8096
	LSR
	LSR
	CMP	#$14
	BCC	L8098
	LDA	#$13
	BPL	L8098
L8096	LDA	#$00
L8098	CLC
	ADC	#$06
	TAY
	LDA	L0080
	STA	L3DD8,Y
L80A1	RTS
L80A2	.byte	$10 ; Screen code for '0'
	.byte	$0F ; Screen code for '/'
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
L80BA	LDX	L00B6
	LDA	L3C12,X
	CMP	#$10
	BCS	L8142
	TAY
	LDA	L815B,Y
	STA	L00B9
	LDA	L3B72,X
	TAY
	SEC
	LDA	L008E
	SBC	L816B,Y
	STA	L00BC
	LDA	L008F
	SBC	L8183,Y
	STA	L00BD
	CLC
	LDA	L3B9A,X
	ADC	L8143,Y
	STA	L0080
	AND	#$03
	TAX
	LDA	LA858,X
	STA	L00BA
	LDY	LA85C,X
	INY
	STY	L00BB
	LDA	L0080
	BMI	L80FB
	LSR
	LSR
	BPL	L80FF
L80FB	SEC
	ROR
	SEC
	ROR
L80FF	STA	L00B7
	LDX	#$06
L8103	LDY	L00B9
	LDA	L819B,Y
	STA	L0080
	LDY	L00B7
	CPY	#$14
	BCS	L811F
	STY	L00B8
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA	(L00BA),Y
	LDY	L00B8
	AND	(L00BC),Y
	STA	(L00BC),Y
L811F	INY
	CPY	#$14
	BCS	L8130
	STY	L00B8
	LDY	L0080
	LDA	(L00BA),Y
	LDY	L00B8
	AND	(L00BC),Y
	STA	(L00BC),Y
L8130	DEX
	BEQ	L8142
	CLC
	LDA	L00BC
	ADC	#$20
	STA	L00BC
	BCC	L813E
	INC	L00BD
L813E	INC	L00B9
	BNE	L8103
L8142	RTS
L8143	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FF
	.byte	$FE
	.byte	$FE
	.byte	$FE
L815B	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$0C ; Screen code for ','
	.byte	$12 ; Screen code for '2'
	.byte	$18 ; Screen code for '8'
	.byte	$1E ; Screen code for '>'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$3C ; '<'
	.byte	$42 ; 'B'
	.byte	$48 ; 'H'
	.byte	$4E ; 'N'
	.byte	$54 ; 'T'
	.byte	$5A ; 'Z'
L816B	.byte	$40 ; '@'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$C0
	.byte	$80
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$C0
	.byte	$A0
	.byte	$80
	.byte	$60
	.byte	$40 ; '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$00 ; Screen code for ' '
	.byte	$E0
	.byte	$C0
	.byte	$A0
	.byte	$80
	.byte	$80
	.byte	$60
	.byte	$40 ; '@'
	.byte	$20 ; ' ' ; Screen code for '@'
L8183	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
L819B	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$60
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$50 ; 'P'
	.byte	$10 ; Screen code for '0'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$40 ; '@'
	.byte	$70 ; 'p'
	.byte	$70 ; 'p'
	.byte	$10 ; Screen code for '0'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$10 ; Screen code for '0'
	.byte	$50 ; 'P'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$10 ; Screen code for '0'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$50 ; 'P'
	.byte	$78 ; 'x'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$70 ; 'p'
	.byte	$40 ; '@'
	.byte	$60
	.byte	$10 ; Screen code for '0'
	.byte	$50 ; 'P'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$40 ; '@'
	.byte	$60
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$70 ; 'p'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$50 ; 'P'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$10 ; Screen code for '0'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$50 ; 'P'
	.byte	$68 ; 'h'
	.byte	$68 ; 'h'
	.byte	$68 ; 'h'
	.byte	$68 ; 'h'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$68 ; 'h'
	.byte	$48 ; 'H'
	.byte	$50 ; 'P'
	.byte	$60
	.byte	$78 ; 'x'
	.byte	$78 ; 'x'
	.byte	$48 ; 'H'
	.byte	$50 ; 'P'
	.byte	$48 ; 'H'
	.byte	$68 ; 'h'
	.byte	$50 ; 'P'
	.byte	$48 ; 'H'
	.byte	$58 ; 'X'
	.byte	$68 ; 'h'
	.byte	$7C ; '|'
	.byte	$48 ; 'H'
	.byte	$48 ; 'H'
	.byte	$78 ; 'x'
	.byte	$60
	.byte	$70 ; 'p'
	.byte	$48 ; 'H'
	.byte	$68 ; 'h'
	.byte	$50 ; 'P'
	.byte	$50 ; 'P'
	.byte	$60
	.byte	$70 ; 'p'
	.byte	$68 ; 'h'
	.byte	$68 ; 'h'
	.byte	$50 ; 'P'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$9A
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$8D
	.byte	$C2
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$4F ; 'O'
	.byte	$8D
	.byte	$EA
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$8D
	.byte	$12 ; Screen code for '2'
	.byte	$3C ; '<'
	.byte	$A9
	.byte	$80
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$99
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$18 ; Screen code for '8'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$88
	.byte	$A8
	.byte	$A2
	.byte	$01 ; Screen code for '!'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L8300	LDA	#$00
	STA	L00B6
	STA	L00C5
	LDX	L00A2
	STX	L00B9
	LDA	L00A4
	STA	L00BA
	CLC
	ADC	L87ED,X
	STA	L00BF
	LDA	#$00
	ADC	L880D,X
	STA	L00C0
	LDA	#$08
	STA	L00BD
	LDX	#$11
	LDA	#$00
L8323	STA	L3800,X
	STA	L3812,X
	STA	L3824,X
	STA	L3836,X
	STA	L3848,X
	STA	L385A,X
	STA	L386C,X
	STA	L387E,X
	STA	L3890,X
	STA	L38A2,X
	DEX
	BPL	L8323
	LDA	L00A5
	LSR
	LSR
	LSR
	LSR
	LSR
	TAX
	AND	#$01
	STA	FRE+2
	LDA	L835D,X
	STA	L0080
	LDA	L8364+1,X
	STA	L0081
	JMP	(L0080)
L835D	.byte	$9A
L835E	CMP	L2DF6
	.byte	$5A ; (undocumented opcode) - NOP
	STA	(L00BE),Y
L8364	ADC	L8383
	.byte	$83,$84 ; (undocumented opcode) - SAX (L0084,X)
	STY	L0084
	STY	L0083
	LDY	#$00
	STY	L3CCF
	CLC
	LDA	L00A5
	ADC	#$40
	TAX
	LDA	L9647,X
	BEQ	L837E
	DEY
L837E	EOR	#$FF
	STA	L3CCC
L8383	INC	L3CCC
	STY	L3CCD
	LDA	L00A5
	EOR	#$FF
	TAX
	INX
	LDA	L9647,X
	STA	L3CCE
	LDX	#$00
	JMP	L84F2
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A9
	.byte	$40 ; '@'
	.byte	$E5
	.byte	$A5
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CD
	.byte	$3C ; '<'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$A6
	.byte	$A5
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CF
	.byte	$3C ; '<'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$4C ; 'L'
	.byte	$F2
	.byte	$84
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$8C
	.byte	$CF
	.byte	$3C ; '<'
	.byte	$A6
	.byte	$A5
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CD
	.byte	$3C ; '<'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A9
	.byte	$40 ; '@'
	.byte	$E5
	.byte	$A5
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$8D
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$A2
	.byte	$01 ; Screen code for '!'
	.byte	$4C ; 'L'
	.byte	$F2
	.byte	$84
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A9
	.byte	$80
	.byte	$E5
	.byte	$A5
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CD
	.byte	$3C ; '<'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$A5
	.byte	$E9
	.byte	$40 ; '@'
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CF
	.byte	$3C ; '<'
	.byte	$A2
	.byte	$01 ; Screen code for '!'
	.byte	$4C ; 'L'
	.byte	$F2
	.byte	$84
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$8C
	.byte	$CF
	.byte	$3C ; '<'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$A5
	.byte	$E9
	.byte	$40 ; '@'
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CD
	.byte	$3C ; '<'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A9
	.byte	$80
	.byte	$E5
	.byte	$A5
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$8D
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$4C ; 'L'
	.byte	$F2
	.byte	$84
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A9
	.byte	$C0
	.byte	$E5
	.byte	$A5
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CD
	.byte	$3C ; '<'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$A5
	.byte	$E9
	.byte	$80
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CF
	.byte	$3C ; '<'
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$4C ; 'L'
	.byte	$F2
	.byte	$84
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$8C
	.byte	$CF
	.byte	$3C ; '<'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$A5
	.byte	$E9
	.byte	$80
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CD
	.byte	$3C ; '<'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A9
	.byte	$C0
	.byte	$E5
	.byte	$A5
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$8D
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$A2
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$F2
	.byte	$84
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$A5
	.byte	$A5
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$AA
	.byte	$E8
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CC
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CD
	.byte	$3C ; '<'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$A5
	.byte	$E9
	.byte	$C0
	.byte	$AA
	.byte	$BD
	.byte	$47 ; 'G'
	.byte	$96
	.byte	$F0
	.byte	$01 ; Screen code for '!'
	.byte	$88
	.byte	$49 ; 'I'
	.byte	$FF
	.byte	$8D
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$EE
	.byte	$CE
	.byte	$3C ; '<'
	.byte	$8C
	.byte	$CF
	.byte	$3C ; '<'
	.byte	$A2
	.byte	$03 ; Screen code for '#'
L84F2	LDA	L87C7,X
	STA	L3CE0
	LDA	L87CB,X
	STA	L3CE1
	LDA	L87D7,X
	STA	L3CE2
	LDA	L87DB,X
	STA	L3CE3
	LDA	L87CF,X
	STA	L3CE4
	LDA	L87D3,X
	STA	L3CE5
	LDA	#$00
	STA	L3CD8
	STA	L3CDA
	LDA	L87E5,X
	STA	L3CD9
	LDA	L87E9,X
	STA	L3CDB
	LDA	L87DF,X
	STA	L00C6
	LDA	L87E0,X
	STA	L00C7
	LDA	L87E1,X
	STA	L00C8
	LDA	L3CCE
	STA	L3CAF
	LDA	L3CCF
	STA	L3CB8
	SEC
	LDA	#$00
	SBC	L3CCC
	STA	L3CC1
	LDA	#$00
	SBC	L3CCD
	STA	L3CCA
	LDX	#$06
L8558	CLC
	LDA	L3CAF
	ADC	L3CA9,X
	STA	L3CA8,X
	LDA	L3CB8
	ADC	L3CB2,X
	STA	L3CB1,X
	CLC
	LDA	L3CC1
	ADC	L3CBB,X
	STA	L3CBA,X
	LDA	L3CCA
	ADC	L3CC4,X
	STA	L3CC3,X
	DEX
	BPL	L8558
	SEC
	LDA	L3CD8
	SBC	L00A1
	STA	FR1+5
	LDA	L3CD9
	SBC	#$00
	STA	FR2
	SEC
	LDA	L3CDA
	SBC	L00A3
	STA	FR2+1
	LDA	L3CDB
	SBC	#$00
	STA	FR2+2
	LDA	L00A5
	STA	FR2+3
	JSR	L95E0
	CLC
	LDA	FR1+5
	STA	L3CD8
	ADC	L3CCC
	STA	L3CD0
	LDA	FR2
	STA	L3CD9
	ADC	L3CCD
	STA	L3CD1
	CLC
	LDA	FR2+1
	STA	L3CDA
	ADC	L3CCE
	STA	L3CD2
	LDA	FR2+2
	STA	L3CDB
	ADC	L3CCF
	STA	L3CD3
	CLC
	LDA	L3CD8
	ADC	L3CAF
	STA	L3CDC
	LDA	L3CD9
	ADC	L3CB8
	STA	L3CDD
	CLC
	LDA	L3CDA
	ADC	L3CC1
	STA	L3CDE
	LDA	L3CDB
	ADC	L3CCA
	STA	L3CDF
	CLC
	LDA	L3CD0
	ADC	L3CAF
	STA	L3CD4
	LDA	L3CD1
	ADC	L3CB8
	STA	L3CD5
	CLC
	LDA	L3CD2
	ADC	L3CC1
	STA	L3CD6
	LDA	L3CD3
	ADC	L3CCA
	STA	L3CD7
	LDA	FR1+5
	STA	L3CD8
	LDA	FR2
	STA	L3CD9
	LDA	FR2+1
	STA	L3CDA
	LDA	FR2+2
	STA	L3CDB
	RTS
	.byte	$C6
L8636	TSX
	BMI	L864B
	DEC	L00BF
	LDY	#$20
	LDA	(L00BF),Y
	STA	L00C4
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	CLC
	JMP	(FRE+3)
L864B	SEC
	JMP	(FRE+3)
	.byte	$C6
L8650	TSX
	BMI	L8665
	DEC	L00BF
	LDY	#$20
	LDA	(L00BF),Y
	STA	L00C4
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	CLC
	JMP	(FRE+5)
L8665	SEC
	JMP	(FRE+5)
	.byte	$C6
L866A	TSX
	BMI	L867F
	DEC	L00BF
	LDY	#$20
	LDA	(L00BF),Y
	STA	L00C4
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	CLC
	JMP	L8932
L867F	SEC
	JMP	L8932
	.byte	$E6
L8684	TSX
	LDY	L396F
	DEY
	CPY	L00BA
	BMI	L869F
	INC	L00BF
	LDY	#$20
	LDA	(L00BF),Y
	STA	L00C4
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	CLC
	JMP	(FRE+3)
L869F	SEC
	JMP	(FRE+3)
	.byte	$E6
L86A4	TSX
	LDY	L396F
	DEY
	CPY	L00BA
	BMI	L86BF
	INC	L00BF
	LDY	#$20
	LDA	(L00BF),Y
	STA	L00C4
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	CLC
	JMP	(FRE+5)
L86BF	SEC
	JMP	(FRE+5)
	.byte	$E6
L86C4	TSX
	LDY	L396F
	DEY
	CPY	L00BA
	BMI	L86DF
	INC	L00BF
	LDY	#$20
	LDA	(L00BF),Y
	STA	L00C4
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	CLC
	JMP	L8932
L86DF	SEC
	JMP	L8932
	.byte	$C6
L86E4	LDA	L1B30,Y
	SEC
	LDA	L00BF
	SBC	#$40
	STA	L00BF
	BCS	L86F2
	DEC	L00C0
L86F2	LDY	#$20
	LDA	(L00BF),Y
	STA	L00C4
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	CLC
	JMP	(FRE+3)
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$6C ; 'l'
	.byte	$DD
	.byte	$00 ; Screen code for ' '
	.byte	$C6
	.byte	$B9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$1B ; Screen code for ';'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$BF
	.byte	$E9
	.byte	$40 ; '@'
	.byte	$85
	.byte	$BF
	.byte	$B0
	.byte	$02 ; Screen code for '"'
	.byte	$C6
	.byte	$C0
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C4
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C3
	.byte	$18 ; Screen code for '8'
	.byte	$6C ; 'l'
	.byte	$DF
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$6C ; 'l'
	.byte	$DF
	.byte	$00 ; Screen code for ' '
	.byte	$C6
	.byte	$B9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$1B ; Screen code for ';'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$BF
	.byte	$E9
	.byte	$40 ; '@'
	.byte	$85
	.byte	$BF
	.byte	$B0
	.byte	$02 ; Screen code for '"'
	.byte	$C6
	.byte	$C0
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C4
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C3
	.byte	$18 ; Screen code for '8'
	.byte	$4C ; 'L'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$89
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$4C ; 'L'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$89
	.byte	$E6
	.byte	$B9
	.byte	$AC
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$88
	.byte	$C4
	.byte	$B9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$1B ; Screen code for ';'
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$BF
	.byte	$69 ; 'i'
	.byte	$40 ; '@'
	.byte	$85
	.byte	$BF
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$C0
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C4
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C3
	.byte	$18 ; Screen code for '8'
	.byte	$6C ; 'l'
	.byte	$DD
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$6C ; 'l'
	.byte	$DD
	.byte	$00 ; Screen code for ' '
	.byte	$E6
	.byte	$B9
	.byte	$AC
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$88
	.byte	$C4
	.byte	$B9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$1B ; Screen code for ';'
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$BF
	.byte	$69 ; 'i'
	.byte	$40 ; '@'
	.byte	$85
	.byte	$BF
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$C0
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C4
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C3
	.byte	$18 ; Screen code for '8'
	.byte	$6C ; 'l'
	.byte	$DF
	.byte	$00 ; Screen code for ' '
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$6C ; 'l'
	.byte	$DF
	.byte	$00 ; Screen code for ' '
	.byte	$E6
	.byte	$B9
	.byte	$AC
	.byte	$6F ; 'o'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$88
	.byte	$C4
	.byte	$B9
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$1B ; Screen code for ';'
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$BF
	.byte	$69 ; 'i'
	.byte	$40 ; '@'
	.byte	$85
	.byte	$BF
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$C0
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C4
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$B1
	.byte	$BF
	.byte	$85
	.byte	$C3
	.byte	$18 ; Screen code for '8'
	.byte	$4C ; 'L'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$89
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$4C ; 'L'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$89
L87C7	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$E3
	.byte	$83
	.byte	$4C ; 'L'
L87CB	.byte	$86
	.byte	$86
	.byte	$86
	.byte	$87
L87CF	.byte	$A3
	.byte	$75 ; 'u'
	.byte	$4F ; 'O'
	.byte	$06 ; Screen code for '&'
L87D3	.byte	$86
	.byte	$87
	.byte	$86
	.byte	$87
L87D7	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$C3
	.byte	$9E
	.byte	$69 ; 'i'
L87DB	.byte	$87
	.byte	$86
	.byte	$87
	.byte	$86
L87DF	.byte	$08 ; Screen code for '('
L87E0	.byte	$01 ; Screen code for '!'
L87E1	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$08 ; Screen code for '('
	.byte	$01 ; Screen code for '!'
L87E5	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
L87E9	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
L87ED	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$80
	.byte	$C0
L880D	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$37 ; '7' ; Screen code for 'W'
L882D	JSR	L8300
	LDA	#$08
	STA	L00B7
L8834	LDA	L00BF
	STA	L00C1
	LDA	L00C0
	STA	L00C2
	LDA	L00BD
	STA	L00BE
	LDA	L00B9
	STA	L00BB
	LDA	L00BA
	STA	L00BC
	LDY	#$20
	LDA	(L00BF),Y
	STA	L00C4
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	JSR	L8EE5
	LDA	#$08
	STA	L00B8
	LDA	#$6A
	STA	FRE+3
	LDA	#$88
	STA	FRE+4
	BNE	L886F
L8865	DEC	L00BD
	JMP	(L3CE0)
	.byte	$B0
L886B	ASL
	JSR	L8EE5
L886F	JSR	L8CC3
	DEC	L00B8
	BPL	L8865
	LDA	L00C1
	STA	L00BF
	LDA	L00C2
	STA	L00C0
	LDA	L00BE
	STA	L00BD
	LDA	L00BB
	STA	L00B9
	LDA	L00BC
	STA	L00BA
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	LDA	#$08
	STA	L00B8
	LDA	#$A3
	STA	FRE+5
	LDA	#$88
	STA	FR1
	BNE	L88A8
L889E	INC	L00BD
	JMP	(L3CE4)
	.byte	$B0
L88A4	ASL
	JSR	L8EE5
L88A8	JSR	L8DD4
	DEC	L00B8
	BPL	L889E
	LDA	L00C1
	STA	L00BF
	LDA	L00C2
	STA	L00C0
	LDA	L00BB
	STA	L00B9
	LDA	L00BC
	STA	L00BA
	LDA	L00BE
	STA	L00BD
	LDY	#$00
	LDA	(L00BF),Y
	STA	L00C3
	LDA	#$08
	STA	L00B8
	JSR	L89A0
	LDA	#$DF
	STA	FRE+3
	LDA	#$88
	STA	FRE+4
	BNE	L88E4
L88DA	DEC	L00BD
	JMP	(L3CE0)
	.byte	$B0
L88E0	.byte	$07,$20 ; (undocumented opcode) - SLO ICHIDZ
	LDA	(L008A,X)
L88E4	DEC	L00B8
	BPL	L88DA
	LDA	L00C1
	STA	L00BF
	LDA	L00C2
	STA	L00C0
	LDA	L00BE
	STA	L00BD
	LDA	L00BB
	STA	L00B9
	LDA	L00BC
	STA	L00BA
	LDA	#$08
	STA	L00B8
	LDA	#$0F
	STA	FRE+5
	LDA	#$89
	STA	FR1
	BNE	L8914
L890A	INC	L00BD
	JMP	(L3CE4)
	.byte	$B0
	.byte	$07 ; Screen code for '''
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B2
	.byte	$8B
L8914	DEC	L00B8
	BPL	L890A
	LDA	L00C1
	STA	L00BF
	LDA	L00C2
	STA	L00C0
	LDA	L00BB
	STA	L00B9
	LDA	L00BC
	STA	L00BA
	CLC
	LDA	L00BE
	ADC	#$12
	STA	L00BD
	JMP	(L3CE2)
L8932	BCS	L899F
	DEC	L00B7
	BMI	L899F
	CLC
	LDA	L3CD0
	STA	L3CD8
	ADC	L3CCC
	STA	L3CD0
	LDA	L3CD1
	STA	L3CD9
	ADC	L3CCD
	STA	L3CD1
	CLC
	LDA	L3CD2
	STA	L3CDA
	ADC	L3CCE
	STA	L3CD2
	LDA	L3CD3
	STA	L3CDB
	ADC	L3CCF
	STA	L3CD3
	CLC
	LDA	L3CD4
	STA	L3CDC
	ADC	L3CCC
	STA	L3CD4
	LDA	L3CD5
	STA	L3CDD
	ADC	L3CCD
	STA	L3CD5
	CLC
	LDA	L3CD6
	STA	L3CDE
	ADC	L3CCE
	STA	L3CD6
	LDA	L3CD7
	STA	L3CDF
	ADC	L3CCF
	STA	L3CD7
	JMP	L8834
L899F	RTS
L89A0	LDA	L00C3
	AND	L00C7
	BEQ	L89D6
	LDA	L00BD
	CMP	#$08
	BEQ	L89FD
	LDA	FRE+2
	BNE	L89D7
	LDA	L3CD4
	STA	L00C9
	LDA	L3CD5
	STA	L00CA
	LDA	L3CD6
	STA	L00CB
	LDA	L3CD7
	STA	L00CC
	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	L38C7,X
	LDA	L00CF
	STA	L3813,X
	JMP	L8AA1
L89D6	RTS
L89D7	LDA	L3CD0
	STA	L00C9
	LDA	L3CD1
	STA	L00CA
	LDA	L3CD2
	STA	L00CB
	LDA	L3CD3
	STA	L00CC
	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	L38C6,X
	LDA	L00CF
	STA	L3812,X
	JMP	L8BB2
L89FD	LDA	L3CD4
	STA	FR0+2
	LDA	L3CD5
	STA	FR0+3
	LDA	L3CD6
	STA	FR0+4
	LDA	L3CD7
	STA	FR0+5
	LDA	L3CD0
	STA	L00D0
	STA	L00C9
	LDA	L3CD1
	STA	L00D1
	STA	L00CA
	LDA	L3CD2
	STA	L00D2
	STA	L00CB
	LDA	L3CD3
	STA	L00D3
	STA	L00CC
	CMP	L00D1
	BMI	L8A39
	BNE	L8A53
	LDA	L00D2
	CMP	L00D0
	BCS	L8A53
L8A39	JSR	L93B1
	LDA	L3CD4
	STA	FR0+2
	LDA	L3CD5
	STA	FR0+3
	LDA	L3CD6
	STA	FR0+4
	LDA	L3CD7
	STA	FR0+5
	JMP	L8A5E
L8A53	JSR	L9200
	LDA	L00CD
	STA	FR0
	LDA	L00CF
	STA	FR0+1
L8A5E	CLC
	LDA	FR0+2
	ADC	FR0+4
	LDA	FR0+3
	ADC	FR0+5
	BMI	L8A6F
	JSR	L9430
	JMP	L8A8A
L8A6F	LDA	FR0+2
	STA	L00C9
	LDA	FR0+3
	STA	L00CA
	LDA	FR0+4
	STA	L00CB
	LDA	FR0+5
	STA	L00CC
	JSR	L9200
	LDA	L00CD
	STA	FRE
	LDA	L00CF
	STA	FRE+1
L8A8A	LDA	FR0
	STA	L38CE
	LDA	FR0+1
	STA	L381A
	LDA	FRE
	STA	L38CF
	LDA	FRE+1
	STA	L381B
	JMP	L96A1
L8AA1	LDA	L00C3
	AND	L00C7
	BEQ	L8AFC
	LDA	#$00
	STA	FR0+3
	LDX	L00BD
	LDA	L3813,X
	STA	FRE+1
	BEQ	L8ABF
	CMP	#$FF
	BEQ	L8AFC
	LDA	L38C7,X
	STA	FRE
	BPL	L8B10
L8ABF	LDY	L00B8
	SEC
	LDA	L3CD4
	SBC	L3CA8,Y
	STA	FR0+2
	STA	L00C9
	LDA	L3CD5
	SBC	L3CB1,Y
	STA	FR0+3
	STA	L00CA
	SEC
	LDA	L3CD6
	SBC	L3CBA,Y
	STA	FR0+4
	STA	L00CB
	LDA	L3CD7
	SBC	L3CC3,Y
	STA	FR0+5
	STA	L00CC
	CMP	FR0+3
	BMI	L8AF7
	BNE	L8AFD
	LDA	FR0+4
	CMP	FR0+2
	BCS	L8AFD
L8AF7	LDA	#$FF
	STA	L3813,X
L8AFC	RTS
L8AFD	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	FRE
	STA	L38C7,X
	LDA	L00CF
	STA	FRE+1
	STA	L3813,X
L8B10	LDA	L00C5
	BEQ	L8B20
	LDA	L3C80
	BNE	L8B20
	LDA	L3C94
	CMP	FRE
	BCS	L8AFC
L8B20	LDX	L00BD
	LDA	L3812,X
	STA	FR0+1
	BEQ	L8B32
	BMI	L8B32
	LDA	L38C6,X
	STA	FR0
	BPL	L8BAF
L8B32	LDY	L00B8
	SEC
	LDA	L3CD0
	SBC	L3CA8,Y
	STA	L00D0
	STA	L00C9
	LDA	L3CD1
	SBC	L3CB1,Y
	STA	L00D1
	STA	L00CA
	SEC
	LDA	L3CD2
	SBC	L3CBA,Y
	STA	L00D2
	STA	L00CB
	LDA	L3CD3
	SBC	L3CC3,Y
	STA	L00D3
	STA	L00CC
	CMP	L00D1
	BMI	L8B6A
	BNE	L8B9C
	LDA	L00D2
	CMP	L00D0
	BCS	L8B9C
L8B6A	LDA	FR0+3
	BNE	L8B90
	SEC
	LDA	L3CD4
	SBC	L3CA8,Y
	STA	FR0+2
	LDA	L3CD5
	SBC	L3CB1,Y
	STA	FR0+3
	SEC
	LDA	L3CD6
	SBC	L3CBA,Y
	STA	FR0+4
	LDA	L3CD7
	SBC	L3CC3,Y
	STA	FR0+5
L8B90	JSR	L93B1
	LDX	L00BD
	LDA	#$FF
	STA	L3812,X
	BNE	L8BAF
L8B9C	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	FR0
	STA	L38C6,X
	LDA	L00CF
	STA	FR0+1
	STA	L3812,X
L8BAF	JMP	L96A1
L8BB2	LDA	L00C3
	AND	L00C7
	BEQ	L8C0C
	LDA	#$00
	STA	L00D1
	LDX	L00BD
	LDA	L3812,X
	STA	FR0+1
	BEQ	L8BD0
	CMP	#$FF
	BEQ	L8C0C
	LDA	L38C6,X
	STA	FR0
	BPL	L8C20
L8BD0	LDY	L00B8
	CLC
	LDA	L3CD0
	ADC	L3CA8,Y
	STA	L00D0
	STA	L00C9
	LDA	L3CD1
	ADC	L3CB1,Y
	STA	L00D1
	STA	L00CA
	CLC
	LDA	L3CD2
	ADC	L3CBA,Y
	STA	L00D2
	STA	L00CB
	LDA	L3CD3
	ADC	L3CC3,Y
	STA	L00D3
	STA	L00CC
	CLC
	LDA	L00C9
	ADC	L00CB
	LDA	L00CA
	ADC	L00CC
	BMI	L8C0D
	LDA	#$FF
	STA	L3812,X
L8C0C	RTS
L8C0D	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	FR0
	STA	L38C6,X
	LDA	L00CF
	STA	FR0+1
	STA	L3812,X
L8C20	LDX	L00C5
	BEQ	L8C32
	LDA	L3C93,X
	CMP	#$4F
	BNE	L8C32
	LDA	FR0
	CMP	L3C7F,X
	BCS	L8C0C
L8C32	LDX	L00BD
	LDA	L3813,X
	STA	FRE+1
	BEQ	L8C44
	BMI	L8C44
	LDA	L38C7,X
	STA	FRE
	BPL	L8CC0
L8C44	LDY	L00B8
	CLC
	LDA	L3CD4
	ADC	L3CA8,Y
	STA	FR0+2
	STA	L00C9
	LDA	L3CD5
	ADC	L3CB1,Y
	STA	FR0+3
	STA	L00CA
	CLC
	LDA	L3CD6
	ADC	L3CBA,Y
	STA	FR0+4
	STA	L00CB
	LDA	L3CD7
	ADC	L3CC3,Y
	STA	FR0+5
	STA	L00CC
	CLC
	LDA	L00C9
	ADC	L00CB
	LDA	L00CA
	ADC	L00CC
	BMI	L8CAD
	LDA	L00D1
	BNE	L8CA1
	CLC
	LDA	L3CD0
	ADC	L3CA8,Y
	STA	L00D0
	LDA	L3CD1
	ADC	L3CB1,Y
	STA	L00D1
	CLC
	LDA	L3CD2
	ADC	L3CBA,Y
	STA	L00D2
	LDA	L3CD3
	ADC	L3CC3,Y
	STA	L00D3
L8CA1	JSR	L9430
	LDX	L00BD
	LDA	#$FF
	STA	L3813,X
	BNE	L8CC0
L8CAD	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	FRE
	STA	L38C7,X
	LDA	L00CF
	STA	FRE+1
	STA	L3813,X
L8CC0	JMP	L96A1
L8CC3	LDA	L00C3
	AND	L00C6
	BEQ	L8D1E
	LDA	#$00
	STA	FR0+3
	LDX	L00BD
	LDA	L3812,X
	STA	FRE+1
	BEQ	L8CE1
	CMP	#$FF
	BEQ	L8D1E
	LDA	L38C6,X
	STA	FRE
	BPL	L8D32
L8CE1	LDY	L00B8
	SEC
	LDA	L3CD0
	SBC	L3CA8,Y
	STA	FR0+2
	STA	L00C9
	LDA	L3CD1
	SBC	L3CB1,Y
	STA	FR0+3
	STA	L00CA
	SEC
	LDA	L3CD2
	SBC	L3CBA,Y
	STA	FR0+4
	STA	L00CB
	LDA	L3CD3
	SBC	L3CC3,Y
	STA	FR0+5
	STA	L00CC
	CMP	FR0+3
	BMI	L8D19
	BNE	L8D1F
	LDA	FR0+4
	CMP	FR0+2
	BCS	L8D1F
L8D19	LDA	#$FF
	STA	L3812,X
L8D1E	RTS
L8D1F	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	FRE
	STA	L38C6,X
	LDA	L00CF
	STA	FRE+1
	STA	L3812,X
L8D32	LDA	L00C5
	BEQ	L8D42
	LDA	L3C80
	BNE	L8D42
	LDA	L3C94
	CMP	FRE
	BCS	L8D1E
L8D42	LDX	L00BD
	LDA	L3800,X
	STA	FR0+1
	BEQ	L8D54
	BMI	L8D54
	LDA	L38B4,X
	STA	FR0
	BPL	L8DD1
L8D54	LDY	L00B8
	SEC
	LDA	L3CD8
	SBC	L3CA8,Y
	STA	L00D0
	STA	L00C9
	LDA	L3CD9
	SBC	L3CB1,Y
	STA	L00D1
	STA	L00CA
	SEC
	LDA	L3CDA
	SBC	L3CBA,Y
	STA	L00D2
	STA	L00CB
	LDA	L3CDB
	SBC	L3CC3,Y
	STA	L00D3
	STA	L00CC
	CMP	L00D1
	BMI	L8D8C
	BNE	L8DBE
	LDA	L00D2
	CMP	L00D0
	BCS	L8DBE
L8D8C	LDA	FR0+3
	BNE	L8DB2
	SEC
	LDA	L3CD0
	SBC	L3CA8,Y
	STA	FR0+2
	LDA	L3CD1
	SBC	L3CB1,Y
	STA	FR0+3
	SEC
	LDA	L3CD2
	SBC	L3CBA,Y
	STA	FR0+4
	LDA	L3CD3
	SBC	L3CC3,Y
	STA	FR0+5
L8DB2	JSR	L93B1
	LDX	L00BD
	LDA	#$FF
	STA	L3800,X
	BNE	L8DD1
L8DBE	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	FR0
	STA	L38B4,X
	LDA	L00CF
	STA	FR0+1
	STA	L3800,X
L8DD1	JMP	L96A1
L8DD4	LDA	L00C3
	AND	L00C8
	BEQ	L8E2E
	LDA	#$00
	STA	L00D1
	LDX	L00BD
	LDA	L3813,X
	STA	FR0+1
	BEQ	L8DF2
	CMP	#$FF
	BEQ	L8E2E
	LDA	L38C7,X
	STA	FR0
	BPL	L8E42
L8DF2	LDY	L00B8
	CLC
	LDA	L3CD4
	ADC	L3CA8,Y
	STA	L00D0
	STA	L00C9
	LDA	L3CD5
	ADC	L3CB1,Y
	STA	L00D1
	STA	L00CA
	CLC
	LDA	L3CD6
	ADC	L3CBA,Y
	STA	L00D2
	STA	L00CB
	LDA	L3CD7
	ADC	L3CC3,Y
	STA	L00D3
	STA	L00CC
	CLC
	LDA	L00C9
	ADC	L00CB
	LDA	L00CA
	ADC	L00CC
	BMI	L8E2F
	LDA	#$FF
	STA	L3813,X
L8E2E	RTS
L8E2F	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	FR0
	STA	L38C7,X
	LDA	L00CF
	STA	FR0+1
	STA	L3813,X
L8E42	LDX	L00C5
	BEQ	L8E54
	LDA	L3C93,X
	CMP	#$4F
	BNE	L8E54
	LDA	FR0
	CMP	L3C7F,X
	BCS	L8E2E
L8E54	LDX	L00BD
	LDA	L3801,X
	STA	FRE+1
	BEQ	L8E66
	BMI	L8E66
	LDA	L38B5,X
	STA	FRE
	BPL	L8EE2
L8E66	LDY	L00B8
	CLC
	LDA	L3CDC
	ADC	L3CA8,Y
	STA	FR0+2
	STA	L00C9
	LDA	L3CDD
	ADC	L3CB1,Y
	STA	FR0+3
	STA	L00CA
	CLC
	LDA	L3CDE
	ADC	L3CBA,Y
	STA	FR0+4
	STA	L00CB
	LDA	L3CDF
	ADC	L3CC3,Y
	STA	FR0+5
	STA	L00CC
	CLC
	LDA	L00C9
	ADC	L00CB
	LDA	L00CA
	ADC	L00CC
	BMI	L8ECF
	LDA	L00D1
	BNE	L8EC3
	CLC
	LDA	L3CD4
	ADC	L3CA8,Y
	STA	L00D0
	LDA	L3CD5
	ADC	L3CB1,Y
	STA	L00D1
	CLC
	LDA	L3CD6
	ADC	L3CBA,Y
	STA	L00D2
	LDA	L3CD7
	ADC	L3CC3,Y
	STA	L00D3
L8EC3	JSR	L9430
	LDX	L00BD
	LDA	#$FF
	STA	L3801,X
	BNE	L8EE2
L8ECF	JSR	L9200
	LDX	L00BD
	LDA	L00CD
	STA	FRE
	STA	L38B5,X
	LDA	L00CF
	STA	FRE+1
	STA	L3801,X
L8EE2	JMP	L96A1
L8EE5	LDA	#$00
	STA	FR1+1
	LDX	L00C4
	CPX	#$FF
	BNE	L8EF0
	RTS
L8EF0	CPX	L3968
	BEQ	L8F44
	SEC
	LDA	L39B2,X
	SBC	L00A1
	STA	FR1+5
	LDA	L39D2,X
	SBC	L00A2
	STA	FR2
	SEC
	LDA	L39F2,X
	SBC	L00A3
	STA	FR2+1
	LDA	L3A12,X
	SBC	L00A4
	STA	FR2+2
	LDA	L00A5
	STA	FR2+3
	JSR	L95E0
	LDA	FR2+2
	BPL	L8F53
	LDX	FR1+1
	CLC
	LDA	FR1+5
	ADC	FR2+1
	STA	L3C6C,X
	LDA	FR2
	ADC	FR2+2
	STA	L3C76,X
	SEC
	ROR	FR2+2
	ROR	FR2+1
	LDA	FR2+2
	CMP	FR2
	BMI	L8F44
	BNE	L8F73
	LDA	FR2+1
	CMP	FR1+5
	BCC	L8F44
	BCS	L8F73
L8F44	LDX	L00C4
	LDA	L3A52,X
	STA	L00C4
	TAX
	CPX	#$FF
	BNE	L8EF0
	JMP	L9019
L8F53	LDX	FR1+1
	SEC
	LDA	FR1+5
	SBC	FR2+1
	STA	L3C6C,X
	LDA	FR2
	SBC	FR2+2
	STA	L3C76,X
	LSR	FR2+2
	ROR	FR2+1
	CLC
	LDA	FR1+5
	ADC	FR2+1
	LDA	FR2
	ADC	FR2+2
	BPL	L8F44
L8F73	LDA	FR1+5
	STA	L00C9
	LDA	FR2
	STA	L00CA
	LDA	FR2+1
	STA	L00CB
	LDA	FR2+2
	STA	L00CC
	JSR	L9200
	SEC
	LDA	L00CE
	SBC	#$28
	STA	L00CD
	LDX	FR1+1
	LDA	L00CF
	STA	L3C58,X
	LDX	L00C4
	CPX	#$10
	BCC	L8F9C
	LSR
	LSR
L8F9C	CMP	#$2A
	BCC	L8FA2
	LDA	#$29
L8FA2	TAY
	LDA	L90D8,Y
	TAX
	LDY	FR1+1
	STA	L3C3A,Y
	CLC
	LDA	L00CD
	ADC	L9103,X
	BMI	L8F44
	CMP	#$50
	BCC	L8FBA
	LDA	#$4F
L8FBA	STA	FRE
	SEC
	LDA	L00CD
	SBC	L9102,X
	STA	L3C44,Y
	BPL	L8FCB
	LDA	#$00
	BEQ	L8FD2
L8FCB	CMP	#$50
	BCC	L8FD2
	JMP	L8F44
L8FD2	STA	FR0
	JSR	L9688
	BEQ	L8FDC
	JMP	L8F44
L8FDC	LDX	L00C4
	CPX	#$10
	BCS	L8FEB
	LDA	L3A92,X
	BEQ	L8FEF
	LDA	#$11
	BNE	L900A
L8FEB	LDA	#$08
	BNE	L900A
L8FEF	LDA	L00CD
	LSR
	LSR
	LSR
	TAX
	INX
	INX
	CLC
	LDA	L911B,X
	LDX	L00C4
	ADC	L3A32,X
	SEC
	SBC	L00A5
	LSR
	LSR
	LSR
	TAX
	LDA	L9129,X
L900A	LDX	FR1+1
	STA	L3C4E,X
	LDA	L00C4
	STA	L3C62,X
	INC	FR1+1
	JMP	L8F44
L9019	LDX	L00B6
	LDY	FR1+1
	BEQ	L9042
	DEY
	BNE	L9043
L9022	LDA	L3C3A
	STA	L3B72,X
	LDA	L3C44
	STA	L3B9A,X
	LDA	L3C4E
	STA	L3BC2,X
	LDA	L3C58
	STA	L3BEA,X
	LDA	L3C62
	STA	L3C12,X
	INC	L00B6
L9042	RTS
L9043	LDA	L3C6C
	STA	FR1+2
	LDA	L3C76
	STA	FR1+3
	LDA	#$00
	STA	FR1+4
	LDY	#$01
L9053	LDA	FR1+3
	CMP	L3C76,Y
	BMI	L9063
	BNE	L906F
	LDA	FR1+2
	CMP	L3C6C,Y
	BCS	L906F
L9063	STY	FR1+4
	LDA	L3C6C,Y
	STA	FR1+2
	LDA	L3C76,Y
	STA	FR1+3
L906F	INY
	CPY	FR1+1
	BCC	L9053
	LDY	FR1+4
	LDX	L00B6
	LDA	L3C3A,Y
	STA	L3B72,X
	LDA	L3C44,Y
	STA	L3B9A,X
	LDA	L3C4E,Y
	STA	L3BC2,X
	LDA	L3C58,Y
	STA	L3BEA,X
	LDA	L3C62,Y
	STA	L3C12,X
	INC	L00B6
	DEC	FR1+1
	LDY	FR1+1
	CPY	FR1+4
	BEQ	L90CC
	LDX	FR1+4
	LDA	L3C3A,Y
	STA	L3C3A,X
	LDA	L3C44,Y
	STA	L3C44,X
	LDA	L3C4E,Y
	STA	L3C4E,X
	LDA	L3C58,Y
	STA	L3C58,X
	LDA	L3C62,Y
	STA	L3C62,X
	LDA	L3C6C,Y
	STA	L3C6C,X
	LDA	L3C76,Y
	STA	L3C76,X
L90CC	CPY	#$01
	BEQ	L90D3
	JMP	L9043
L90D3	LDX	L00B6
	JMP	L9022
L90D8	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$16 ; Screen code for '6'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$14 ; Screen code for '4'
	.byte	$13 ; Screen code for '3'
	.byte	$12 ; Screen code for '2'
	.byte	$11 ; Screen code for '1'
	.byte	$11 ; Screen code for '1'
	.byte	$10 ; Screen code for '0'
	.byte	$0F ; Screen code for '/'
	.byte	$0E ; Screen code for '.'
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
L9102	.byte	$10 ; Screen code for '0'
L9103	.byte	$0F ; Screen code for '/'
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L911B	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$18 ; Screen code for '8'
	.byte	$10 ; Screen code for '0'
	.byte	$08 ; Screen code for '('
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$F8
	.byte	$F0
	.byte	$E8
	.byte	$E0
	.byte	$E4
	.byte	$E8
L9129	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$0E ; Screen code for '.'
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
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
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L9200	SEC
	LDA	L00C9
	STA	FR1+5
	EOR	#$FF
	ADC	#$00
	STA	FR2+1
	LDA	L00CA
	STA	FR2
	EOR	#$FF
	ADC	#$00
	STA	FR2+2
	LDA	#$00
	TAX
	TAY
	STA	FR2+3
	LDA	#$A0
	STA	FR2+4
	LSR
	STA	L00CE
L9222	CPX	L00CC
	BMI	L923B
	BNE	L922E
	CPY	L00CB
	BCC	L923B
	BEQ	L9262
L922E	STX	FR2+2
	STY	FR2+1
	LDA	L00CE
	STA	FR2+4
	JMP	L9243
	.byte	$B0
	.byte	$08 ; Screen code for '('
L923B	STX	FR2
	STY	FR1+5
	LDA	L00CE
	STA	FR2+3
L9243	CLC
	LDA	FR1+5
	ADC	FR2+1
	TAY
	LDA	FR2
	ADC	FR2+2
	CLC
	BPL	L9251
	SEC
L9251	ROR
	TAX
	TYA
	ROR
	TAY
	CLC
	LDA	FR2+3
	ADC	FR2+4
	ROR
	STA	L00CE
	CMP	FR2+3
	BNE	L9222
L9262	LDA	L00CE
	LSR
	STA	L00CD
L9267	LDX	L00CA
	INX
	BEQ	L929C
	INX
	BEQ	L928F
	INX
	BEQ	L9281
	LDA	L00C9
	ASL
	LDA	L00CA
	ROL
	AND	#$1F
	TAX
	LDA	L92A7,X
	STA	L00CF
	RTS
L9281	LDA	L00C9
	LSR
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA	L92C1,X
	STA	L00CF
	RTS
L928F	LDA	L00C9
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA	L92C9,X
	STA	L00CF
	RTS
L929C	LDX	L00C9
	CPX	#$D8
	BCS	L92A8
	LDA	L92D9,X
	STA	L00CF
L92A7	RTS
L92A8	LDA	#$7F
	STA	L00CF
	RTS
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
L92C1	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
L92C9	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$0E ; Screen code for '.'
	.byte	$0F ; Screen code for '/'
	.byte	$10 ; Screen code for '0'
	.byte	$10 ; Screen code for '0'
	.byte	$11 ; Screen code for '1'
	.byte	$12 ; Screen code for '2'
L92D9	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$14 ; Screen code for '4'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$15 ; Screen code for '5'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$16 ; Screen code for '6'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$17 ; Screen code for '7'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$18 ; Screen code for '8'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$19 ; Screen code for '9'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$1A ; Screen code for ':'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1C ; Screen code for '<'
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1D ; Screen code for '='
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1E ; Screen code for '>'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$1F ; Screen code for '?'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$3B ; ';'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3D ; '='
	.byte	$3E ; '>'
	.byte	$3E ; '>'
	.byte	$3F ; '?'
	.byte	$40 ; '@'
	.byte	$41 ; 'A'
	.byte	$42 ; 'B'
	.byte	$42 ; 'B'
	.byte	$43 ; 'C'
	.byte	$44 ; 'D'
	.byte	$45 ; 'E'
	.byte	$46 ; 'F'
	.byte	$47 ; 'G'
	.byte	$48 ; 'H'
	.byte	$49 ; 'I'
	.byte	$4A ; 'J'
	.byte	$4B ; 'K'
	.byte	$4C ; 'L'
	.byte	$4E ; 'N'
L9398	.byte	$4F ; 'O'
	.byte	$50 ; 'P'
	.byte	$51 ; 'Q'
	.byte	$53 ; 'S'
	.byte	$54 ; 'T'
	.byte	$55 ; 'U'
	.byte	$57 ; 'W'
	.byte	$58 ; 'X'
	.byte	$5A ; 'Z'
	.byte	$5B
	.byte	$5D
	.byte	$5F
	.byte	$61 ; 'a'
	.byte	$62 ; 'b'
	.byte	$64 ; 'd'
	.byte	$66 ; 'f'
	.byte	$68 ; 'h'
	.byte	$6B ; 'k'
	.byte	$6D ; 'm'
	.byte	$6F ; 'o'
	.byte	$72 ; 'r'
	.byte	$74 ; 't'
	.byte	$77 ; 'w'
	.byte	$7A ; 'z'
	.byte	$7D
L93B1	ASL	L00D0
	ROL	L00D1
	ASL	L00D2
	ROL	L00D3
	ASL	FR0+2
	ROL	FR0+3
	ASL	FR0+4
	ROL	FR0+5
	LDX	#$7F
L93C3	CLC
	LDA	L00D0
	ADC	FR0+2
	STA	L00C9
	LDA	L00D1
	ADC	FR0+3
	SEC
	BMI	L93D2
	CLC
L93D2	ROR
	STA	L00CA
	ROR	L00C9
	CPY	L00C9
	BNE	L93EE
	CPX	L00CA
	BNE	L93EE
L93DF	LDA	#$00
	STA	FR0
	SEC
	ROR	L00CA
	ROR	L00C9
	JSR	L9267
	STA	FR0+1
	RTS
L93EE	CLC
	LDA	L00D2
	ADC	FR0+4
	STA	L00CB
	LDA	L00D3
	ADC	FR0+5
	SEC
	BMI	L93FD
	CLC
L93FD	ROR
	STA	L00CC
	ROR	L00CB
	LDY	L00C9
	LDX	L00CA
	CPX	L00CC
	BMI	L9421
	BNE	L9412
	CPY	L00CB
	BCC	L9421
	BEQ	L93DF
L9412	STX	L00D1
	STY	L00D0
	LDA	L00CB
	STA	L00D2
	LDA	L00CC
	STA	L00D3
	JMP	L93C3
L9421	STX	FR0+3
	STY	FR0+2
	LDA	L00CB
	STA	FR0+4
	LDA	L00CC
	STA	FR0+5
	JMP	L93C3
L9430	ASL	L00D0
	ROL	L00D1
	ASL	L00D2
	ROL	L00D3
	ASL	FR0+2
	ROL	FR0+3
	ASL	FR0+4
	ROL	FR0+5
	LDX	#$7F
L9442	CLC
	LDA	L00D0
	ADC	FR0+2
	STA	L00C9
	LDA	L00D1
	ADC	FR0+3
	SEC
	BMI	L9451
	CLC
L9451	ROR
	STA	L00CA
	ROR	L00C9
	CPY	L00C9
	BNE	L946D
	CPX	L00CA
	BNE	L946D
L945E	LDA	#$4F
	STA	FRE
	SEC
	ROR	L00CA
	ROR	L00C9
	JSR	L9267
	STA	FRE+1
	RTS
L946D	CLC
	LDA	L00D2
	ADC	FR0+4
	STA	L00CB
	LDA	L00D3
	ADC	FR0+5
	SEC
	BMI	L947C
	CLC
L947C	ROR
	STA	L00CC
	ROR	L00CB
	LDY	L00C9
	LDX	L00CA
	CLC
	TYA
	ADC	L00CB
	STA	L0080
	TXA
	ADC	L00CC
	BMI	L94A5
	BNE	L9496
	LDA	L0080
	BEQ	L945E
L9496	STX	FR0+3
	STY	FR0+2
	LDA	L00CB
	STA	FR0+4
	LDA	L00CC
	STA	FR0+5
	JMP	L9442
L94A5	STX	L00D1
	STY	L00D0
	LDA	L00CB
	STA	L00D2
	LDA	L00CC
	STA	L00D3
	JMP	L9442
L94B4	EOR	#$FF
	SEC
	ADC	#$40
L94B9	LDX	#$00
	CMP	#$40
	BCS	L94C2
	TAY
	BPL	L94DB
L94C2	CMP	#$80
	BCS	L94CC
	EOR	#$7F
	TAY
	INY
	BNE	L94DB
L94CC	CMP	#$C0
	BCS	L94D6
	INX
	AND	#$7F
	TAY
	BPL	L94DB
L94D6	INX
	EOR	#$FF
	TAY
	INY
L94DB	LDA	L9647,Y
	EOR	#$FF
	STA	L0099
	LDA	#$00
	STA	L0098
	STA	L009C
	STA	L009D
	STA	L009E
	LDA	L0097
	BPL	L9502
	SEC
	LDA	L0096
	EOR	#$FF
	ADC	#$00
	STA	L0096
	LDA	L0097
	EOR	#$FF
	ADC	#$00
	STA	L0097
	INX
L9502	LSR	L0099
	BCS	L9512
	LDA	L0096
	ADC	L009E
	STA	L009E
	LDA	L0097
	ADC	L009C
	STA	L009C
L9512	ASL	L0096
	ROL	L0097
	LSR	L0099
	BCS	L9526
	LDA	L0096
	ADC	L009E
	STA	L009E
	LDA	L0097
	ADC	L009C
	STA	L009C
L9526	ASL	L0096
	ROL	L0097
	LSR	L0099
	BCS	L953A
	LDA	L0096
	ADC	L009E
	STA	L009E
	LDA	L0097
	ADC	L009C
	STA	L009C
L953A	ASL	L0096
	ROL	L0097
	LSR	L0099
	BCS	L954E
	LDA	L0096
	ADC	L009E
	STA	L009E
	LDA	L0097
	ADC	L009C
	STA	L009C
L954E	ASL	L0096
	ROL	L0097
	LSR	L0099
	BCS	L9562
	LDA	L0096
	ADC	L009E
	STA	L009E
	LDA	L0097
	ADC	L009C
	STA	L009C
L9562	ASL	L0096
	ROL	L0097
	ROL	L0098
	LSR	L0099
	BCS	L957E
	LDA	L0096
	ADC	L009E
	STA	L009E
	LDA	L0097
	ADC	L009C
	STA	L009C
	LDA	L0098
	ADC	L009D
	STA	L009D
L957E	ASL	L0096
	ROL	L0097
	ROL	L0098
	LSR	L0099
	BCS	L959A
	LDA	L0096
	ADC	L009E
	STA	L009E
	LDA	L0097
	ADC	L009C
	STA	L009C
	LDA	L0098
	ADC	L009D
	STA	L009D
L959A	ASL	L0096
	ROL	L0097
	ROL	L0098
	LSR	L0099
	BCS	L95B6
	LDA	L0096
	ADC	L009E
	STA	L009E
	LDA	L0097
	ADC	L009C
	STA	L009C
	LDA	L0098
	ADC	L009D
	STA	L009D
L95B6	LDA	L009E
	BPL	L95C0
	INC	L009C
	BNE	L95C0
	INC	L009D
L95C0	TXA
	AND	#$01
	BNE	L95C6
	RTS
L95C6	SEC
	LDA	L009C
	EOR	#$FF
	ADC	#$00
	STA	L009C
	LDA	L009D
	EOR	#$FF
	ADC	#$00
	STA	L009D
	LDA	L009E
	EOR	#$FF
	ADC	#$00
	STA	L009E
	RTS
L95E0	LDA	FR2+1
	STA	L0096
	LDA	FR2+2
	STA	L0097
	LDA	FR2+3
	JSR	L94B9
	LDA	L009C
	STA	FR2+4
	LDA	L009D
	STA	FR2+5
	LDA	FR1+5
	STA	L0096
	LDA	FR2
	STA	L0097
	LDA	FR2+3
	JSR	L94B4
	SEC
	LDA	L009C
	SBC	FR2+4
	STA	FR2+4
	LDA	L009D
	SBC	FR2+5
	STA	FR2+5
	LDA	FR1+5
	STA	L0096
	LDA	FR2
	STA	L0097
	LDA	FR2+3
	JSR	L94B9
	LDA	L009C
	STA	FRX
	LDA	L009D
	STA	EEXP
	LDA	FR2+1
	STA	L0096
	LDA	FR2+2
	STA	L0097
	LDA	FR2+3
	JSR	L94B4
	CLC
	LDA	L009C
	ADC	FRX
	STA	FR2+1
	LDA	L009D
	ADC	EEXP
	STA	FR2+2
	LDA	FR2+4
	STA	FR1+5
	LDA	FR2+5
	STA	FR2
	RTS
L9647	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$0C ; Screen code for ','
	.byte	$12 ; Screen code for '2'
	.byte	$19 ; Screen code for '9'
	.byte	$1F ; Screen code for '?'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$3E ; '>'
	.byte	$44 ; 'D'
	.byte	$4A ; 'J'
	.byte	$50 ; 'P'
	.byte	$56 ; 'V'
	.byte	$5C
	.byte	$61 ; 'a'
	.byte	$67 ; 'g'
	.byte	$6D ; 'm'
	.byte	$73 ; 's'
	.byte	$78 ; 'x'
	.byte	$7E
	.byte	$83
	.byte	$88
	.byte	$8E
	.byte	$93
	.byte	$98
	.byte	$9D
	.byte	$A2
	.byte	$A7
	.byte	$AB
	.byte	$B0
	.byte	$B5
	.byte	$B9
	.byte	$BD
	.byte	$C1
	.byte	$C5
	.byte	$C9
	.byte	$CD
	.byte	$D1
	.byte	$D4
	.byte	$D8
	.byte	$DB ; Screen code for '›'
	.byte	$DE
	.byte	$E1
	.byte	$E4
	.byte	$E7
	.byte	$EA
	.byte	$EC
	.byte	$EE
	.byte	$F1
	.byte	$F3
	.byte	$F4
	.byte	$F6
	.byte	$F8
	.byte	$F9
	.byte	$FB
	.byte	$FC
	.byte	$FD
	.byte	$FE
	.byte	$FE
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
L9688	LDX	L00C5
L968A	DEX
	BMI	L969E
	LDA	L3C94,X
	CMP	FRE
	BCC	L969E
	LDA	FR0
	CMP	L3C80,X
	BCC	L968A
	LDA	#$01
	RTS
L969E	LDA	#$00
	RTS
L96A1	LDX	L00C5
L96A3	DEX
	BMI	L96B5
	LDA	L3C94,X
	CMP	FRE
	BCC	L96B5
	LDA	FR0
	CMP	L3C80,X
	BCC	L96A3
	RTS
L96B5	LDX	L00B6
	LDA	FR0
	STA	L3B9A,X
	LDA	FR0+1
	STA	L3BC2,X
	LDA	FRE
	STA	L3BEA,X
	LDA	FRE+1
	STA	L3C12,X
	LDX	#$83
	SEC
	LDA	FRE
	SBC	FR0
	CMP	#$02
	BCS	L96E2
	LDA	FRE+1
	CMP	FR0+1
	BCS	L96E0
	LDX	#$81
	BNE	L96E2
L96E0	LDX	#$82
L96E2	STX	FR2+2
	LDY	#$83
	LDX	#$00
	LDA	FR0
	CPX	L00C5
	BCS	L9707
L96EE	CMP	L3C80,X
	BCC	L9707
	CMP	L3C94,X
	BCC	L9701
	BEQ	L9701
	INX
	CPX	L00C5
	BCC	L96EE
	BCS	L9707
L9701	LDA	L3C80,X
	STA	FR0
	DEY
L9707	STX	FR2
	STX	FR2+1
	LDA	FRE
	CPX	L00C5
	BCS	L972D
L9711	CMP	L3C80,X
	BCC	L972D
	CMP	L3C94,X
	BCC	L9724
	BEQ	L9724
	INX
	CPX	L00C5
	BCC	L9711
	BCS	L972D
L9724	LDA	L3C94,X
	STA	FRE
	DEY
	DEY
	DEC	FR2
L972D	INC	FR2
	DEX
	STX	FR1+5
	LDX	L00B6
	TYA
	AND	FR2+2
	STA	L3B72,X
	SEC
	LDA	FR1+5
	SBC	FR2
	CLC
	ADC	#$01
	BMI	L9765
	BEQ	L977E
	LDX	FR1+5
	LDY	FR2
	INX
	CPX	L00C5
	BCS	L9761
L974F	LDA	L3C80,X
	STA	L3C80,Y
	LDA	L3C94,X
	STA	L3C94,Y
	INY
	INX
	CPX	L00C5
	BCC	L974F
L9761	STY	L00C5
	BCS	L977E
L9765	LDX	L00C5
	CPX	FR2
	BCC	L977C
L976B	LDA	L3C7F,X
	STA	L3C80,X
	LDA	L3C93,X
	STA	L3C94,X
	DEX
	CPX	FR2
	BCS	L976B
L977C	INC	L00C5
L977E	LDY	L00B6
	LDX	FR2+1
	LDA	FR0
	STA	L3C80,X
	BNE	L9791
	LDA	L3B72,Y
	AND	#$FE
	STA	L3B72,Y
L9791	LDA	FRE
	STA	L3C94,X
	CMP	#$4F
	BCC	L97A2
	LDA	L3B72,Y
	AND	#$FD
	STA	L3B72,Y
L97A2	INC	L00B6
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
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L9800	SEC
	LDA	L00B9
	TAY
	SBC	L00BF
	TAX
	STY	L00BF
	BNE	L980D
L980B	LDX	#$01
L980D	LDA	L00B7
	AND	#$03
	STA	L00BC
	LDA	L00B7
	LSR
	LSR
	STA	L00BB
	LDA	L00B8
	AND	#$03
	STA	L00BE
	LDA	L00B8
	LSR
	LSR
	STA	L00BD
	LDY	L00BC
	LDA	L9923+1,Y
	STA	L00C1
	LDY	L00BE
	LDA	L9926+2,Y
	STA	L00C2
	SEC
	LDA	L00BD
	SBC	L00BB
	BNE	L986C
	LDA	L00C1
	AND	L00C2
	STA	L00C1
	LDY	L00BB
L9842	DEC	L00C0
	BMI	L986B
	LDA	(L0092),Y
	ORA	L00C1
	STA	(L0092),Y
	LDA	(L0094),Y
	ORA	L00C1
	STA	(L0094),Y
	CLC
	LDA	L0094
	ADC	#$20
	STA	L0094
	BCC	L985D
	INC	L0095
L985D	SEC
	LDA	L0092
	SBC	#$20
	STA	L0092
	BCS	L9868
	DEC	L0093
L9868	DEX
	BNE	L9842
L986B	RTS
L986C	TAY
	LDA	L9910,Y
	STA	L00C3
	LDA	#$98
	STA	L00C4
	DEC	L00C0
	BMI	L986B
	LDY	L00BB
	LDA	(L0092),Y
	ORA	L00C1
	STA	(L0092),Y
	LDA	(L0094),Y
	ORA	L00C1
	STA	(L0094),Y
	INY
	LDA	#$FF
	JMP	(L00C3)
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$91
	.byte	$92
	.byte	$91
	.byte	$94
	.byte	$C8
	.byte	$B1
	.byte	$92
	.byte	$05 ; Screen code for '%'
	.byte	$C2
	.byte	$91
	.byte	$92
	.byte	$B1
	.byte	$94
	.byte	$05 ; Screen code for '%'
	.byte	$C2
	.byte	$91
	.byte	$94
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$94
	.byte	$69 ; 'i'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$85
	.byte	$94
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$95
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$92
	.byte	$E9
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$85
	.byte	$92
	.byte	$B0
	.byte	$02 ; Screen code for '"'
	.byte	$C6
	.byte	$93
	.byte	$CA
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$76 ; 'v'
	.byte	$98
L9910	.byte	$60
L9911	INX
	.byte	$E3,$DE ; (undocumented opcode) - ISC (FRE+4,X)
	CMP	LCFD4,Y
	DEX
	CMP	L00C0
	.byte	$BB,$B6,$B1 ; (undocumented opcode) - LAS LB1B6,Y
	LDY	LA2A7
	STA	L9398,X
L9923	STX	L3FFF
L9926	.byte	$0F ; (undocumented opcode) - SLO LC003
L9927	.byte	$03,$C0
	BEQ	L9927
	.byte	$FF
L992C	.byte	$85,$CA ; (undocumented opcode) - ISC LCA85,X
	LDA	L3B9A,X
	STA	L00B7
	STA	FR0
	LDA	L3BC2,X
	STA	L00B9
	STA	FR0+1
	LDA	L3BEA,X
	STA	L00B8
	STA	FRE
	LDA	L3C12,X
	STA	L00BA
	STA	FRE+1
	LDA	L008E
	STA	L0092
	LDA	L008F
	STA	L0093
	LDA	L0090
	STA	L0094
	LDA	L0091
	STA	L0095
	LDA	#$32
	STA	L00C0
	LDA	#$00
	STA	L00BF
	SEC
	LDA	L00B8
	SBC	L00B7
	STA	L00C7
	TAX
	LDA	L00BA
	SBC	L00B9
	BCS	L9973
	JMP	L9A02
L9973	STA	L00C8
	CPX	L00C8
	BCC	L99BA
	TXA
	LSR
	EOR	#$FF
	CLC
	ADC	L00C8
	STA	L00C5
	SEC
	LDA	L00C8
	SBC	L00C7
	STA	L00C6
	JSR	L9800
	BNE	L99B7
	LDA	L00C5
	LDX	L00B7
	LDY	L00C7
L9994	DEY
	BMI	L99B7
	INX
	CMP	#$00
	BPL	L99A1
	CLC
	ADC	L00C8
	BVC	L9994
L99A1	STA	L00C5
	STX	L00B7
	STY	L00C9
	JSR	L980B
	BNE	L99B7
	CLC
	LDA	L00C5
	ADC	L00C6
	LDX	L00B7
	LDY	L00C9
	BNE	L9994
L99B7	JMP	L9A95
L99BA	LDA	L00C8
	LSR
	EOR	#$FF
	SEC
	ADC	L00C7
	STA	L00C5
	SEC
	LDA	L00C7
	SBC	L00C8
	STA	L00C6
	LDA	L00C5
	LDX	L00B9
	LDY	L00C8
L99D1	DEY
	BMI	L99FA
	CMP	#$00
	BPL	L99DE
	CLC
	ADC	L00C7
	INX
	BNE	L99D1
L99DE	STA	L00C5
	STX	L00B9
	STY	L00C9
	JSR	L9800
	BNE	L99F7
	INC	L00B7
	CLC
	LDA	L00C5
	ADC	L00C6
	LDX	L00B9
	INX
	LDY	L00C9
	BNE	L99D1
L99F7	JMP	L9A95
L99FA	STX	L00B9
	JSR	L9800
	JMP	L9A95
L9A02	EOR	#$FF
	ADC	#$01
	STA	L00C8
	LDA	L00BA
	STA	L00B9
	CPX	L00C8
	BCC	L9A51
	TXA
	LSR
	EOR	#$FF
	SEC
	ADC	L00C8
	STA	L00C5
	SEC
	LDA	L00C8
	SBC	L00C7
	STA	L00C6
	JSR	L9800
	BNE	L9A4E
	LDA	L00C5
	LDX	L00B8
	LDY	L00C7
L9A2B	DEY
	BMI	L9A4E
	DEX
	CMP	#$00
	BPL	L9A38
	CLC
	ADC	L00C8
	BVC	L9A2B
L9A38	STA	L00C5
	STX	L00B8
	STY	L00C9
	JSR	L980B
	BNE	L9A4E
	CLC
	LDA	L00C5
	ADC	L00C6
	LDX	L00B8
	LDY	L00C9
	BNE	L9A2B
L9A4E	JMP	L9A95
L9A51	LDA	L00C8
	LSR
	EOR	#$FF
	SEC
	ADC	L00C7
	STA	L00C5
	SEC
	LDA	L00C7
	SBC	L00C8
	STA	L00C6
	LDA	L00C5
	LDX	L00B9
	LDY	L00C8
L9A68	DEY
	BMI	L9A90
	CMP	#$00
	BPL	L9A75
	CLC
	ADC	L00C7
	INX
	BNE	L9A68
L9A75	STA	L00C5
	STX	L00B9
	STY	L00C9
	JSR	L9800
	BNE	L9A95
	DEC	L00B8
	CLC
	LDA	L00C5
	ADC	L00C6
	LDX	L00B9
	INX
	LDY	L00C9
	BNE	L9A68
	BEQ	L9A95
L9A90	STX	L00B9
	JSR	L9800
L9A95	LDA	L00CA
	AND	#$01
	BEQ	L9AE9
	LDA	L008E
	STA	L0092
	LDA	L008F
	STA	L0093
	LDA	L0090
	STA	L0094
	LDA	L0091
	STA	L0095
	LDA	FR0
	LSR
	LSR
	TAY
	LDA	FR0
	AND	#$03
	TAX
	LDA	L9B3E,X
	STA	L00C1
	LDX	FR0+1
	CPX	#$33
	BCC	L9AC2
	LDX	#$32
L9AC2	LDA	(L0092),Y
	AND	L00C1
	STA	(L0092),Y
	LDA	(L0094),Y
	AND	L00C1
	STA	(L0094),Y
	DEX
	BEQ	L9AE9
	CLC
	LDA	L0094
	ADC	#$20
	STA	L0094
	BCC	L9ADC
	INC	L0095
L9ADC	SEC
	LDA	L0092
	SBC	#$20
	STA	L0092
	BCS	L9AC2
	DEC	L0093
	BNE	L9AC2
L9AE9	LDA	L00CA
	AND	#$02
	BEQ	L9B3D
	LDA	L008E
	STA	L0092
	LDA	L008F
	STA	L0093
	LDA	L0090
	STA	L0094
	LDA	L0091
	STA	L0095
	LDA	FRE
	LSR
	LSR
	TAY
	LDA	FRE
	AND	#$03
	TAX
	LDA	L9B3E,X
	STA	L00C2
	LDX	FRE+1
	CPX	#$33
	BCC	L9B16
	LDX	#$32
L9B16	LDA	(L0092),Y
	AND	L00C2
	STA	(L0092),Y
	LDA	(L0094),Y
	AND	L00C2
	STA	(L0094),Y
	DEX
	BEQ	L9B3D
	CLC
	LDA	L0094
	ADC	#$20
	STA	L0094
	BCC	L9B30
	INC	L0095
L9B30	SEC
	LDA	L0092
	SBC	#$20
	STA	L0092
	BCS	L9B16
	DEC	L0093
	BNE	L9B16
L9B3D	RTS
L9B3E	.byte	$3F ; '?'
	.byte	$CF
	.byte	$F3
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
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$9A
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$8D
	.byte	$C2
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$4F ; 'O'
	.byte	$8D
	.byte	$EA
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$8D
	.byte	$12 ; Screen code for '2'
	.byte	$3C ; '<'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$B6
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A9
	.byte	$80
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$99
	.byte	$A6
	.byte	$B6
	.byte	$BD
	.byte	$77 ; 'w'
	.byte	$9C
	.byte	$A8
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$18 ; Screen code for '8'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$88
	.byte	$A8
	.byte	$A2
	.byte	$0E ; Screen code for '.'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$01 ; Screen code for '!'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$13 ; Screen code for '3'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$16 ; Screen code for '6'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$E6
	.byte	$B6
	.byte	$A5
	.byte	$B6
	.byte	$C9
	.byte	$1D ; Screen code for '='
	.byte	$90
	.byte	$C3
	.byte	$A2
	.byte	$06 ; Screen code for '&'
	.byte	$BD
	.byte	$94
	.byte	$9C
	.byte	$9D
	.byte	$85
	.byte	$5B
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$4C ; 'L'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$AF
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$0E ; Screen code for '.'
	.byte	$0F ; Screen code for '/'
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$0E ; Screen code for '.'
	.byte	$0F ; Screen code for '/'
	.byte	$00 ; Screen code for ' '
	.byte	$CC
	.byte	$DC
	.byte	$FC
	.byte	$FC
	.byte	$78 ; 'x'
	.byte	$78 ; 'x'
	.byte	$30 ; '0' ; Screen code for 'P'
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
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$9A
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$8D
	.byte	$C2
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$4F ; 'O'
	.byte	$8D
	.byte	$EA
	.byte	$3B ; ';'
	.byte	$A9
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$8D
	.byte	$12 ; Screen code for '2'
	.byte	$3C ; '<'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$B6
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A9
	.byte	$80
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$99
	.byte	$A6
	.byte	$B6
	.byte	$BD
	.byte	$BC
	.byte	$9D
	.byte	$A8
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$A2
	.byte	$18 ; Screen code for '8'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$88
	.byte	$A8
	.byte	$A2
	.byte	$0E ; Screen code for '.'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$01 ; Screen code for '!'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$13 ; Screen code for '3'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$65 ; 'e'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$A2
	.byte	$13 ; Screen code for '3'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$58 ; 'X'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$A2
	.byte	$0D ; Screen code for '-'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$A2
	.byte	$13 ; Screen code for '3'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$46 ; 'F'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$A2
	.byte	$13 ; Screen code for '3'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$1D ; Screen code for '='
	.byte	$AF
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$E6
	.byte	$B6
	.byte	$A5
	.byte	$B6
	.byte	$C9
	.byte	$16 ; Screen code for '6'
	.byte	$B0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$C7
	.byte	$9C
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$A5
	.byte	$8E
	.byte	$E9
	.byte	$60
L9D38	STA	L00AF
	LDA	L008F
	SBC	#$02
	STA	L00B0
	LDA	#$14
	STA	L00B6
L9D44	LDA	#$AA
	LDY	#$0A
	STA	(L00AF),Y
	INY
	STA	(L00AF),Y
	CLC
	LDA	L00AF
	ADC	#$20
	STA	L00AF
	BCC	L9D58
	INC	L00B0
L9D58	DEC	L00B6
	BNE	L9D44
	BEQ	L9D61
	JMP	BANK_RETURN
L9D61	SEC
	LDA	L008E
	SBC	#$85
	STA	L00AF
	LDA	L008F
	SBC	#$00
	STA	L00B0
	LDY	#$11
L9D70	LDA	L9DD2,Y
	STA	(L00AF),Y
	DEY
	LDA	L9DD2,Y
	STA	(L00AF),Y
	DEY
	LDA	L9DD2,Y
	STA	(L00AF),Y
	DEY
	BMI	L9D91
	SEC
	LDA	L00AF
	SBC	#$1D
	STA	L00AF
	BCS	L9D70
	DEC	L00B0
	BNE	L9D70
L9D91	LDX	#$01
	JSR	BANK_CALL_INDEXED
	CLC
	LDA	RTCLOK+2
	ADC	#$0F
	STA	L3ECD
L9D9E	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDX	#$13
	JSR	BANK_CALL_INDEXED
	LDA	L3ED2
	BNE	L9DB9
	LDA	RTCLOK+2
	CMP	L3ECD
	BMI	L9D9E
	LDX	#$01
	JSR	BANK_CALL_INDEXED
L9DB9	JMP	BANK_RETURN
	.byte	$00 ; Screen code for ' '
	.byte	$0F ; Screen code for '/'
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
L9DD2	.byte	$8A
	.byte	$A8
	.byte	$AA
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$A0
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$88
	.byte	$88
	.byte	$AA
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$8A
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A2
	.byte	$A2
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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

	opt h-

	icl "include/atari_os.inc"
	icl "include/hardware.inc"
	icl "include/cartridge.inc"
	icl "include/game_ram.inc"

; Bank 15: fixed 8KB cartridge bank, mapped at $A000-$BFFF.
; Contains resident cartridge code, OS/hardware setup, bank-switch helpers,
; and the MIDI/POKEY serial interrupt paths near the end of the bank.
; Generated Lxxxx symbols are preserved until their meaning is proven.
; Hardware/OS constants are named where confidently identified.
; Bank map (working):
;   $A000-$A970  Resident packed data/tables and preserved byte runs.
;   $A971-$AEFF  Drawing/math/random helpers used by switchable banks.
;   $AF00-$B0E5  Bank switching, fixed-bank helpers, and bank-call slot table.
;   $B0E6-$B510  Status/drawing helpers and resident display setup.
;   $B511-$BFFF  Fixed draw/frame services, cartridge start/init, and MIDI/POKEY serial path.

; MIDI/SIO zero-page usage observed in this bank:
;   L0082  RX write index into MIDI_RX_BUFFER.
;   L0083  RX read index from MIDI_RX_BUFFER.
;   L0084  TX read index from MIDI_TX_BUFFER.
;   L0085  TX write index into MIDI_TX_BUFFER.
;   L0086  TX active flag; nonzero means SEROUT/ISR is draining bytes.

L0080	= $0080
L0081	= $0081
L0082	= $0082
L0083	= $0083
L0084	= $0084
L0085	= $0085
L0086	= $0086
L0087	= $0087
L0088	= $0088
L0089	= $0089
L008A	= $008A
L008B	= $008B
L008C	= $008C
L008D	= $008D
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
L0099	= $0099
L009A	= $009A
L009C	= $009C
L009D	= $009D
L00A0	= $00A0
L00A6	= $00A6
L00A7	= $00A7
L00A8	= $00A8
L00A9	= $00A9
L00AA	= $00AA
L00AB	= $00AB
L00B0	= $00B0
L00B1	= $00B1
L00B2	= $00B2
L00B3	= $00B3
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
L0AD0	= $0AD0
L0CA9	= $0CA9
L0EAD	= $0EAD
L1AD0	= $1AD0
L20A2	= $20A2
L28A9	= $28A9
L2F00	= $2F00
L3DF8	= $3DF8
L4720	= $4720
L5B00	= $5B00
L5C00	= $5C00
L5D00	= $5D00
L5E00	= $5E00
L5F00	= $5F00
L6C3E	= $6C3E
L7024	= $7024
LD0B1	= $D0B1 ; GTIA mirror/open-bus-looking address used only in raw byte comment.
LE520	= $E520 ; OS ROM routine, exact purpose not yet verified.
	org $A000
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$82
	.byte	$88
	.byte	$8A
	.byte	$A0
	.byte	$A2
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$82
	.byte	$88
	.byte	$8A
	.byte	$A0
	.byte	$A2
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$82
	.byte	$88
	.byte	$8A
	.byte	$A0
	.byte	$A2
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$82
	.byte	$88
	.byte	$8A
	.byte	$A0
	.byte	$A2
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$82
	.byte	$88
	.byte	$8A
	.byte	$A0
	.byte	$A2
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$82
	.byte	$88
	.byte	$8A
	.byte	$A0
	.byte	$A2
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$82
	.byte	$88
	.byte	$8A
	.byte	$A0
	.byte	$A2
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$82
	.byte	$88
	.byte	$8A
	.byte	$A0
	.byte	$A2
	.byte	$A8
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$80
	.byte	$82
	.byte	$82
	.byte	$88
	.byte	$88
	.byte	$8A
	.byte	$8A
	.byte	$A0
	.byte	$A0
	.byte	$A2
	.byte	$A2
	.byte	$A8
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$80
	.byte	$82
	.byte	$82
	.byte	$88
	.byte	$88
	.byte	$8A
	.byte	$8A
	.byte	$A0
	.byte	$A0
	.byte	$A2
	.byte	$A2
	.byte	$A8
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$80
	.byte	$82
	.byte	$82
	.byte	$88
	.byte	$88
	.byte	$8A
	.byte	$8A
	.byte	$A0
	.byte	$A0
	.byte	$A2
	.byte	$A2
	.byte	$A8
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$80
	.byte	$82
	.byte	$82
	.byte	$88
	.byte	$88
	.byte	$8A
	.byte	$8A
	.byte	$A0
	.byte	$A0
	.byte	$A2
	.byte	$A2
	.byte	$A8
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$FF
	.byte	$FC
	.byte	$F3
	.byte	$F0
	.byte	$CF
	.byte	$CC
	.byte	$C3
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$F3
	.byte	$F0
	.byte	$CF
	.byte	$CC
	.byte	$C3
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$F3
	.byte	$F0
	.byte	$CF
	.byte	$CC
	.byte	$C3
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$F3
	.byte	$F0
	.byte	$CF
	.byte	$CC
	.byte	$C3
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$F3
	.byte	$F0
	.byte	$CF
	.byte	$CC
	.byte	$C3
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$F3
	.byte	$F0
	.byte	$CF
	.byte	$CC
	.byte	$C3
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$F3
	.byte	$F0
	.byte	$CF
	.byte	$CC
	.byte	$C3
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$F3
	.byte	$F0
	.byte	$CF
	.byte	$CC
	.byte	$C3
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FF
	.byte	$FC
	.byte	$FC
	.byte	$F3
	.byte	$F3
	.byte	$F0
	.byte	$F0
	.byte	$CF
	.byte	$CF
	.byte	$CC
	.byte	$CC
	.byte	$C3
	.byte	$C3
	.byte	$C0
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FF
	.byte	$FC
	.byte	$FC
	.byte	$F3
	.byte	$F3
	.byte	$F0
	.byte	$F0
	.byte	$CF
	.byte	$CF
	.byte	$CC
	.byte	$CC
	.byte	$C3
	.byte	$C3
	.byte	$C0
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FF
	.byte	$FC
	.byte	$FC
	.byte	$F3
	.byte	$F3
	.byte	$F0
	.byte	$F0
	.byte	$CF
	.byte	$CF
	.byte	$CC
	.byte	$CC
	.byte	$C3
	.byte	$C3
	.byte	$C0
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FF
	.byte	$FC
	.byte	$FC
	.byte	$F3
	.byte	$F3
	.byte	$F0
	.byte	$F0
	.byte	$CF
	.byte	$CF
	.byte	$CC
	.byte	$CC
	.byte	$C3
	.byte	$C3
	.byte	$C0
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A0
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A2
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FF
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
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
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$FC
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F3
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$F0
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CF
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$CC
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$3C ; '<'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0F ; Screen code for '/'
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$0C ; Screen code for ','
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
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
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$68 ; 'h'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$08 ; Screen code for '('
	.byte	$D8
	.byte	$A8
	.byte	$78 ; 'x'
	.byte	$48 ; 'H'
	.byte	$18 ; Screen code for '8'
	.byte	$E8
	.byte	$B8
	.byte	$88
	.byte	$58 ; 'X'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$F8
	.byte	$C8
	.byte	$98
	.byte	$D0
	.byte	$A0
	.byte	$70 ; 'p'
	.byte	$40 ; '@'
	.byte	$10 ; Screen code for '0'
	.byte	$E0
	.byte	$B0
	.byte	$80
	.byte	$50 ; 'P'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$F0
	.byte	$C0
	.byte	$90
	.byte	$60
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$54 ; 'T'
	.byte	$FC
	.byte	$A4
	.byte	$4C ; 'L'
	.byte	$F4
	.byte	$9C
	.byte	$44 ; 'D'
	.byte	$EC
	.byte	$94
	.byte	$3C ; '<'
	.byte	$E4
	.byte	$8C
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$DC
	.byte	$84
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$BB
	.byte	$55 ; 'U'
	.byte	$EF
	.byte	$89
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$BD
	.byte	$57 ; 'W'
	.byte	$F1
	.byte	$8B
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$BF
	.byte	$59 ; 'Y'
	.byte	$F3
	.byte	$8D
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$FD
	.byte	$75 ; 'u'
	.byte	$ED
	.byte	$65 ; 'e'
	.byte	$DD
	.byte	$55 ; 'U'
	.byte	$CD
	.byte	$45 ; 'E'
	.byte	$BD
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$AD
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$9D
	.byte	$15 ; Screen code for '5'
	.byte	$8D
	.byte	$05 ; Screen code for '%'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$A2
	.byte	$0E ; Screen code for '.'
	.byte	$7A ; 'z'
	.byte	$E6
	.byte	$52 ; 'R'
	.byte	$BE
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$96
	.byte	$02 ; Screen code for '"'
	.byte	$6E ; 'n'
	.byte	$DA
	.byte	$46 ; 'F'
	.byte	$B2
	.byte	$1E ; Screen code for '>'
	.byte	$8A
	.byte	$F8
	.byte	$48 ; 'H'
	.byte	$98
	.byte	$E8
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$88
	.byte	$D8
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$78 ; 'x'
	.byte	$C8
	.byte	$18 ; Screen code for '8'
	.byte	$68 ; 'h'
	.byte	$B8
	.byte	$08 ; Screen code for '('
	.byte	$58 ; 'X'
	.byte	$A8
	.byte	$1E ; Screen code for '>'
	.byte	$6E ; 'n'
	.byte	$BE
	.byte	$0E ; Screen code for '.'
	.byte	$5E
	.byte	$AE
	.byte	$FE
	.byte	$4E ; 'N'
	.byte	$9E
	.byte	$EE
	.byte	$3E ; '>'
	.byte	$8E
	.byte	$DE
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$7E
	.byte	$CE
	.byte	$56 ; 'V'
	.byte	$C6
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$A6
	.byte	$16 ; Screen code for '6'
	.byte	$86
	.byte	$F6
	.byte	$66 ; 'f'
	.byte	$D6
	.byte	$46 ; 'F'
	.byte	$B6
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$96
	.byte	$06 ; Screen code for '&'
	.byte	$76 ; 'v'
	.byte	$E6
	.byte	$8A
	.byte	$F2
	.byte	$5A ; 'Z'
	.byte	$C2
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$92
	.byte	$FA
	.byte	$62 ; 'b'
	.byte	$CA
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$9A
	.byte	$02 ; Screen code for '"'
	.byte	$6A ; 'j'
	.byte	$D2
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$A2
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$90
	.byte	$F0
	.byte	$50 ; 'P'
	.byte	$B0
	.byte	$10 ; Screen code for '0'
	.byte	$70 ; 'p'
	.byte	$D0
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$90
	.byte	$F0
	.byte	$50 ; 'P'
	.byte	$B0
	.byte	$10 ; Screen code for '0'
	.byte	$70 ; 'p'
	.byte	$D0
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$8E
	.byte	$E6
	.byte	$3E ; '>'
	.byte	$96
	.byte	$EE
	.byte	$46 ; 'F'
	.byte	$9E
	.byte	$F6
	.byte	$4E ; 'N'
	.byte	$A6
	.byte	$FE
	.byte	$56 ; 'V'
	.byte	$AE
LA53E	.byte	$06 ; Screen code for '&'
	.byte	$5E
	.byte	$4E ; 'N'
	.byte	$8A
	.byte	$C6
	.byte	$02 ; Screen code for '"'
	.byte	$3E ; '>'
	.byte	$7A ; 'z'
	.byte	$B6
	.byte	$F2
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$6A ; 'j'
	.byte	$A6
	.byte	$E2
	.byte	$1E ; Screen code for '>'
	.byte	$5A ; 'Z'
	.byte	$96
	.byte	$D2
	.byte	$98
	.byte	$CE
	.byte	$04 ; Screen code for '$'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$70 ; 'p'
	.byte	$A6
	.byte	$DC
	.byte	$12 ; Screen code for '2'
	.byte	$48 ; 'H'
	.byte	$7E
	.byte	$B4
	.byte	$EA
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$56 ; 'V'
	.byte	$8C
	.byte	$C2
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$5F
	.byte	$95
	.byte	$CB
	.byte	$01 ; Screen code for '!'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$6D ; 'm'
	.byte	$A3
	.byte	$D9
	.byte	$0F ; Screen code for '/'
	.byte	$45 ; 'E'
	.byte	$7B
	.byte	$B1
	.byte	$E7
	.byte	$1D ; Screen code for '='
	.byte	$53 ; 'S'
	.byte	$A1
	.byte	$D1
	.byte	$01 ; Screen code for '!'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$61 ; 'a'
	.byte	$91
	.byte	$C1
	.byte	$F1
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$51 ; 'Q'
	.byte	$81
	.byte	$B1
	.byte	$E1
	.byte	$11 ; Screen code for '1'
	.byte	$41 ; 'A'
	.byte	$71 ; 'q'
	.byte	$80
	.byte	$81
	.byte	$82
	.byte	$82
	.byte	$83
	.byte	$84
	.byte	$85
	.byte	$86
	.byte	$86
	.byte	$87
	.byte	$88
	.byte	$89
	.byte	$8A
	.byte	$8A
	.byte	$8B
	.byte	$8C
	.byte	$8D
	.byte	$8E
	.byte	$8F
	.byte	$90
	.byte	$91
	.byte	$91
	.byte	$92
	.byte	$93
	.byte	$94
	.byte	$95
	.byte	$95
	.byte	$96
	.byte	$97
	.byte	$98
	.byte	$99
	.byte	$9A
	.byte	$80
	.byte	$80
	.byte	$81
	.byte	$82
	.byte	$82
	.byte	$83
	.byte	$84
	.byte	$84
	.byte	$85
	.byte	$86
	.byte	$86
	.byte	$87
	.byte	$88
	.byte	$88
	.byte	$89
	.byte	$8A
	.byte	$8B
	.byte	$8B
	.byte	$8C
	.byte	$8C
	.byte	$8D
	.byte	$8E
	.byte	$8E
	.byte	$8F
	.byte	$8F
	.byte	$90
	.byte	$91
	.byte	$91
	.byte	$92
	.byte	$92
	.byte	$93
	.byte	$94
	.byte	$94
	.byte	$95
	.byte	$95
	.byte	$96
	.byte	$96
	.byte	$97
	.byte	$97
	.byte	$98
	.byte	$98
	.byte	$99
	.byte	$99
	.byte	$9A
	.byte	$9A
	.byte	$9B ; '›'
	.byte	$9B ; '›'
	.byte	$9C
	.byte	$80
	.byte	$80
	.byte	$81
	.byte	$81
	.byte	$81
	.byte	$82
	.byte	$82
	.byte	$83
	.byte	$83
	.byte	$84
	.byte	$84
	.byte	$84
	.byte	$85
	.byte	$85
	.byte	$86
	.byte	$86
	.byte	$9A
	.byte	$9B ; '›'
	.byte	$9B ; '›'
	.byte	$9B ; '›'
	.byte	$9C
	.byte	$9C
	.byte	$9C
	.byte	$9D
	.byte	$9D
	.byte	$9D
	.byte	$9E
	.byte	$9E
	.byte	$9E
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$87
	.byte	$87
	.byte	$87
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$89
	.byte	$89
	.byte	$89
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8B
	.byte	$8B
	.byte	$8B
	.byte	$8C
	.byte	$8C
	.byte	$8D
	.byte	$8D
	.byte	$8E
	.byte	$8E
	.byte	$8E
	.byte	$8F
	.byte	$8F
	.byte	$90
	.byte	$90
	.byte	$91
	.byte	$91
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$93
	.byte	$93
	.byte	$94
	.byte	$94
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$96
	.byte	$96
	.byte	$97
	.byte	$97
	.byte	$98
	.byte	$98
	.byte	$98
	.byte	$99
	.byte	$99
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$81
	.byte	$81
	.byte	$82
	.byte	$82
	.byte	$82
	.byte	$83
	.byte	$83
	.byte	$83
	.byte	$84
	.byte	$84
	.byte	$85
	.byte	$85
	.byte	$85
	.byte	$9A
	.byte	$9A
	.byte	$9A
	.byte	$9B ; '›'
	.byte	$9B ; '›'
	.byte	$9B ; '›'
	.byte	$9C
	.byte	$9C
	.byte	$9C
	.byte	$9D
	.byte	$9D
	.byte	$9D
	.byte	$9E
	.byte	$9E
	.byte	$9F
	.byte	$9F
	.byte	$86
	.byte	$86
	.byte	$86
	.byte	$87
	.byte	$87
	.byte	$87
	.byte	$87
	.byte	$87
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$88
	.byte	$89
	.byte	$89
	.byte	$89
	.byte	$89
	.byte	$9C
	.byte	$9C
	.byte	$9D
	.byte	$9D
	.byte	$9D
	.byte	$9D
	.byte	$9D
	.byte	$9E
	.byte	$9E
	.byte	$9E
	.byte	$9E
	.byte	$9E
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$8B
	.byte	$8B
	.byte	$8B
	.byte	$8B
	.byte	$8B
	.byte	$8C
	.byte	$8C
	.byte	$8C
	.byte	$8C
	.byte	$8C
	.byte	$8D
	.byte	$8D
	.byte	$8D
	.byte	$8D
	.byte	$8E
	.byte	$8E
	.byte	$8E
	.byte	$8E
	.byte	$8E
	.byte	$8E
	.byte	$8F
	.byte	$8F
	.byte	$8F
	.byte	$8F
	.byte	$8F
	.byte	$90
	.byte	$90
	.byte	$90
	.byte	$AF
	.byte	$CB
	.byte	$E7
	.byte	$03 ; Screen code for '#'
	.byte	$1F ; Screen code for '?'
	.byte	$3B ; ';'
	.byte	$57 ; 'W'
	.byte	$73 ; 's'
	.byte	$8F
	.byte	$AB
	.byte	$C7
	.byte	$E3
	.byte	$FF
	.byte	$1B ; Screen code for ';'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$53 ; 'S'
	.byte	$7B
	.byte	$93
	.byte	$AB
	.byte	$C3
	.byte	$DB ; Screen code for '›'
	.byte	$F3
	.byte	$0B ; Screen code for '+'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$3B ; ';'
	.byte	$53 ; 'S'
	.byte	$6B ; 'k'
	.byte	$83
	.byte	$9B ; '›'
	.byte	$B3
	.byte	$CB
	.byte	$E3
	.byte	$05 ; Screen code for '%'
	.byte	$19 ; Screen code for '9'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$41 ; 'A'
	.byte	$55 ; 'U'
	.byte	$69 ; 'i'
	.byte	$7D
	.byte	$91
	.byte	$A5
	.byte	$B9
	.byte	$CD
	.byte	$E1
	.byte	$F5
	.byte	$09 ; Screen code for ')'
	.byte	$1D ; Screen code for '='
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$4D ; 'M'
	.byte	$5D
	.byte	$6D ; 'm'
	.byte	$7D
	.byte	$8D
	.byte	$9D
	.byte	$AD
	.byte	$BD
	.byte	$CD
	.byte	$DD
	.byte	$ED
	.byte	$FD
	.byte	$0D ; Screen code for '-'
	.byte	$1D ; Screen code for '='
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$3D ; '='
	.byte	$51 ; 'Q'
	.byte	$59 ; 'Y'
	.byte	$61 ; 'a'
	.byte	$69 ; 'i'
	.byte	$71 ; 'q'
	.byte	$79 ; 'y'
	.byte	$81
	.byte	$89
	.byte	$91
	.byte	$99
	.byte	$A1
	.byte	$A9
	.byte	$B1
	.byte	$B9
	.byte	$C1
	.byte	$C9
	.byte	$D4
	.byte	$DA
	.byte	$E0
	.byte	$E6
	.byte	$EC
	.byte	$F2
	.byte	$F8
	.byte	$FE
	.byte	$04 ; Screen code for '$'
	.byte	$0A ; Screen code for '*'
	.byte	$10 ; Screen code for '0'
	.byte	$16 ; Screen code for '6'
	.byte	$1C ; Screen code for '<'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$B8
	.byte	$BC
	.byte	$C0
	.byte	$C4
	.byte	$C8
	.byte	$CC
	.byte	$D0
	.byte	$D4
	.byte	$D8
	.byte	$DC
	.byte	$E0
	.byte	$E4
	.byte	$E8
	.byte	$EC
	.byte	$F0
	.byte	$F4
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$3B ; ';'
	.byte	$3D ; '='
	.byte	$3F ; '?'
	.byte	$41 ; 'A'
	.byte	$43 ; 'C'
	.byte	$45 ; 'E'
	.byte	$47 ; 'G'
	.byte	$49 ; 'I'
	.byte	$4B ; 'K'
	.byte	$4D ; 'M'
	.byte	$4F ; 'O'
	.byte	$51 ; 'Q'
	.byte	$53 ; 'S'
	.byte	$90
	.byte	$90
	.byte	$90
	.byte	$91
	.byte	$91
	.byte	$91
	.byte	$91
	.byte	$91
	.byte	$91
	.byte	$91
	.byte	$91
	.byte	$91
	.byte	$91
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$92
	.byte	$93
	.byte	$93
	.byte	$93
	.byte	$93
	.byte	$93
	.byte	$93
	.byte	$93
	.byte	$93
	.byte	$93
	.byte	$93
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$94
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$95
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$96
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$9F
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
	.byte	$97
LA780	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$0D ; Screen code for '-'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$0E ; Screen code for '.'
	.byte	$0D ; Screen code for '-'
	.byte	$0C ; Screen code for ','
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$08 ; Screen code for '('
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
LA7B0	.byte	$0C ; Screen code for ','
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
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$08 ; Screen code for '('
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$0B ; Screen code for '+'
	.byte	$09 ; Screen code for ')'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$0B ; Screen code for '+'
	.byte	$00 ; Screen code for ' '
	.byte	$68 ; 'h'
	.byte	$00 ; Screen code for ' '
	.byte	$D4
	.byte	$C1
	.byte	$00 ; Screen code for ' '
	.byte	$D0
	.byte	$F6
	.byte	$1E ; Screen code for '>'
	.byte	$56 ; 'V'
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$7D
	.byte	$0E ; Screen code for '.'
	.byte	$89
	.byte	$A1
	.byte	$6F ; 'o'
	.byte	$FB
	.byte	$45 ; 'E'
	.byte	$4D ; 'M'
	.byte	$D1
	.byte	$B6
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$80
	.byte	$8D
	.byte	$80
	.byte	$8A
	.byte	$94
	.byte	$80
	.byte	$9A
	.byte	$86
	.byte	$8C
	.byte	$93
	.byte	$80
	.byte	$9A
	.byte	$86
	.byte	$9C
	.byte	$8A
	.byte	$8D
	.byte	$90
	.byte	$92
	.byte	$93
	.byte	$95
	.byte	$96
	.byte	$96
	.byte	$9F
	.byte	$97
LA810	.byte	$55 ; 'U'
	.byte	$B5
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$85
	.byte	$CB
	.byte	$0D ; Screen code for '-'
	.byte	$15 ; Screen code for '5'
	.byte	$3D ; '='
	.byte	$60
	.byte	$78 ; 'x'
	.byte	$A5
	.byte	$90
	.byte	$B9
	.byte	$01 ; Screen code for '!'
	.byte	$C5
	.byte	$D1
	.byte	$DA
	.byte	$DE
	.byte	$E2
	.byte	$E4
	.byte	$E6
	.byte	$E7
	.byte	$A4
	.byte	$E8
LA828	.byte	$97
	.byte	$97
	.byte	$98
	.byte	$98
	.byte	$98
	.byte	$99
	.byte	$98
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$99
	.byte	$68 ; 'h'
	.byte	$68 ; 'h'
	.byte	$54 ; 'T'
	.byte	$4D ; 'M'
	.byte	$3C ; '<'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$1E ; Screen code for '>'
	.byte	$1B ; Screen code for ';'
	.byte	$1B ; Screen code for ';'
	.byte	$18 ; Screen code for '8'
	.byte	$0E ; Screen code for '.'
	.byte	$0C ; Screen code for ','
	.byte	$0A ; Screen code for '*'
	.byte	$08 ; Screen code for '('
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
LA858	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$80
LA85C	.byte	$A0
	.byte	$A0
	.byte	$A2
	.byte	$A2
LA860	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$03 ; Screen code for '#'
	.byte	$07 ; Screen code for '''
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$80
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$08 ; Screen code for '('
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$80
	.byte	$88
	.byte	$A0
	.byte	$A8
	.byte	$FF
	.byte	$3F ; '?'
	.byte	$FF
	.byte	$CF
	.byte	$3F ; '?'
	.byte	$0F ; Screen code for '/'
	.byte	$FF
	.byte	$F3
	.byte	$CF
	.byte	$C3
	.byte	$3F ; '?'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$0F ; Screen code for '/'
	.byte	$03 ; Screen code for '#'
LA880	.byte	$64 ; 'd'
	.byte	$64 ; 'd'
	.byte	$66 ; 'f'
	.byte	$6A ; 'j'
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$A8
	.byte	$85
	.byte	$D1
	.byte	$8A
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$03 ; Screen code for '#'
	.byte	$85
	.byte	$D5
	.byte	$8A
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$04 ; Screen code for '$'
	.byte	$4A ; 'J'
	.byte	$4A ; 'J'
	.byte	$10 ; Screen code for '0'
	.byte	$04 ; Screen code for '$'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$6A ; 'j'
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$6A ; 'j'
	.byte	$85
	.byte	$CB
	.byte	$A5
	.byte	$8E
	.byte	$85
	.byte	$92
	.byte	$A5
	.byte	$8F
	.byte	$85
	.byte	$93
	.byte	$A5
	.byte	$90
	.byte	$85
	.byte	$94
	.byte	$A5
	.byte	$91
	.byte	$85
	.byte	$95
	.byte	$A6
	.byte	$D1
	.byte	$A5
	.byte	$8C
	.byte	$48 ; 'H'
	.byte	$BD
	.byte	$C8
	.byte	$A7
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$D5
	.byte	$85
	.byte	$8C
	.byte	$BD
	.byte	$98
	.byte	$A7
	.byte	$85
	.byte	$C7
	.byte	$BD
	.byte	$80
	.byte	$A7
	.byte	$85
	.byte	$C5
	.byte	$BD
	.byte	$40 ; '@'
	.byte	$A8
	.byte	$85
	.byte	$D4
	.byte	$BD
	.byte	$E0
	.byte	$A7
	.byte	$85
	.byte	$B7
	.byte	$BD
	.byte	$F8
	.byte	$A7
	.byte	$85
	.byte	$B8
	.byte	$C0
	.byte	$11 ; Screen code for '1'
	.byte	$B0
	.byte	$58 ; 'X'
	.byte	$A5
	.byte	$D1
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$0A ; Screen code for '*'
	.byte	$84
	.byte	$80
	.byte	$05 ; Screen code for '%'
	.byte	$80
	.byte	$AA
	.byte	$B0
	.byte	$08 ; Screen code for '('
	.byte	$BD
	.byte	$80
	.byte	$A4
	.byte	$BC
	.byte	$80
	.byte	$A5
	.byte	$D0
	.byte	$06 ; Screen code for '&'
	.byte	$BD
	.byte	$80
	.byte	$A6
	.byte	$BC
	.byte	$00 ; Screen code for ' '
	.byte	$A7
	.byte	$85
	.byte	$B9
	.byte	$84
	.byte	$BA
	.byte	$18 ; Screen code for '8'
	.byte	$65 ; 'e'
	.byte	$D4
	.byte	$85
	.byte	$BB
	.byte	$90
	.byte	$01 ; Screen code for '!'
	.byte	$C8
	.byte	$84
	.byte	$BC
	.byte	$A6
	.byte	$D5
	.byte	$BD
	.byte	$58 ; 'X'
	.byte	$A8
	.byte	$BC
	.byte	$5C
	.byte	$A8
	.byte	$85
	.byte	$BD
	.byte	$84
	.byte	$BE
	.byte	$85
	.byte	$BF
	.byte	$C8
	.byte	$84
	.byte	$C0
	.byte	$BD
	.byte	$60
LA912	TAY
	STA	L00D3
	LDA	LA880,X
	STA	L00C1
	CLC
	ADC	#$0E
	STA	L00C3
	LDA	#$A8
	STA	L00C2
	STA	L00C4
	LDA	L00D1
	CMP	#$08
	BCS	LA971
	JMP	LAA21
	.byte	$A5
LA92F	.byte	$B7,$85 ; (undocumented opcode) - LAX L0085,Y
	LDA	LBB85,Y
	LDA	L00B8
	STA	L00BA
	STA	L00BC
	LDX	FR0+1
	LDA	LA858,X
	LDY	LA85C,X
	STA	L00BF
	INY
	STY	L00C0
	LDA	#$00
	STA	L00BD
	LDA	#$A4
	STA	L00BE
	LDA	LA860,X
	STA	L00D3
	CLC
	LDA	LA880,X
	ADC	#$0E
	STA	L00C3
	LDA	#$A8
	STA	L00C4
	LDA	#$00
	STA	L00C1
	LDA	#$A4
	STA	L00C2
	LDA	L00D1
	CMP	#$08
	BCS	LA971
	JMP	LAA21
LA971	LDA	#$FF
	STA	L00C8
LA975	LDA	L00C5
	STA	L00C6
	LDA	L00CB
	STA	L00C9
LA97D	INC	L00C8
	LDA	L00C9
	CMP	#$14
	BCS	LA9B4
	LDY	L00C8
	LDA	(L00B7),Y
	TAY
	LDA	(L00BF),Y
	STA	L00D2
	LDY	L00C9
	AND	(L0092),Y
	STA	L00CD
	LDA	L00D2
	AND	(L0094),Y
	STA	L00CF
	LDY	L00C8
	LDA	(L00B9),Y
	TAY
	LDA	(L00BD),Y
	ORA	L00CD
	LDY	L00C9
	STA	(L0092),Y
	LDY	L00C8
	LDA	(L00BB),Y
	TAY
	LDA	(L00BD),Y
	ORA	L00CF
	LDY	L00C9
	STA	(L0094),Y
LA9B4	INC	L00C9
	DEC	L00C6
	BNE	LA97D
	LDA	L00C9
	CMP	#$14
	BCS	LA9FD
	LDA	L00D3
	BEQ	LA9FD
	LDY	L00C8
	AND	(L00B7),Y
	BEQ	LA9FB
	TAY
	LDA	(L00C3),Y
	STA	L00D2
	LDY	L00C9
	AND	(L0092),Y
	STA	L00CD
	LDA	L00D2
	AND	(L0094),Y
	STA	L00CF
	LDY	L00C8
	LDA	(L00B9),Y
	AND	L00D3
	TAY
	LDA	(L00C1),Y
	ORA	L00CD
	LDY	L00C9
	STA	(L0092),Y
	LDY	L00C8
	LDA	(L00BB),Y
	AND	L00D3
	TAY
	LDA	(L00C1),Y
	ORA	L00CF
	LDY	L00C9
	STA	(L0094),Y
	LDA	L00D3
LA9FB	STA	L00D3
LA9FD	DEC	L00C7
	BEQ	LAA1A
	CLC
	LDA	L0094
	ADC	#$20
	STA	L0094
	BCC	LAA0C
	INC	L0095
LAA0C	SEC
	LDA	L0092
	SBC	#$20
	STA	L0092
	BCS	LAA17
	DEC	L0093
LAA17	JMP	LA975
LAA1A	PLA
	STA	L008C
	STA	CART_BANK_SELECT
	RTS
LAA21	SEC
	LDA	L0092
	SBC	#$20
	STA	L0092
	BCS	LAA2C
	DEC	L0093
LAA2C	LDA	L00CB
	CLC
	ADC	#$20
	STA	L00CC
	LDA	#$FF
	STA	L00C8
LAA37	LDA	L00C5
	STA	L00C6
	LDA	L00CB
	STA	L00C9
	LDA	L00CC
	STA	L00CA
LAA43	INC	L00C8
	LDA	L00C9
	CMP	#$14
	BCS	LAA9C
	LDY	L00C8
	LDA	(L00B7),Y
	TAY
	LDA	(L00BF),Y
	STA	L00D2
	LDY	L00C9
	AND	(L0092),Y
	STA	L00CD
	LDA	L00D2
	AND	(L0094),Y
	STA	L00CF
	LDA	L00D2
	LDY	L00CA
	AND	(L0092),Y
	STA	L00CE
	LDA	L00D2
	AND	(L0094),Y
	STA	L00D0
	LDY	L00C8
	LDA	(L00B9),Y
	TAY
	LDA	(L00BD),Y
	STA	L0080
	ORA	L00CD
	LDY	L00C9
	STA	(L0092),Y
	LDA	L0080
	ORA	L00CE
	LDY	L00CA
	STA	(L0092),Y
	LDY	L00C8
	LDA	(L00BB),Y
	TAY
	LDA	(L00BD),Y
	STA	L0080
	ORA	L00CF
	LDY	L00C9
	STA	(L0094),Y
	LDA	L0080
	ORA	L00D0
	LDY	L00CA
	STA	(L0094),Y
LAA9C	INC	L00C9
	INC	L00CA
	DEC	L00C6
	BNE	LAA43
	LDA	L00C9
	CMP	#$14
	BCS	LAB09
	LDA	L00D3
	BEQ	LAB09
	LDY	L00C8
	AND	(L00B7),Y
	BEQ	LAB07
	TAY
	LDA	(L00C3),Y
	STA	L00D2
	LDY	L00C9
	AND	(L0092),Y
	STA	L00CD
	LDA	L00D2
	AND	(L0094),Y
	STA	L00CF
	LDA	L00D2
	LDY	L00CA
	AND	(L0092),Y
	STA	L00CE
	LDA	L00D2
	AND	(L0094),Y
	STA	L00D0
	LDY	L00C8
	LDA	(L00B9),Y
	AND	L00D3
	TAY
	LDA	(L00C1),Y
	STA	L0080
	ORA	L00CD
	LDY	L00C9
	STA	(L0092),Y
	LDA	L0080
	ORA	L00CE
	LDY	L00CA
	STA	(L0092),Y
	LDY	L00C8
	LDA	(L00BB),Y
	AND	L00D3
	TAY
	LDA	(L00C1),Y
	STA	L0080
	ORA	L00CF
	LDY	L00C9
	STA	(L0094),Y
	LDA	L0080
	ORA	L00D0
	LDY	L00CA
	STA	(L0094),Y
	LDA	L00D3
LAB07	STA	L00D3
LAB09	DEC	L00C7
	BEQ	LAB26
	CLC
	LDA	L0094
	ADC	#$40
	STA	L0094
	BCC	LAB18
	INC	L0095
LAB18	SEC
	LDA	L0092
	SBC	#$40
	STA	L0092
	BCS	LAB23
	DEC	L0093
LAB23	JMP	LAA37
LAB26	PLA
	STA	L008C
	STA	CART_BANK_SELECT
	RTS
	.byte	$85
LAB2E	CMP	(L008A),Y
	AND	#$03
	STA	FR0+1
	TXA
	BMI	LAB3B
	LSR
	LSR
	BPL	LAB3F
LAB3B	SEC
	ROR
	SEC
	ROR
LAB3F	STA	L00CB
	LDA	L008C
	PHA
	LDA	#$0B
	STA	CART_BANK_SELECT
	STA	L008C
	LDX	L00D1
	LDA	LA780,X
	STA	L00C5
	LDA	LA810,X
	STA	L00B7
	LDA	LA828,X
	STA	L00B8
	LDA	LA7B0,X
	STA	L00C7
	LSR
	STA	L0080
	TYA
	SEC
	SBC	L0080
	TAY
	LDX	#$00
	STX	L0080
	ASL
	ROL	L0080
	ASL
	ROL	L0080
	ASL
	ROL	L0080
	ASL
	ROL	L0080
	ASL
	ROL	L0080
	CLC
	ADC	L0090
	STA	L0094
	LDA	L0080
	ADC	L0091
	STA	L0095
	CLC
	TYA
	ADC	L00C7
	CMP	#$33
	BCC	LABA3
	SEC
	LDA	#$32
	STY	L0080
	SBC	L0080
	STA	L00C7
	BMI	LAB9C
	BNE	LABA3
LAB9C	PLA
	STA	L008C
	STA	CART_BANK_SELECT
	RTS
LABA3	LDX	FR0+1
	LDA	LA858,X
	LDY	LA85C,X
	STA	L00BF
	INY
	STY	L00C0
	LDA	LA860,X
	STA	L00D3
	CLC
	LDA	LA880,X
	ADC	#$0E
	STA	L00C3
	LDA	#$A8
	STA	L00C4
	LDA	#$FF
	STA	L00C8
LABC5	LDA	L00C5
	STA	L00C6
	LDA	L00CB
	STA	L00C9
LABCD	INC	L00C8
	LDA	L00C9
	CMP	#$14
	BCS	LABE2
	LDY	L00C8
	LDA	(L00B7),Y
	TAY
	LDA	(L00BF),Y
	LDY	L00C9
	AND	(L0094),Y
	STA	(L0094),Y
LABE2	INC	L00C9
	DEC	L00C6
	BNE	LABCD
	LDA	L00C9
	CMP	#$14
	BCS	LAC03
	LDA	L00D3
	BEQ	LAC03
	LDY	L00C8
	AND	(L00B7),Y
	TAY
	LDA	(L00C3),Y
	LDY	L00C9
	AND	(L0094),Y
	STA	(L0094),Y
	LDA	L00D3
	STA	L00D3
LAC03	DEC	L00C7
	BEQ	LAC15
	CLC
	LDA	L0094
	ADC	#$20
	STA	L0094
	BCC	LAC12
	INC	L0095
LAC12	JMP	LABC5
LAC15	PLA
	STA	L008C
	STA	CART_BANK_SELECT
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
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$A6
	.byte	$A6
	.byte	$BD
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$AD
	.byte	$05 ; Screen code for '%'
	.byte	$A7
	.byte	$85
	.byte	$A8
	.byte	$BD
	.byte	$4F ; 'O'
	.byte	$AD
	.byte	$85
	.byte	$A9
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$B1
	.byte	$A8
	.byte	$AA
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B1
	.byte	$A8
	.byte	$60
LAD18	STA	L0080
	LDX	L00A6
	LDA	LAD2F,X
	ORA	L00A7
	STA	L00A8
	LDA	LAD4F,X
	STA	L00A9
	LDA	L0080
	LDY	#$20
	STA	(L00A8),Y
	RTS
LAD2F	.byte	$00 ; Screen code for ' '
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
; Repeating screen-code lookup table.
LAD4F	.byte	$30 ; '0' ; Screen code for 'P'
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
	.byte	$AE
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$D2
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$85
	.byte	$A6
	.byte	$BD
	.byte	$12 ; Screen code for '2'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$85
	.byte	$A7
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$00 ; Screen code for ' '
	.byte	$AD
	.byte	$C9
	.byte	$FF
	.byte	$D0
	.byte	$17 ; Screen code for '7'
	.byte	$AD
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$18 ; Screen code for '8'
	.byte	$AD
	.byte	$AE
	.byte	$70 ; 'p'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A5
	.byte	$A8
	.byte	$9D
	.byte	$72 ; 'r'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A5
	.byte	$A9
	.byte	$9D
	.byte	$92
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$EE
	.byte	$70 ; 'p'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$60
LAD9A	TAX
	LDA	MAZE_CELL_PLAYER_NEXT,X
	CMP	#$FF
	BNE	LAD9A
	LDA	MAZE_LINK_PLAYER_INDEX
	STA	MAZE_CELL_PLAYER_NEXT,X
	RTS
	.byte	$A0
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AE
	.byte	$70 ; 'p'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$CA
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$11 ; Screen code for '1'
	.byte	$BD
	.byte	$72 ; 'r'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$85
	.byte	$A8
	.byte	$BD
	.byte	$92
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$85
	.byte	$A9
	.byte	$A9
	.byte	$FF
	.byte	$91
	.byte	$A8
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$EF
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$8E
	.byte	$70 ; 'p'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$8E
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$BD
	.byte	$72 ; 'r'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$D0
	.byte	$05 ; Screen code for '%'
	.byte	$BD
	.byte	$92
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$F0
	.byte	$0B ; Screen code for '+'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6F ; 'o'
	.byte	$AD
	.byte	$AE
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A9
	.byte	$FF
	.byte	$9D
	.byte	$52 ; 'R'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$BD
	.byte	$82
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$F0
	.byte	$19 ; Screen code for '9'
	.byte	$18 ; Screen code for '8'
	.byte	$8A
	.byte	$69 ; 'i'
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$6F ; 'o'
	.byte	$AD
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$AD
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$E9
	.byte	$10 ; Screen code for '0'
	.byte	$AA
	.byte	$8D
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$A9
	.byte	$FF
	.byte	$9D
	.byte	$62 ; 'b'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$EE
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$AE
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$EC
	.byte	$6E ; 'n'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$90
	.byte	$C2
	.byte	$60
LAE09	LDA	#$00
	STA	L00A0
	LDA	L0097
	BPL	LAE24
	INC	L00A0
	SEC
	LDA	L0096
	EOR	#$FF
	ADC	#$00
	STA	L0096
	LDA	L0097
	EOR	#$FF
	ADC	#$00
	STA	L0097
LAE24	LDA	L009A
	BPL	LAE3B
	INC	L00A0
	SEC
	LDA	L0099
	EOR	#$FF
	ADC	#$00
	STA	L0099
	LDA	L009A
	EOR	#$FF
	ADC	#$00
	STA	L009A
LAE3B	JSR	LAE56
	LDA	L00A0
	AND	#$01
	BEQ	LAE55
	SEC
	LDA	L009C
	EOR	#$FF
	ADC	#$00
	STA	L009C
	LDA	L009D
	EOR	#$FF
	ADC	#$00
	STA	L009D
LAE55	RTS
LAE56	LDA	#$00
	STA	L009C
	STA	L009D
	LDA	L0099
	STA	L0080
LAE60	LSR	L0096
	BCC	LAE71
	CLC
	LDA	L009C
	ADC	L0099
	STA	L009C
	LDA	L009D
	ADC	L009A
	STA	L009D
LAE71	ASL	L0099
	ROL	L009A
	LDA	L0096
	BNE	LAE60
LAE79	LSR	L0097
	BCC	LAE84
	CLC
	LDA	L009D
	ADC	L0080
	STA	L009D
LAE84	ASL	L0080
	LDA	L0097
	BNE	LAE79
	RTS
LAE8B	LDA	PRNG_SEED_LOW
	STA	L0096
	LDA	PRNG_SEED_HIGH
	STA	L0097
	LDA	#$FB
	STA	L0099
	LDA	#$1A
	STA	L009A
	JSR	LAE09
	CLC
	LDA	L009C
	ADC	#$CD
	STA	PRNG_SEED_LOW
	LDA	L009D
	ADC	#$FC
	STA	PRNG_SEED_HIGH
	RTS
	.byte	$85
LAEB1	.byte	$AB,$AA ; (undocumented opcode) - LAX #$AA
	LDA	LAEDC,X
	STA	L00AA
LAEB8	JSR	LAE8B
	LDA	PRNG_SEED_HIGH
	ASL
	ASL
	ASL
	ASL
	STA	L0080
	LDA	PRNG_SEED_LOW
	LSR
	LSR
	LSR
	LSR
	ORA	L0080
	LDX	L00AA
	BEQ	LAED5
	CMP	L00AA
	BCS	LAEB8
LAED5	SEC
LAED6	SBC	L00AB
	BCS	LAED6
	ADC	L00AB
LAEDC	RTS
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$FC
	.byte	$00 ; Screen code for ' '
	.byte	$FC
	.byte	$FA
	.byte	$FD
	.byte	$FC
	.byte	$F7
	.byte	$FC
	.byte	$FF
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$FC
	.byte	$F7
	.byte	$F0
	.byte	$FC
	.byte	$F2
	.byte	$FD
	.byte	$F0
	.byte	$FA
	.byte	$EA
	.byte	$F3
	.byte	$FC
	.byte	$E8
	.byte	$F0
	.byte	$F8
	.byte	$00 ; Screen code for ' '
	.byte	$E7
	.byte	$EE
	.byte	$F5
	.byte	$FC
	.byte	$DE
	.byte	$E4
	.byte	$EA
	.byte	$F0
	.byte	$F6
	.byte	$FC
	.byte	$D7
	.byte	$DC
	.byte	$E1
	.byte	$E6
	.byte	$EB
	.byte	$F0
	.byte	$F5
	.byte	$FA
	.byte	$FF
	.byte	$D0
	.byte	$D4
	.byte	$D8
	.byte	$DC
	.byte	$E0
	.byte	$E4
	.byte	$E8
	.byte	$EC
	.byte	$F0
	.byte	$F4
	.byte	$F8
	.byte	$FC
	.byte	$00 ; Screen code for ' '
; Indexed bank-call trampoline. X selects entries from the target address
; and bank tables at BANK_CALL_ADDR_LO/BANK_CALL_ADDR_HI/BANK_CALL_BANK_ID. The current bank is saved
; in L008C, CART_BANK_SELECT is updated, and control jumps indirectly.
BANK_CALL_INDEXED	LDA	BANK_CALL_ADDR_LO,X
	STA	L0087
	LDA	BANK_CALL_ADDR_HI,X
	STA	L0088
	LDA	BANK_CALL_BANK_ID,X
	TAX
	LDA	L008C
	PHA
	STX	L008C
	STX	CART_BANK_SELECT
	JMP	(L0087)
; Common return point for banked routines. Restores the saved bank
; before returning to the original caller.
BANK_RETURN	STA	L0087
	PLA
	STA	L008C
	STA	CART_BANK_SELECT
	LDA	L0087
	RTS
	.byte	$84
; Alternate bank trampoline entry; exact calling convention still unverified.
LAF42	.byte	$87,$86 ; (undocumented opcode) - SAX L0086
	DEY
	TAX
	LDA	L008C
	PHA
	STX	L008C
	STX	CART_BANK_SELECT
	JMP	(L0087)
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$83
	.byte	$85
	.byte	$85
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$60
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$60
	.byte	$A5
	.byte	$83
	.byte	$C5
	.byte	$85
	.byte	$60
	.byte	$A6
	.byte	$83
	.byte	$BD
	.byte	$00 ; Screen code for ' '
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$E6
	.byte	$83
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$60
	.byte	$A6
	.byte	$85
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$E6
	.byte	$85
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$60
; Blocking read from the custom MIDI RX ring. Waits until L00B1/L00B2 differ,
; increments the read index, and returns the byte from $2F00,X in A.
MIDI_RX_READ_BLOCKING	LDX	L00B2
MIDI_RX_READ_WAIT	CPX	L00B1
	BEQ	MIDI_RX_READ_WAIT
	INC	L00B2
	LDA	L2F00,X
	RTS
; Poll the custom MIDI RX ring. Returns with Z set when empty and clear when
; unread bytes are available. A is L00B2 on return; X/Y are preserved.
MIDI_RX_HAS_BYTE	LDA	L00B2
	CMP	L00B1
	RTS
; Service slot $0D until NET_CALL_VECTOR_2 reports ready or NET_TIMEOUT_TICKS ticks pass.
; On timeout clears NET_ERROR_CODE; otherwise calls NET_CALL_VECTOR_0 and
; returns its Y/status convention unchanged.
NET_SERVICE_WAIT_POLL	CLC
	LDA	L00B3
	ADC	NET_TIMEOUT_TICKS
	STA	NET_TIMEOUT_DEADLINE
NET_SERVICE_WAIT_LOOP	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	JSR	NET_CALL_VECTOR_2
	BEQ	NET_SERVICE_WAIT_TIMEOUT_TEST
	JSR	NET_CALL_VECTOR_0
	BNE	NET_SERVICE_WAIT_DONE
	BEQ	NET_SERVICE_WAIT_POLL
NET_SERVICE_WAIT_TIMEOUT_TEST	LDA	L00B3
	CMP	NET_TIMEOUT_DEADLINE
	BMI	NET_SERVICE_WAIT_LOOP
	LDA	#$00
	STA	NET_ERROR_CODE
NET_SERVICE_WAIT_DONE	RTS
; Wait for NET_CALL_VECTOR_2 to report ready while polling slot $0D. If the
; timeout expires, stores $C7 in NET_ERROR_CODE. On success, calls
; NET_CALL_VECTOR_0 and returns NET_ERROR_CODE in Y.
NET_VECTOR_WAIT_POLL	CLC
	LDA	L00B3
	ADC	NET_TIMEOUT_TICKS
	STA	NET_TIMEOUT_DEADLINE
NET_VECTOR_WAIT_LOOP	JSR	NET_CALL_VECTOR_2
	BNE	NET_VECTOR_READY
	LDA	NET_ERROR_CODE
	BNE	NET_VECTOR_WAIT_DONE
	LDX	#$0D
	JSR	BANK_CALL_INDEXED
	LDA	L00B3
	CMP	NET_TIMEOUT_DEADLINE
	BMI	NET_VECTOR_WAIT_LOOP
	LDA	#$C7
	STA	NET_ERROR_CODE
NET_VECTOR_WAIT_DONE	RTS
NET_VECTOR_READY	JSR	NET_CALL_VECTOR_0
	LDY	NET_ERROR_CODE
	RTS
; Indirect callback vectors populated by bank 12 setup/gameplay modes.
NET_CALL_VECTOR_0	JMP	($3ED3)
NET_CALL_VECTOR_1	JMP	($3ED5)
NET_CALL_VECTOR_2	JMP	($3ED7)
NET_CALL_VECTOR_3	JMP	($3ED9)
NET_CALL_VECTOR_4	JMP	($3EDB)
NET_CALL_VECTOR_5	JMP	($3EDD)
NET_CALL_VECTOR_6	JMP	($3EDF)
; Wait until RTCLOK+2 changes. Used to pace UI/frame-visible operations.
WAIT_FOR_RTC_TICK	LDA	RTCLOK+2
WAIT_FOR_RTC_TICK_LOOP	CMP	RTCLOK+2
	BEQ	WAIT_FOR_RTC_TICK_LOOP
	RTS
; Encode direction bits from A into the status-bit field kept in L0080.
PACK_DIRECTION_TO_STATUS_BITS	STA	L0080
	ROL
	ROL
	ROL
	ROL
	AND	#$03
	TAX
	LDA	L0080
	AND	#$9F
	ORA	DIRECTION_STATUS_BITS_A,X
	RTS
DIRECTION_STATUS_BITS_A	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$60
ROTATE_DIRECTION_TO_STATUS_BITS	STA	L0080
	ROL
	ROL
	ROL
	ROL
	AND	#$03
	TAX
	LDA	L0080
	AND	#$9F
	ORA	DIRECTION_STATUS_BITS_B,X
	RTS
DIRECTION_STATUS_BITS_B	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$60
; Initialize the 37-entry bank-call table. Each packed entry is:
;   bank id, target low byte, target high byte.
; Switchable banks patch selected slots before calling BANK_CALL_INDEXED.
LB020	LDX	#$00
	LDY	#$00
LB024	LDA	LB03F,X
	INX
	STA	BANK_CALL_BANK_ID,Y
	LDA	LB03F,X
	INX
	STA	BANK_CALL_ADDR_LO,Y
	LDA	LB03F,X
	INX
	STA	BANK_CALL_ADDR_HI,Y
	INY
	CPY	#$25
	BCC	LB024
	RTS
LB03F	.byte	$00 ; Screen code for ' '
	.byte	$11 ; Screen code for '1'
	.byte	$B5
	.byte	$00 ; Screen code for ' '
	.byte	$79 ; 'y'
	.byte	$B5
	.byte	$0D ; Screen code for '-'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$0D ; Screen code for '-'
	.byte	$85
	.byte	$81
	.byte	$0E ; Screen code for '.'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$0E ; Screen code for '.'
	.byte	$11 ; Screen code for '1'
	.byte	$80
	.byte	$0E ; Screen code for '.'
	.byte	$FB
	.byte	$81
	.byte	$0E ; Screen code for '.'
	.byte	$00 ; Screen code for ' '
	.byte	$9C
	.byte	$0D ; Screen code for '-'
	.byte	$90
	.byte	$90
	.byte	$0E ; Screen code for '.'
	.byte	$9B ; '›'
	.byte	$9C
	.byte	$0D ; Screen code for '-'
	.byte	$00 ; Screen code for ' '
	.byte	$8E
	.byte	$0D ; Screen code for '-'
	.byte	$00 ; Screen code for ' '
	.byte	$99
	.byte	$0D ; Screen code for '-'
	.byte	$96
	.byte	$8E
	.byte	$0D ; Screen code for '-'
	.byte	$C0
	.byte	$8E
	.byte	$0D ; Screen code for '-'
	.byte	$F6
	.byte	$91
	.byte	$0D ; Screen code for '-'
	.byte	$15 ; Screen code for '5'
	.byte	$91
	.byte	$0D ; Screen code for '-'
	.byte	$00 ; Screen code for ' '
	.byte	$89
	.byte	$0C ; Screen code for ','
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$09 ; Screen code for ')'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$0C ; Screen code for ','
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$0F ; Screen code for '/'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$12 ; Screen code for '2'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$15 ; Screen code for '5'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$18 ; Screen code for '8'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$1B ; Screen code for ';'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$1E ; Screen code for '>'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$80
	.byte	$05 ; Screen code for '%'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$06 ; Screen code for '&'
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$04 ; Screen code for '$'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$80
PLAYER_RECORD_OFFSET_TABLE	.byte	$00 ; Screen code for ' '
	.byte	$0B ; Screen code for '+'
	.byte	$16 ; Screen code for '6'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$42 ; 'B'
	.byte	$4D ; 'M'
	.byte	$58 ; 'X'
	.byte	$63 ; 'c'
	.byte	$6E ; 'n'
	.byte	$79 ; 'y'
	.byte	$84
	.byte	$8F
	.byte	$9A
	.byte	$A5
PLAYER_RECORD_LENGTH_TABLE	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$04 ; Screen code for '$'
	.byte	$06 ; Screen code for '&'
	.byte	$09 ; Screen code for ')'
	.byte	$0C ; Screen code for ','
	.byte	$10 ; Screen code for '0'
; Clear the two 16-byte status/message line buffers at $72C0 and $72D0.
CLEAR_STATUS_LINE_BUFFERS	LDX	#$0F
	LDA	#$00
CLEAR_STATUS_LINE_BUFFERS_LOOP	STA	STATUS_LINE_BUFFER,X
	STA	STATUS_LINE_BUFFER_2,X
	DEX
	BPL	CLEAR_STATUS_LINE_BUFFERS_LOOP
	RTS
; Mark the 32-byte status/message line region dirty by setting bit 7.
MARK_STATUS_LINE_DIRTY	LDX	#$1F
	LDA	#$00
MARK_STATUS_LINE_DIRTY_LOOP	LDA	STATUS_LINE_BUFFER,X
	ORA	#$80
	STA	STATUS_LINE_BUFFER,X
	DEX
	BPL	MARK_STATUS_LINE_DIRTY_LOOP
	RTS
	.byte	$A2
LB0E6	JSR	IOCB6+9
	STA	ICCOM,X
	LDA	#$0F
	STA	ICBAL,X
	LDA	#$B1
	STA	ICBAH,X
	LDA	#$0D
	STA	ICAX1,X
	JSR	CIOV
	LDA	#$00
	STA	ICBLL,X
	STA	ICBLH,X
	TYA
	BMI	LB10B
	LDY	#$00
LB10B	STY	NET_ERROR_CODE
	RTS
	.byte	$52 ; 'R'
LB110	AND	(XMTDON),Y
	.byte	$9B,$A2,$20 ; (undocumented opcode) - SHS L20A2,Y
	LDA	#$0D
	STA	ICCOM,X
	JSR	CIOV
	BMI	LB121
	LDY	#$00
LB121	STY	NET_ERROR_CODE
	RTS
	.byte	$20 ; ' ' ; Screen code for '@'
LB126	.byte	$13,$B1 ; (undocumented opcode) - SLO (L00B1),Y
	BNE	LB12E
	LDA	DVSTAT+1
	RTS
LB12E	LDA	#$00
	RTS
	.byte	$AD
	.byte	$00 ; Screen code for ' '
	.byte	$04 ; Screen code for '$'
	.byte	$60
LB135	LDX	#$20
	LDA	#$07
	STA	ICCOM,X
	JSR	CIOV
	BMI	LB143
	LDY	#$00
LB143	STY	NET_ERROR_CODE
LB146	RTS
LB147	TAY
LB148	LDX	#$20
	LDA	#$0B
	STA	ICCOM,X
	TYA
	JSR	CIOV
	BMI	LB157
	LDY	#$00
LB157	STY	NET_ERROR_CODE
	RTS
	.byte	$A2
LB15C	JSR	L0CA9
	STA	ICCOM,X
	JSR	CIOV
	BMI	LB169
	LDY	#$00
LB169	STY	NET_ERROR_CODE
	RTS
	.byte	$20 ; ' ' ; Screen code for '@'
LB16E	.byte	$5B,$B1,$D0 ; (undocumented opcode) - SRE LD0B1,Y
	JSR	LE520
	BCS	LB146
	.byte	$1B,$AD,$0E ; (undocumented opcode) - SLO L0EAD,Y
	.byte	$3F,$F0,$02 ; (undocumented opcode) - RLA CRSINH,X
	LDA	#$0A
	LDX	#$20
	STA	ICAX1,X
	LDA	#$24
	STA	ICCOM,X
	JSR	CIOV
	BMI	LB18F
	LDY	#$00
LB18F	STY	NET_ERROR_CODE
	RTS
LB193	LDX	#$20
	LDA	#$28
	STA	ICCOM,X
	JSR	CIOV
	BMI	LB1A1
	LDY	#$00
LB1A1	STY	NET_ERROR_CODE
	RTS
	.byte	$20 ; ' ' ; Screen code for '@'
LB1A6	SBC	L00B0
	BNE	LB1AD
	JSR	LB193
LB1AD	RTS
	.byte	$A9
LB1AF	ORA	(L0085,X)
	.byte	$07,$A9 ; (undocumented opcode) - SLO L00A9
	.byte	$1B,$20,$47 ; (undocumented opcode) - SLO L4720,Y
	LDA	(L00D0),Y
	ORA	L00A9
	.byte	$5A ; (undocumented opcode) - NOP
	JSR	LB147
	LDA	#$00
	STA	TSTDAT
	LDA	NET_ERROR_CODE
	RTS
	.byte	$A9
	.byte	$01 ; Screen code for '!'
	.byte	$85
	.byte	$07 ; Screen code for '''
	.byte	$A9
	.byte	$1B ; Screen code for ';'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$47 ; 'G'
	.byte	$B1
	.byte	$D0
	.byte	$05 ; Screen code for '%'
	.byte	$A9
	.byte	$59 ; 'Y'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$47 ; 'G'
	.byte	$B1
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$07 ; Screen code for '''
	.byte	$AD
	.byte	$D2
	.byte	$3E ; '>'
	.byte	$60
LB1DE	STA	L008A
	STX	L008B
	LDA	VCOUNT
	LSR
	TAX
	CPX	#$28
	BCS	LB1F6
	LDA	LB204+1,X
	STA	COLPF0
	LDX	L008B
	LDA	L008A
	RTI
LB1F6	CPX	#$32
	BCS	LB204
	LDA	#$00
	STA	COLPF2
	LDX	L008B
	LDA	L008A
	RTI
LB204	LDA	COLOR0
	STA	COLPF0
	LDA	#$06
	STA	COLPF2
	LDX	L008B
	LDA	L008A
	RTI
	.byte	$8C
	.byte	$8C
	.byte	$8C
	.byte	$8C
	.byte	$8C
	.byte	$8C
	.byte	$8A
	.byte	$8A
	.byte	$8A
	.byte	$88
	.byte	$88
	.byte	$86
	.byte	$86
	.byte	$84
	.byte	$C2
	.byte	$C2
	.byte	$A9
	.byte	$3C ; '<'
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$B3
	.byte	$8D
	.byte	$01 ; Screen code for '!'
	.byte	$02 ; Screen code for '"'
	.byte	$AD
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$02 ; Screen code for '"'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$8D
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$1D ; Screen code for '='
	.byte	$D0
	.byte	$A2
	.byte	$03 ; Screen code for '#'
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$D0
	.byte	$9D
	.byte	$04 ; Screen code for '$'
	.byte	$D0
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F7
	.byte	$85
	.byte	$8D
	.byte	$8D
	.byte	$C6
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$A9
	.byte	$40 ; '@'
	.byte	$8D
	.byte	$0E ; Screen code for '.'
	.byte	$D4
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$80
	.byte	$A9
	.byte	$5D
	.byte	$85
	.byte	$81
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$70 ; 'p'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$4E ; 'N'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$BA
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A2
	.byte	$1A ; Screen code for ':'
	.byte	$A9
	.byte	$0E ; Screen code for '.'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$CA
	.byte	$D0
	.byte	$FA
	.byte	$A9
	.byte	$8E
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$B0
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$C2
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$5E
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A2
	.byte	$0C ; Screen code for ','
	.byte	$A9
	.byte	$02 ; Screen code for '"'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$CA
	.byte	$D0
	.byte	$FA
	.byte	$A9
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$42 ; 'B'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$C0
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$72 ; 'r'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$10 ; Screen code for '0'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$02 ; Screen code for '"'
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
	.byte	$A9
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$82
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$41 ; 'A'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$5D
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$5D
	.byte	$8D
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$02 ; Screen code for '"'
	.byte	$A2
	.byte	$D0
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$9D
	.byte	$FF
	.byte	$5D
	.byte	$9D
	.byte	$CF
	.byte	$5E
	.byte	$CA
	.byte	$D0
	.byte	$F7
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$C8
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$8D
	.byte	$C4
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$1A ; Screen code for ':'
	.byte	$8D
	.byte	$C5
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$C6
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$06 ; Screen code for '&'
	.byte	$A0
	.byte	$5F
	.byte	$A2
	.byte	$E4
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5C
	.byte	$E4
	.byte	$A9
	.byte	$07 ; Screen code for '''
	.byte	$A0
	.byte	$B1
	.byte	$A2
	.byte	$B5
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5C
	.byte	$E4
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$EF
	.byte	$AF
	.byte	$A9
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$8D
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$C0
	.byte	$8D
	.byte	$0E ; Screen code for '.'
	.byte	$D4
	.byte	$A9
	.byte	$06 ; Screen code for '&'
	.byte	$8D
	.byte	$C6
	.byte	$02 ; Screen code for '"'
	.byte	$18 ; Screen code for '8'
	.byte	$A5
	.byte	$B3
	.byte	$69 ; 'i'
	.byte	$64 ; 'd'
	.byte	$8D
	.byte	$EB
	.byte	$3E ; '>'
	.byte	$60
LB33C	STA	L008A
	LDA	VCOUNT
	CMP	#$50
	BCS	LB34D
	LDA	#$00
	STA	COLPF2
	LDA	L008A
	RTI
LB34D	LDA	COLOR2
	STA	WSYNC
	STA	COLPF2
	LDA	L008A
	RTI
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$8D
	.byte	$8D
	.byte	$C6
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$80
	.byte	$A9
	.byte	$70 ; 'p'
	.byte	$85
	.byte	$81
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$70 ; 'p'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$4E ; 'N'
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$91
	.byte	$80
	.byte	$C8
	.byte	$A9
	.byte	$60
LB381	STA	(L0080),Y
	INY
	LDX	#$1B
	LDA	#$0E
LB388	STA	(L0080),Y
	INY
	DEX
	BNE	LB388
	LDA	#$F0
	STA	(L0080),Y
	INY
	LDA	#$4E
	STA	(L0080),Y
	INY
	LDA	#$80
	STA	(L0080),Y
	INY
	LDA	#$63
	STA	(L0080),Y
	INY
	LDX	#$62
	LDA	#$0E
LB3A6	STA	(L0080),Y
	INY
	DEX
	BNE	LB3A6
	LDA	#$8E
	STA	(L0080),Y
	INY
	LDA	#$90
	STA	(L0080),Y
	INY
	LDA	#$00
	STA	(L0080),Y
	INY
	LDA	#$C2
	STA	(L0080),Y
	INY
	LDA	#$C0
	STA	(L0080),Y
	INY
	LDA	#$72
	STA	(L0080),Y
	INY
	LDA	#$10
	STA	(L0080),Y
	INY
	LDA	#$02
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	LDA	#$20
	STA	(L0080),Y
	INY
	LDA	#$82
	STA	(L0080),Y
	INY
	LDA	#$41
	STA	(L0080),Y
	INY
	LDA	#$00
	STA	(L0080),Y
	INY
	LDA	#$70
	STA	(L0080),Y
	INY
	LDA	#$8E
	LDY	#$37
	STA	(L0080),Y
	LDY	#$44
	STA	(L0080),Y
	LDY	#$4D
	STA	(L0080),Y
	LDY	#$52
	STA	(L0080),Y
	LDY	#$55
	STA	(L0080),Y
	LDY	#$5B
	STA	(L0080),Y
	JSR	LB4DE
	LDX	#$0A
	JSR	BANK_CALL_INDEXED
	LDX	#$01
	JSR	BANK_CALL_INDEXED
	LDA	#$00
	STA	HPOSP0
	STA	HPOSP1
	STA	HPOSP2
	STA	HPOSP3
	STA	HPOSM0
	STA	HPOSM1
	STA	HPOSM2
	STA	HPOSM3
	LDA	#$34
	STA	PCOLR0
	STA	PCOLR1
	STA	PCOLR2
	STA	PCOLR3
	LDA	#$58
	STA	PMBASE
	LDA	#$01
	STA	GPRIOR
	LDA	#$00
	STA	SIZEP0
	STA	SIZEP1
	STA	SIZEP2
	STA	SIZEP3
	STA	SIZEM
	LDA	#$DE
	STA	VDSLST
	LDA	#$B1
	STA	VDSLST+1
	LDA	#$40
	STA	NMIEN
	JSR	WAIT_FOR_RTC_TICK
	LDA	#$0A
	STA	COLOR0
	LDA	#$06
	STA	COLOR2
	LDA	#$00
	STA	SDLSTL
	LDA	#$70
	STA	SDLSTH
	LDA	#$3D
	STA	SDMCTL
	LDA	#$03
	STA	GRACTL
	LDA	#$C0
	STA	NMIEN
	JSR	WAIT_FOR_RTC_TICK
	LDX	#$00
	TXA
LB49B	STA	L5B00,X
	STA	L5C00,X
	STA	L5D00,X
	STA	L5E00,X
	STA	L5F00,X
	INX
	BNE	LB49B
	LDA	#$45
	STA	HPOSP0
	LDA	#$AB
	STA	HPOSP1
	LDA	#$B3
	STA	HPOSP2
	LDA	#$BB
	STA	HPOSP3
	LDA	#$7F
	STA	HPOSM0
	LDA	#$81
	STA	HPOSM1
	LDA	#$7F
	STA	HPOSM2
	LDA	#$7D
	STA	HPOSM3
	CLC
	LDA	L00B3
	ADC	#$64
	STA	SETUP_REFRESH_DEADLINE
	RTS
LB4DE	LDA	#$80
	STA	L0080
	LDA	#$73
	STA	L0081
	JSR	LB4F1
	LDA	#$80
	STA	L0080
	LDA	#$63
	STA	L0081
LB4F1	LDA	#$00
	TAY
	LDX	#$0C
LB4F6	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	BNE	LB4F6
	INC	L0081
	DEX
	BNE	LB4F6
	LDY	#$7F
LB50B	STA	(L0080),Y
	DEY
	BPL	LB50B
	RTS
; Slot $00 fixed-bank service. Fills the $7380 display region with pattern bytes.
FIXED_DRAW_FIELD_7380_FILL_ENTRY	.byte	$A5
LB512	STA	L0AD0
	LDA	#$80
	STA	L0080
	LDA	#$73
	STA	L0081
	BNE	LB527
	LDA	#$80
	STA	L0080
	LDA	#$63
	STA	L0081
LB527	LDX	#$64
LB529	LDA	#$55
	LDY	#$06
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	INY
	STA	(L0080),Y
	CLC
	LDA	L0080
	ADC	#$20
	STA	L0080
	BCC	LB573
	INC	L0081
LB573	DEX
	BNE	LB529
	JMP	BANK_RETURN
; Slot $01 fixed-bank service. Continues frame/display service and returns via BANK_RETURN.
FIXED_FRAME_DISPLAY_SERVICE_ENTRY	.byte	$A5
LB57A	STA	L1AD0
	LDA	#$73
	STA	L7024
	INC	L008D
	LDA	#$A6
	STA	L008E
	LDA	#$69
	STA	L008F
	LDA	#$C6
	STA	L0090
	LDA	#$69
	STA	L0091
	JMP	BANK_RETURN
	.byte	$A9
LB598	.byte	$63,$8D ; (undocumented opcode) - RRA (L008D,X)
	BIT	ROWAC
	DEC	L008D
	LDA	#$A6
	STA	L008E
	LDA	#$79
	STA	L008F
	LDA	#$C6
	STA	L0090
	LDA	#$79
	STA	L0091
	JMP	BANK_RETURN
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$4D ; 'M'
	.byte	$A5
	.byte	$14 ; Screen code for '4'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$03 ; Screen code for '#'
	.byte	$D0
	.byte	$02 ; Screen code for '"'
	.byte	$E6
	.byte	$B3
	.byte	$AD
	.byte	$FC
	.byte	$02 ; Screen code for '"'
	.byte	$C9
	.byte	$FF
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$5F
	.byte	$B6
	.byte	$A2
	.byte	$7F
	.byte	$8E
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$A0
	.byte	$0C ; Screen code for ','
	.byte	$88
	.byte	$D0
	.byte	$FD
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F5
	.byte	$8E
	.byte	$FC
	.byte	$02 ; Screen code for '"'
	.byte	$85
	.byte	$7C ; '|'
	.byte	$AA
	.byte	$E0
	.byte	$C0
	.byte	$90
	.byte	$02 ; Screen code for '"'
	.byte	$A2
	.byte	$03 ; Screen code for '#'
	.byte	$BD
	.byte	$FE
	.byte	$B7
	.byte	$8D
	.byte	$FB
	.byte	$02 ; Screen code for '"'
	.byte	$C9
	.byte	$80
	.byte	$F0
	.byte	$72 ; 'r'
	.byte	$C9
	.byte	$81
	.byte	$F0
	.byte	$6E ; 'n'
	.byte	$C9
	.byte	$82
	.byte	$D0
	.byte	$15 ; Screen code for '5'
	.byte	$AD
	.byte	$BE
	.byte	$02 ; Screen code for '"'
	.byte	$C9
	.byte	$80
	.byte	$D0
	.byte	$07 ; Screen code for '''
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$BE
	.byte	$02 ; Screen code for '"'
	.byte	$F0
	.byte	$5C
	.byte	$49 ; 'I'
	.byte	$40 ; '@'
	.byte	$8D
	.byte	$BE
	.byte	$02 ; Screen code for '"'
	.byte	$10 ; Screen code for '0'
	.byte	$55 ; 'U'
	.byte	$C9
	.byte	$83
	.byte	$D0
	.byte	$07 ; Screen code for '''
	.byte	$A9
	.byte	$40 ; '@'
	.byte	$8D
	.byte	$BE
	.byte	$02 ; Screen code for '"'
	.byte	$D0
	.byte	$4A ; 'J'
	.byte	$C9
	.byte	$84
	.byte	$D0
	.byte	$07 ; Screen code for '''
	.byte	$A9
	.byte	$80
	.byte	$8D
	.byte	$BE
	.byte	$02 ; Screen code for '"'
	.byte	$D0
	.byte	$3F ; '?'
	.byte	$C9
	.byte	$C0
	.byte	$90
	.byte	$15 ; Screen code for '5'
	.byte	$C9
	.byte	$CF
	.byte	$D0
	.byte	$0A ; Screen code for '*'
	.byte	$AD
	.byte	$E9
	.byte	$3E ; '>'
	.byte	$09 ; Screen code for ')'
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$E9
	.byte	$3E ; '>'
	.byte	$10 ; Screen code for '0'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$0F ; Screen code for '/'
	.byte	$8D
	.byte	$E9
	.byte	$3E ; '>'
	.byte	$10 ; Screen code for '0'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$A5
	.byte	$7C ; '|'
	.byte	$C9
	.byte	$40 ; '@'
	.byte	$B0
	.byte	$16 ; Screen code for '6'
	.byte	$AD
	.byte	$FB
	.byte	$02 ; Screen code for '"'
	.byte	$C9
	.byte	$61 ; 'a'
	.byte	$90
	.byte	$0F ; Screen code for '/'
	.byte	$C9
	.byte	$7B
	.byte	$B0
	.byte	$0B ; Screen code for '+'
	.byte	$AD
	.byte	$BE
	.byte	$02 ; Screen code for '"'
	.byte	$F0
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$7C ; '|'
	.byte	$AA
	.byte	$4C ; 'L'
	.byte	$E0
	.byte	$B5
	.byte	$AD
	.byte	$FB
	.byte	$02 ; Screen code for '"'
	.byte	$A6
	.byte	$B1
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$E6
	.byte	$B1
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$AD
	.byte	$07 ; Screen code for '''
	.byte	$3F ; '?'
	.byte	$F0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$95
	.byte	$B7
	.byte	$AD
	.byte	$D7
	.byte	$3D ; '='
	.byte	$F0
	.byte	$0B ; Screen code for '+'
	.byte	$8D
	.byte	$E1
	.byte	$3E ; '>'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$D7
	.byte	$3D ; '='
	.byte	$8D
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$AE
	.byte	$E1
	.byte	$3E ; '>'
	.byte	$F0
	.byte	$15 ; Screen code for '5'
	.byte	$CA
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$94
	.byte	$B6
	.byte	$CA
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$C5
	.byte	$B6
	.byte	$CA
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$B7
	.byte	$4C ; 'L'
	.byte	$68 ; 'h'
	.byte	$B7
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$A9
	.byte	$0F ; Screen code for '/'
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$D2
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D2
	.byte	$AE
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$BD
	.byte	$B7
	.byte	$B6
	.byte	$8D
	.byte	$01 ; Screen code for '!'
	.byte	$D2
	.byte	$E8
	.byte	$E0
	.byte	$0E ; Screen code for '.'
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$8E
	.byte	$E1
	.byte	$3E ; '>'
	.byte	$8E
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$AF
	.byte	$AD
	.byte	$AB
	.byte	$AA
	.byte	$A8
	.byte	$A7
	.byte	$A7
	.byte	$A6
	.byte	$A5
	.byte	$A4
	.byte	$A3
	.byte	$A2
	.byte	$A1
	.byte	$00 ; Screen code for ' '
	.byte	$AE
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$BD
	.byte	$F0
	.byte	$B6
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$D2
	.byte	$BD
	.byte	$00 ; Screen code for ' '
	.byte	$B7
	.byte	$8D
	.byte	$01 ; Screen code for '!'
	.byte	$D2
	.byte	$BD
	.byte	$10 ; Screen code for '0'
	.byte	$B7
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$D2
	.byte	$BD
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$B7
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D2
	.byte	$E8
	.byte	$E0
	.byte	$10 ; Screen code for '0'
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$8E
	.byte	$E1
	.byte	$3E ; '>'
	.byte	$8E
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$78 ; 'x'
	.byte	$64 ; 'd'
	.byte	$6E ; 'n'
	.byte	$5A ; 'Z'
	.byte	$64 ; 'd'
	.byte	$50 ; 'P'
	.byte	$5A ; 'Z'
	.byte	$46 ; 'F'
	.byte	$50 ; 'P'
	.byte	$3C ; '<'
	.byte	$46 ; 'F'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$3C ; '<'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$1E ; Screen code for '>'
	.byte	$AF
	.byte	$AD
	.byte	$AB
	.byte	$AA
	.byte	$A9
	.byte	$A8
	.byte	$A7
	.byte	$A6
	.byte	$A5
	.byte	$A4
	.byte	$A3
	.byte	$A2
	.byte	$A2
	.byte	$A1
	.byte	$A1
	.byte	$00 ; Screen code for ' '
	.byte	$06 ; Screen code for '&'
	.byte	$06 ; Screen code for '&'
	.byte	$07 ; Screen code for '''
	.byte	$07 ; Screen code for '''
	.byte	$08 ; Screen code for '('
	.byte	$09 ; Screen code for ')'
	.byte	$09 ; Screen code for ')'
	.byte	$0A ; Screen code for '*'
	.byte	$0B ; Screen code for '+'
	.byte	$0C ; Screen code for ','
	.byte	$0D ; Screen code for '-'
	.byte	$0F ; Screen code for '/'
	.byte	$11 ; Screen code for '1'
	.byte	$14 ; Screen code for '4'
	.byte	$19 ; Screen code for '9'
	.byte	$1E ; Screen code for '>'
	.byte	$0F ; Screen code for '/'
	.byte	$0D ; Screen code for '-'
	.byte	$0B ; Screen code for '+'
	.byte	$0A ; Screen code for '*'
	.byte	$09 ; Screen code for ')'
	.byte	$07 ; Screen code for '''
	.byte	$06 ; Screen code for '&'
	.byte	$05 ; Screen code for '%'
	.byte	$04 ; Screen code for '$'
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$01 ; Screen code for '!'
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$03 ; Screen code for '#'
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$D2
	.byte	$A9
	.byte	$FF
	.byte	$8D
	.byte	$02 ; Screen code for '"'
	.byte	$D2
	.byte	$AE
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$BD
	.byte	$58 ; 'X'
	.byte	$B7
	.byte	$8D
	.byte	$01 ; Screen code for '!'
	.byte	$D2
	.byte	$09 ; Screen code for ')'
	.byte	$C0
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D2
	.byte	$E8
	.byte	$E0
	.byte	$10 ; Screen code for '0'
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$8E
	.byte	$E1
	.byte	$3E ; '>'
	.byte	$8E
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$8F
	.byte	$8D
	.byte	$8B
	.byte	$8A
	.byte	$89
	.byte	$87
	.byte	$86
	.byte	$85
	.byte	$84
	.byte	$84
	.byte	$83
	.byte	$83
	.byte	$82
	.byte	$82
	.byte	$81
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$64 ; 'd'
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$D2
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$03 ; Screen code for '#'
	.byte	$D2
	.byte	$AE
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$BD
	.byte	$8B
	.byte	$B7
	.byte	$8D
	.byte	$01 ; Screen code for '!'
	.byte	$D2
	.byte	$E8
	.byte	$E0
	.byte	$0A ; Screen code for '*'
	.byte	$90
	.byte	$05 ; Screen code for '%'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$8E
	.byte	$E1
	.byte	$3E ; '>'
	.byte	$8E
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$AA
	.byte	$A7
	.byte	$A3
	.byte	$00 ; Screen code for ' '
	.byte	$AE
	.byte	$D7
	.byte	$3D ; '='
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$D7
	.byte	$3D ; '='
	.byte	$8D
	.byte	$E1
	.byte	$3E ; '>'
	.byte	$8A
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$CA
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$BB
	.byte	$B7
	.byte	$CA
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$CE
	.byte	$B7
	.byte	$CA
	.byte	$D0
	.byte	$03 ; Screen code for '#'
	.byte	$4C ; 'L'
	.byte	$E1
	.byte	$B7
	.byte	$4C ; 'L'
	.byte	$BB
	.byte	$B7
	.byte	$A2
	.byte	$7F
	.byte	$8E
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$A0
	.byte	$0C ; Screen code for ','
	.byte	$88
	.byte	$D0
	.byte	$FD
	.byte	$CA
	.byte	$D0
	.byte	$F5
	.byte	$8E
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$A2
	.byte	$1F ; Screen code for '?'
	.byte	$8E
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$A0
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$88
	.byte	$D0
	.byte	$FD
	.byte	$CA
	.byte	$10 ; Screen code for '0'
	.byte	$F5
	.byte	$8E
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$A9
	.byte	$02 ; Screen code for '"'
	.byte	$8D
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$8E
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$A0
	.byte	$02 ; Screen code for '"'
	.byte	$88
	.byte	$D0
	.byte	$FD
	.byte	$CA
	.byte	$D0
	.byte	$F5
	.byte	$CE
	.byte	$E2
	.byte	$3E ; '>'
	.byte	$D0
	.byte	$F0
	.byte	$8E
	.byte	$1F ; Screen code for '?'
	.byte	$D0
	.byte	$4C ; 'L'
	.byte	$62 ; 'b'
	.byte	$E4
	.byte	$6C ; 'l'
	.byte	$6A ; 'j'
	.byte	$3B ; ';'
	.byte	$80
	.byte	$80
	.byte	$6B ; 'k'
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$6F ; 'o'
	.byte	$80
	.byte	$70 ; 'p'
	.byte	$75 ; 'u'
	.byte	$9B ; '›'
	.byte	$69 ; 'i'
	.byte	$2D ; '-' ; Screen code for 'M'
	.byte	$3D ; '='
	.byte	$76 ; 'v'
	.byte	$80
	.byte	$63 ; 'c'
	.byte	$8C
	.byte	$8D
	.byte	$62 ; 'b'
	.byte	$78 ; 'x'
	.byte	$7A ; 'z'
	.byte	$34 ; '4' ; Screen code for 'T'
	.byte	$80
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$36 ; '6' ; Screen code for 'V'
	.byte	$1B ; Screen code for ';'
	.byte	$35 ; '5' ; Screen code for 'U'
	.byte	$32 ; '2' ; Screen code for 'R'
	.byte	$31 ; '1' ; Screen code for 'Q'
	.byte	$2C ; ',' ; Screen code for 'L'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$2E ; '.' ; Screen code for 'N'
	.byte	$6E ; 'n'
	.byte	$80
	.byte	$6D ; 'm'
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$81
	.byte	$72 ; 'r'
	.byte	$80
	.byte	$65 ; 'e'
	.byte	$79 ; 'y'
	.byte	$7F
	.byte	$74 ; 't'
	.byte	$77 ; 'w'
	.byte	$71 ; 'q'
	.byte	$39 ; '9' ; Screen code for 'Y'
	.byte	$80
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$37 ; '7' ; Screen code for 'W'
	.byte	$7E
	.byte	$38 ; '8' ; Screen code for 'X'
	.byte	$3C ; '<'
	.byte	$3E ; '>'
	.byte	$66 ; 'f'
	.byte	$68 ; 'h'
	.byte	$64 ; 'd'
	.byte	$80
	.byte	$82
	.byte	$67 ; 'g'
	.byte	$73 ; 's'
	.byte	$61 ; 'a'
	.byte	$4C ; 'L'
	.byte	$4A ; 'J'
	.byte	$3A ; ':' ; Screen code for 'Z'
	.byte	$8A
	.byte	$8B
	.byte	$4B ; 'K'
	.byte	$5C
	.byte	$5E
	.byte	$4F ; 'O'
	.byte	$80
	.byte	$50 ; 'P'
	.byte	$55 ; 'U'
	.byte	$9B ; '›'
	.byte	$49 ; 'I'
	.byte	$5F
	.byte	$7C ; '|'
	.byte	$56 ; 'V'
	.byte	$80
	.byte	$43 ; 'C'
	.byte	$8C
	.byte	$8D
	.byte	$42 ; 'B'
	.byte	$58 ; 'X'
	.byte	$5A ; 'Z'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$80
	.byte	$23 ; '#' ; Screen code for 'C'
	.byte	$26 ; '&' ; Screen code for 'F'
	.byte	$1B ; Screen code for ';'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$21 ; '!' ; Screen code for 'A'
	.byte	$5B
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$5D
	.byte	$4E ; 'N'
	.byte	$80
	.byte	$4D ; 'M'
	.byte	$3F ; '?'
	.byte	$81
	.byte	$52 ; 'R'
	.byte	$80
	.byte	$45 ; 'E'
	.byte	$59 ; 'Y'
	.byte	$80
	.byte	$54 ; 'T'
	.byte	$57 ; 'W'
	.byte	$51 ; 'Q'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$80
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$27 ; ''' ; Screen code for 'G'
	.byte	$80
	.byte	$40 ; '@'
	.byte	$7D
	.byte	$80
	.byte	$46 ; 'F'
	.byte	$48 ; 'H'
	.byte	$44 ; 'D'
	.byte	$80
	.byte	$83
	.byte	$47 ; 'G'
	.byte	$53 ; 'S'
	.byte	$41 ; 'A'
	.byte	$C8
	.byte	$C4
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$C0
	.byte	$80
	.byte	$80
	.byte	$C9
	.byte	$80
	.byte	$80
	.byte	$C5
	.byte	$80
	.byte	$C1
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$14 ; Screen code for '4'
	.byte	$80
	.byte	$13 ; Screen code for '3'
	.byte	$16 ; Screen code for '6'
	.byte	$80
	.byte	$15 ; Screen code for '5'
	.byte	$12 ; Screen code for '2'
	.byte	$11 ; Screen code for '1'
	.byte	$C2
	.byte	$CF
	.byte	$CA
	.byte	$80
	.byte	$80
	.byte	$C6
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$19 ; Screen code for '9'
	.byte	$80
	.byte	$10 ; Screen code for '0'
	.byte	$17 ; Screen code for '7'
	.byte	$80
	.byte	$18 ; Screen code for '8'
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$80
	.byte	$98
	.byte	$48 ; 'H'
	.byte	$AC
	.byte	$01 ; Screen code for '!'
	.byte	$D3
	.byte	$AD
	.byte	$09 ; Screen code for ')'
	.byte	$D2
	.byte	$CD
	.byte	$F2
	.byte	$02 ; Screen code for '"'
	.byte	$D0
	.byte	$05 ; Screen code for '%'
	.byte	$AD
	.byte	$F1
	.byte	$02 ; Screen code for '"'
	.byte	$D0
	.byte	$0E ; Screen code for '.'
	.byte	$AD
	.byte	$09 ; Screen code for ')'
	.byte	$D2
	.byte	$8D
	.byte	$FC
	.byte	$02 ; Screen code for '"'
	.byte	$8D
	.byte	$F2
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$03 ; Screen code for '#'
	.byte	$8D
	.byte	$F1
	.byte	$02 ; Screen code for '"'
	.byte	$A9
	.byte	$10 ; Screen code for '0'
	.byte	$8D
	.byte	$2B ; '+' ; Screen code for 'K'
	.byte	$02 ; Screen code for '"'
	.byte	$8C
	.byte	$01 ; Screen code for '!'
	.byte	$D3
	.byte	$68 ; 'h'
	.byte	$A8
	.byte	$68 ; 'h'
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
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$24 ; '$' ; Screen code for 'D'
	.byte	$B2
	.byte	$A2
	.byte	$00 ; Screen code for ' '
	.byte	$BD
	.byte	$01 ; Screen code for '!'
	.byte	$5E
	.byte	$9D
	.byte	$00 ; Screen code for ' '
	.byte	$5E
	.byte	$E8
	.byte	$D0
	.byte	$F7
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$A9
	.byte	$0F ; Screen code for '/'
	.byte	$85
	.byte	$8C
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$48 ; 'H'
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$85
	.byte	$87
	.byte	$A9
	.byte	$80
	.byte	$85
	.byte	$88
	.byte	$A9
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$85
	.byte	$80
	.byte	$68 ; 'h'
	.byte	$18 ; Screen code for '8'
	.byte	$AE
	.byte	$0A ; Screen code for '*'
	.byte	$D2
	.byte	$8E
	.byte	$00 ; Screen code for ' '
	.byte	$D5
	.byte	$A6
	.byte	$8C
	.byte	$8E
	.byte	$00 ; Screen code for ' '
	.byte	$D5
	.byte	$71 ; 'q'
	.byte	$87
	.byte	$C8
	.byte	$D0
	.byte	$EF
	.byte	$E6
	.byte	$88
	.byte	$C6
	.byte	$80
	.byte	$D0
	.byte	$E9
	.byte	$C6
	.byte	$8C
	.byte	$10 ; Screen code for '0'
	.byte	$D7
	.byte	$8D
	.byte	$FF
	.byte	$5E
	.byte	$4C ; 'L'
	.byte	$03 ; Screen code for '#'
	.byte	$B9
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$05 ; Screen code for '%'
	.byte	$54 ; 'T'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$16 ; Screen code for '6'
	.byte	$A5
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$00 ; Screen code for ' '
	.byte	$10 ; Screen code for '0'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3C ; '<'
	.byte	$0C ; Screen code for ','
	.byte	$18 ; Screen code for '8'
	.byte	$89
	.byte	$03 ; Screen code for '#'
	.byte	$03 ; Screen code for '#'
	.byte	$0C ; Screen code for ','
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$00 ; Screen code for ' '
	.byte	$50 ; 'P'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$0C ; Screen code for ','
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3F ; '?'
	.byte	$0C ; Screen code for ','
	.byte	$54 ; 'T'
	.byte	$89
	.byte	$43 ; 'C'
	.byte	$03 ; Screen code for '#'
	.byte	$0C ; Screen code for ','
	.byte	$3F ; '?'
	.byte	$3C ; '<'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$41 ; 'A'
	.byte	$44 ; 'D'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$3C ; '<'
	.byte	$F3
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$0C ; Screen code for ','
	.byte	$55 ; 'U'
	.byte	$8A
	.byte	$43 ; 'C'
	.byte	$03 ; Screen code for '#'
	.byte	$3F ; '?'
	.byte	$03 ; Screen code for '#'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$45 ; 'E'
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$3C ; '<'
	.byte	$F3
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$CC
	.byte	$65 ; 'e'
	.byte	$6A ; 'j'
	.byte	$43 ; 'C'
	.byte	$CF
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$0F ; Screen code for '/'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$54 ; 'T'
	.byte	$00 ; Screen code for ' '
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$FF
	.byte	$F3
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$CC
	.byte	$69 ; 'i'
	.byte	$5A ; 'Z'
	.byte	$43 ; 'C'
	.byte	$CF
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$0C ; Screen code for ','
	.byte	$3F ; '?'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$04 ; Screen code for '$'
	.byte	$04 ; Screen code for '$'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$CF
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$CC
	.byte	$6A ; 'j'
	.byte	$56 ; 'V'
	.byte	$43 ; 'C'
	.byte	$FF
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3C ; '<'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$40 ; '@'
	.byte	$05 ; Screen code for '%'
	.byte	$14 ; Screen code for '4'
	.byte	$50 ; 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$03 ; Screen code for '#'
	.byte	$CF
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$0C ; Screen code for ','
	.byte	$62 ; 'b'
	.byte	$95
	.byte	$43 ; 'C'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3F ; '?'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$30 ; '0' ; Screen code for 'P'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
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
	.byte	$40 ; '@'
	.byte	$05 ; Screen code for '%'
	.byte	$10 ; Screen code for '0'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$03 ; Screen code for '#'
	.byte	$0C ; Screen code for ','
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3F ; '?'
	.byte	$0C ; Screen code for ','
	.byte	$58 ; 'X'
	.byte	$05 ; Screen code for '%'
	.byte	$43 ; 'C'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
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
	.byte	$54 ; 'T'
	.byte	$01 ; Screen code for '!'
	.byte	$10 ; Screen code for '0'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$03 ; Screen code for '#'
	.byte	$0C ; Screen code for ','
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3C ; '<'
	.byte	$0C ; Screen code for ','
	.byte	$1A ; Screen code for ':'
	.byte	$29 ; ')' ; Screen code for 'I'
	.byte	$03 ; Screen code for '#'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$33 ; '3' ; Screen code for 'S'
	.byte	$3F ; '?'
	.byte	$3F ; '?'
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
	.byte	$45 ; 'E'
LBB85	.byte	$01 ; Screen code for '!'
	.byte	$10 ; Screen code for '0'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$16 ; Screen code for '6'
	.byte	$A5
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$41 ; 'A'
	.byte	$41 ; 'A'
	.byte	$10 ; Screen code for '0'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$54 ; 'T'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$51 ; 'Q'
	.byte	$10 ; Screen code for '0'
	.byte	$40 ; '@'
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
	.byte	$50 ; 'P'
	.byte	$10 ; Screen code for '0'
	.byte	$00 ; Screen code for ' '
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
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$12 ; Screen code for '2'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$56 ; 'V'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$12 ; Screen code for '2'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$55 ; 'U'
	.byte	$52 ; 'R'
	.byte	$02 ; Screen code for '"'
	.byte	$0A ; Screen code for '*'
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A8
	.byte	$01 ; Screen code for '!'
	.byte	$50 ; 'P'
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$82
	.byte	$A8
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$82
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$02 ; Screen code for '"'
	.byte	$A0
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$15 ; Screen code for '5'
	.byte	$55 ; 'U'
	.byte	$4A ; 'J'
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A2
	.byte	$AA
	.byte	$55 ; 'U'
	.byte	$40 ; '@'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$A2
	.byte	$A8
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$82
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$8A
	.byte	$A2
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A1
	.byte	$55 ; 'U'
	.byte	$55 ; 'U'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$25 ; '%' ; Screen code for 'E'
	.byte	$55 ; 'U'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$88
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$82
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$54 ; 'T'
	.byte	$00 ; Screen code for ' '
	.byte	$15 ; Screen code for '5'
	.byte	$55 ; 'U'
	.byte	$42 ; 'B'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$02 ; Screen code for '"'
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$82
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$A8
	.byte	$0A ; Screen code for '*'
	.byte	$88
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$15 ; Screen code for '5'
	.byte	$55 ; 'U'
	.byte	$50 ; 'P'
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$0A ; Screen code for '*'
	.byte	$A2
	.byte	$02 ; Screen code for '"'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$88
	.byte	$02 ; Screen code for '"'
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$05 ; Screen code for '%'
	.byte	$55 ; 'U'
	.byte	$55 ; 'U'
	.byte	$55 ; 'U'
	.byte	$01 ; Screen code for '!'
	.byte	$55 ; 'U'
	.byte	$55 ; 'U'
	.byte	$41 ; 'A'
	.byte	$40 ; '@'
	.byte	$00 ; Screen code for ' '
	.byte	$82
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$0A ; Screen code for '*'
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$A0
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$88
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$55 ; 'U'
	.byte	$55 ; 'U'
	.byte	$6A ; 'j'
	.byte	$02 ; Screen code for '"'
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$A1
	.byte	$55 ; 'U'
	.byte	$54 ; 'T'
	.byte	$00 ; Screen code for ' '
	.byte	$82
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$08 ; Screen code for '('
	.byte	$22 ; '"' ; Screen code for 'B'
	.byte	$A8
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$8A
	.byte	$A2
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$01 ; Screen code for '!'
	.byte	$60
	.byte	$00 ; Screen code for ' '
	.byte	$AA
	.byte	$00 ; Screen code for ' '
	.byte	$80
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$02 ; Screen code for '"'
	.byte	$01 ; Screen code for '!'
	.byte	$40 ; '@'
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$02 ; Screen code for '"'
	.byte	$A2
	.byte	$A8
	.byte	$2A ; '*' ; Screen code for 'J'
	.byte	$80
	.byte	$0A ; Screen code for '*'
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$0A ; Screen code for '*'
	.byte	$82
	.byte	$A0
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$02 ; Screen code for '"'
	.byte	$A8
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$02 ; Screen code for '"'
	.byte	$00 ; Screen code for ' '
	.byte	$20 ; ' ' ; Screen code for '@'
	.byte	$02 ; Screen code for '"'
	.byte	$A0
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$28 ; '(' ; Screen code for 'H'
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$4C ; 'L'
	.byte	$17 ; Screen code for '7'
	.byte	$BE
	.byte	$4C ; 'L'
	.byte	$E9
	.byte	$BE
	.byte	$4C ; 'L'
	.byte	$C7
	.byte	$BE
	.byte	$4C ; 'L'
	.byte	$F7
	.byte	$BE
	.byte	$4C ; 'L'
	.byte	$FD
	.byte	$BE
	.byte	$4C ; 'L'
	.byte	$67 ; 'g'
	.byte	$BF
; Minimal command monitor over the custom MIDI serial link.
; Command byte dispatch observed here:
;   0: send $FF acknowledgement.
;   1: read address and jump indirectly.
;   2: read address and return byte at that address.
;   3: read address, read one byte, and store it at that address.
;   >=4: use command as high byte, receive a 256-byte page, return checksum.
CART_STRT	LDX	#$12
	JSR	BANK_CALL_INDEXED
	JSR	MIDI_INSTALL
MIDI_COMMAND_LOOP	LDA	RANDOM
	STA	COLBK
	JSR	MIDI_RX_COUNT
	BEQ	MIDI_COMMAND_LOOP
	JSR	MIDI_READ_BYTE_BLOCKING
	CMP	#$00
	BEQ	MIDI_ACK_COMMAND
	CMP	#$01
	BEQ	MIDI_JUMP_COMMAND
	CMP	#$02
	BEQ	MIDI_PEEK_COMMAND
	CMP	#$03
	BEQ	MIDI_POKE_COMMAND
	STA	L0088
	STA	L0089
	LDA	#$00
	STA	L0087
; Receive 256 bytes into page $xx00, where xx is the command byte.
; L0089 accumulates a checksum that is sent back after the page wraps.
MIDI_LOAD_PAGE_COMMAND	LDA	RANDOM
	STA	COLPF1
	JSR	MIDI_RX_COUNT
	BEQ	MIDI_LOAD_PAGE_COMMAND
	JSR	MIDI_READ_BYTE_BLOCKING
	LDY	#$00
	STA	(L0087),Y
	CLC
	ADC	L0089
	STA	L0089
	INC	L0087
	BNE	MIDI_LOAD_PAGE_COMMAND
	LDA	L0089
	JSR	MIDI_SEND_BYTE
	JMP	MIDI_COMMAND_LOOP
MIDI_ACK_COMMAND	LDA	#$FF
	JSR	MIDI_SEND_BYTE
	JMP	MIDI_COMMAND_LOOP
MIDI_JUMP_COMMAND	JSR	MIDI_READ_ADDRESS
	JSR	MIDI_JUMP_INDIRECT
	JMP	MIDI_COMMAND_LOOP
MIDI_JUMP_INDIRECT	JMP	(L0087)
MIDI_PEEK_COMMAND	JSR	MIDI_READ_ADDRESS
	LDY	#$00
	LDA	(L0087),Y
	JSR	MIDI_SEND_BYTE
	JMP	MIDI_COMMAND_LOOP
MIDI_POKE_COMMAND	JSR	MIDI_READ_ADDRESS
	JSR	MIDI_READ_BYTE_BLOCKING
	LDY	#$00
	STA	(L0087),Y
	JMP	MIDI_COMMAND_LOOP
; Read little-endian address into L0087/L0088 for command handlers.
MIDI_READ_ADDRESS	JSR	MIDI_READ_BYTE_BLOCKING
	STA	L0087
	JSR	MIDI_READ_BYTE_BLOCKING
	STA	L0088
	RTS
	.byte	$98
; VSERIN handler: read POKEY SERIN into the RX ring buffer.
; Indexes intentionally wrap as 8-bit values.
MIDI_RX_ISR	PHA
	LDA	SERIN
	LDY	L0082
	STA	MIDI_RX_BUFFER,Y
	INC	L0082
	PLA
	TAY
	PLA
	RTI
	.byte	$98
; VSEROR handler: feed the next queued TX byte to POKEY SEROUT.
; When the TX ring is empty, L0086 is cleared to mark the transmitter idle.
MIDI_TX_ISR	PHA
	LDY	L0084
	CPY	L0085
	BEQ	LBEBF
	LDA	MIDI_TX_BUFFER,Y
	STA	SEROUT
	INC	L0084
	JMP	LBEC3
LBEBF	LDA	#$00
	STA	L0086
LBEC3	PLA
	TAY
	PLA
	RTI
; Queue one byte for MIDI transmit. If the transmitter is idle, the byte
; is written directly to SEROUT; otherwise it is appended to the TX ring.
MIDI_SEND_BYTE	SEI
	LDY	L0086
	BNE	LBED5
	STA	SEROUT
	INC	L0086
	CLI
	LDY	#$00
	RTS
LBED5	LDY	L0085
	STA	MIDI_TX_BUFFER,Y
	INY
	STY	L0085
	CLI
LBEDE	TYA
	SEC
	SBC	L0084
	CMP	#$F8
	BCS	LBEDE
	LDY	#$00
	RTS
; Blocking MIDI receive: wait until RX read and write indexes differ,
; then return the next byte from the RX ring.
MIDI_READ_BYTE_BLOCKING	LDY	L0083
	CPY	L0082
	BEQ	MIDI_READ_BYTE_BLOCKING
	LDA	MIDI_RX_BUFFER,Y
	INC	L0083
	LDY	#$00
	RTS
; Return RX ring occupancy as write-minus-read with natural 8-bit wrap.
MIDI_RX_COUNT	LDA	L0083
	SEC
	SBC	L0082
	RTS
; Install custom MIDI/SIO handlers and program POKEY for direct serial I/O.
; This bypasses normal CIO/SIO transfer routines and hooks OS serial vectors.
MIDI_INSTALL	SEI
	LDA	#$3C
	STA	PACTL
	LDA	#$3C
	STA	PBCTL
	LDY	#$03
LBF0A	LDA	VSERIN,Y
	STA	L3DF8,Y
	DEY
	BPL	LBF0A
; Install VSERIN = MIDI_RX_ISR ($BE9C/$BE9D entry sequence) and
; VSEROR = MIDI_TX_ISR ($BEAC/$BEAD entry sequence). The preceding
; saved Y byte is preserved as raw data, so the vector targets the
; byte before the visible handler label.
	LDA	#$9C
	STA	VSERIN
	LDA	#$BE
	STA	VSERIN+1
	LDA	#$AC
	STA	VSEROR
	LDA	#$BE
	STA	VSEROR+1
	LDA	#$00
	LDY	#$05
LBF2B	STA	L0082,Y
	DEY
	BPL	LBF2B
	LDA	#$28
	STA	AUDCTL
	LDA	#$A0
	STA	AUDC3
	STA	AUDC4
	LDA	#$15
	STA	AUDF3
	LDA	#$00
	STA	AUDF4
	LDA	#$13
	STA	SSKCTL
	STA	SKCTL
	STA	SKREST
	LDA	POKMSK
	AND	#$F0
	ORA	#$30
	STA	POKMSK
	STA	IRQEN
	CLI
	LDA	#$34
	STA	PACTL
	LDY	#$00
	RTS
	.byte	$A5
LBF68	STX	L00D0
	.byte	$FC,$A0,$53 ; (undocumented opcode) - NOP	$53A0,X
; Remove the custom MIDI/SIO handlers and restore saved OS serial vectors.
MIDI_REMOVE	DEY
	BNE	MIDI_REMOVE
	LDA	#$3C
	STA	PACTL
	LDA	POKMSK
	AND	#$C0
	SEI
	STA	POKMSK
	STA	IRQEN
	LDY	#$03
LBF81	LDA	L3DF8,Y
	STA	VSERIN,Y
	DEY
	BPL	LBF81
	CLI
	LDY	#$00
	RTS
CART_INIT	LDA	WARMST
	BMI	LBF95
	JSR	LB020
LBF95	LDA	#$06
	LDY	#$9E
	LDX	#$BF
	JMP	SETVBV
; Raw cartridge tail bytes/vectors preserved until the exact structure is verified.
	.byte	$A9
	.byte	$00 ; Screen code for ' '
	.byte	$8D
	.byte	$2F ; '/' ; Screen code for 'O'
	.byte	$02 ; Screen code for '"'
	.byte	$8D
	.byte	$00 ; Screen code for ' '
	.byte	$D4
	.byte	$4C ; 'L'
	.byte	$5F
	.byte	$E4
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$00 ; Screen code for ' '
	.byte	$12 ; Screen code for '2'
	.byte	$BE
	.byte	$00 ; Screen code for ' '
	.byte	$05 ; Screen code for '%'
	.byte	$8E
	.byte	$BF

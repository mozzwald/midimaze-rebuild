; Atari 8-bit hardware registers used by the cartridge source.
;
; Many hardware registers are read-only, write-only, mirrored, or have
; side effects. Keep source changes around these addresses byte-verified.

; GTIA
HPOSP0	= $D000
HPOSP1	= $D001
HPOSP2	= $D002
HPOSP3	= $D003
HPOSM0	= $D004
HPOSM1	= $D005
HPOSM2	= $D006
HPOSM3	= $D007
SIZEP0	= $D008
SIZEP1	= $D009
SIZEP2	= $D00A
SIZEP3	= $D00B
SIZEM	= $D00C
COLPF0	= $D016
COLPF1	= $D017
COLPF2	= $D018
COLBK	= $D01A
GRACTL	= $D01D
CONSOL	= $D01F

; POKEY
AUDC1	= $D201
AUDF3	= $D204
AUDC3	= $D205
AUDF4	= $D206
AUDC4	= $D207
AUDCTL	= $D208
RANDOM	= $D20A
SKREST	= $D20A
SEROUT	= $D20D
SERIN	= $D20D
IRQEN	= $D20E
IRQST	= $D20E
SKCTL	= $D20F
SKSTAT	= $D20F

; PIA
PACTL	= $D302
PBCTL	= $D303

; ANTIC
PMBASE	= $D407
WSYNC	= $D40A
VCOUNT	= $D40B
NMIEN	= $D40E

; Unverified hardware aliases preserved from the disassembly.
KBCODE	= $D209
AUDC2	= $D203

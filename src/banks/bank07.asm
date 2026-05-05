	opt h-

	icl "include/atari_os.inc"
	icl "include/hardware.inc"
	icl "include/cartridge.inc"
	icl "include/game_ram.inc"
	icl "include/fixed_bank.inc"

; Bank 07: switchable 8KB cartridge bank, mapped at $8000-$9FFF.
; Original bank is entirely $FF fill. Keep collapsed as a repeat directive
; so the emitted 8192 bytes remain exact without pretending this is code.
; Bank map:
;   $8000-$9FFF  8192 bytes of $FF fill.

	org $8000
:8192	.byte	$ff

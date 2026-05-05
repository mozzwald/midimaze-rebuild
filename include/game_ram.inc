; Confirmed game-private RAM structures.
;
; Keep this file limited to addresses whose role is proven across call sites.
; Ambiguous scratch labels should remain local generated Lxxxx symbols.

BANK_CALL_ADDR_LO	= $3D3E
BANK_CALL_ADDR_HI	= $3D66
BANK_CALL_BANK_ID	= $3D8E

MIDI_RX_BUFFER	= $2D00
MIDI_TX_BUFFER	= $2E00

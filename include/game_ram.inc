; Confirmed game-private RAM structures.
;
; Keep this file limited to addresses whose role is proven across call sites.
; Ambiguous scratch labels should remain local generated Lxxxx symbols.

BANK_CALL_ADDR_LO	= $3D3E
BANK_CALL_ADDR_HI	= $3D66
BANK_CALL_BANK_ID	= $3D8E

MIDI_RX_BUFFER	= $2D00
MIDI_TX_BUFFER	= $2E00

; Networking/setup state. Names here are based on current reverse-engineering
; notes and matching cross-references in bank 12; keep uncertain scratch local.
LOCAL_PLAYER_INDEX	= $3968
PRNG_SEED_LOW	= $3969
PRNG_SEED_HIGH	= $396A
HUMAN_PLAYER_COUNT	= $396B
TOTAL_PLAYER_COUNT	= $396E
MAZE_SIZE_INDEX	= $396F

NET_ERROR_CODE	= $3ED2
PENDING_NET_COMMAND	= $3EE7
OUTGOING_NET_COMMAND	= $3EE8
BOT_COUNT_TARGET	= $3EED
BOT_COUNT_DRONE	= $3EEE
BOT_COUNT_NINJA	= $3EEF
BOT_COUNT_NASTY	= $3F13

CMD_INIT_RING	= $80
CMD_CLEAR_STATE	= $81
CMD_HOLD_SYNC	= $82
MARKER_SETUP_PAYLOAD	= $83
CMD_RESYNC	= $84
CMD_ROSTER_EXCHANGE	= $86
CMD_START_GAME	= $87
ERR_GAME_TERMINATED	= $02
ERR_NETWORK	= $04
ERR_CHECKSUM	= $07
ERR_CANT_SYNC	= $0A

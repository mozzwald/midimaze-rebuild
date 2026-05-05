; Resident service routines in fixed bank 15.
; Switchable banks call these by absolute address while mapped at $8000-$9FFF.

BANK_CALL_INDEXED	= $AF1D
BANK_RETURN	= $AF36

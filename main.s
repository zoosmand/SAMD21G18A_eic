Stack_Size EQU 0x00000400

  AREA STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem SPACE Stack_Size
__initial_sp


Heap_Size EQU 0x00000200

  AREA HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem SPACE Heap_Size
__heap_limit



  PRESERVE8
  THUMB

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  AREA RESET, DATA, READONLY
  ALIGN

  GET samd21g18a.inc
  GET vectors.inc
  GET macroses.inc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  AREA |.text|, CODE, READONLY
  ALIGN

  GBLA	GCNT
GCNT SETA	0


tmpa     RN R1
tmpd     RN R2
tmp      RN R7


; Events Register Flags
_MEIF_   EQU 0 ; Main Event Interval Flag


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ENTRY
  AREA |.text|, CODE, READONLY

  GET init.inc


;======================== MAIN Loop ===========================;
MAIN PROC

  FLAG_CHK "clear", _EREG_, _MEIF_, _MAIN_sleep
  FLAG "clear", _EREG_, (1<<_MEIF_)
  BL LED_BLINK_EIC

_MAIN_sleep
  WFI
  B.N MAIN
_MAIN_exit
  B.N MAIN
  ENDP
;==============================================================;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  AREA |.text|, CODE, READONLY
  ALIGN
  GET utils.inc
  GET interrupts.inc

  GET var.inc

  END

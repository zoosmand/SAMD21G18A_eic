__Utils

;============== LED Blink on External Interrupt ===============;
LED_BLINK_EIC PROC
  PUSH {R1-R3, LR}
ledPinEic	RN R3
  LDR ledPinEic, =BIT_POS_4

  LDR tmpa, =PORT0
  LDR tmpd, [tmpa, #PORT_IN_offset]
  LDR tmp, =BIT_POS_14
  TST tmpd, tmp
  BEQ _LED_BLINK_EIC_UP

_LED_BLINK_EIC_DOWN
  STR ledPinEic, [tmpa, #PORT_OUTSET_offset]
  B _LED_BLINK_EIC_EXIT

_LED_BLINK_EIC_UP
  STR ledPinEic, [tmpa, #PORT_OUTCLR_offset]

_LED_BLINK_EIC_EXIT
  POP {R1-R3, PC}
  ENDP
;==============================================================;



  END

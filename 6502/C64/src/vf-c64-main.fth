
hex

2 drive 27 30 thru

1 drive

Onlyforth hex
  c    load   \ clear memory and
  d e  thru   \ clr labels  .status

\ *** Block No. 9, Hexblock 9

\ Target-Machine              clv06dec88

cr .( Host is: )
    (64  .( C64) C)
    (16  .( C16) C)

       : )     ; immediate
       : (C    ; immediate

       : (C64  ; immediate
\      : (C16  ; immediate
\      : (C16+ ; immediate
\      : (C16- ; immediate

\      : (C64  [compile] ( ; immediate
       : (C16  [compile] ( ; immediate
       : (C16+ [compile] ( ; immediate
       : (C16- [compile] ( ; immediate


include vf-main.fth

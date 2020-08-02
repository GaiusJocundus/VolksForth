\ A SINUS-TABLE               20OCT87RE
\    SINUS-TABLE FROM FD Vol IV/1

\needs code    INCLUDE" D:TAS65.FS"

| : TABLE    ( VALUES N -)
 CREATE 0 DO , LOOP
 ;CODE       ( N - VALUE)
 SP X) LDA  CLC  1 # ADC  .A ASL  TAY
 W )Y LDA  SP X) STA
 INY  W )Y LDA  1 # LDY  SP )Y STA
 NEXT JMP  END-CODE

10000 9998 9994 9986 9976 9962 9945 9925
 9903 9877 9848 9816 9781 9744 9703 9659
 9613 9563 9511 9455 9397 9336 9272 9205
 9135 9063 8988 8910 8829 8746 8660 8572
 8480 8387 8290 8192 8090 7986 7880 7771
 7660 7547 7431 7314 7193 7071 6947 6820
 6691 6561 6428 6293 6157 6018 5878 5736
 5592 5446 5299 5150 5000 4848 4695 4540
 4384 4226 4067 3907 3746 3584 3420 3256
 3090 2924 2756 2588 2419 2250 2079 1908
 1736 1564 1392 1219 1045 0872 0698 0523
 0349 0175 0000

&91 | TABLE SINTABLE

| : S180   ( DEG -- SIN*10000:SIN 0-180)
 DUP &90 >
   IF &180 SWAP - THEN
 SINTABLE ;

: SIN     ( DEG -- SIN*10000)
 &360 MOD DUP 0< IF &360 + THEN
 DUP &180 >
    IF &180 - S180 NEGATE
    ELSE S180 THEN ;

: COS     ( DEG -- COS*10000)
 &360 MOD &90 + SIN ;

: TAN     ( DEG -- TAN*10000)
 DUP SIN SWAP COS ?DUP
   IF &100 SWAP */ ELSE 3 * THEN ;

CODE D2*  ( D1 - D2)
 2 # LDA SETUP JSR
 N 2+ ASL N 3 + ROL  N ROL N 1+ ROL
 SP 2DEC N 3 + LDA SP )Y STA
 N 2+ LDA SP X) STA
 SP 2DEC N 1+ LDA SP )Y STA
 N LDA SP X) STA
 NEXT JMP END-CODE

: DU< &32768 + ROT &32768 + ROT ROT D< ;

| : EASY-BITS  ( N1 -- N2)
 0 DO
  >R D2* D2*  R@ -  DUP 0<
    IF   R@ +   R> 2* 1-
    ELSE        R> 2* 3 +
    THEN 
  LOOP ;

| : 2'S-BIT
 >R D2* DUP 0<
  IF    D2* R@ - R> 1+
  ELSE  D2* R@ 2DUP U<
   IF DROP R> 1-  ELSE -  R> 1+  THEN
  THEN ;

| : 1'S-BIT
 >R DUP 0<
  IF 2DROP R> 1+
  ELSE D2* &32768 R@  DU< 0=
    NEGATE R> +
  THEN ;

: SQRT    ( UD1 - U2)
 0 1  8 EASY-BITS
 ROT DROP 6 EASY-BITS
 2'S-BIT 1'S-BIT ;

\ Test
\
\ : XX  
\ &16 * &62500 UM*
\ SQRT 0 <# # # # ASCII . HOLD #S #>
\ TYPE SPACE ;

CODE 100*  ( N1 - N2)
 SP X) LDA  N STA  SP )Y LDA  N 1+ STA
 N ASL N 1+ ROL  N ASL N 1+ ROL
 N LDA N 2+ STA  N 1+ LDA N 3 + STA
 N 2+ ASL N 3 + ROL  N 2+ ASL N 3 + ROL 
 N 2+ ASL N 3 + ROL
 CLC N LDA N  2+ ADC N STA
  N 1+ LDA N 3 + ADC N 1+ STA
 N 2+  ASL N 3 + ROL
 CLC N LDA N  2+ ADC  SP X) STA
  N 1+ LDA N 3 + ADC  SP )Y STA
 NEXT JMP END-CODE

LABEL 4/+
 N 7 + LSR N 6 + ROR N 5 + ROR N 4 + ROR
 N 7 + LSR N 6 + ROR N 5 + ROR N 4 + ROR
 CLC N  LDA N 4 + ADC N     STA
  N 1+  LDA N 5 + ADC N 1+  STA
  SP X) LDA N 6 + ADC SP X) STA
  SP )Y LDA N 7 + ADC SP )Y STA  RTS

CODE  100U/  ( U - N)
 N STX  N 4 + STX
 SP X) LDA  .A ASL N 1+  STA  N 5 + STA
 SP )Y LDA  .A ROL SP X) STA  N 6 + STA
 TXA .A ROL        SP )Y STA  N 7 + STA
 4/+ JSR
 N 7 + LSR N 6 + ROR N 5 + ROR N 4 + ROR
 4/+ JSR
 NEXT JMP END-CODE


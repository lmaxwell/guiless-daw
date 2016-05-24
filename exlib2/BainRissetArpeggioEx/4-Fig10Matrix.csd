; Csound Journal (Issue 17)
; Bain, Risset's Arpeggio 
; Code example file: 4-Fig10Matrix.csd

<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 13

idur      =         p3

ampenv    linen     2100,.02,idur,.5
                                             
a1        oscili    ampenv,p4,5 ; Nine sinusoids with
a2        oscili    ampenv,p5,5 ; same amplitude
a3        oscili    ampenv,p6,5 ; envelope and phase         
a4        oscili    ampenv,p7,5             
a5        oscili    ampenv,p8,5             
a6        oscili    ampenv,p9,5             
a7        oscili    ampenv,p10,5            
a8        oscili    ampenv,p11,5
a9        oscili    ampenv,p12,5

          out       (a1+a2+a3+a4+a5+a6+a7+a8+a9)/9
          endin


</CsInstruments>
<CsScore>

; Sine wave
f5 0 4096 10 1

; FIG. 10: 7x9 FREQUENCY MATRIX

; Rows presented individually, in high-to-low frequency order,
; so that it is easy to hear the distinct beating patterns produced
; by each mistuned source spectrum component set

;    st  idur  p4    p5      p6      p7      p8      p9     p10     p11     p12
i13  0   10    1000  1001    1002    1003    1004    1005   1006    1007    1008  ; Row 7
i13  +   .     900   900.9   901.8   902.7   903.6   904.5  905.4   906.3   907.2 ; Row 6
i13  +   .     800   800.8   801.6   802.4   803.2   804.0  804.8   805.6   806.4 ; Row 5
i13  +   .     700   700.7   701.4   702.1   702.8   703.5  704.2   704.9   705.6 ; Row 4
i13  +   .     600   600.6   601.2   601.8   602.4   603.0  603.6   604.2   604.8 ; Row 3
i13  +   .     500   500.5   501.0   501.5   502.0   502.5  503.0   503.5   504.0 ; Row 2
i13  +   .     100   100.1   100.2   100.3   100.4   100.5  100.6   100.7   100.8 ; Row 1
s

; Rows superposed, in high-to-low frequency order, 
; so that it is easy to hear the polyrhythmic relationships

;    st  idur  p4    p5      p6      p7      p8      p9     p10     p11     p12
i13  0   70    1000  1001    1002    1003    1004    1005   1006    1007    1008  ; Row 7
i13  10  60    900   900.9   901.8   902.7   903.6   904.5  905.4   906.3   907.2 ; Row 6
i13  20  50    800   800.8   801.6   802.4   803.2   804.0  804.8   805.6   806.4 ; Row 5
i13  30  40    700   700.7   701.4   702.1   702.8   703.5  704.2   704.9   705.6 ; Row 4
i13  40  30    600   600.6   601.2   601.8   602.4   603.0  603.6   604.2   604.8 ; Row 3
i13  50  20    500   500.5   501.0   501.5   502.0   502.5  503.0   503.5   504.0 ; Row 2
i13  60  10    100   100.1   100.2   100.3   100.4   100.5  100.6   100.7   100.8 ; Row 1
s

; All rows presented simultaneously, Risset's arpeggio

;    st  idur  p4    p5      p6      p7      p8      p9     p10     p11     p12
i13  0   10    100   100.1   100.2   100.3   100.4   100.5  100.6   100.7   100.8 ; Row 1
i13  .   .     500   500.5   501.0   501.5   502.0   502.5  503.0   503.5   504.0 ; Row 2
i13  .   .     600   600.6   601.2   601.8   602.4   603.0  603.6   604.2   604.8 ; Row 3
i13  .   .     700   700.7   701.4   702.1   702.8   703.5  704.2   704.9   705.6 ; Row 4
i13  .   .     800   800.8   801.6   802.4   803.2   804.0  804.8   805.6   806.4 ; Row 5
i13  .   .     900   900.9   901.8   902.7   903.6   904.5  905.4   906.3   907.2 ; Row 6
i13  .   .     1000  1001    1002    1003    1004    1005   1006    1007    1008  ; Row 7
s

e
</CsScore>
</CsoundSynthesizer>

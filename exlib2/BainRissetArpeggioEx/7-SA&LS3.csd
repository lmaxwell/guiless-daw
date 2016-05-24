; Csound Journal (Issue 17)
; Bain, Risset's Arpeggio 
; Code example file: 7-SA&LS3.csd
; Boulanger 2000a, ACCCI v1.2, Bain 2011


<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 2

idur      =         p3
ifreq     =         2 * (p4 * 0.1) ; For GEN09 partial
                                   ; specification
iamp      =         p5
ienv      =         p6

ideltaf   =         p7

i1        =         ideltaf
i2        =         2*ideltaf
i3        =         3*ideltaf
i4        =         5*ideltaf
                    
iwf       =         p8
igldst    =         p9

ipani     =         p10
ipanf     =         p11

aenv      oscili    iamp,1/idur,ienv

kfreq     expon     ifreq,idur,igldst*ifreq
                                             
a1        oscili    aenv,kfreq,iwf              

a2        oscili    aenv,kfreq+i1,iwf
a3        oscili    aenv,kfreq-i1,iwf

a4        oscili    aenv,kfreq+i2,iwf         
a5        oscili    aenv,kfreq-i2,iwf

a6        oscili    aenv,kfreq+i3,iwf
a7        oscili    aenv,kfreq-i3,iwf

a8        oscili    aenv,kfreq+i4,iwf
a9        oscili    aenv,kfreq-i4,iwf

kpan      linseg    ipani,idur,ipanf
kangle    =         kpan*3.141592*0.5
kpanl     =         sin(kangle)
kpanr     =         cos(kangle)

asig1     =         a1+a3+a5+a7+a9
asig2     =         a1+a2+a4+a6+a8

          outs      kpanl*asig1,kpanr*asig2
          
          endin     

</CsInstruments>
<CsScore>

; Fibonacci amplitude envelope
f6 0 1025 7 0 128 1 128 .8 256 .3 257 0

; Inharmonic source spectra (Fibonacci and Lucas)

;            1.3       2.1       3.4       5.5       8.9       14.4       23.3
f41 0 4096 9 13 .89 0  21 .55 0  34 .34 0  55 .21 0  89 .13 0  144 .08 0  233 .05 0

;            1.1       1.8       2.9       4.7       7.6       12.3       19.9
f42 0 4096 9 11 .89 0  18 .55 0  29 .34 0  47 .21 0  76 .13 0  123 .08 0  199 .05 0

; Inharmonic tone examples (Fibonacci and Lucas)
; Bain 2011, 2:58-3:08

;   st   idur  ifreq   iamp    ienv   ideltaf   iwf    igldst   ipani   ipanf
i2  0    10    60      3230    6      .01       41     1.0      .99     .01  ; L->R     

;   st   idur  ifreq   iamp    ienv   ideltaf   iwf    igldst   ipani   ipanf
i2  10   10    60      3230    6      .01       42     1.0      .01     .99  ; R->L      

; Inharmonic glissando tone examples (Fibonacci and Lucas)

;   st   idur  ifreq   iamp    ienv   ideltaf   iwf    igldst   ipani   ipanf
i2  20   10    60      3230    6      .01       41     2.0      .99     .01  ; L->R     

;   st   idur  ifreq   iamp    ienv   ideltaf   iwf    igldst   ipani   ipanf
i2  30   10    60      3230    6      .01       42     .5       .01     .99  ; R->L 
s

; Spiral canons
; Bain 2011, 4:10-5:09

t 0 55 13 89 34 89 55 233 68 144 75 233 89 1996

;   st   idur  ifreq   iamp    ienv   ideltaf   iwf    igldst   ipani   ipanf
i2  0    34    60      3230    6      .01       41     1.0      .99     .01  ; L->R
i2  8    26    58      3230    6      .01       41     2.67     .01     .99  ; R->L
i2  13   21    57      3230    6      .02       41     4.3      .99     .01  ; L->R
i2  21   13    47      3230    6      .03       41     7.0      .01     .99  ; R->L

;   st   idur  ifreq   iamp    ienv   ideltaf   iwf    igldst   ipani   ipanf
i2  33   34    60      3230    6      .01       42     1.0      .99     .01  ; L->R
i2  41   26    57      3230    6      .03       42     2.67     .01     .99  ; R->L
i2  46   21    55      3230    6      .04       42     4.3      .99     .01  ; L->R
i2  54   13    49      3230    6      .07       42     7.0      .01     .99  ; R->L

;   st   idur  ifreq   iamp    ienv   ideltaf   iwf    igldst   ipani   ipanf
i2  55   21    60      5226    6      .01       41     1.0      .99     .01  ; L->R
i2  55   21    59      5226    6      .02       41     1.0      .01     .99  ; R->L
i2  60   16    58      3230    6      .03       41     7.0      .99     .01  ; L->R
i2  60   16    385     3230    6      .05       41     .143     .01     .99  ; R->L
i2  63   13    52      3230    6      .05       41     11.3     .99     .01  ; L->R
i2  63   13    587.6   3230    6      .05       41     .088     .01     .99  ; R->L
i2  68   9     47      3230    6      .03       41     11.3     .99     .01  ; L->R
i2  68   9     714.87  3230    6      .03       41     .055     .01     .99  ; R->L
s

e

</CsScore>
</CsoundSynthesizer>

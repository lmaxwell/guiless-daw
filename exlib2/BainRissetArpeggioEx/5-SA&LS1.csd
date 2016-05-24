; Csound Journal (Issue 17)
; Bain, Risset's Arpeggio 
; Code example file: 5-SA&LS1.csd
; Boulanger 2000a, ACCCI v1.2, Bain 2011

<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


          instr 1

idur      =         p3
ifreq     =         p4
iamp      =         p5
ienv      =         p6

ideltaf   =         p7

i1        =         ideltaf
i2        =         2*ideltaf
i3        =         3*ideltaf
i4        =         5*ideltaf
                    
iwf       =         p8
igldst    =         p9

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

asig1     =         a1+a3+a5+a7+a9
asig2     =         a1+a2+a4+a6+a8

          outs      asig1,asig2
          
          endin   
          
          instr 3

idur      =         p3
ifreq     =         p4
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

kpan      linseg    ipani, idur, ipanf
kangle    =         kpan*3.141592*0.5
kpanl     =         sin(kangle)
kpanr     =         cos(kangle)

asig1     =         a1+a3+a5+a7+a9
asig2     =         a1+a2+a4+a6+a8

          outs      kpanl*asig1,kpanr*asig2
          
          endin       

</CsInstruments>
<CsScore>

; REGINALD BAIN, STRANGE ATTRACTORS & LOGARITHMIC SPIRALS

; Risset sounds
; Bain 2011, 0:40-1:20

; Source spectra

;             1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20
f11 0 4096 10 0  0  0  0  0  0  0  0  0  0  0  .8 0  0  0  .5 0  0  0  .3
f12 0 4096 10 0  0  0  0  0  0  0  0  0  0  0  .8 0  0  .5  0 0  .3
f13 0 4096 10 0  0  0  0  0  0  0  .8 .8 .8 .8 .8 .8 0  .8 .8
f50 0 4096 10 0  .8 .5 0  .3 0  0  .2 0  0  0  0  .1

; Fibonacci amplitude envelope
f6 0 1025 7 0 128 1 128 .8 256 .5 256 .3 257 0

t 0 34 12 89 13 55 32 89

;  st   idur    ifreq   iamp    ienv   ideltaf   iwf    iglsdt
i1 0    21      20      1234    6      .02       50     1
i1 13   8       20      1234    6      .03       50     1

;  st   idur    ifreq   iamp    ienv   ideltaf   iwf    iglsdt   ipani   ipanf
i3 0    4       40      1234    6      .02       50     1        .99     .01  ; L->R
i3 4    4       30      1234    6      .03       50     1        .01     .99  ; R->L
i3 8    4       20      1234    6      .00       50     1        .99     .01  ; L->R

;  st   idur    ifreq   iamp    ienv   ideltaf   iwf    iglsdt
i1 0    8       20      1996    6      .01       11     1
i1 0    8       40      1996    6      .01       11     1
i1 4    8       20      1996    6      .02       12     1
i1 4    8       40      1996    6      .02       12     1
i1 11   8       20      1996    6      .03       11     1
i1 11   8       40      1996    6      .03       11     1

;  st   idur    ifreq   iamp    ienv   ideltaf   iwf    iglsdt   ipani   ipanf
i3 12   9       40      3230    6      .09       13     1        .01     .99  ; R->L
i3 12   9       80      3230    6      .09       13     1        .99     .01  ; L->R
i3 12   9       40.1    3230    6      .09       13     1        .01     .99  ; R->L
i3 12   9       80.1    3230    6      .09       13     1        .99     .01  ; L->R

;  st   idur    ifreq   iamp    ienv   ideltaf   iwf    igliss   ipani   ipanf
i3 13   7       10      1996    6      .02       50     1        .99     .01  ; L->R
i3 13   7       10      1996    6      .02       50     1.618    .01     .99  ; R->L
i3 13   7       10      1996    6      .03       50     1.618    .99     .01  ; L->R

;  st   idur    ifreq   iamp    ienv   ideltaf   iwf    igliss   ipani   ipanf
i3 21   15      5       111     6      .03       11     1        .99     .01  ; L->R
i3 21   15      10      111     6      .05       11     1        .01     .99  ; R->L
i3 21   15      40      180     6      .03       11     1        .01     .99  ; R->L
i3 21   15      80      180     6      .05       11     1        .99     .01  ; L->R

</CsScore>
</CsoundSynthesizer>

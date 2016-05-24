; Csound Journal (Issue 17)
; Bain, Risset's Arpeggio 
; Code example file: 6-SA&LS2.csd
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

aenv      oscili    iamp, 1/idur, ienv

kfreq     expon     ifreq, idur, igldst * ifreq
                                             
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

          outs      asig1, asig2
          
          endin       

</CsInstruments>
<CsScore>

; REGINALD BAIN, STRANGE ATTRACTORS & LOGARITHMIC SPIRALS

; Spectral harmonies
; Bain 2011, 6:53-7:37

; Source spectra

;             1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20
f11 0 1024 10 0  0  0  0  0  0  0  0  0  0  0  .8 0  0  0  .5 0  0  0  .3
f12 0 1024 10 0  0  0  0  0  0  0  0  0  0  0  .8 0  0  .5  0 0  .3
f13 0 1024 10 0  0  0  0  0  0  0  .8 .8 .8 .8 .8 .8 0  .8 .8
f14 0 1024 10 0  0  0  0  0  0  0  0  0  0  .8 0  0  0  .5  0 0  0 .3
f15 0 1024 10 0  0  0  0  0  0  0  0  0  0  .8 0  0  .5  0  0 .3
f16 0 1024 10 0  0  0  0  0  0  0  0  0  .8 0  0  0  .5  0  0 0 .3
f17 0 1024 10 0  0  0  0  0  0  0  0  0  .8 0  0  .5  0  0 .3
f18 0 1024 10 0  0  0  0  0  0  0  0  .8 0  0  0  .5  0  0 0 .5
f19 0 1024 10 0  0  0  0  0  0  0  0  .8 0  0  .5 0   0 .5

; Fibonacci envelope
f6 0 1025 7 0 128 1 128 .8 256 .3 257 0 

;   st   idur    ifreq   iamp    ienv   ideltaf   iwf    igldst
i1  2    5       32.36   2100    6      .02       11     1
i1  2    5       64.72   2100    6      .01       11     1  
i1  6    5       32.36   2100    6      .03       12     1
i1  6    5       64.72   2100    6      .02       12     1  

i1  10   5       32.36   2100    6      .03       14     1
i1  10   5       64.72   2100    6      .02       14     1  
i1  14   5       32.36   2100    6      .05       15     1
i1  14   5       64.72   2100    6      .03       15     1  

i1  18   8       32.36   2100    6      .03       16     1
i1  18   8       64.72   2100    6      .02       16     1  
i1  20   5       32.36   2100    6      .05       17     1
i1  20   5       64.72   2100    6      .03       17     1  

i1  23   8       32.36   2100    6      .05       18     1
i1  23   8       64.72   2100    6      .03       18     1  
i1  27   5       32.36   2100    6      .08       19     1
i1  27   5       64.72   2100    6      .05       19     1  

; Natural scale

; gliss. up two octaves
i1  31   8       32.36   2100    6      .09       13     4   
; static
i1  31   8       64.72   2100    6      .09       13     1   
; gliss. down two octaves
i1  31   8       129.44  2100    6      .09       13     .25 

e

</CsScore>
</CsoundSynthesizer>

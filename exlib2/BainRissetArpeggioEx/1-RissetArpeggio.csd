; Csound Journal (Issue 17)
; Bain, Risset's Arpeggio
; Code example file: 1-RissetArpeggio.csd
; Boulanger 2000a, ACCCI v1.2

<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 10

idur      =         p3
ifreq     =         p4
iamp      =         p5
ideltaf   =         p6
irise     =         p7
idecay    =         p8
iwf       =         p9

i1        =         ideltaf
i2        =         2*ideltaf
i3        =         3*ideltaf
i4        =         4*ideltaf
                    
aenv      linen     iamp,irise,idur,idecay
                                             
a1        oscili    aenv,ifreq,iwf              

a2        oscili    aenv,ifreq+i1,iwf
a3        oscili    aenv,ifreq-i1,iwf

a4        oscili    aenv,ifreq+i2,iwf         
a5        oscili    aenv,ifreq-i2,iwf

a6        oscili    aenv,ifreq+i3,iwf
a7        oscili    aenv,ifreq-i3,iwf

a8        oscili    aenv,ifreq+i4,iwf
a9        oscili    aenv,ifreq-i4,iwf

          out       a1+a2+a3+a4+a5+a6+a7+a8+a9
          
          endin

</CsInstruments>
<CsScore>

;             HARMONIC PARTIAL NUMBERS 
;             1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16
f1  0 4096 10 1  0  0  0  .7 .7 .7 .7 .7 .7
f2  0 4096 10 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  
f3  0 4096 10 0  0  0  1  1  1
f4  0 4096 10 0  0  0  0  0  0  0  1  1  1  1  1  1  0  1  1

; Risset's arpeggio, f1, short duration
;       st      idur    ifreq   iamp    ifdelta  irise   idecay   iwf
i10     0       7       96      2100    .03      .02     .5       1      

; Risset's arpeggio, f1, longer duration
;       st      idur    ifreq   iamp    ifdelta  irise   idecay   iwf
i10     10      27      96      2100    .03      .02     .5       1      

; Risset's arpeggio, f2, G2 partials 1-16
;       st      idur    ifreq   iamp    ifdelta  irise   idecay   iwf
i10     40      17      96      2100    .03      .02     .5       2

; Risset's arpeggio, f3, G2 partials 4-6
;       st      idur    ifreq   iamp    ifdelta  irise   idecay   iwf
i10     60      17      96      2100    .03      .02     .5       3 

; Risset's arpeggio, f4, G2 partials 8-16, with 14 omitted
;       st      idur    ifreq   iamp    ifdelta  irise   idecay   iwf
i10     80      17      96      2100    .03      .02     .5       4 

e

</CsScore>
</CsoundSynthesizer>

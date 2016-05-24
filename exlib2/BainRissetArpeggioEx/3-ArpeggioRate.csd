; Csound Journal (Issue 17)
; Bain, Risset's Arpeggio 
; Code example file: 3-ArpeggioRate.csd
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

          out       (a1+a2+a3+a4+a5+a6+a7+a8+a9)/9
          
          endin
                    
</CsInstruments>
<CsScore>

;             HARMONIC PARTIAL NUMBERS
;             1  2  3  4  5  6  7  8  9  10
f98  0 4096 10 0  0  0  0  0  0  0  1  1  1 ; B5-A5-G5
f99  0 4096 10 0  0  0  1  1  1             ; D5-B4-G4

; Risset's arpeggio, rate control using ideltaf

; B5-A5-G5

;    st      idur    ifreq   iamp    ideltaf  irise   idecay   iwf
i10  0       9       96      5500    .01      .02     .5       98      
i10  10      .       .       .       .02      .       .        .   
i10  20      .       .       .       .03      .       .        .      
i10  30      .       .       .       .05      .       .        .      
i10  40      .       .       .       .08      .       .        .      
i10  50      .       .       .       .13      .       .        .     
i10  60      .       .       .       .21      .       .        .      
i10  70      .       .       .       .34      .       .        .      
i10  80      .       .       .       .55      .       .        .      
i10  90      .       .       .       .89      .       .        .      
s

; D5-B4-G4

;    st      idur    ifreq   iamp    ideltaf  irise   idecay   iwf
i10  0       9       96      5500    .01      .02     .5       99      
i10  10      .       .       .       .02      .       .        .   
i10  20      .       .       .       .03      .       .        .      
i10  30      .       .       .       .05      .       .        .      
i10  40      .       .       .       .08      .       .        .      
i10  50      .       .       .       .13      .       .        .     
i10  60      .       .       .       .21      .       .        .      
i10  70      .       .       .       .34      .       .        .      
i10  80      .       .       .       .55      .       .        .      
i10  90      .       .       .       .89      .       .        .      
s

e

</CsScore>
</CsoundSynthesizer>

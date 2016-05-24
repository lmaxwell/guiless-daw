; Csound Journal (Issue 17)
; Bain, Risset's Arpeggio 
; Code example file: 2-Beats.csd

<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 11

idur      =         p3
if1       =         p4               ; Frequency 1
if2       =         p5               ; Frequency 2

aenv      linen     2100,.02,idur,.5 ; Amplitude envelope
                                             
a1        oscili    aenv,if1,5       ; Two sinusoids with same 
a2        oscili    aenv,if2,5       ; amplitude envelope and phase

          out       a1+a2

          endin
          
          instr 12

idur      =         p3
if1       =         p4               ; Frequency 1
if2       =         p5               ; Frequency 2

aenv      linen     2100,.02,idur,.5 ; Amplitude envelope
                                          
kfreq     expon     if1,idur,if2     ; Glissando control signal

a1        oscili    aenv,if1,5       ; Static sine
a2        oscili    aenv,kfreq,5     ; Sine glissando from 
                                     ; if1 to if2
          out       a1+a2

          endin


</CsInstruments>
<CsScore>

; Sine wave
f5 0 4096 10 1

; BEATING BETWEEN TWO SINUSOIDS WITH CLOSE FREQUENCIES

;       st      idur    if1     if2  ; BEAT FREQUENCY [DELTAF]
i11     0       4       441     440 ; 1 beat per sec [1]
i11     5       .       439     440 ; Also 1 beat per sec [1]
i11     10      .       442     440 ; 2 beats per sec [2]
i11     15      .       443     440 ; 3 beats per sec [3]
i11     20      .       445     440 ; 5 beats per sec [5]
i11     25      .       448     440 ; 8 beats per sec [8]
i11     30      .       453     440 ; 13 beats per sec [13]
i11     35      .       461     440 ; [21]
i11     40      .       474     440 ; [34]
i11     45      .       495     440 ; [55]
s ; end section

;       st      idur    if1     if2 ; BEAT FREQUENCY [DELTAF]
i11     0       9       440.1   440 ; 1 beat per 10 sec [1/10]
i11     10      .       440.2   440 ; 2 beats per 10 sec 
                                    ; [2/10 = 1/5]
i11     20      .       440.3   440 ; 3 beats per 10 sec [3/10]
i11     30      .       440.5   440 ; 5 beats per 10 sec 
                                    ; [5/10 = 1/2]
s

;       st      idur    if1     if2 ; BEAT FREQUENCY [DELTAF]
i11     0       4       441.3   440 ; 1.3 beats per sec [1.3]
i11     5       .       442.1   440 ; 2.1 beats per sec [2.1]
i11     10      .       443.4   440 ; 3.4 beats per sec [3.4]
i11     15      .       445.5   440 ; 5.5 beats per sec [5.5]
s

;       st      idur    if1     if2  ; BEAT FREQUENCY [DELTAF]
i11     0       25      440.08  440  ; 8 beats per 100 secords 
                                     ; [8/100 = 2/25]
s

; TONE EXPERIMENT
; UNISON -> BEATING -> ROUGHNESS -> TWO SEPARATE TONES

; if1 is a static A4 440 Hz, if2 varies from 440 
; to 660 Hz, up a 3:2 fifth

;       st      idur    if1     if2
i12     1       24      440     660     ; 
                                        ; 
; if1 is a static A4 440 Hz, if2 varies from 440
; to 293.333 Hz, down a 3:2 fifth                                       

i12     25      24      440     293.333

s

e
</CsScore>
</CsoundSynthesizer>

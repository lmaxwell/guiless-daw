<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>
; tremolo orc

	sr = 44100
	kr = 4410
	ksmps = 10
	nchnls = 1

	instr	1

iamp = ampdb(p4)	;conversione da decibel ad ampiezza assoluta

kfreq randi p5, p6, -1	;calcolo random della variazione di frequenza per lfo

klfo oscil .2, kfreq, p7;lfo

;kvar = klfo+1

;a1 oscili iamp*klfo, 440, 1

atrem   loscil  iamp*klfo, 4000, 4, 4000, 1, 0, 88000;lettura del campione e modulazione d'ampiezza


	out atrem
	
	endin

</CsInstruments>
<CsScore>
; tremolo sco

f1      0	4096 	10 	1 				  ;sinusoide
f2	0	4096	10	10 5 3.3 2.5 2 1.6 1.4 1.25 1.1 1 ;dente di sega approssimata
f3	0	4096	10	10 0 3.3 0   2 0   1.4 0    1.1   ;quadra approssimata

f4 0 0 1 "barra1.WAV" 0 0 0 ;importazione del campione in una tabella


;	p2:start p3:dur	p4:ampdb p5:frqmin p6:frqmax p7:ondalfo
i1	0	 2	90	 8	   10	     1
i1	2.5	 2	90	 8	   10	     2
i1	5	 2	90	 8	   10	     3	
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>1266</x>
 <y>61</y>
 <width>396</width>
 <height>800</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>0</r>
  <g>0</g>
  <b>0</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
<MacGUI>
ioView nobackground {0, 0, 0}
</MacGUI>

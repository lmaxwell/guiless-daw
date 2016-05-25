Scale scale;
scale.set(70,"ionian");
Chord chord;
RissetChordBeat rb => Mixer.bus[0];
0.4=>Mixer.bus[0].send[0].gain;
rb.set(20);
BPM bpm;
bpm.set(120);
4=>float t;
while(true)
{
    chord.set(scale.get(1),"major7");
    rb.play(chord,t*BPM.quarterNote);
    chord.set(scale.get(4),"major7");
    rb.play(chord,t*BPM.quarterNote);
    t%6+4=>t;
    <<<t>>>;
}


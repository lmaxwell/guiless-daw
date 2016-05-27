Scale scale;
scale.set(60,"ionian");
Chord chord;
RissetChordBeat rb => Mixer.bus[0];
0.4=>Mixer.bus[0].send[0].gain;
BPM bpm;
bpm.set(120);
4=>float t;

LFO lfo;
spork ~lfo.am(rb,8,10,2::samp,10::samp);

while(true)
{
    Math.random2(1,20)=>int num;
    <<<num>>>;
    rb.set(num);
    chord.set(scale.get(1),"major7");
    rb.play(chord,t*BPM.quarterNote);
    chord.set(scale.get(4),"major7");
    rb.play(chord,t*BPM.quarterNote);
    t%6+4=>t;
    <<<t>>>;
}




MandolinBass bass => dac;
Scale scale;
scale.set(24,"aeolian");
Chord chord;
chord.set(24,"minor");
while(true)
{
    chord.sample()=>Std.mtof=>bass.freq;
    1.0=>bass.noteOn;
    200::ms=>now;
    1.0=>bass.noteOff;
}

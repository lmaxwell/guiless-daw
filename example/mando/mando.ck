

Chord chord;
chord.set(50,"major7");
Scale scale;
scale.set(50,"ionian");

MandoPlayer m => Mixer.bus[0];
0.4=>Mixer.bus[0].send[0].gain;

repeat(4)
{
    m.damp(Math.randomf());
    chord.set(50,"major7");
    m.roll(chord,200::ms);

    m.strum(scale.note[1]+12,2::second);

    chord.set(55,"major7");
    m.roll(chord,200::ms);

    m.strum(scale.note[4]+12,2::second);
}



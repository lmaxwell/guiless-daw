SinOsc s =>  Mixer.bus[0];

4000=>s.freq;

LFO lfo;
13=>lfo.freq;
1=>lfo.gain;
spork ~lfo.am(s,2,20,1::samp,150::samp);

while(true)
{
    1::samp=>now;
}



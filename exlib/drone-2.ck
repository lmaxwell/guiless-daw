
// modulator, carrier, demon bunny filter!
SinOsc m => SqrOsc c => LPF f => HPF g => JCRev r => dac;
// gain
.1 => r.gain;
// reverb mix
.05 => r.mix;

// sync for FM synthesis
2 => c.sync;

Scale scale;
scale.set(50,"lydian");
FibonacciSeq fibo;
fibo.set(scale.note.cap());

float freq;
// carrier freq
60 => Std.mtof => c.freq;
<<<c.freq()>>>;
// modulator freq
200 => m.freq;
// index of modulation
200 => m.gain;
spork ~tune();

// go 
while( true )
{
    // carrier freq
    scale.note[fibo.genNext()] => Std.mtof =>freq; 
    freq=>c.freq;
    // modulator freq
    freq/261.626*200.0 => m.freq;
    // index of modulation
    200 => m.gain;
    4::second=>now;
}

fun void tune()
{
    while(true)
    {
        // be careful: invalid filter params can blow up!
        c.freq()*1.5 + c.freq()*
            Math.sin( now/second*.7 ) => f.freq;
        // set high pass cutoff
        f.freq() / 2 => g.freq;

        // set resonances on low and high pass
        4 => f.Q;
        2 => g.Q;
        
        // time step
        5::ms => now;
    }
}

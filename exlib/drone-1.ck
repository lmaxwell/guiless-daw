// FM synth
SinOsc m => SqrOsc c => JCRev r => dac;
// gain
.05 => r.gain;
// reverb mix
.05 => r.mix;

// sync for FM synthesis
2 => c.sync;

Scale scale;
scale.set(60,"lydian");
FibonacciSeq fibo;
fibo.set(scale.note.cap());

float freq;

// go
while( true ) 
{
    // carrier freq
    scale.note[fibo.genNext()] => Std.mtof =>freq; 
    freq=>c.freq;
    // modulator freq
    freq/261.00*200.0 => m.freq;
    // index of modulation
    200 => m.gain;
    1::second => now;
}

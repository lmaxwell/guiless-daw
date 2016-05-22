SinOsc s => dac;

BPM bpm;
bpm.set(120);

0=>int beat;
0=>int i;
0=>int j;

Scale scale;
scale.set(50,"dorian");

FibonacciSeq fibo;
fibo.set(scale.note.cap()); // fibo.set(7)

int k;
while(beat<112)
{
    fibo.genNext()=>k;
    <<<k>>>;
    scale.note[k]+Math.random2(0,1)*12=>Std.mtof=>s.freq;
    bpm.eighthNote=>now;

    beat++;
}


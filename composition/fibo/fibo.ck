SinOsc s => Mixer.chan[0];
s=>RtGrain rtgrain  => Mixer.chan[1];
0.8=>Mixer.chan[1].pan;

//spork ~rtgrain.run();

BPM bpm;
bpm.set(160);
bpm.quarterNote-(now%bpm.quarterNote)=>now;

1=>int beat;
0=>int i;
0=>int j;

Scale scale;
scale.set(50,"lydian");

FibonacciSeq fibo;
fibo.set(scale.note.cap()); // fibo.set(7)

EuclidSeq seq;
seq.set(8,7,0);

int k;
while(true)
{
    fibo.genNext()=>k;
    <<<k>>>;
    if(seq.genNext())
    {
        changeGain(1.0);
        scale.note[k]+Math.random2(0,1)*12=>Std.mtof=>s.freq;
    }
    else
        changeGain(0.0);
    bpm.eighthNote=>now;

    if(beat%32==0)
    {
        seq.random();
        <<<"change">>>;
    }
    beat++;
}

fun void changeGain(float newGain)
{
    s.gain()=>float oldGain;
    50::ms+now=>time _time;
    newGain-oldGain=>float diff;
    while(now<_time)
    {
        s.gain()=>oldGain;
        oldGain+(diff)/50.0=>s.gain;
        1::ms=>now;
    }
    
}


fun void tune()
{
    while(true)
    {
        seq.random();
        bpm.eighthNote*8=>now;
        <<<"change">>>;
    }
}

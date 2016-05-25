
BPM bpm;
bpm.set(120);

FibonacciArp fibarp => Mixer.bus[0];
0.6=>Mixer.bus[0].send[0].gain;

fibarp.set(26,bpm.quarterNote/4);

Scale scale;
scale.set(20,"lydian");

float freq;
while(true)
{
    fibarp.randAmp();
    scale.sample()=>Std.mtof =>freq;
    fibarp.setFreq(freq);
    fibarp.setRate(bpm.quarterNote/(Math.random2(1,6)));
    fibarp.noteOn();
    bpm.quarterNote*4=>now;
    fibarp.noteOff();
    bpm.quarterNote =>now;
}

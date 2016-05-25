
Scale scale;
scale.set(70,"lydian");
RissetNoteBeat rb => Mixer.bus[0];
0.4=>Mixer.bus[0].send[0].gain;
BPM bpm;
bpm.set(120);
while(true)
{
    Math.random2(2,50)=>int num;
    <<<num>>>;
    rb.set(num);
    scale.sample()=>Std.mtof=>float freq;
    rb.play(freq,bpm.quarterNote*Math.random2(1,8));
}


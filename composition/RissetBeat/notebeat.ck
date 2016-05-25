
Scale scale;
scale.set(70,"lydian");
RissetNoteBeat rb => Mixer.bus[0];
0.4=>Mixer.bus[0].send[0].gain;
rb.set(20);
while(true)
{
    scale.sample()=>Std.mtof=>float freq;
    rb.play(freq,2::second);
}



SndBuf kick=>Pan2 panKick=>Dyno comp[2] => Gain drumGain[2]=>Moe moe=>dac;
"samples/RolandTr808/BassDrum/KickDrum0001.aif"=>kick.read;
kick.samples()=>kick.pos;


SndBuf snare=>Pan2 panSnare=>comp;
"samples/RolandTr808/SnareDrum/SnareDrum0001.aif"=>snare.read;
0.46=>panSnare.pan;
snare.samples()=>snare.pos;


SndBuf clhat=>Pan2 panClhat=>comp;
"samples/RolandTr808/cHihat/Closed Hihat0001.aif"=>clhat.read;
0.3=>panClhat.pan;
clhat.samples()=>clhat.pos;

comp[0].compress;
comp[1].compress;

0.5=>drumGain[0].gain => drumGain[1].gain;



spork ~moe.run();

spork ~playComponent(kick,1000::ms);
spork ~playComponent(clhat,250::ms);
500::ms=>now;
spork ~playComponent(snare,1000::ms);
while(true)
{
    100::ms=>now;
}

fun void playComponent(SndBuf s,dur d)
{
    while(true)
    {
        0=>s.pos;
        d=>now;
    }
}






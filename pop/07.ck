Mixer.master.set();
0.5=>Mixer.master.gain;
Scale scale;
scale.set(70,"aeolian");
Chord chord;
RissetChordBeat rcb => ABSaturator sat => Mixer.bus[0];
8=>sat.drive;
4=>sat.dcOffset;
0.6=>Mixer.bus[0].gain;
0.5=>Mixer.bus[0].send[0].gain;
//-0.5=>Mixer.bus[0].pan;
BPM bpm;
bpm.set(120);
FbDelay fbd;
fbd.setTime(bpm.quarterNote*3.0/4.0);
fbd.setFeedBack(0.6);
fbd.setMix(1);
//rcb=>fbd=>Mixer.bus[1];

bpm.quarterNote-now%bpm.quarterNote => now;
//Machine.add("util/rec-auto-stereo.ck");


Impulse i => Moe moe => Mixer.bus[2];
Dinky dk => moe;
0.5=>dk.gain;
i=>Larry larry => Mixer.bus[2];
dk =>larry;
0.8=>Mixer.bus[2].gain;
-0.9=>Mixer.bus[2].pan;
0.9=>Mixer.fxdelay.pan;
0.5=>Mixer.bus[2].send[0].gain;
0.0=>Mixer.bus[2].send[1].gain;
Mixer.fxdelay.fbdelay.setTime(bpm.quarterNote*3.0/4.0);
//Mixer.fxdelay.fbdelay.setFeedBack(0.8);
spork ~moe.run();
spork ~larry.run();


RissetNoteBeat rnb=> ABSaturator satrnb => Mixer.bus[1];
8=>satrnb.drive;
4=>satrnb.dcOffset;

0.4=>Mixer.bus[1].send[0].gain;
0.7=>Mixer.bus[1].gain;
0.5=>Mixer.bus[1].pan;
RissetNoteBeat rnb_low => ABSaturator satrnb_low => Mixer.bus[3];
8=>satrnb_low.drive;
4=>satrnb_low.dcOffset;
0.4=>Mixer.bus[3].send[0].gain;
0.8=>Mixer.bus[3].gain;

EuclidSeq impulseseq;
EuclidSeq dkseq;
dkseq.set(16,9,0);

int measure;
LFO lfo_rcb;
120=>lfo_rcb.sync;
//spork ~lfo_rcb.am(rcb,2,8,1::samp,10::samp);

LFO lfo_wave;



while(true)
{
/*
Wave wave => Mixer.bus[4];
0.05=>Mixer.bus[4].gain;
0.6=>Mixer.bus[4].send[0].gain;
1000=>wave.freq;
-0.2=>Mixer.bus[4].pan;
spork ~wave.run(bpm.quarterNote*4*16);
spork ~lfo_wave.am(wave,2,10,10::ms,15::ms);
*/
section1();
section2();
section3();
section4();
section5();
section6();
/*
wave.stop();
*/
}



fun void section6()
{
    //section 3
    0=> measure;


    while(measure<16)
    {
        Math.random2(5,15)=>int num;
        <<<num>>>;
        rnb.set(num);
        Math.random2(4,10)=> num;
        rnb_low.set(num);
        <<<num>>>;
        Math.random2(5,15)=>num;
        rcb.set(num);
        <<<num>>>;
        chord.set(scale.get(1),"minor7");
            spork ~dinky(chord,8*BPM.quarterNote,-1,2);
        spork ~rnb_low.play(Std.mtof(chord.sample()-24),bpm.quarterNote*6);
        spork ~rnb.play(Std.mtof(chord.sample()+24),bpm.quarterNote*3);
        rcb.play(chord,8*BPM.quarterNote);
        chord.set(scale.get(7)-12,"dom7");
            spork ~dinky(chord,8*BPM.quarterNote,-2,2);
        spork ~rnb_low.play(Std.mtof(chord.sample()-24),bpm.quarterNote*6);
        spork ~rnb.play(Std.mtof(chord.sample()+24),bpm.quarterNote*3);
        rcb.play(chord,8*BPM.quarterNote);
        measure+4=>measure;
    }

}


fun void section5()
{
//section 3
0=> measure;
while(measure<16)
{
    Math.random2(5,15)=>int num;
    <<<num>>>;
    rnb.set(num);
    Math.random2(4,10)=> num;
    rnb_low.set(num);
    <<<num>>>;
    Math.random2(5,15)=>num;
    rcb.set(num);
    <<<num>>>;
    chord.set(scale.get(1),"minor7");
        spork ~dinky(chord,8*BPM.quarterNote,-1,2);
    spork ~rnb_low.play(Std.mtof(chord.sample()-24),bpm.quarterNote*6);
    spork ~rnb.play(Std.mtof(chord.sample()+24),bpm.quarterNote*3);
    rcb.play(chord,8*BPM.quarterNote);
    chord.set(scale.get(7)-12,"dom7");
        spork ~dinky(chord,8*BPM.quarterNote,-2,2);
    spork ~rnb_low.play(Std.mtof(chord.sample()-24),bpm.quarterNote*6);
    spork ~rnb.play(Std.mtof(chord.sample()+24),bpm.quarterNote*3);
    rcb.play(chord,8*BPM.quarterNote);
    measure+4=>measure;
}
}
fun void section4()
{
//section 3
0=> measure;
while(measure<16)
{
    Math.random2(5,15)=>int num;
    <<<num>>>;
    rnb.set(num);
    Math.random2(4,10)=> num;
    rnb_low.set(num);
    <<<num>>>;
    Math.random2(5,15)=>num;
    rcb.set(num);
    <<<num>>>;
    chord.set(scale.get(1),"minor7");
        spork ~dinky(chord,8*BPM.quarterNote,-1,2);
    spork ~rnb_low.play(Std.mtof(chord.sample()-24),bpm.quarterNote*6);
    spork ~rnb.play(Std.mtof(chord.sample()+12),bpm.quarterNote*3);
    rcb.play(chord,8*BPM.quarterNote);
    chord.set(scale.get(7)-12,"dom7");
        spork ~dinky(chord,8*BPM.quarterNote,-2,2);
    spork ~rnb_low.play(Std.mtof(chord.sample()-24),bpm.quarterNote*6);
    spork ~rnb.play(Std.mtof(chord.sample()+12),bpm.quarterNote*3);
    rcb.play(chord,8*BPM.quarterNote);
    measure+4=>measure;
}
}

fun void section3()
{
//section 3
impulseseq.setRotation(2);
0=> measure;
while(measure<16)
{
    Math.random2(5,15)=>int num;
    <<<num>>>;
    rnb.set(num);
    Math.random2(4,10)=> num;
    rnb_low.set(num);
    <<<num>>>;
    Math.random2(5,15)=>num;
    rcb.set(num);
    <<<num>>>;
    chord.set(scale.get(1),"minor7");
        spork ~dinky(chord,8*BPM.quarterNote,-1,2);
    spork ~rnb_low.play(Std.mtof(chord.sample()-12),bpm.quarterNote*3);
    spork ~rnb.play(Std.mtof(chord.sample()+12),bpm.quarterNote*3);
    rcb.play(chord,8*BPM.quarterNote);
    chord.set(scale.get(7)-12,"dom7");
        spork ~dinky(chord,8*BPM.quarterNote,-2,2);
    spork ~rnb_low.play(Std.mtof(chord.sample()-12),bpm.quarterNote*3);
    spork ~rnb.play(Std.mtof(chord.sample()+12),bpm.quarterNote*3);
    rcb.play(chord,8*BPM.quarterNote);
    measure+4=>measure;
}
}

fun void section2()
{
impulseseq.setRotation(1);
//section 2
0=> measure;
while(measure<16)
{
    Math.random2(5,15)=>int num;
    <<<num>>>;
    rnb.set(num);
    <<<num>>>;
    Math.random2(5,15)=>num;
    rcb.set(num);
    <<<num>>>;
    chord.set(scale.get(1),"minor7");
        spork ~dinky(chord,8*BPM.quarterNote,-1,0);
    spork ~rnb.play(Std.mtof(chord.sample()+12),bpm.quarterNote*3);
    rcb.play(chord,8*BPM.quarterNote);
    chord.set(scale.get(7)-12,"dom7");
        spork ~dinky(chord,8*BPM.quarterNote,-1,1);
    spork ~rnb.play(Std.mtof(chord.sample()+12),bpm.quarterNote*3);
    rcb.play(chord,8*BPM.quarterNote);
    measure+4=>measure;
}
}

fun void section1()
{
//section 1
0=> measure;
while(measure<32)
{
    if (measure == 4)
        spork ~impulse();
    if (measure ==8)
        1.0=>Mixer.bus[2].send[1].gain;
    Math.random2(5,15)=>int num;
    rcb.set(num);
    <<<num>>>;
    chord.set(scale.get(1),"minor7");
    if (measure >16)
        spork ~dinky(chord,8*BPM.quarterNote,-1,0);
    rcb.play(chord,8*BPM.quarterNote);
    chord.set(scale.get(7)-12,"dom7");
    if (measure >16)
        spork ~dinky(chord,8*BPM.quarterNote,-1,0);
    rcb.play(chord,8*BPM.quarterNote);
    measure+4=>measure;
}
}


fun void dinky(Chord chord ,dur _dur, int low,int high)
{
    now + _dur=>time mark;
    dkseq.setRotation(Math.random2(0,16));
    while(now<mark)
    {
        if (dkseq.genNext())
        dk.play(Std.mtof(chord.sample()+Math.random2(low,high)*12),bpm.sixteenthNote);
        else 
            bpm.sixteenthNote=>now;
    }
}
fun void impulse()
{
    impulseseq.set(16,11,1);
    while(true)
    {
        if(impulseseq.genNext())
        {
            1.0=>i.next;
            0.5=>i.gain;
        }
        bpm.sixteenthNote=>now;

    }
}

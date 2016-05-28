
class Master {
    Gain in[2];
	Gain  _gain[2];
	Dyno  comp[2];
	Dyno  limit[2];
    fun void gain(float __gain)
    {
        __gain => _gain[0].gain =>_gain[1].gain; 
    }
    fun void set()
    {
        in=>comp=>limit=>_gain;
        //compressor
        2.0=>comp[0].gain=>comp[1].gain;
        -1=>comp[0].op=>comp[1].op;
        comp[0].compress();
        comp[1].compress();

        //limiter
        2.0=>limit[0].gain=>limit[1].gain;
        0.9=>limit[0].thresh;
        limit[0].slopeBelow(1.0);
        limit[0].slopeAbove(0.0);
        0.9=>limit[1].thresh;
        limit[1].slopeBelow(1.0);
        limit[1].slopeAbove(0.0);
        limit[0].limit();
        limit[1].limit();
    }
}

class Bus extends Pan2 {
    Gain send[2];
}

class FxRev {
    Gain in[2];
    GVerb gverb; 
    Gain out[2];
    fun void set()
    {
        2000 => gverb.roomsize;
        2::second => gverb.revtime;
        .0 => gverb.dry;
        0.2 => gverb.early;
        0.5 => gverb.tail;
        in=>gverb=>out;
    }
}
class FxDelay {
    Gain in[2];
    FbDelay fbdelay;
    Gain out[2];
    Pan2 _pan;
    fun void pan(float _pan)
    {
        _pan => this._pan.pan;
    }
    fun void set()
    {
        fbdelay.setFeedBack(0.6);
        fbdelay.setMix(1.0);
        in=>fbdelay=> _pan=>out;
    }
}

public class Mixer{
	static Bus @ bus[6];
    static FxRev @ fxrev;
    static FxDelay @ fxdelay;
    static Master @  master;
}


new Bus[12] @=> Mixer.bus;
new Master @=> Mixer.master;
new FxRev @=> Mixer.fxrev;
new FxDelay @=> Mixer.fxdelay;

Mixer.master.set();
Mixer.fxrev.set();
Mixer.fxdelay.set();

for (0=>int i;i<12;i++)
{
	Mixer.bus[i] => Mixer.master.in; 
    .0 => Mixer.bus[i].send[0].gain;
    .0 => Mixer.bus[i].send[1].gain;
    Mixer.bus[i] => Mixer.bus[i].send[0];
    Mixer.bus[i] => Mixer.bus[i].send[1];
    Mixer.bus[i].send[0] => Mixer.fxrev.in;
    Mixer.bus[i].send[1] => Mixer.fxdelay.in;
}

Mixer.fxrev.out => Mixer.master.in;
Mixer.fxdelay.out => Mixer.master.in;

Mixer.master._gain =>dac;

//reverb

/*
5 =>Master.rev[0].roomsize => Master.rev[1].roomsize;
0.01::second => Master.rev[0].revtime => Master.rev[1].revtime;
0.3=>Master.rev[0].dry=>Master.rev[1].dry;
0.2=>Master.rev[0].early=>Master.rev[1].early;
0.5=>Master.rev[0].tail=>Master.rev[1].tail;
*/

/*
50 =>Master.rev.roomsize ;
0.2::second => Master.rev.revtime ;
0.3=>Master.rev.dry;
0.2=>Master.rev.early;
0.5=>Master.rev.tail;
*/
while(true) 
{

	1::second => now;

}

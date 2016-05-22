

class Master {
    Gain in[2];
	Gain  gain[2];
	Dyno  comp[2];
	Dyno  limit[2];
    fun void set()
    {
        in=>comp=>limit=>gain;
        //compressor
        comp[0].compress();
        comp[1].compress();
        2.0=>comp[0].gain=>comp[1].gain;
        -1=>comp[0].op=>comp[1].op;

        //limiter
        limit[0].limit();
        limit[1].limit();
        4=>limit[0].gain=>limit[1].gain;
        -1=>limit[0].op=>limit[1].op;
    }
}

public class Mixer{
	static Pan2 @ chan[8];
    static Master @  master;
}


new Pan2[8] @=> Mixer.chan;
new Master @=> Mixer.master;

Mixer.master.set();

for (0=>int i;i<8;i++)
{
	Mixer.chan[i] => Mixer.master.in; 
}

Mixer.master.gain =>dac;

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

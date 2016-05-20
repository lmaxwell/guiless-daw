
public class Master{
	static Gain @ volume[2];
	static GVerb @ rev;
	static Dyno @ comp[2];
	static Dyno @ limit[2];
	static Gain @ chan[8];
	static Pan2 @ pan[8];
	
}

new Gain[2] @=> Master.volume;

new Gain[8] @=> Master.chan; 
new Pan2[8] @=> Master.pan;

new GVerb @=> Master.rev;
new Dyno[2] @=> Master.limit;
new Dyno[2] @=> Master.comp;



for (0=>int i;i<8;i++)
{
	Master.chan[i] =>  Master.pan[i] =>Master.volume;
}

Master.volume =>dac;// => Master.comp =>  Master.limit=> dac;
//Master.volume => dac;
//Master volume
1.0 => Master.volume[0].gain=> Master.volume[1].gain;
1.0=>dac.gain;

//reverb

/*
5 =>Master.rev[0].roomsize => Master.rev[1].roomsize;
0.01::second => Master.rev[0].revtime => Master.rev[1].revtime;
0.3=>Master.rev[0].dry=>Master.rev[1].dry;
0.2=>Master.rev[0].early=>Master.rev[1].early;
0.5=>Master.rev[0].tail=>Master.rev[1].tail;
*/


50 =>Master.rev.roomsize ;
0.2::second => Master.rev.revtime ;
0.3=>Master.rev.dry;
0.2=>Master.rev.early;
0.5=>Master.rev.tail;



//compressor
Master.comp[0].compress();
Master.comp[1].compress();
2.0=>Master.comp[0].gain=>Master.comp[1].gain;
-1=>Master.comp[0].op=>Master.comp[1].op;

//limiter
Master.limit[0].limit();
Master.limit[1].limit();
4=>Master.limit[0].gain=>Master.limit[1].gain;
-1=>Master.limit[0].op=>Master.limit[1].op;


while(true) 
{

	1::second => now;

}

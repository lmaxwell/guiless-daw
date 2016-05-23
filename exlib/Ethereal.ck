// Ethereal
// -- written by Graham Percival, gperciva@uvic.ca, Oct 2005
// Placed in the public domain.

// Generates new age music.  Make $$$ fast by
//	 holding down the shift and pressing the "4" key!  Also
//	 by generating harmonically-related pitches.
// (no, seriously; that was the class assignment.  "Make
// a program that generates harmonically-related pitches.  You
// can use it to produce reams of crappy new age music and
// sell it")


//	PARAMETERS
1 => int DEBUG;		// set to 0 to suppress debugging info
15 => int MAXOSC;
20 => int MAXHARM;
220.0 => float fundfreq;	// fundamental frequency
0.2 => float NEWFREQPROB;  // probability of changing the
// fundamental frequency.  1-NEWFREQPROB = chance of adding
// a new harmonic.
500 => int MINEVENTTIME; // minimum time between events.	(in ms)
2500 => int MAXEVENTTIME; // max time... (in ms)

sinosc sins[MAXOSC];   // they don't need to be sinosc;
//triosc sins[MAXOSC]; // try uncommenting one of
//sqrosc sins[MAXOSC]; // these lines.


// auto init (don't touch these things)
1.0/MAXOSC => float MAXGAIN;
int harms[MAXOSC];	// binary "is this in use?" array
pan2 pans[MAXOSC];
Envelope envs[MAXOSC];
0=>int fundfreqblock;


// init the osc
for (0 => int i; i < sins.cap() ; i++ )
{
	sins[i] => envs[i] => pans[i] => dac;
	0 => harms[i];
	0 => pans[i].pan;
}

fun void newfundfreq ()
{
// don't get a new fundamental frequency if we're already
// changing one.
	if (fundfreqblock==1) return;
	1=> fundfreqblock;

// pick new fundamental fundfrequency
	float newfundfreq;
	fundfreq * std.rand2f(0.8,1.25) => newfundfreq;
	if (newfundfreq < 110) 110 => newfundfreq;
	if (newfundfreq > 330) 330 => newfundfreq;
	if (DEBUG) <<< "start fundfreq moving to", newfundfreq >>>;

// gliss to new fundfreq over 5 seconds.
	std.fabs( (fundfreq-newfundfreq)/50) => float stepsize;
	for (0 => int i; i < 50; i++)
	{
// yes, this can result in the fundreq alternating around
// the result -- i.e. if funfreq is close to newfundfreq,
// it might reach (and surpass) the goal, and then move
// in the opposite direction.  This is not a bug.  :)
//   (ok, it _was_ unintentional, but I kind-of like
//    this behavior, so I didn't fix the bug)
		if (fundfreq < newfundfreq) stepsize +=> fundfreq;
		if (fundfreq > newfundfreq) stepsize -=> fundfreq;
		100::ms => now;
	}
	if (DEBUG) <<< "fundfreq now", fundfreq >>>;
	0=>fundfreqblock;
}

fun void addharm ()
{
	int i;

// Find first unused osc -- reuse, recycle, and... err... something else!
// If all oscs are used, don't add a harmonic.  Number of unused
// osc is stored in i.
	for( 0 => i; i < sins.cap(); i++ )
		if (harms[i] == 0) break;
	if (i==MAXOSC) return;

// pick harmonic to play
	std.rand2(2,MAXHARM) => harms[i];
	fundfreq * harms[i] => sins[i].freq;

// pick a random pan.
	std.randf() => float t;
	math.sin(t) => pans[i].pan;

// target volume and speed at which we fade in
	std.rand2f(MAXGAIN/4,MAXGAIN) => envs[i].target;

// WTF is .time measured in?!?!
//	 .time is measured in 100::ms for some ungodly reason.
//	 This really needs to be documented!!!
	std.rand2f(10,20) => envs[i].time;

	envs[i].time() * 100::ms => now;

	if (DEBUG) <<< "in", i, harms[i] >>>;
	std.rand2(500,10000) => int length;

//isn't this a cool language?  It's got a "maybe" statement!	QED.
	if (maybe) walkharm(i,t,length/10);
	length::ms=>now;

// fadeout; don't do it as fast as fadein
	0 => envs[i].target;
	std.rand2f(15,30) => envs[i].time;

	envs[i].time() * 100::ms => now;

	if (DEBUG) <<< "out", i, harms[i] >>>;
// release osc  (lets us know that we're not using it)
	0=>harms[i];
}

fun void walkharm( int i, float t, int length )
{
// panning harmonic; get speed of movement
	std.rand2(10,30)/1000.0 => float stepsize;
	for( 0 => int j; j < length; j++ )
	{
		math.sin(t) => pans[i].pan;
		stepsize +=> t;
		10::ms => now;
	}
}

// main loop; random stuff happens
while( true ) {
	std.rand2f(0,1) => float doact;
// do nothing if it's exactly NEWFREQPROB!	This is not a bug!	:)
	if (doact < NEWFREQPROB ) spork ~ newfundfreq();
	if (doact > NEWFREQPROB ) spork ~ addharm();
	std.rand2(MINEVENTTIME,MAXEVENTTIME)::ms => now;
}

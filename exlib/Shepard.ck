// Shepard Tones
// -- written by Graham Percival, gperciva@uvic.ca, Feb 2006
// Placed in the public domain.

// These sound like a pitch that continually rises or falls.
// See http://en.wikipedia.org/wiki/Shepard_tone for more info.
//   WARNING!!!  This code only works for FALLING tones.
//   It should be easy to fix it to work for rising tones, but
//   I'm not going to fix it.  (I don't need rising tones).
//   Consider it an exercise left for the reader.  :)

// number of oscillators per tone.  You probably don't want to
// change this, but I'm in the habit of using constants anyway.
7 => int NUMOSC;


// initfreq: obvious
// freqmultiplier: controls the rate of change of the pitch.  Slightly
//   lower than 1 produces a falling tone, slightly above 1 causes a
//   rising tone.  WARNING: rising tones don't work yet.
// pan: -1 left, +1 right.
// speed: delay of the inner loop.  This value and freqmultiplier
//   controls the speed of the glissando.
fun void shep (float initfreq, float freqmultiplier, float pan, dur speed) {
	sinosc oct[NUMOSC];
	int i;  // counter

	float currentfreq;
	0=>int lowestosc;
	std.ftom(initfreq)=>float omcf;  // Original Midi Center Frequency

  float newvolume;

// setup the sinosc.
	for (0=>i; i<oct.cap(); i++) {
		oct[i] => pan2 p1 => dac;
		pan => p1.pan;

// I use MIDI note values (std.mtof and std.ftom) to avoid dealing
// with logarithimc frequencies.  In MIDI, each +-12 steps is an
// octave, whereas in frequencies I need to deal with */2.
//   Here, the starting frequencies are set (octaves above and below
//   the Original Midi Center Frequency )
		std.mtof( omcf+(12*(i-(NUMOSC-1)/2)) )=> oct[i].freq;
	}

	while (true) {
		for (0=>i; i<oct.cap(); i++) {
// do pitch stuff
			oct[i].freq()*freqmultiplier=>currentfreq;
			currentfreq => oct[i].freq;
// adjust volume.  This is supposed to be a normal curve, but
// I wimped out and just used a linear function.
//   volume = 1-distance_from_center
			std.fabs(omcf-std.ftom(currentfreq)) => newvolume;
			1.0-(newvolume/40.0) => newvolume;
// If the volume on an osc is low enough, re-use that
// osc on the other side (ie if we're going down, set the
// osc freq to be a new highest octave).
//   If you don't know how Shepard tones work, this won't
//   make any sense.
// WARNING!!!  This code only works if the tone is FALLING.
// If you want to use this for rising tones, this section
// is where you need to fix.
			if (newvolume<0) {
				if (i==lowestosc) {
					if (lowestosc==0)
						oct[(oct.cap()-1)].freq()*2*freqmultiplier=>currentfreq;
						else
						oct[(i-1)].freq()*2=>currentfreq;
					currentfreq => oct[i].freq;
					std.fabs(omcf-std.ftom(currentfreq))/2.0 => newvolume;
					newvolume/20.0 => newvolume;
					1-newvolume => newvolume;
					if (newvolume<0) 0=>newvolume;
					newvolume/4 => oct[i].gain;
					lowestosc+1 => lowestosc;
					if (lowestosc==oct.cap()) 0=>lowestosc;
				}
				else
				0=>newvolume;
			} else 
				newvolume/4 => oct[i].gain;
		}
	speed=>now;
	}
}

spork ~ shep(440,0.995,0,40::ms);
//spork ~ shep(440,0.995,-0.5,40::ms);
//spork ~ shep(330,0.992,0.5,30::ms);

while (true){
  4::second=>now;
}

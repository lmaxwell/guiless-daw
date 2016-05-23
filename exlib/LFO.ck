SinOsc s => Gain g => dac;
SinOsc lfo => blackhole; // Make the ugen calculate new samples, but don't send them to the dac.

1.0 => lfo.freq;   // number off times the lfo should complete it's cycle each second
300 => lfo.gain;   // How the lfo should oscillate (here: from -300 to 300)

0.2 => g.gain;

// Change samp to something else (like 50::ms) for a glitchier effect.
while(samp => now) {
        lfo.last() + 900.0 => s.freq;   // Here we add the last value of lfo and a little booster.
}

// Fractal-Glitchy-Techno by Kristjan Varnik 
// Placed in the Public Domain. 2005

120.0 * 0.2 => float tempo;
.5::second => dur T;
T - (now % T) => now;
0.0 => float pitch;

fun float getStep(float step) {
      60.0/tempo => float beat;   
        beat / 2.0 => float step1;
          return step * step1;
}

// the patch
sinosc s=> gain g => dac;

fun void playA(float time, float pitch) {
       pitch => s.freq;
}

fun void playRecursive(float levels, float time, float pitch) {     
        levels -1.0 => levels;
            if (levels < 0.0) {
                       playA(time, pitch);
                           } else {
                                      playRecursive(levels, time, pitch * 1.0);
                                             getStep(time)::T => now;
                                                    playRecursive(levels, time, pitch * 1.0);
                                                           getStep(time * 0.5)::T => now;
                                                                  playRecursive(levels, time, pitch * 1.0);
                                                                         getStep(time)::T => now;
                                                                                playRecursive(levels, time, pitch * 1.414);
                                                                                       getStep(time)::T => now;
                                                                                           }
}

// go
playRecursive(5.0,0.07, 110.0);
0.0 => g.gain;

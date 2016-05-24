// Boolean_Trio.ck
// copyright 2007 Les Hall
// This software released under the GNU General Protective License
// experiments with creating music from base n sequences
// three instruments in Boolean logic sequence

// control variables
2 => int n; // numeric base of the sequence
100 => float frequency;

// the patches
SinOsc s1 => dac;
SinOsc s2 => dac;
SinOsc s3 => dac;
SinOsc s4 => dac;
SinOsc s5 => dac;
Impulse i1 => BPF f1 => JCRev r1 => dac;
i1 => BPF f2 => r1 => dac;
i1 => BPF f3 => r1 => dac;
i1 => BPF f4 => r1 => dac;
i1 => BPF f5 => r1 => dac;
Impulse i2 => BPF f6 => JCRev r2 => dac;

// set up the oscillator frequencies
5 * frequency => s1.freq;
4 * frequency => s2.freq;
3 * frequency => s3.freq;
2 * frequency => s4.freq;
1 * frequency => s5.freq;

// set up the band pass filter
f1.Q(100);
f2.Q(100);
f3.Q(100);
f4.Q(100);
f5.Q(100);
f1.gain(1.0);
f2.gain(1.0);
f3.gain(1.0);
f4.gain(1.0);
f5.gain(1.0);
f1.freq(1 * frequency);
f1.freq(2 * frequency);
f1.freq(3 * frequency);
f1.freq(4 * frequency);
f1.freq(5 * frequency);
f6.Q(200);
f6.gain(3.0);
f6.freq(1.5 * frequency);

// set up the reverb
r1.mix(0.02);
r2.mix(0.02);


// time loop
while (true) {
    // print the base for each sequence
    <<< "base", n >>>;

    // calculate the logic threshold
    (n-1) / 2.0 => float t;

    // loop in a 5-bit binary sequence and pluck the strings
    for (0 => int j1; j1 < n; j1++) {
        j1 / 16.0 / (n-1) => s1.gain;
        for (0 => int j2; j2 < n; j2++) {
            j2 / 8.0 / (n-1) => s2.gain;
            for (0 => int j3; j3 < n; j3++) {
                j3 / 4.0 / (n-1) => s3.gain;
                for (0 => int j4; j4 < n; j4++) {
                    j4 / 2.0 / (n-1) => s4.gain;
                    for (0 => int j5; j5 < n; j5++) {
                        j5 / 1.0 / (n-1) => s5.gain;
                        if ((j2 > t) && (j4 > t) || (j5 > t) && (j3 > t)) {
                            ((j1 + j2 + j3 + j4 + j5) / n) * frequency => float freq;
                            f1.freq(1 * freq);
                            f1.freq(2 * freq);
                            f1.freq(3 * freq);
                            f1.freq(4 * freq);
                            f1.freq(5 * freq);
                            300.0 => i1.next;
                        }
                        if ((j4 < t) && (j5 < t)) {
                            if (((j2 > t) && (j3 < t)) || ((j2 < t) && (j3 > t))) {
                                f6.freq(1.5 * frequency);
                            } else {
                                f6.freq(2.5 * frequency);
                            }
                            1000.0 => i2.next;
                        }
                        100::ms => now; // advance time
                    }
                }
            }
        }
    }

    // shut off the oscillators
    0 => s1.gain;
    0 => s2.gain;
    0 => s3.gain;
    0 => s4.gain;
    0 => s5.gain;

    // increment the base number
    n++;

    // advance time between binary counts
    <<< "pause" >>>;
    3::second => now;
}

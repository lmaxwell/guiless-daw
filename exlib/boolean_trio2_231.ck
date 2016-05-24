// Boolean_Trio2.ck
// copyright 2007 Les Hall
// This software released under the GNU General Protective License
// experiments with creating music from base n sequences
// three instruments in Boolean logic sequence

// control variables
4 => int n; // numeric base of the sequence
100 => float frequency;

// gain of each instrument
Gain g1;
Gain g2;
Gain g3;
1.00 => g1.gain;  // binary count SinOsc's
0.50 => g2.gain;  // high frequency plucked instrument
0.50 => g3.gain;  // low frequency plucked instrument

// the background oscillators
SinOsc s[5];
for (0 => int i; i<5; i++) {
    // the patches
    s[i] => g1 => dac;
    // the frequencies
    (5 - i) * frequency => s[i].freq;
}

// The plucked treble instrument
Impulse i1;
JCRev r1;
r1.mix(0.02);
BPF f[5];
i1 => f[0] => r1 => g2 => dac;
i1 => f[1] => r1 => g2 => dac;
i1 => f[2] => r1 => g2 => dac;
i1 => f[3] => r1 => g2 => dac;
i1 => f[4] => r1 => g2 => dac;
for (0 => int i; i < 5; i++) {
    // the patches
    //i1 => BPF f[i] => r1 => dac;
    // the quality factors
    100 => f[i].Q;
    // the frequencies
    (i + 1) * frequency => f[i].freq;
}
// the gains
0.5 => f[0].gain;
1.0 => f[1].gain;
0.5 => f[2].gain;
0.5 => f[3].gain;
0.4 => f[4].gain;

// the plucked bass instrument
Impulse i2;
JCRev r2;
r2.mix(0.05);
BPF fb[5];
// the patches
i2 => fb[0] => r2 => g3 => dac;
i2 => fb[1] => r2 => g3 => dac;
i2 => fb[2] => r2 => g3 => dac;
i2 => fb[3] => r2 => g3 => dac;
i2 => fb[4] => r2 => g3 => dac;
for (0 => int i; i < 5; i++) {
    // the quality factors
    200 => fb[i].Q;
    // the frequencies
    (i + 1) * frequency => f[i].freq;
    // the gains
    2.0 / (i + 1) => f[i].gain;
}


// time loop
while (true) {
    // print the base for each sequence
    <<< "base", n >>>;

    // calculate the logic threshold
    (n-1) / 2.0 => float t;

    // loop in a 5-bit binary sequence and pluck the strings
    for (0 => int j1; j1 < n; j1++) {
        j1 / 16.0 / (n-1) => s[0].gain;
        for (0 => int j2; j2 < n; j2++) {
            j2 / 8.0 / (n-1) => s[1].gain;
            for (0 => int j3; j3 < n; j3++) {
                j3 / 4.0 / (n-1) => s[2].gain;
                for (0 => int j4; j4 < n; j4++) {
                    j4 / 2.0 / (n-1) => s[3].gain;
                    if (j4 > t) {
                        (1.5 * (2 * (n - 1) + j3) / (3 *(n - 1))) * frequency => float freq;
                        for (0 => int i; i < 5; i++) {
                            (i + 1) * freq => fb[i].freq;
                        }
                        1000.0 => i2.next;
                    }
                    for (0 => int j5; j5 < n; j5++) {
                        j5 / 1.0 / (n-1) => s[4].gain;
                        if ((j2 > t) && (j4 > t) || (j5 > t) && (j3 > t)) {
                            (8 * (j1 + j2 + j3 + j4 + j5) / (5 * (n -1))) * frequency => float freq;
                            for (0 => int i; i < 5; i++) {
                                (i + 1) * freq => f[i].freq;
                            }
                            300.0 => i1.next;
                        }
                        100::ms => now; // advance time
                    }
                }
            }
        }
    }

    // shut off the oscillators
    for (0 => int i; i < 5; i++) {
        0 => s[i].gain;
    }

    // increment the base number
    n++;

    // advance time between binary counts
    <<< "pause" >>>;
    3::second => now;
}

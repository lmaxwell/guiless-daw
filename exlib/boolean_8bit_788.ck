// Boolean_Quartet.ck
// copyright 2007 Les Hall
// This software released under the GNU General Protective License
// experiments with creating music from base n sequences
// four instruments in Boolean logic sequence

// control variables
200 => float frequency;  // fundamental frequency, all others proportional to this
0.50 => float gain1;  // HF plucked
0.50 => float gain2;  // LF plucked
0.05 => float gain3;  // harp
2 => int n; // starting numeric base of the sequence

// gain of each instrument
Gain g1;
Gain g2;
Gain g3;
gain1 => g1.gain;  // high frequency plucked instrument
gain2 => g2.gain;  // low frequency plucked instrument
gain3 => g3.gain;  // harp instrument

// The plucked treble instrument
Impulse i1;
JCRev r1;
r1.mix(0.02);
BPF ft[5];
i1 => ft[0] => r1 => g1 => dac;
i1 => ft[1] => r1 => g1 => dac;
i1 => ft[2] => r1 => g1 => dac;
i1 => ft[3] => r1 => g1 => dac;
i1 => ft[4] => r1 => g1 => dac;
for (0 => int i; i < 5; i++) {
    // the quality factors
    100 => ft[i].Q;
    // the gains
    1.0 / Math.sqrt(i + 1) => ft[i].gain;
}

// the plucked bass instrument
Impulse i2;
JCRev r2;
r2.mix(0.25);
BPF fb[5];
// the patches
i2 => fb[0] => r2 => g2 => dac;
i2 => fb[1] => r2 => g2 => dac;
i2 => fb[2] => r2 => g2 => dac;
i2 => fb[3] => r2 => g2 => dac;
i2 => fb[4] => r2 => g2 => dac;
for (0 => int i; i < 5; i++) {
    // the quality factors
    300 => fb[i].Q;
    // the gains
    1.0 / Math.sqrt(i + 1) => fb[i].gain;
}

// the harp instrument
TriOsc sg[5];
JCRev rg;
0.50 => rg.mix;
for (0 => int i; i<5; i++) {
    // the patches
    sg[i] => rg => g3 => dac;
    // the gains
    1.0 / Math.sqrt(i + 1) => sg[i].gain;
}


// time loop
while (true) {
    // print the base for each sequence
    <<< "base", n >>>;

    // calculate the logic threshold
    (n-1) / 2.0 => float t;

    // turn on the harp
    gain3 => g3.gain;

    // loop in a 8-bit binary sequence and pluck the strings
    for (0 => int j7; j7 < n; j7++) {
        for (0 => int j6; j6 < n; j6++) {
            for (0 => int j5; j5 < n; j5++) {
                for (0 => int j4; j4 < n; j4++) {
                    for (0 => int j3; j3 < n; j3++) {
                        for (0 => int j2; j2 < n; j2++) {
                            for (0 => int j1; j1 < n; j1++) {
                                // the low frequency plucked instrument
                                if ((j6 <= t) && (j5 <= t) || (j4 >= t) && (j3 >= t) || (j2 <= t) && (j1 <= t)) {
                                    (2 * (j7 + j6 + j5 + j4) / (4.0 * (n - 1))) * frequency => float freq;
                                    for (0 => int i; i < 5; i++) {
                                        (i + 1) * freq => fb[i].freq;
                                    }
                                    1000.0 => i2.next;
                                }
                                for (0 => int j0; j0 < n; j0++) {
                                    // the high frequency plucked instrument
                                    if ((j5 <= t) && (j4 <= t) || (j3 >= t) && (j2 >= t) || (j1 <= t) && (j0 <= t)) {
                                        (4 * (j4 + j3 + j2 + j1) / (4.0 * (n - 1))) * frequency => float freq;
                                        for (0 => int i; i < 5; i++) {
                                            (i + 1) * freq => ft[i].freq;
                                        }
                                        300.0 => i1.next;
                                    }
                                    // the harp
                                    (2 * (1*j6 + 2*j5 + 4*j4 + 4*j2 + 2*j1 + 1*j0) / (14.0*(n-1))) * frequency => float freq;
                                    for (0 => int i; i<5; i++) {
                                        (i + 1) * freq => sg[i].freq;
                                    }
                                    1::second / 8.0  => now; // advance time
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // shut off the harp
    0 => g3.gain;

    // increment the base number
    n++;

    // advance time between counting sequences
    <<< "pause" >>>;
    2::second => now;
}

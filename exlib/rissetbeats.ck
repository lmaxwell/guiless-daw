5.0 => float songlength;
[660.0, 587.0, 440.0, 392.0, 370.0, 392.0] @=> float freqs[];
[0.5, 1.5, 2.5, 3.0, 3.5, 4.0] @=> float soundtimes[];
[0.5, 0.5, 1.0, 1.0, 1.0, 1.0] @=> float amps[];
[20, 20, 20, 20, 20, 20] @=> int num[];

for (0 => int i; i < freqs.size(); 1 +=> i) {
    SinOsc s[num[i]];//Hold all of the oscillators for this note
    0.5 / num[i] => float scale;
    for (0 => int j; j < num[i]; 1 +=> j) {
        freqs[i] + j * 1.0 / songlength => float freq;
        freq => s[j].freq;
        freq * soundtimes[i] * (-1.0) => s[j].phase;
        amps[i]*scale => s[j].gain;
        s[j] => dac;
    }
}


songlength::second => now;
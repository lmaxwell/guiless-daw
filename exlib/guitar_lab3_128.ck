// guitar_lab2.ck
// copyright 2007 Les Hall
// This code is protected by the GNU General Public License
// Evaluates test expressions for creating riffs and sequences

// parameters
4 => int lead;  // select which lead guitar to play
                // 0:  no lead guitar
                // 1:  lead guitar with ORed 2-bit ANDing, has a familiar, powerful sound
                // 2:  lead guitar with ORed progressive ANDing, has an "east-meets-west" sound
                // 3:  lead guitar with XORed bits, suggested by kijjaz
                // 4:  lead guitar with cellular automata
0 => int bass;  // select which bass guitar to play
                // 0:  no bass guitar
                // 1:  bass guitar with ORed progressive ANDing, just a basic bass riff
                // 2:  bass guitar with XORed bits, suggested by kijjaz
                // 3:  bass guitar with ORed progressive Anding, has an "eas-meets-west" sound
2 => int n;  // counting base
10 => float base_freq;  // all freqencies are multiplied by this
8 => float notes_per_second;  // the timing

// many thanks to kijjaz for the mandolin-based Stratocaster guitar sound with overdrive:  
// Mandolin as the electric guitar test: by kijjaz (kijjaz@yahoo.com)
// feel free to use, modify, publish
class kjzGuitar101 {
    Mandolin str[3]; // create mandolin strings
    SinOsc overdrive => NRev rev => Gain output; // create overdrive to reverb to dac
    overdrive.sync(1); // make overdrive do Sine waveshaping
    rev.mix(0.02); // set reverb mix
    rev.gain(0.6); // set master gain
    output.gain(1.0); // set output gain

    // connect strings, set string damping
    for(int i; i < 3; i++) {
        str[i] => overdrive;
       .9 => str[i].stringDamping;
    }
}
kjzGuitar101 A;  // lead guitar
A.output => Gain g_lead_right => dac.right;
A.output => Gain g_lead_left => dac.left;
kjzGuitar101 B;  // bass guitar
B.output => Gain g_bass_right => dac.right;
B.output => Gain g_bass_left => dac.left;

// declare variables
float freq;  // the frequency multiplier of the next note of the instrument
(n - 1) / 2.0 => float t;  // calculate threshold
float lead_fade;  // fade value of lead guitar
float bass_fade;  // fade value of bass guitar
int a[20];  // cellular automata
int a_new[20];  // new cellular automata

// time loop
for (0 => int j15; j15 < n; j15++) {
for (0 => int j14; j14 < n; j14++) {
for (0 => int j13; j13 < n; j13++) {
for (0 => int j12; j12 < n; j12++) {
for (0 => int j11; j11 < n; j11++) {
for (0 => int j10; j10 < n; j10++) {
for (0 => int j9; j9 < n; j9++) {
for (0 => int j8; j8 < n; j8++) {
for (0 => int j7; j7 < n; j7++) {
for (0 => int j6; j6 < n; j6++) {
for (0 => int j5; j5 < n; j5++) {
for (0 => int j4; j4 < n; j4++) {
for (0 => int j3; j3 < n; j3++) {
for (0 => int j2; j2 < n; j2++) {
for (0 => int j1; j1 < n; j1++) {

// bass guitar
if (bass == 1) {
    if ((j6>=t)&&(j5>=t)&&(j4>=t) || (j3>=t)&&(j2>=t) || (j1>=t))  {
        (16 + 1*j6 + 2*j5 + 4*j4 + 8*j3 + 16*j2) / 8.0 * base_freq => freq;
        for (0 => int i; i < 3; i++) {
            freq * (0.5*i+1) => B.str[i].freq;
        }
        for (0 => int i; i < 3; i++) {
            0.8 => B.str[i].pluck;
        }
    }
}

// bass guitar with XOR
if (bass == 2) {
    if ((j15>=t)^(j14>=t)^(j13>=t)^(j12>=t)^(j11>=t)^(j10>=t)^(j9>=t)^(j8>=t)^(j7>=t)^(j6>=t)^(j5>=t)^(j4>=t)^(j3>=t)^(j2>=t)^(j1>=t))  {
        ((j15 ^ j14 + j13 ^ j12 + j11 ^ j10 + j9 ^ j8 + j7 ^ j6 + j5 ^ j4 + j3 ^ j2 + j1) + 2) * 1 * base_freq => freq;
        for (0 => int i; i < 3; i++) {
            freq * (0.5*i+1) => B.str[i].freq;
        }
        for (0 => int i; i < 3; i++) {
            0.8 => B.str[i].pluck;
        }
    }
}

// bass guitar
if (bass == 3) {
    if ((j14>=t)&&(j13>=t)&&(j12>=t)&&(j11>=t)&&(j10>=t) || (j9>=t)&&(j8>=t)&&(j7>=t)&&(j6>=t) || 
        (j5>=t)&&(j4>=t)&&(j3>t) || (j2>=t)&&(j1>=t)) {
        (j15 + j14 + j13 + j12 + j11 + j10 + j9 + j8 + j7 + j6 + j5 + j4 + j3 + j2 + j1 + 1) * 2 * base_freq => freq;
        for (0 => int i; i < 3; i++) {
            freq * (0.5*i+1) => B.str[i].freq;
        }
        for (0 => int i; i < 3; i++) {
            0.8 => B.str[i].pluck;
        }
    }
}

for (0 => int j0; j0 < n; j0++) {

// lead guitar
if (lead == 1) {
    if ((j15>=t)&&(j14>=t) || (j13>=t)&&(j12>=t) || (j11>=t)&&(j10>=t) || (j9>=t)&&(j8>=t) || 
        (j7>=t)&&(j6>=t) || (j5>=t)&&(j4>=t) || (j3>=t)&&(j2>=t) || (j1>=t)&&(j0>=t)) {
        (j15 + j14 + j13 + j12 + j11 + j10 + j9 + j8 + j7 + j6 + j5 + j4 + j3 + j2 + j1 + j0 + 1) * 8 * base_freq => freq;
        for (0 => int i; i < 3; i++) {
            freq * (0.5*i+1) => A.str[i].freq;
        }
        for (0 => int i; i < 3; i++) {
            0.8 => A.str[i].pluck;
        }
    }
}

// lead guitar, "east meets west"
if (lead == 2) {
    if ((j14>=t)&&(j13>=t)&&(j12>=t)&&(j11>=t)&&(j10>=t) || (j9>=t)&&(j8>=t)&&(j7>=t)&&(j6>=t) || 
        (j5>=t)&&(j4>=t)&&(j3>t) || (j2>=t)&&(j1>=t) || (j0>=t)) {
        (j15 + j14 + j13 + j12 + j11 + j10 + j9 + j8 + j7 + j6 + j5 + j4 + j3 + j2 + j1 + j0 + 1) * 8 * base_freq => freq;
        for (0 => int i; i < 3; i++) {
            freq * (0.5*i+1) => A.str[i].freq;
        }
        for (0 => int i; i < 3; i++) {
            0.8 => A.str[i].pluck;
        }
    }
}

// lead guitar with XOR
if (lead == 3) {
    if ((j15 ^ j14 ^ j13 & j12) | (j11 ^ j10 & j9) | (j8 ^ j7 & j6) | (j5 ^ j4 & j3) | (j2 ^ j1 & j0)) {
        ((j15 ^ j14 ^ j13 + j12) + (j11 ^ j10 + j9) + (j8 ^ j7 + j6) + (j5 ^ j4 + j3) + (j2 ^ j1 + j0) + 1) * 8 * base_freq => freq;
        for (0 => int i; i < 3; i++) {
            freq * (0.5*i+1) => A.str[i].freq;
        }
        for (0 => int i; i < 3; i++) {
            0.8 => A.str[i].pluck;
        }
    }
}

// lead guitar with cellular automata
if (lead == 4) {
    if ((j14>=t)&&(j13>=t)&&(j12>=t)&&(j11>=t)&&(j10>=t) || (j9>=t)&&(j8>=t)&&(j7>=t)&&(j6>=t) || 
        (j5>=t)&&(j4>=t)&&(j3>t) || (j2>=t)&&(j1>=t) || (j0>=t)) {
        0 => int asum;
        for (int i; i < 20; i++) a[i] +=> asum;
        if (asum == 0) {  // initialize cellular automata
            for(int i; i < 20; i++) maybe * maybe => a[i];  // 25% probability that a[i] would be 1 
        }
        for(int i; i < 20; i++) a[(i + 19) % 20] ^ a[(i + 21) % 20] => a_new[i];  // do a cellular automata iteration
        for(int i; i < 20; i++) a_new[i] => a[i];  // update a's with new values  
        0 => asum;
        for(int i; i < 20; i++) a[i] +=> asum;  // update a's with new values  
        asum *  base_freq => freq;
        for (0 => int i; i < 3; i++) {
            freq * (0.5*i+1) => A.str[i].freq;
        }
        for (0 => int i; i < 3; i++) {
            0.8 => A.str[i].pluck;
        }
    }
}

// lead guitar fade
if (lead > 0) {
    (128.0*j7 + 64.0*j6 + 32.0*j5 + 16.0*j4 + 8.0*j3 + 4.0*j2 + 2.0*j1 + 1.0*j0) / 256.0 => float lead_fade;
    if (j8>=t) {
        g_lead_right.gain(lead_fade);
        g_lead_left.gain(1.0-lead_fade);
    } else {
        g_lead_right.gain(1.0-lead_fade);
        g_lead_left.gain(lead_fade);
    }
}

// bass guitar fade
if (bass > 0) {
    (128.0*j7 + 64.0*j6 + 32.0*j5 + 16.0*j4 + 8.0*j3 + 4.0*j2 + 2.0*j1 + 1.0*j0) / 256.0 => float bass_fade;
    if (j8>=t) {
        g_bass_right.gain(1.0-bass_fade);
        g_bass_left.gain(bass_fade);
    } else {
        g_bass_right.gain(bass_fade);
        g_bass_left.gain(1.0-bass_fade);
    }
}

// print binary sequence
<<<j15, j14, j13, j12, j11, j10, j9, j8, j7, j6, j5, j4, j3, j2, j1, j0>>>;

// advance time
1::second / notes_per_second => now;

}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}






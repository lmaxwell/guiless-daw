// drum_beat_lab3.ck
// copyright 2007 Les Hall
// This code is protected by the GNU General Public License
// Evaluates test expressions for creating drum beat sequences

// parameters
4 => int snare;  // select which snare to play
                 // 0:  no snare
                 // 1:  kijjaz's kjzSnare101 with simple repetetive playing
                 // 2:  kijjaz's kjzSnare102 with simple repetetive playing
                 // 3:  kijjaz's kjzSnare101 with XOR sequence
                 // 4:  kijjaz's kjzSnare101 ultra-simple, designed to work with drum 3
3 => int drums;  // select which drums to play
                 // 0:  no drums
                 // 1:  kijjaz's kjzBD101
                 // 2:  kijjaz's kjzBD101
                 // 3:  kijjaz's kjzBD101 ultra-simple, designed to work with snare 4
1 => int tomtom; // select which tomtom to play
                 // 0:  no tomtom
                 // 1:  kijjaz's kjzTT101 with XORed overlapping pairs of ANDed bits
0.30 => float snare_gain1;   // gain for kjzSnare101
0.30 => float snare_gain2;   // gain for kjzSnare102
0.30 => float drum_gain1;    // gain for kjzBD101
0.30 => float tomtom_gain1;  // gain for kjzTT101
2 => int n;  // counting base
8 => float notes_per_second;  // the timing

// many thanks to kijjaz (kijjaz@yahoo.com) for the snare code examples, rock on kijjaz!  
// easy white noise snare
class kjzSnare101 {
    // note: connect output to external sources to connect
    Noise s => Gain s_env => LPF s_f => Gain output; // white noise source
    Impulse i => Gain g => Gain g_fb => g => LPF g_f => s_env;
   
    3 => s_env.op; // make s envelope a multiplier
    s_f.set(3000, 4); // set default drum filter
    g_fb.gain(1.0 - 1.0/3000); // set default drum decay
    g_f.set(200, 1); // set default drum attack
   
    fun void setFilter(float f, float Q)
    {
        s_f.set(f, Q);
    }
    fun void setDecay(float decay)
    {
        g_fb.gain(1.0 - 1.0 / decay); // decay unit: samples!
    }
    fun void setAttack(float attack)
    {
        g_f.freq(attack); // attack unit: Hz!
    }
    fun void hit(float velocity)
    {
        velocity => i.next;
    }
}

kjzSnare101 A;
A.output => Gain g1 => dac;
g1.gain(snare_gain1);


// with some approvements from 101: snare ringing in the body
class kjzSnare102 {
    // note: connect output to external sources to connect
    Noise s => Gain s_env => LPF s_f => Gain output; // white noise source
    Impulse i => Gain g => Gain g_fb => g => LPF g_f => s_env;
   
    s_env => DelayA ringing => Gain ringing_fb => ringing => LPF ringing_f => output;   
   
    3 => s_env.op; // make s envelope a multiplier
    s_f.set(3000, 4); // set default drum filter
    g_fb.gain(1.0 - 1.0/3000); // set default drum decay
    g_f.set(200, 1); // set default drum attack
   
    ringing.max(second);
    ringing.delay((1.0 / 440) :: second); // set default: base ringing frequency = 440Hz
    ringing_fb.gain(0.35); // set default ringing feedback
    ringing_f.set(1500, 1); // set default ringing LPF
    ringing_f.gain(0.6); // set default ringing vol
   
    fun void setFilter(float f, float Q)
    {
        s_f.set(f, Q);
    }
    fun void setDecay(float decay)
    {
        g_fb.gain(1.0 - 1.0 / decay); // decay unit: samples!
    }
    fun void setAttack(float attack)
    {
        g_f.freq(attack); // attack unit: Hz!
    }
    fun void hit(float velocity)
    {
        velocity => i.next;
    }
   
    fun void setRingingGain(float g)
    {
        g => ringing_f.gain;
    }
    fun void setRingingFreq(float f)
    {
        (1.0 / f)::second => ringing.delay;
    }
    fun void setRingingFeedback(float g)
    {
        g => ringing_fb.gain;
    }
    fun void setRingingFilter(float f, float Q)
    {
        ringing_f.set(f, Q);
    }
}

kjzSnare102 B;
B.output => Gain g2 => dac;
g2.gain(snare_gain2);



// simple analog-sounding bass drum with pitch and amp decay and sine overdrive
class kjzBD101
{
   Impulse i; // the attack
   i => Gain g1 => Gain g1_fb => g1 => LPF g1_f => Gain BDFreq; // BD pitch envelope
   i => Gain g2 => Gain g2_fb => g2 => LPF g2_f; // BD amp envelope
   
   // drum sound oscillator to amp envelope to overdrive to LPF to output
   BDFreq => SinOsc s => Gain ampenv => SinOsc s_ws => LPF s_f => Gain output;
   g2_f => ampenv; // amp envelope of the drum sound
   3 => ampenv.op; // set ampenv a multiplier
   1 => s_ws.sync; // prepare the SinOsc to be used as a waveshaper for overdrive
   
   // set default
   80.0 => BDFreq.gain; // BD initial pitch: 80 hz
   1.0 - 1.0 / 2000 => g1_fb.gain; // BD pitch decay
   g1_f.set(100, 1); // set BD pitch attack
   1.0 - 1.0 / 4000 => g2_fb.gain; // BD amp decay
   g2_f.set(50, 1); // set BD amp attack
   .75 => ampenv.gain; // overdrive gain
   s_f.set(600, 1); // set BD lowpass filter
   
   fun void hit(float v)
   {
      v => i.next;
   }
   fun void setFreq(float f)
   {
      f => BDFreq.gain;
   }
   fun void setPitchDecay(float f)
   {
      f => g1_fb.gain;
   }
   fun void setPitchAttack(float f)
   {
      f => g1_f.freq;
   }
   fun void setDecay(float f)
   {
      f => g2_fb.gain;
   }
   fun void setAttack(float f)
   {
      f => g2_f.freq;
   }
   fun void setDriveGain(float g)
   {
      g => ampenv.gain;
   }
   fun void setFilter(float f)
   {
      f => s_f.freq;
   }
}


kjzBD101 C;
C.output => Gain g3 => dac;
g3.gain(drum_gain1);


// simple analog-sounding tom-tom with pitch and amp decay and sine overdrive
class kjzTT101
{
   Impulse i; // the attack
   i => Gain g1 => Gain g1_fb => g1 => LPF g1_f => Gain TomFallFreq; // tom decay pitch envelope
   i => Gain g2 => Gain g2_fb => g2 => LPF g2_f; // tom amp envelope
   
   // drum sound oscillator to amp envelope to overdrive to LPF to output
   TomFallFreq => SinOsc s => Gain ampenv => SinOsc s_ws => LPF s_f => Gain output;
   Step BaseFreq => s; // base Tom pitch

   g2_f => ampenv; // amp envelope of the drum sound
   3 => ampenv.op; // set ampenv a multiplier
   1 => s_ws.sync; // prepare the SinOsc to be used as a waveshaper for overdrive
   
   // set default
   100.0 => BaseFreq.next;
   50.0 => TomFallFreq.gain; // tom initial pitch: 80 hz
   1.0 - 1.0 / 4000 => g1_fb.gain; // tom pitch decay
   g1_f.set(100, 1); // set tom pitch attack
   1.0 - 1.0 / 4000 => g2_fb.gain; // tom amp decay
   g2_f.set(50, 1); // set tomD amp attack
   .5 => ampenv.gain; // overdrive gain
   s_f.set(1000, 1); // set tom lowpass filter
   
   fun void hit(float v)
   {
      v => i.next;
   }
   fun void setBaseFreq(float f)
   {
      f => BaseFreq.next;
   }   
   fun void setFreq(float f)
   {
      f => TomFallFreq.gain;
   }
   fun void setPitchDecay(float f)
   {
      f => g1_fb.gain;
   }
   fun void setPitchAttack(float f)
   {
      f => g1_f.freq;
   }
   fun void setDecay(float f)
   {
      f => g2_fb.gain;
   }
   fun void setAttack(float f)
   {
      f => g2_f.freq;
   }
   fun void setDriveGain(float g)
   {
      g => ampenv.gain;
   }
   fun void setFilter(float f)
   {
      f => s_f.freq;
   }
} 


kjzTT101 D;
D.output => Gain g4 => dac;
g4.gain(tomtom_gain1);


// declare variables
(n - 1) / 2.0 => float t;  // calculate threshold

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

// kjzSnare101
if (snare == 1) {
    if ((j6>=t)&&(j5>=t)&&(j4>=t) || (j3>=t)&&(j2>=t))  {
        A.setDecay(10000);
        A.setFilter(5000, 5);
        A.hit(0.8);
    }
}

// kjzSnare102
if (snare == 2) {
    if ((j6>=t)&&(j5>=t)&&(j4>=t) || (j3>=t)&&(j2>=t))  {
        B.setRingingFeedback(.995);
        B.setRingingFilter(500, 1);
        B.hit(0.8);
    }
}

// kjzSnare101
if (snare == 1) {
    if (j15 ^ j14 ^ j13 ^ j12 ^ j11 ^ j10 ^ j9 ^ j8 ^ j7 ^ j6 ^ j5 ^ j4 ^ j3 ^ j2) {
        A.setDecay(10000);
        A.setFilter(5000, 5);
        A.hit(0.8);
    }
}

for (0 => int j1; j1 < n; j1++) {

// simple drum beat, works with snare 3
if (drums == 3) {
    if (!j1)  {
        C.hit(0.8);
    }
}

// kjzSnare101, works with drums 4
if (snare == 4) {
    if (j2 & j1) {
        A.hit(0.8);
    }
}
for (0 => int j0; j0 < n; j0++) {

// simple drum beat
if (drums == 1) {
    if (j3&j2 | j1&j0)  {
        (j3 + j2 + j1 + j0)/4.0 + 0.5 => float hit_var;
        ((j3 + j2 + j1 + j0)/4.0 + 0.5) * 200 => float freq_var;
        C.setPitchAttack(1000);
        C.setFreq(freq_var);
        C.hit(hit_var);
    }
}

// simple drum beat
if (drums == 2) {
    if (j3&j2&j1 | j1&j0)  {
        (j3 + j2 + j1 + j0)/4.0 + 0.5 => float hit_var;
        C.hit(hit_var);
    }
}

// tomtom with XORed overlapping pairs of ANDed bits
if (tomtom == 1) {
    if (j15&j14 ^ j14&j13 ^ j13&j12 ^ j12&j11 ^ j11&j10 ^ j10&j9 ^ j9&j8 ^ j8&j7 ^ j7&j6 ^ j6&j5 ^ j5&j4 ^ j4&j3 ^ j3&j2 ^ j2&j1 ^j1&j0)  {
        D.setBaseFreq(60 + 20 * (j7 + j6 + j5 + j4 + j3 + j2 + j1 + j0));
        D.hit(0.5 + 0.1 * (j7 + j6 + j5 + j4 + j3 + j2 + j1 + j0));
    }
}

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







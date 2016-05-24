// Kijjaz's Noise+Sine Bass Drum, Snare Drum, Hi Hat machine ver. 0.2 prototype
// source code for ChucK programming language
// Copyright 2008 Kijjasak Triyanond (kijjaz@yahoo.com)
// This software is protected by the GNU General Public License.
// Feel free to use, modify, and distribute.

class kjz_BDSDHH_02
{
    second / samp => float SampleRate;
    
    // use BD(), SD(), TT1(), TT2(), TT3(), CH(), OH(), clave() to select sound preset
    // (note: CH = closed hi hat, OH = opened hi hat)
    // use hit() to just hit with velocity = 1
    // use hit(float) to hit with velocity = float
    // use hit(float1, float2) hit with tone velocity = float1, noise velocity = float2
    
    // to adjust, see tone(float), toneGlide(float), toneDecay(float), noiseDecay(float), noiseGain(float)
    // the noiseGain amount is just like FM index for the main oscillator
    
    // to connect to an output, just use output => ...

    // The Patch
    Step freq => LPF freq_f => SinOsc drumtone => Gain drumtone_g =>
    Dyno comp => LPF lpf1 => SinOsc overdrive => Gain output;

    Noise n => Gain n_g => drumtone;
    3 => n_g.op => drumtone_g.op;

    comp.compress();
    5 => comp.ratio;

    1 => overdrive.sync;

    Impulse n_i => Gain n_i_g => Gain n_i_g_fb => n_i_g => n_g;
    Impulse drumtone_i => Gain drumtone_i_g => Gain drumtone_i_g_fb => drumtone_i_g => drumtone_g;

    // Initiaization
    freq_f.set(500, 1);
    
    fun void BD()
    {
        50 => freq.next;
        lpf1.set(80, 5);
        100 => n_g.gain;
        1.0 - 30.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 100.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void SD()
    {
        300 => freq.next;
        // hpf1.set(30, 1);
        lpf1.set(6000, 4);
        2200 => n_g.gain;
        1.0 - 40.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 20.0/SampleRate => n_i_g_fb.gain;
    }
    
    fun void TT1()
    {
        200 => freq.next;
        lpf1.set(400, 2);
        20 => n_g.gain;
        1.0 - 90.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 60.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void TT2()
    {
        150 => freq.next;
        lpf1.set(300, 2);
        20 => n_g.gain;
        1.0 - 80.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 60.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void TT3()
    {
        100 => freq.next;
        lpf1.set(300, 2);
        20 => n_g.gain;
        1.0 - 60.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 60.0/SampleRate => n_i_g_fb.gain;    
    }
        
    fun void CH()
    {
        5000 => freq.next;            
        lpf1.set(12000, 1);
        12000 => n_g.gain;
        1.0 - 200.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 50.0/SampleRate => n_i_g_fb.gain;
    }
    
    fun void OH()
    {
        5000 => freq.next;
        lpf1.set(8000, 3);
        12000 => n_g.gain;
        1.0 - 40.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 10.0/SampleRate => n_i_g_fb.gain;
    }

    fun void clave()
    {
        1200 => freq.next;
        lpf1.set(1000, 2);
        200 => n_g.gain;
        1.0 - 150.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 120.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void hit()
    {
        1 - n_i_g.last() => n_i.next;
        1 - drumtone_i_g.last() => drumtone_i.next;
    }
    
    fun void hit(float vel)
    {
        vel - n_i_g.last() => n_i.next;
        vel - drumtone_i_g.last() => drumtone_i.next;
    }
    
    fun void hit(float velTone, float velNoise)
    {
        velTone - n_i_g.last() => n_i.next;
        velNoise - drumtone_i_g.last() => drumtone_i.next;
    }
    
    fun void tone(float f)
    {
        f => freq.next;
    }
    
    fun void toneGlide(float rate)
    {
        rate => freq_f.freq;
    }
    
    fun void toneDecay(float rate)
    {
        1.0 - rate/SampleRate => drumtone_i_g_fb.gain;
    }
    
    fun void noiseDecay(float rate)
    {
        1.0 - rate/SampleRate => n_i_g_fb.gain;
    }
    
    fun void noiseGain(float g)
    {
        g => n_g.gain;
    }
}


// - - - Test Code - - -
500::ms => dur Beat;

kjz_BDSDHH_02 Drums;

Drums.output => dac;

Drums.BD();
for(int i; i < 7; i++)
{
    Drums.hit();
    Beat => now;
}

Drums.SD();
for(int i; i < 8; i++)
{
    Drums.hit(i $ float / 8);
    Beat/8 => now;
}

for(int i; i < 8; i++)
{
    Drums.BD();
    Drums.hit();
    .75::Beat => now;
    Drums.SD();
    Drums.hit();
    .25::Beat => now;
    Drums.BD();
    Drums.hit();
    .5::Beat => now;
    Drums.TT2();
    Drums.hit();
    .25::Beat => now;
    Drums.TT2();
    Drums.hit();
    .25::Beat => now;
}

for(int i; i < 8; i++)
{
    Drums.BD();
    Drums.hit();
    .25::Beat => now;
    Drums.CH();
    Drums.hit();
    .25::Beat => now;
    Drums.OH();
    Drums.hit();
    .25::Beat => now;
    Drums.SD();
    Drums.hit();
    .25::Beat => now;
    Drums.BD();
    Drums.hit();
    .5::Beat => now;
    Drums.TT1();
    Drums.hit();
    .25::Beat => now;
    Drums.TT3();
    Drums.hit();
    .25::Beat => now;
}

for(int i; i < 8; i++)
{
    Drums.BD();
    Drums.hit();
    .25::Beat => now;
    Drums.CH();
    Drums.hit();
    .25::Beat => now;
    Drums.clave();
    Drums.hit();
    .25::Beat => now;
    Drums.SD();
    Drums.hit();
    .25::Beat => now;
    Drums.BD();
    Drums.hit();
    .25::Beat => now;
    Drums.clave();
    Drums.hit();
    .25::Beat => now;
    Drums.TT1();
    Drums.hit();
    .25::Beat => now;
    Drums.TT3();
    Drums.hit();
    .25::Beat => now;
}
public class LFO{

    SinOsc lfo => blackhole; // Make the ugen calculate new samples, but don't send them to the dac.  
    fun void freq(float _freq)
    {
        _freq => lfo.freq;
    }

    fun void gain(float _gain)
    {
        _gain => lfo.gain;
    }
    
    fun float get()
    {
        return lfo.last();
    }

    fun void am(UGen u,float freq_low,float freq_high,dur update_low,dur update_high)
    {

        (update_low/1::samp) $ int => int num_samp_low;
        (update_high/1::samp) $ int => int num_samp_high;
        // Change samp to something else (like 50::ms) for a glitchier effect.
        while(Math.random2(num_samp_low,num_samp_high)::samp => now) {
            Math.random2f(freq_low,freq_high)=>lfo.freq;
            (get()+lfo.gain())/2.0 => u.gain;       
                   // Here we add the last value of lfo and a little booster.
        }
    }

}


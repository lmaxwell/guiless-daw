public class Grain
{
    //env atributes
    0.241971 => float dif;
    6.3709 => float scale;
    
    fun void playGrain(int sample_rate, float master_gain, float vol, float pan, float osc_freq, float duration)
    {
        SinOsc s => Gain env => Gain g => Gain master => Pan2 p => dac;//maybe a global gain?
        Phasor ph => blackhole;
        osc_freq => s.freq;
        1/duration => ph.freq;
        vol => g.gain;
        master_gain => master.gain;
        pan => p.pan;
        
        now + (duration*sample_rate)::samp => time later;
        
        while( now < later )
        {
            1::samp => now;
            ((1/(1*Math.sqrt(2*pi)))*Math.pow(2.71828, -1/(2*Math.pow(1, 2))*Math.pow(ph.last()*2.0 - 1.0, 2) ) - dif)*scale => env.gain;
        }
    }    


}


public class RissetNoteBeat extends Chubgraph{
    
    int num;
    SinOsc s[];
    float scale;
    float freq;
    Envelope env=>outlet;
    50::ms=>env.duration;
    5.0 => float songlength;
    fun void set( int _num)
    {
        _num=>num;
        new SinOsc[num] @=> s;//Hold all of the oscillators for this note
        0.5 / num =>  scale;
    }
    fun void play(float _freq,dur _dur)
    {
        _freq=>freq;
        _dur/1::second => float songlength;
        for (0 => int j; j < num; 1 +=> j) {
            freq + j * 1.0 / songlength => float freq;
            freq => s[j].freq;
            freq *  (-1.0) => s[j].phase;
            1.0*scale => s[j].gain;
            s[j] => env;
            }
        env.keyOn();
        _dur-env.duration()=> now;
        env.keyOff();
        env.duration()=>now;
        
    }

}



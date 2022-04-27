
public class RissetNoteBeat extends Chubgraph{
    
    int num;
    int NUM;
    100=>NUM;
    SinOsc s[NUM];
    float scale;
    float freq;
    Envelope env=>outlet;
    50::ms=>env.duration;
    5.0 => float songlength;
    fun void set( int _num)
    {
        _num=>num;
        for(0=>int i;i<NUM;i++)
            s[i]=<env;
        for(0=>int i;i<num;i++)
            s[i]=>env;
        0.9 / num =>  scale;
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



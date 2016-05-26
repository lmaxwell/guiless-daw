
//reimplemented of Marios Athineos's rissetbeat.m code
public class RissetBeat extends Chubgraph{
    
    int num1;
    int num2;
    int NUM1,NUM2;
    200=>NUM1=>NUM2;
    SinOsc s[NUM1][NUM2];
    float amp[NUM1][NUM2];
    float scale;
    float freq;
    float inc;
    Envelope env=>outlet;
    50::ms=>env.duration;
    5.0 => float songlength;
    fun void set( int _num1,int _num2,float _inc)
    {
        _num1=>num1;
        _num2=>num2;
        _inc=>inc;
        for (0=>int i;i<NUM1;i++)
            for (0=>int j;j<NUM2;j++)
                s[i][j]=<env;
        for (0=>int i;i<_num1;i++)
            for (0=>int  j;j<_num2;j++)
            {
                0=>s[i][j].gain;
                s[i][j]=>env;
            }
    }
    fun void play(float _freq,dur _dur)
    {
        _freq-inc=>freq;
        _dur/1::second => float songlength;

        0=>float sum;
        for (0 => int i; i < num1; 1 +=> i) {
                this.freq+inc=>this.freq;             
                20000/freq $ int=> int num3;
                if(num3<num2)
                {
                    num3=>num2;
                }
                1.0 / num1 /(num2) =>  scale;
            for (0 => int j; j < num2 ; 1 +=> j) {
                1.0/scale/(j+1)=>amp[i][j];
                if (i==0)
                    sum+amp[i][j]=>sum;
            }
            
        }


        _freq-inc=>freq;
        for (0 => int i; i < num1; 1 +=> i) {
            this.freq+inc=>this.freq;             


            for (0 => int j; j < num2 ; 1 +=> j) {
                this.freq * j  => float freq;
                freq => s[i][j].freq;
                freq *  (-1.0) => s[i][j].phase;
                spork ~changeGain(s[i][j],amp[i][j]/(sum*1.2),50::ms);
                }
        }
        env.keyOn();
        _dur-env.duration()-20::ms=> now;
        env.keyOff();
        env.duration()+20::ms=>now;
        
    }
    fun void changeGain(UGen s ,float newGain,dur _dur)
    {
        s.gain()=>float oldGain;
        _dur+now=>time _time;
        newGain-oldGain=>float diff;
        while(now<_time)
        {
            s.gain()=>oldGain;
            oldGain+(diff)/500.0=>s.gain;
            _dur/500.0=>now;
        }
        
    }

}




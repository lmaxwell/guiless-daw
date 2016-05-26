public class RissetChordBeat extends Chubgraph{
    
    int num,num2;
    int NUM1,NUM2;
    6=>NUM1;
    100=>NUM2;
    SinOsc s[NUM1][NUM2];
    float amp[NUM1];
    [1.0,1.0,1.0,1.0,1.0,1.0] @=> amp;
    float scale;
    float freq;
    5.0 => float songlength;

    Envelope env => outlet;
    10::ms=>dur env_dur;
    env_dur=>env.duration;
    fun void set( int _num)
    {
        for (0=>int i;i<NUM1;i++)
        {
            for (0=>int j;j<NUM2;j++)
            {
               // spork ~changeGain(s[i][j],0.0,10::ms);
                s[i][j]=<env;
                0.0=>s[i][j].gain;
            }
        }

        _num=>num;
        for (0=>int i;i<NUM1;i++)
        {
            for (0=>int j;j<num;j++)
            {
                s[i][j] => env;
            }
        }

    }

    fun void play(Chord chord,dur _dur)
    {

        _dur/1::second => songlength;
        0=>float phase;
        1.0/ (num*1.5)  =>  scale;
        if (num<15)
            0.07 => scale;
        /*
        0=>float sum;
        for (0=>int i;i<num;1+=>i)
        {
            1.0*scale =>amp[i];
            sum+amp[i]=>sum;
        }
        */

        for (0=>int i;i<chord.note.cap();1+=>i)
        {
            chord.note[i]=>Std.mtof=>this.freq;
            for (0 => int j; j < num; 1 +=> j) {
                this.freq + j * 1.0 / songlength => float freq;
                freq => s[i][j].freq;
                freq * phase *  (-1.0) => s[i][j].phase;
                //amp[j]/(sum*1.5) => s[i][j].gain;
                spork ~changeGain(s[i][j],amp[i]*scale,50.0*(num $ float/1.5)*Math.random2(1,3)::ms);
                }
            phase + 0.25*Math.random2(1,4) =>phase;
        }
        env.keyOn();
        _dur-env_dur-50::ms=>now;
        env.keyOff();
        /*
        for (0=>int i;i<NUM1;i++)
        {
            for (0=>int j;j<NUM2;j++)
            {
                spork ~changeGain(s[i][j],0.0,10::ms);
            }
        }
        */
        env_dur+50::ms=>now;
    }

    fun void changeGain(UGen s ,float newGain,dur _dur)
    {
        s.gain()=>float oldGain;
        _dur+now=>time _time;
        newGain-oldGain=>float diff;
        while(now<_time)
        {
            s.gain()=>oldGain;
            oldGain+(diff)/1000.0=>s.gain;
            _dur/1000.0=>now;
        }
        
    }
}



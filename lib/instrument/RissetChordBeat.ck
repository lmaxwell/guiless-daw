public class RissetChordBeat extends Chubgraph{
    
    int num;
    SinOsc s[4][30];
    float scale;
    float freq;
    5.0 => float songlength;

    Envelope env => outlet;
    100::ms=>dur env_dur;
    env_dur=>env.duration;
    fun void set( int _num)
    {
        _num=>num;

        for (0=>int i;i<4;i++)
        {
            for (0=>int j;j<num;j++)
            {
                0=>s[i][j].gain;
                s[i][j] => env;
            }
        }
        0.5 / (num) =>  scale;
    }

    fun void play(Chord chord,dur _dur)
    {
        _dur/1::second => songlength;
        0=>float phase;
        for (0=>int i;i<chord.note.cap();1+=>i)
        {
            chord.note[i]=>Std.mtof=>this.freq;
            for (0 => int j; j < num; 1 +=> j) {
                this.freq + j * 1.0 / songlength => float freq;
                freq => s[i][j].freq;
                freq * phase *  (-1.0) => s[i][j].phase;
                1.0*scale => s[i][j].gain;
                }
            phase + 0.25*Math.random2(1,4) =>phase;
        }
        env.keyOn();
        _dur-env_dur-10::ms=>now;
        env.keyOff();
        env_dur+10::ms=>now;
    }

}



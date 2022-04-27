//adapted from chuck example dinky.ck
public class Dinky extends Chubgraph
{
    Impulse i=> BiQuad f => Envelope e => outlet;

    // set the filter's pole radius
    .99 => f.prad;
    // set equal gain zeros
    1 => f.eqzs;
    // set filter gain
    .2 => f.gain;
    // set the envelope
    .001::second => e.duration;

    0.999=>f.prad;
    0.8=>i.gain;

    fun void play(float freq,dur _dur)
    {
        freq=>f.pfreq;
        noteOn();
        _dur-e.duration()-4::ms=>now;
        noteOff();
        e.duration()+4::ms=>now;
    }
    
    fun void noteOn()
    {
        1.0=>i.next;
        e.keyOn();
    }

    fun void noteOff()
    {
        e.keyOff();
    }

}


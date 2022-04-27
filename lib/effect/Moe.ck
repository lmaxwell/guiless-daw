
// run each stooge, or run three stooges concurrently
// %> chuck moe++ larry++ curly++

public class Moe extends Chubgraph
{
    // source to filter to dac
    inlet => BiQuad f => Gain g => outlet;
    // second formant
    inlet => BiQuad f2 => g;
    // third formant
    inlet => BiQuad f3 => g;

    // set the filter's pole radius
    .995 => f.prad; .995 => f2.prad; .995 => f3.prad;
    // set equal gain zeros
    1 => f.eqzs; 1 => f2.eqzs; 1 => f3.eqzs;
    // initialize float variable
    // set filter gain
    .2 => f.gain; .04 => f2.gain; .01 => f3.gain;
      
    fun void run()
    {
        // infinite time-loop   
        1.5 * 3.14 => float v;
        while( true )
        {

            // sweep the filter resonant frequency
            660.0 + Math.sin(v)*80.0 => f.pfreq;
            1780.0 + Math.sin(v*.5)*50.0 => f2.pfreq;
            2410.0 + Math.sin(v*.25)*150.0 => f3.pfreq;

            // increment v
            v + .05 => v;
            // gain
            0.15 + Math.sin(v)*.15 => g.gain;
            // advance time
            (80.0 + Math.sin(v*2.0)*10.0)::ms => now;
        }
    }
}

public class HarmonicAppregio extends Chubgraph
{

    ADSR env => NRev rev => Pan2 pan => dac;
    ( 3::second, 100::ms, .5, 3::second ) => env.set;

    float partials[];
    float amps[];
    
    fun void makeTable(float root, float partials[], float amps[], ADSR env, NRev rev, Pan2 pan)
    {
        SinOsc s[partials.size()];

        for (0 => int j; j < partials.size(); 1 +=> j)
        {
                Math.random2f(0.1,0.5) => rev.mix;
                Math.random2f(-1.0,1.0) => pan.pan;
                root*partials[j] => s[j].freq;
                amps[j] => s[j].gain;
                s[j] => env;
        }
    }

    fun void risset(float delta, float root, float partials[], float amps[], float duration)
    {

            makeTable(root, partials, amps, env, rev, pan);
            for (1 => int i; i <= 4; 1 +=> i)
            {
                makeTable(root+(delta*i), partials, amps, env, rev, pan);
                makeTable(root-(delta*i), partials, amps, env, rev, pan);
            }
    }
    fun void noteOn()
    {
            env.keyOn();
        
    }
    fun void noteOff()
    {
            env.keyOff();
    }


    fun void set(int preset)
    {
        if(preset==0)
            mongol();
        else if(preset==1)
            fullharm();
        else if(preset==2)
            perfect3();
        else if(preset==3)
            natscale();
        else if(preset==4)
            fibo();
        else if(preset==5)
            inharm();
        else
            <<<"invalid preset">>>;

    }

    fun void mongol()
    {
          <<<"mogol">>>;
          [1.0,5.0,6.0,7.0,8.0,9.0,10.0] @=> float partials[];
            [.04,.02,.02,.02,.02,.02,.02] @=> float amps[];
              risset(.03, 100.0, partials, amps, 10);
    }

    fun void fullharm()
    {
          <<<"fullharm">>>;
          [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0] @=> float partials1[];
            [.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02] @=> float amps1[];
              risset(.03, 100.0, partials1, amps1, 10);
    }


    fun void perfect3()
    {
          <<<"perfect3">>>;
          [4.0,5.0,6.0] @=> float partials2[];
            [.05,.05,.05] @=> float amps2[];
              risset(.03, 100.0, partials2, amps2, 10);
    }


    fun void natscale()
    {
          <<<"natscale">>>;
          [8.0,9.0,10.0,11.0,12.0,13.0,15.0,16.0] @=> float partials3[];
            [.04,.04,.04,.04,.04,.04,.04,.04] @=> float amps3[];
              risset(.03, 100.0, partials3, amps3, 10);
    }


    fun void fibo()
    {
          [1.0,3.0,5.0,8.0,13.0,21.0,34.0] @=> float partials[];
            [.04,.02,.02,.02,.02,.02,.02] @=> float amps[];
              risset(.03, 100.0, partials, amps, 10);
    }


    fun void inharm()
    {
          [1.3,3.2,4.5,8.2,11.8,12.7,13.4] @=> float partials[];
            [.04,.02,.02,.02,.02,.02,.02] @=> float amps[];
              risset(.03, 100.0, partials, amps, 15);
    }

}

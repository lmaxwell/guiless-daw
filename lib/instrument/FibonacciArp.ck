public class FibonacciArp extends Chubgraph
{
    26=>int NUM;
    SinOsc sin[NUM];
    float amp[NUM];
    int perm[NUM];
    Envelope env;
    int i;
    float freq;
    int isNoteOn;
    0.2::second=>dur addRate;
    0.01::second=>dur susRate;
    for(0=>i;i<NUM;i++)
    {	
        0=>sin[i].gain;
        sin[i]=>env=>outlet;
        i=>perm[i];
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

    int p,q,r;

    fun void set(int _num,dur rate)
    {
        _num=>NUM;
        randAmp();
        rate=>addRate;
    }
    fun void setRate(dur a)
    {
        a=>addRate;
    }
    /*
    fun void setRate(dur a,dur b)
    {
        a=>addRate;
        b=>susRate;
    }
    */
    fun void setFreq(float _freq)
    {
        _freq=>  freq;
        0=>p;
        1=>q;
        for(0=>i;i<NUM;i++)
        {
            p+q=>r;
            q=>p;
            r=>q;
            r*freq=>sin[i].freq;
        }
    }


    fun void noteOn()
    {
        env.keyOn();
        1=>isNoteOn;
        spork ~play();
        
    }
    fun void noteOff()
    {
        env.keyOff();
        0=>isNoteOn;
        
        for(0=>i;i<NUM;i++)
        {	
            spork ~changeGain(sin[i],0.0,50::ms);
        }

    }

    fun void play()
    {
            for(0=>i;i<NUM;i++)
            {	
                //changeGain(sin[i],0.0,1::ms);
                0.0=>sin[i].gain;
            }
            for(0=>i;i<NUM;i++)
            {	
                //addComponent(1.0/NUM,i);
                spork ~addComponent(amp[i],i);
                addRate=>now;
            }
            sustain();
    }


    fun void addComponent(float _gain,int i)
    {
        now=> time mark;
        changeGain(sin[i],_gain,20::ms);
        /*
        _gain-sin[i].gain()=>float diff;
        while(now<mark+0.01::second)
        {
            sin[i].gain()+diff/100.0 => sin[i].gain;
            0.01::second/100=>now;
        }
        */
    }


    fun void rmComponent(int i)
    {
        now => time mark;
        
        changeGain(sin[i],0.0,10::ms);
        //0=>sin[i].gain;
        /*
        sin[i].gain()=>float _gain;
        while(now < mark+0.1::second)
        {
            sin[i].gain()-_gain/100.0=>sin[i].gain;	
            0.1::second/100=>now;
        }
        */
    }

    fun void sustain()
    {

        while(isNoteOn)
        {
            Math.random2(0,NUM-1)=>int j;
            Math.random2(0,3)=> int k;
            if(k==0)
            {
                spork ~rmComponent(j);
                //<<<"remove">>>;
            }
            else if(k==1)
            {
                spork ~addComponent(amp[j]/2.0,j);
                //<<<"add">>>;
                //Math.random2f(-1.0,1.0)=>pan[j].pan;
            }
            else if(k==2)
            {
                spork ~addComponent(amp[j]*1.2,j);
            //	Math.random2f(-1.0,1.0)=>pan[j].pan;
                //<<<"add">>>;
            }
            else
            {
                Math.random2(0,NUM-1)=>int l;
                sin[j].gain()=>float temp;
                spork ~changeGain(sin[j],sin[l].gain(),10::ms);
                spork ~changeGain(sin[l],temp,10::ms);
                //<<<"swap">>>;
            }
            susRate=>now;
        }
    }

    fun void randAmp()
    {
        0=>float sum;
        for(0=>i;i<NUM;i++)
        {
            //Math.randomf()=>amp[i];
            1.0/NUM =>amp[i];
            sum+amp[i]=>sum;
        }

        for(0=>i;i<NUM;i++)
        {
            amp[i]/sum/(2*NUM)=>amp[i];
        }
    }
}



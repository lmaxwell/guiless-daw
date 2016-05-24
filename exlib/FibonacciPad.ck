public class FibonacciPad extends Chubgraph
{
    26=>int NUM;
    SinOsc sin[NUM];
    float amp[NUM];
    int perm[NUM];
    Envelope env;
    int i;
    float freq;
    int mode;
    Event sustainEvent;
    int isNoteOn;
    0.1::second=>dur addRate;
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

    fun void set(float _freq,int _num,int mode)
    {
        _num=>NUM;
        randAmp();
        setFreq(_freq);
        setMode(mode);
    }
    fun void setRate(dur a,dur b)
    {
        a=>addRate;
        b=>susRate;
    }
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
    fun void setMode(int _mode)
    {
        _mode => mode;
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
        if(mode==0)
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
        else if(mode==1)
        {
            randPerm();
            for(0=>i;i<NUM;i++)
            {	
                //changeGain(sin[i],0.0,1::ms);
                0.0=>sin[i].gain;
            }
            for(0=>i;i<NUM;i++)
            {	
                //addComponent(1.0/NUM,i);
                spork ~addComponent(amp[perm[i]],perm[i]);
                addRate=>now;
            }
            sustain();
        }
        else if(mode==2)
        {
            
            for(0=>i;i<NUM;i++)
            {	
                amp[i]/4.0=>amp[i];
                0=>sin[i].gain;
                //addComponent(1.0/NUM,i);
                spork ~addComponent(amp[i],i);
            }
            sustain();
            ;
        }

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
            Math.randomf()=>amp[i];
            sum+amp[i]=>sum;
        }

        for(0=>i;i<NUM;i++)
        {
            amp[i]/sum/(5*NUM)=>amp[i];
        }
    }
    fun void randPerm()
    {
        int temp;
        int randIndex;
        for(1=>int i;i<NUM;i++)
        {   
            Math.random2(i+1,NUM-1)=>randIndex;
            perm[i]=>temp;
            perm[randIndex]=>perm[i];
            temp=>perm[randIndex];
            <<<i,perm[i]>>>;
        }
    }

/*
    section2();


    fun void section2()
    {
        
        for(0=>i;i<NUM;i++)
        {	
            0=>sin[i].gain;
        }

        110=>f0;
        0=>p;
        1=>q;

        for(0=>i;i<NUM;i++)
        {
            p+q=>r;
            q=>p;
            r=>q;


            r*f0=>sin[i].freq;
            addComponent(1.0/NUM,i);
            -1.0+2.0/NUM*i=>pan[i].pan;
            <<<pan[i].pan()>>>;
            0.1::second=>now;
        now=>time last;
        while(now<last+130::second)
        {
            Math.random2(0,NUM-1)=>int j;
            Math.random2(0,3)=> int k;
            if(k==0)
            {
                rmComponent(j);
                <<<"remove">>>;
            }
            else if(k==1)
            {
                addComponent(1.0/13.0/j,j);
                <<<"add">>>;
                //Math.random2f(-1.0,1.0)=>pan[j].pan;
            }
            else if(k==2)
            {
                addComponent(1.0/13.0/j/j,j);
            //	Math.random2f(-1.0,1.0)=>pan[j].pan;
                <<<"add">>>;
            }
            else
            {
                Math.random2(0,NUM-1)=>int l;
                pan[j].pan()=>float temp;
                pan[l].pan()=>pan[j].pan;
                temp=>pan[l].pan;
                <<<"swap">>>;
            }
            Math.random2f(0.01,0.03)::second=>now;
        }
        for(0=>i;i<NUM;i++)
            rmComponent(i);
        <<<"over!">>>;
        for(0=>i;i<NUM;i++)
        {

            rmComponent(NUM-1-i);
                
            1::second=>now;
        }

        for(0=>i;i<NUM;i++)
        {
        

            addComponent(1.0/13.0/i,i);
            0.01::second=>now;

        }

        for(0=>i;i<NUM;i++)
        {

            rmComponent(NUM-1-i);
                
            1::second=>now;
        }
        
        for(0=>i;i<NUM;i++)
        {
        

            addComponent(1.0/13.0,i);
            0.01::second=>now;

        }

        for(0=>i;i<NUM;i++)
        {

            rmComponent(NUM-1-i);
                
            1::second=>now;
        }
        
            
    }





    fun void section1(){
        while(true)
        {
            scale[Math.random2(0,6)]=>Std.mtof=> f0;
            0=>p;
            1=>q;
            for(0=>i;i<NUM;i++)
            {	
                0=>sin[i].gain;
            }

            for(0=>i;i<NUM;i++)
            {
                p+q=>r;
                q=>p;
                r=>q;
                r*f0=>sin[i].freq;
                1.0/NUM*Math.random2f(0.25,4.0)=>sin[i].gain;
                <<<r>>>;
            }
            1::second=>now;	
        }
    }
*/
}




FibonacciPad fibpad => Mixer.bus[0];
0.4=>Mixer.bus[0].send[0].gain;
fibpad.set(110,20,2);
//fibpad.setADSR(1::ms,2::ms,0.8,1::second);
1.0 =>fibpad.gain;


Scale scale;
scale.set(50,"lydian");
float freq;
while(true)
{
    fibpad.randAmp();
    scale.sample()=>Std.mtof =>freq;
    fibpad.setFreq(freq);
    fibpad.noteOn();
    1.5::second=>now;
    fibpad.noteOff();
    0.5::second =>now;
}

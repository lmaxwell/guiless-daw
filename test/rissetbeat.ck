Scale scale;
scale.set(35,"lydian");
RissetBeat rb =>  Mixer.bus[0];
0.4=>Mixer.bus[0].send[0].gain;
rb=>RtGrain rtgrain => Mixer.bus[1];
0.7=>Mixer.bus[1].pan;
0.0=>Mixer.bus[1].send[0].gain;


spork ~rtgrain.run();
int num1,num2;
float rate;
0=>int count;

0.1=>rate;
rb.set(7,7,rate);
while(count<20)
{
    if (count % 4==0)
    {
        Math.random2(1,20)=>num1;
        Math.random2(1,200/num1)=>num2;
        Math.random2f(0.1,1.0)=>rate;
        rb.set(7,7,rate);
        <<<num1,num2,rate>>>;
    }
    scale.sample()=>Std.mtof=>float freq;
    rb.play(freq,2::second);
    count+1=>count;
}
    
while(true)
{

    if (count % 4==0)
    {
        Math.random2(1,100)=>num1;
        Math.random2(1,200/num1)=>num2;
        Math.random2f(0.05,1)=>rate;
        <<<num1,num2,rate>>>;
    }
    rb.set(num1,num2,rate);
    scale.sample()=>Std.mtof=>float freq;
    rb.play(freq,1::second);
    count+1=>count;
}


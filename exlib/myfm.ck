SinOsc m=>Gain g=>TriOsc c=>LPF l=>HPF h=>dac;

60=>c.freq;
225=>m.freq;
2=>c.sync;
0.0=>float i;
while(true) 
{
	i=>g.gain;
	<<<g.gain>>>;
	<<<i>>>;
	2000::ms=>now;
	i+0.2=>i;
}

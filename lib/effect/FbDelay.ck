public class FbDelay extends Chubgraph
{

	Gain forwardgain;
	Gain feedBack;
	inlet => forwardgain =>  DelayL dl => feedBack => forwardgain; 
	dl => Gain wet=> outlet;
	inlet => Gain dry =>outlet;
	1.0=>feedBack.gain;
	fun void setTime(dur dd)
	{
		dd => dl.max;
		dd => dl.delay;
	}
	fun void setFeedBack(float f)
	{
		f=>feedBack.gain;	
	}
	fun void setMix(float f)
	{
		f=>wet.gain;
		1.0-f=>dry.gain;
	}

}

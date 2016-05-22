public class FibonacciSeq{
	
	int i;
	int j;
	int k;
    int len;
	fun void set(int _len)
	{
		0=>i;
		0=>j;
		1=>k;
        _len=>len;
	}
	fun void reset()
	{
		0=>i;
		0=>j;
		1=>k;
	}

	fun int genNext()
	{
		j=>i;
		k=>j;
 		(i+j)%len=>k;
		return k;	
	}
}

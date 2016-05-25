public class RtGrain extends Chubgraph{

	LiSa lisa[3];
	5::second=> dur bufferlen;
	0 => int recbuf;
	2 => int playbuf;
	
	Event e;
	// LiSa params
	for( 0 => int i; i < 3; i++ )
	{
		lisa[i].duration( bufferlen );
		lisa[i].maxVoices( 30 );
		lisa[i].clear();
		lisa[i].gain( 0.1 );
		lisa[i].feedback( 0.5 );
		lisa[i].recRamp( 20::ms );
		lisa[i].record( 0 );

		inlet => lisa[i] => outlet;
	}

	lisa[recbuf].record(1);
	
	1=> int isGrain;

	fun void setIsGrain(int i)
	{
		i=>isGrain;	
	}

	fun void run()
	{
		while(true)
		{

			while(isGrain)
			{
				now + bufferlen => time later;

                0=>int count;
                float newrate;
                dur newdur;
                
				// toss some grains
				while( now < later )
				{
                    if(count%10==0)
                    {
                        Math.random2f(0.8, 1.2) =>  newrate;
                        Math.random2f(450, 600) * 1::ms => newdur;
                    }
					
					// grain
					spork ~ getgrain(playbuf, newdur, 50::ms, 50::ms, newrate);
					// advance time
					30::ms => now;
                    count+1=>count;
				}

				// rotate the record and playbufs
				lisa[recbuf++].record( 0 );
				if( recbuf == 3 ) 0 => recbuf;
				lisa[recbuf].record( 1 );

				playbuf++;
				if( playbuf == 3 ) 0 => playbuf;
			}
		}
		
	}


	// sporkee
	fun void getgrain( int which, dur grainlen, dur rampup, dur rampdown, float rate )
	{
		lisa[which].getVoice() => int newvoice;
		//<<<newvoice>>>;

		if(newvoice > -1)
		{
			lisa[which].rate(newvoice, rate);
			lisa[which].playPos(newvoice, Math.random2f(0,1) * bufferlen);
			lisa[which].rampUp(newvoice, rampup);
			(grainlen - (rampup + rampdown)) => now;
			lisa[which].rampDown(newvoice, rampdown);
			rampdown => now;
		}
	}



}


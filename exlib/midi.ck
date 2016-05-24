// number of the device to open (see: chuck --probe)
1 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;


0=>int isGrain;
0=>int grainChan;

// open the device
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;


// infinite time-loop
while( true )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
		<<<msg.data1,msg.data2,msg.data3>>>;
        // print out midi message
        if(msg.data1==176)
		{
			if(msg.data2>15 && msg.data2<23)
			{
				msg.data2-16=> int ich;
				-(msg.data3-63)/64=>Mixer.bus[ich].pan;
			}
			if(msg.data2>=64&&msg.data2<=71)
			{
				msg.data2-64=>grainChan;
				if(msg.data3==127)
				{
					//Mixer.rtGrain[grainChan].setIsGrain(1);
                    ;
					//Mixer.rtGrain[grainChan].e.signal();
				}
				if(msg.data3==0)
					//Mixer.rtGrain[grainChan].setIsGrain(0);
                    ;
			}
		}
        if(msg.data1>224)
		{

				msg.data1-224 => int ich;
				msg.data3/127.0=>Mixer.chan[ich].gain;
		}
    }
}









// this class defines the Dinky instrument
// the variables defined at class level are member variables
//
// to test this:
//    > chuck dinky.ck try.ck
//
// NOTE: in a future version of chuck...
//       this class will be able to extend UGen

// the Dinky class
class Dinky
{
   // impulse to filter to dac
   impulse i => biquad f => Envelope e;
   // set the filter's pole radius
   .99 => f.prad;
   // set equal gain zeros
   1 => f.eqzs;
   // set filter gain
   .2 => f.gain;
   // set the envelope
   .001::second => e.duration;

   public void radius( float rad )
   { rad => f.prad; }

   public void gain( float g )
   { g => i.gain; }// instantiate a Dinky (not connected yet)

   public void connect( UGen ugen )
   { e => ugen; }
    
   // t is for trigger
   public void t( float freq )
   {
       // set the current sample/impulse
       1.0 => i.next;
       // set filter resonant frequency
       freq => f.pfreq;
       // open the envelope
       e.keyOn();
   }

   // t is for trigger (using MIDI note numbers)
   public void t( int note )
   { t( std.mtof( note ) ); }
   
   // another lazy name: c (for close)
   public void c() { e.keyOff(); }
}


Dinky imp;

// connect the rest of the patch
gain g => NRev r => Echo e => Echo e2 => dac;
// direct/dry
g => dac;
e => dac;

// set up delay, gain, and mix
1500::ms => e.max => e.delay;
3000::ms => e2.max => e2.delay;
1 => g.gain;
.5 => e.gain;
.25 => e.gain;
.1 => r.mix;

// connect the Dinky
// (in a future version of chuck, Dinky can be defined as an UGen)
imp.connect( g );
// set the radius (should never be more than 1)
imp.radius( .999 );

// an array (our scale)
[ 0, 2, 4, 7, 9, 11 ] @=> int hi[];

// infinite time-loop
while( true )
{
   // trigger
   45 + std.rand2(0,3) * 12 +
        hi[std.rand2(0,hi.cap()-1)] => imp.t;
   // let time pass
   195::ms => now; 
   // close the envelope
   imp.c();
   // let a bit more time pass
   5::ms => now;  
}

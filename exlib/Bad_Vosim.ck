 // dynamic patch
  sinosc s1 => gain g => Mixer.bus[0];
  0.4=>Mixer.bus[0].send[0].gain;
  1.4=>Mixer.bus[0].send[1].gain;
  Mixer.fxdelay.fbdelay.setTime(100::ms);

  // feed s1 into g as second input
  s1 => g;
  // feed s1 to zero crossing then blackhole, which pulls samples
  s1 => gain g2 => zerox z => blackhole;
  
  // set multiply at g (1+, 2-, 3*, 4/)
  3 => g.op;
  
  // vosim control params
  1.0 => float amplitude;
  // factor
  .8 => float factor;
  // number of pulses
  10 => int N => int n;
  // duration between pulse series
  10::ms => dur M;
  
  // a control shred
  fun void foo()
  {
      0.0 => float t;
      while( true )
      {
          100.0 + 600.0 * std.fabs(math.sin(t)) => s1.sfreq;
          10::ms => now;
          t + .01 => t;
      }
  }
  
  // spork foo
  spork ~ foo();
  
  // bad vosim algorithm
  while( true )
  {
      // zero crossing
      if( z.last() != 0.0 )
      {
          // scale the amplitude   
          factor * amplitude => amplitude => g.gain;
          // next pulse
          n - 1 => n;
      
          // finished one series of pulses
          if( n <= 0 )
          {
              // silence
              0.0 => g.gain => g2.gain;
              // pause until the next pulse
              M => now;
              // reset osc phase - (not zero due to osc bug in 1.1.5.5 - fixed)
              0.00001 => s1.phase;
              // reset amplitude and gain
              1.0 => amplitude => g.gain => g2.gain;
              // reset N
              N => n;
          }
      }
      
      // advance time   
      1::samp => now;
  }

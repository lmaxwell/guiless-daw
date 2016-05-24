Machine.add("lib/basic/BPM.ck");
Machine.add("lib/basic/Chord.ck");
Machine.add("lib/basic/Scale.ck");
Machine.add("lib/effect/FbDelay.ck");
Machine.add("lib/effect/RtGrain.ck");
Machine.add("lib/instrument/MandoPlayer.ck");
Machine.add("lib/instrument/MandolinBass.ck");
Machine.add("lib/mixer/Mixer.ck");
Machine.add("lib/seq/EuclidSeq.ck");
Machine.add("lib/seq/FibonacciSeq.ck");
for(0=>int i;i<me.args();i++)
  Machine.add(me.arg(i));

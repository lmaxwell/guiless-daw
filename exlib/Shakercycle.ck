Shakers s => Chorus c1 => JCRev rev => Chorus c2 => Chorus c3 =>dac;

0 => s.which;
1. => s.gain;
100. => float theTime;

while (true)
{
    1.0 => s.noteOn;
    theTime::ms => now;

    1.0 => s.noteOff;
    theTime::ms => now;   

    ( s.which() + 1 ) % 20 => s.which;
    std.rand2f(20.,140.) => theTime;
}

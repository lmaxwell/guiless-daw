// modulator to carrier
SinOsc m => SinOsc c => dac;
// add constant bias (carrier freq)
Step s => c;
// carrier gain
.5 => c.gain;

// carrier frequency
220 => s.next;
// modulator frequency
550 => m.freq;
// index of modulation
200 => m.gain;

// targets and values
float mf_target, mf;
float cf_target, cf;
float im_target, im;

// spork it!
spork ~ ramp_mf();
spork ~ ramp_cf();
spork ~ ramp_im();
spork ~ ctrl_im();

// time-loop
while( true )
{
    Std.rand2f(10, 200) => mf_target;
    Std.rand2f(150, 410) => cf_target;
    <<< mf_target, cf_target >>>;
    4::second => now;
}

// interpolation
fun void ramp_mf()
{
    .01 => float slew;
    while (1)
    {
        (mf_target - mf) * slew + mf => mf => m.freq;
        0.01 :: second => now;
    }
}

// interpolation
fun void ramp_cf()
{
    .01 => float slew;
    while (1)
    {
        (cf_target - cf) * slew + cf => cf => s.next;
        0.01 :: second => now;
    }
}

// interpolation
fun void ramp_im()
{
    .05 => float slew;
    while (1)
    {
        (im_target - im) * slew + im => im => m.gain;
        5::ms => now;
    }
}

// control im
fun void ctrl_im()
{
    while( true )
    {
        Std.rand2f(20, 200) => im_target;
        <<< "im:", im_target >>>;
        Std.rand2f(2,4)::second => now;
    }
}

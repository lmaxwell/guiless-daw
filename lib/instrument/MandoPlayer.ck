// Listing 9.20 Smart mandolin instrument and player class
// Four Mando "strings", plus some smarts
// by Perry R. Cook, March 2013

public class MandoPlayer extends Chubgraph {     // (1) Public MandoPlayer class definition.
    // make an array of four mandolin strings and connect them up
    Mandolin m[4];             // (2) Contains four Mandolin UGens.
    m[0] => outlet;  // (3) Hooks them all up so you can hear them.
    m[1] => outlet;
    m[2] => outlet;
    m[3] => outlet;

    // set all four string frequencies in one function
    fun void freqs(float gStr, float dStr, float aStr, float eStr)
    {                      // (4) Sets all four string frequencies
        m[0].freq(gStr);
        m[1].freq(aStr);
        m[2].freq(dStr);
        m[3].freq(eStr);
    }

    // roll a chord from lowest note to highest at rate
    fun void roll(Chord chord, dur rate) 
    {                               // (9) Chord roll (arpeggiate) function.
        for (0 => int i; i < chord.note.cap(); i++) {
            chord.note[i]=>Std.mtof=>m[i].freq;
            1 => m[i].noteOn;       // (11) Plays notes one at a time...
            rate => now;            // (12) ...with rate duration between.
        }
    }

    // Archetypical tremolo strumming
    fun void strum(int note, dur howLong) 
    {                                      // (13) Strumming function (tremolo).
        int whichString;
        if (note < 62) 0 => whichString;      // (14) Figures out which string to strum.
        else if (note < 69) 1 => whichString;
        else if (note < 76) 2 => whichString;
        else 3 => whichString;
        Std.mtof(note) => m[whichString].freq; // (15) Sets frequency.
        now + howLong => time stop;            // (16) Time to stop strumming...
        while (now < stop) {                   // (17) ...do it until you get to that time.
            Std.rand2f(0.5,1.0) => m[whichString].noteOn;  // (18) Somewhat random volume.
            Std.rand2f(0.06,0.09) :: second => now;       // (19) Somewhat random time.
        }
    }

    // Damp all strings by amount
    // 0.0 = lots of damping, 1.0 = none
    fun void damp(float amount) {        // (20) Damping function.
        for (0 => int i; i < 4; i++) {
            amount => m[i].stringDamping;
        }
    }

// END the MandoPlayer Class Definition
       // (21) Whew! Finished defining the smart Mandolin player class.
}

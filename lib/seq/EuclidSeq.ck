//code from http://www.casperschipper.nl/v2/uncategorized/euclidian-rhythms-in-chuck/
public class Euclid {
    int bitmap[];
    int remainder[];
    int count[];
     
    fun  void buildString (int level) {
        if (level == -1) {
            append(bitmap,0);
        } else if (level == -2) {
            append(bitmap,1);
        } else {
            for (0 => int i; i < count[level]; i++) {
                buildString (level-1);
            } 
            if (remainder[level] != 0) {
                buildString (level-2);
            }
        }
    }
     
    fun void computeBitmap(int numSlots, int numPulses) {
        numSlots - numPulses => int divisor;
         
        null @=> remainder;
        null @=> count;
        null @=> bitmap;
         
        int a[100] @=> remainder;
        int b[100] @=> count;
        int c[0] @=> bitmap;
         
        numPulses => remainder[0];
        0 => int level;
        do {
            divisor / remainder[level] => count[level];
            divisor % remainder[level] => remainder[level + 1];
            remainder[level] => divisor;
            level++;
        } while (remainder[level] > 1);
         
        divisor => count[level];
         
        buildString (level);    
    }
     
    fun int [] compute(int slots,int pulse) {
        computeBitmap(slots,pulse);
        return bitmap;
    }
     
    fun int [] append (int input[],int value) {
        input.size() => int size;
        size + 1 => input.size;
        value => input[size];
        return input;
    }
     
    fun void [] print () {
        chout <= "Euclid pattern =" <= IO.newline();
        for (int i;i<bitmap.size();chout <= bitmap[i++] <= " ") {
            // nothing
        }
        chout <= IO.newline();
    }
}
 
 /*
class TestEuclid { // this is a little testclass...
    Euclid myPattern;
    chout <= myPattern.toString() <= IO.newline();
    float freq;
     
    fun void init(int numSlots,int pulses,float _freq) {
        _freq => freq;
        myPattern.compute(numSlots,pulses); // make a pattern with 15 slots of which 4 are turned on.
        myPattern.print(); 
        spork ~ schedule();
    }
     
    fun void ping(float gain,dur dura) { // a simple pulse
        SinOsc c => Envelope e => Pan2 p => dac;
        Math.random2f(-1,1) => p.pan;
        .12 => e.gain;
        freq => c.freq;
        gain => c.gain;
        e.value(1);
        e.target(0);
        dura * 2 => e.duration => now;
    }
     
    fun void schedule() { // sequencer
        0 => int i;
        myPattern.print();
        while(1) {
            spork ~ ping(myPattern.bitmap[i++],.1::second);
            i % myPattern.bitmap.cap() => i;
            .12::second => now;
        }
    }
}
 
TestEuclid test[10];
 
test.cap() => int i;
while(i--) { // 10 test patterns with random amount of slots and pulses, random harmonic of 55 hz.
    // note: handpicking the values can give even nicer results
    test[i].init(Math.random2(7,21),Math.random2(2,7),Math.random2(1,8)*110);
}
 
 
hour => now;
*/

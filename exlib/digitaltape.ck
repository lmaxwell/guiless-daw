//DigitalTape:
//Name and concept by kijjaz
//Implementation by Pyry Pakkanen (Frostburn)
/*
    This program is free software: you can redistribute it and/or modify 
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful, 
    but WITHOUT ANY WARRANTY; without even the implied warranty of 
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License 
    along with this program.  If not, see <http://www.gnu.org/licenses/>. 
*/

class DigitalTapeManipulator{
        float buffer[]; //This is a pointer to a cassette of DigitalTape
        
        //Interpolation when upsampling 0 = none, 1 = linear TODO:Cubic
        1 => int interp;        
                
        false => int loop; //Loop around the array?
        //float loopStart; //TODO?
        //float loopEnd;
        
        1.0 => float rate; //When this is the rate of writing, it will have the inverse effect when played back. (recorded slow => plays fast)
        0 => int pos; //The position in the buffer
        pos => float lastPos; //This is a more abstract position that takes looping in to account if it's "out range".
        
        fun float setPos(float _pos){
                _pos => lastPos;
                Math.floor(_pos)$int => pos;
                checkLoop();
                return lastPos;
        }

        fun void checkLoop(){
                if(loop){
                        while(pos >= buffer.cap()) buffer.cap() -=> pos;
                        while(pos < 0) buffer.cap() +=> pos;
                }
                else{
                        if(pos >= buffer.cap()) buffer.cap()-1 => pos; 
                        else if(pos < 0) 0 => pos;
                }
        }
}

class DigitalTapeWriter extends DigitalTapeManipulator{
        0.0 => float feedback; //How much to retain when overdubbing?

        //Interpolation varibles
        float interpBuffer[2];
        0.0 => float nu;
        int sgn;
        float diff;
        0.0 => float mu;
        
        fun float write(float value){
                return write(value,lastPos+rate);
        }
        fun float write(float value,float nextPos){
                for(0 => int i; i < interpBuffer.cap()-1; i++) interpBuffer[i] => interpBuffer[i+1];
                value => interpBuffer[0];
                
                Std.fabs(nextPos-lastPos) +=> nu;
                Std.sgn(nextPos-lastPos)$int => sgn;
                
                if(interp == 0){
                        while(nu >= 1.0){
                                value + buffer[pos]*feedback => buffer[pos];
                                sgn +=> pos;
                                checkLoop();                        
                                1.0 -=> nu;
                        }
                }
                else if(interp == 1){
                        nextPos-lastPos => diff;
                        while(nu > 0.0){
                                ( nextPos - Math.floor(lastPos) )/diff => mu;
                                (interpBuffer[0]*(1.0-mu)+interpBuffer[1]*mu) + buffer[pos$int]*feedback => buffer[pos$int];
                                sgn +=> pos;
                                sgn +=> lastPos;
                                checkLoop();                        
                                1.0 -=> nu;
                        }
                }
                
                nextPos => lastPos;
                return value;
        }
}

class DigitalTapeReader extends DigitalTapeManipulator{
        //Interpolation varibles
        float returnValue;
        float interpBuffer[2];
        0.0 => float mu;
        
        fun float read(){
                return read(lastPos+rate);
        }
        fun float read(float nextPos){                           
                if(interp == 0){
                        nextPos$int => pos;
                        checkLoop();
                        buffer[pos] => returnValue;
                }
                else if(interp == 1){
                        nextPos-Math.floor(nextPos) => mu;
                        Math.floor(nextPos)$int+1 => pos;
                        checkLoop();
                        buffer[pos] => interpBuffer[1];
                        
                        Math.floor(nextPos)$int => pos;
                        checkLoop();
                        buffer[pos] => interpBuffer[0];
                        
                        interpBuffer[0]*(1.0-mu) + interpBuffer[1]*mu => returnValue;
                }
                
                nextPos => lastPos;
                return returnValue;
        }
       
}


class ArrayPlayer{ //Plays the contents of a float buffer using linear interpolation
        float buffer[]; //This is a pointer to a cassette of DigitalTape        

        Impulse impulse => Gain out;
        
        1.0 => float rate;
        0.0 => float pos;
        
        float mu;
        
        fun void play(){
                while(pos < buffer.cap()){
                        pos-pos$int => mu;
                        valueAt(pos$int)*(1.0-mu)+valueAt(pos$int+1)*mu => impulse.next;
                        rate +=> pos;
                        samp => now;
                }
        }        
        
        fun float valueAt(int where){
                if(where < 0) 0 => where;
                if(where >= buffer.cap() ) buffer.cap()-1 => where;
                return buffer[where];
        }
}

float digitaltape[(10::second/samp)$int]; //A tape with 10 seconds worth of samples

DigitalTapeWriter dtw;
digitaltape @=> dtw.buffer; //Make the connection
(7.5::second/samp) => dtw.setPos; //Let's write past the middle of the buffer

//Here's how to copy the contents of a sound file to a float buffer using DigitalTapeWriter
1.0 => dtw.rate;
SndBuf sndbuf;// "samples/garbage.wav" => sndbuf.read;
for(0 => int i; i < sndbuf.samples(); i++) i => sndbuf.valueAt => dtw.write;

//Ok let's go crazy:
1.0 => dtw.feedback; //Retain everything when overdubbing

DigitalTapeReader dtr;
digitaltape @=> dtr.buffer; //Connect the read head to the tape

fun void omgwtfbbq(float start){ //I'm pretty sure all your base are belong to us!!
        Std.rand2f(start::second/samp,10::second/samp) => dtr.setPos; //Main screen turn on!!
        Std.rand2f(second/samp,7::second/samp) => dtw.setPos;
        for(0.0 => float t; t < 1.0 ; samp/second +=> t){
                Std.rand2f(0.9995,1.0005) *=> dtr.rate; //Read and write at changing rates to make it all wavely
                Std.rand2f(0.9995,1.0005) *=> dtw.rate;
                dtr.read()*t*(1.0-t)*3.5 => dtw.write; //Someone set up us the bomb!!
        }                
}

//Work from the back of the buffer towards the beginning and **uck everything up. ** == ch
for(7.5 => float t; t > 0.0; 0.1 -=> t) omgwtfbbq(t); //This'll take a while...
<<<"ok","done">>>;


//Let's hear it!
ArrayPlayer ap;
digitaltape @=> ap.buffer;
ap.out => dac;// => WvOut w => blackhole; "foo.wav" => w.wavFilename;
0.5 => ap.out.gain;
ap.play();
//w.closeFile();

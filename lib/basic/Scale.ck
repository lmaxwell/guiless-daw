public class Scale{
	
  static int note[];
	  
	fun void set(int p,string mode)
	{
    if(mode=="ionian")
      [p-1,p,p+2,p+4,p+5,p+7,p+9]@=>note;
	else if(mode=="dorian")
			[p-2,p,p+2,p+3,p+5,p+7,p+8]@=>note;
    else if(mode=="phrygian")
      [p-2,p,p+1,p+3,p+5,p+7,p+8]@=>note;
    else if(mode=="lydian")
      [p-1,p,p+2,p+4,p+6,p+7,p+9]@=>note;
    else if(mode=="mixolydian")
      [p-2,p,p+2,p+4,p+5,p+7,p+9]@=>note;
    else if(mode=="aeolian")
      [p-2,p,p+2,p+3,p+5,p+7,p+8]@=>note;
    else if(mode=="locrian")
      [p-2,p,p+1,p+3,p+5,p+7,p+8]@=>note;
    else
      [p-1,p,p+2,p+4,p+5,p+7,p+9]@=>note;
	}	
    fun int sample()
    {
        note.cap()=>int len;
        return note[Math.random2(0,len-1)];
    }
}

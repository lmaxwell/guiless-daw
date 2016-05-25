public class Scale{
	
  static int note[];
	  
	fun void set(int p,string mode)
	{
    if(mode=="ionian" || mode=="i")
      [p,p+2,p+4,p+5,p+7,p+9,p+11]@=>note;
	else if(mode=="d||ian" || mode=="ii")
			[p,p+2,p+3,p+5,p+7,p+8,p+10]@=>note;
    else if(mode=="phrygian" || mode=="iii")
      [p,p+1,p+3,p+5,p+7,p+8,p+10]@=>note;
    else if(mode=="lydian" || mode=="iv")
      [p,p+2,p+4,p+6,p+7,p+9,p+11]@=>note;
    else if(mode=="mixolydian" || mode =="v")
      [p,p+2,p+4,p+5,p+7,p+9,p+10]@=>note;
    else if(mode=="aeolian" || mode=="vi")
      [p,p+2,p+3,p+5,p+7,p+8,p+10]@=>note;
    else if(mode=="locrian" || mode=="vii")
      [p,p+1,p+3,p+5,p+7,p+8,p+10]@=>note;
    else
      [p,p+2,p+4,p+5,p+7,p+9,p+11]@=>note;
	}	

    fun int sample()
    {
        note.cap()=>int len;
        return note[Math.random2(0,len-1)];
    }
       
    fun int get(int degree)
    {
        return note[degree-1];
    }
        
}

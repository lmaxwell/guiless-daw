public class Chord
{
    static int note[];
    fun void set(int root, string quality)
    {
        if(quality=="major")
            [root,root+4,root+7]@=>note;
        else if(quality=="minor")
            [root,root+3,root+7]@=>note;
        else if(quality=="major7")
            [root,root+4,root+7,root+11]@=>note;
        else if(quality=="dom7")
            [root,root+4,root+7,root+10]@=>note;
        else if(quality=="minor7")
            [root,root+3,root+7,root+10]@=>note;
        else if(quality=="mMaj7")
            [root,root+3,root+7,root+11]@=>note;
    }
    fun int sample()
    {
        note.cap()=>int len;
        return note[Math.random2(0,len-1)];
    }
}

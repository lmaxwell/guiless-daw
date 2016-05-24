public class GrainSync
{
    1 => int _play;
    0 => int _id;
    
    Global g;
    Grain grain;
    
    fun void setGlobal(Global G)
    {
        G @=> g;
    }
    
    fun void setID(int id)
    {
        id => _id;
    }
    
    fun void stop()
    {
        0 => _play;
    }
    
    fun float currentTime()
    {
        return Std.rand2f( g.SEL_TIME*( 1 - g.TIME_DISP), g.SEL_TIME*( 1 + g.TIME_DISP ) );
    }
    
    fun float getPan()//pan slider [0,2]
    {
        Std.rand2f(g.PAN - g.PAN_DISP, g.PAN + g.PAN_DISP ) => float temp; 
        if(temp > 2)
        {
            4 - temp => temp;
        }
        else if(temp < 0)
        {
            -1*temp => temp;
        }
        return temp - 1;//[-1, 1]
    }
    
    fun float getPitch()//pan slider [0,2]
    {
        return Std.rand2f( g.SEL_PITCH*( 1 - g.DISP_PITCH ), g.SEL_PITCH*( 1 + g.DISP_PITCH ) ); 
    }
    
    fun float getVolume()
    {
        Std.rand2f( g.SEL_VOLUME - g.DISP_VOLUME, g.SEL_VOLUME + g.DISP_VOLUME ) => float vol;
        if(vol > 1.0) 
        {
            return 1.0;
        }
        else if(vol < 0.0 )
        {
            return 0.0;
        }
        else
        {
            return vol;
        }
    }
    
    fun void grainLayer()
    {
        1 => _play;
        while(_play == 1)
        {
            spork ~ grain.playGrain(g.SAMPLE_RATE, g.MASTER_GAIN, getVolume(), getPan(), getPitch(), g.DURATION);
            now + currentTime()::ms => now;
        }
    }
}

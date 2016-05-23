public class EuclidSeq{

    int total;
    int beat;
    int cur;
    int rotation;
    
    fun void set(int _total,int _beat,int _rotation)
    {
        _total=>total;
        _beat=>beat;
        _rotation=>rotation;
        0=>cur;
    }

    fun int euclide( int c, int k, int n, int r ) { 
           return (((c + r) * k) % n) < k; 
    } 

    fun void setRotation(int r)
    {
        r=>rotation;
    }

    fun void random()
    {
        Math.random2(0,total)=>rotation;
    }

    fun int genNext()
    {
        cur++;
        return euclide(cur-1,beat,total,rotation);
    }
}




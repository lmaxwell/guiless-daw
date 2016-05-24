public class Global
{
    44100 => int SAMPLE_RATE;
    15 => int MAX_THREAD_NUM;
    //estos parametros deberian ser recibidos globalmente
    100 => int TMIN;
    8000 => int TMAX;
    
    (TMIN + TMAX)/2.0 => float SEL_TIME;
    1.0 => float TIME_DISP;
    
    1.0 => float PAN;
    1.0 => float PAN_DISP;
    
    3000 => float PITCH_MIN;
    16000 => float PITCH_MAX;
    0 => float DISP_PITCH;
    PITCH_MAX/1.3 => float SEL_PITCH;
    
    0.002 => float DURATION;
    
    0.5 => float SEL_VOLUME;
    0.5 => float DISP_VOLUME;
    
    1 => float MASTER_GAIN;
}
/*
grain generator
by Wolfgang Gil
*/

Global g;

GrainSync gs_array[ g.MAX_THREAD_NUM ];//critic seccion
0 => int GS_COUNT;

// maui elements
MAUI_View control_view;

MAUI_Button b_add; MAUI_Button b_remove;
MAUI_Slider time_slider;
MAUI_Slider time_disp_slider;
MAUI_Slider volume_slider;
MAUI_Slider vol_disp_slider;
MAUI_Slider pan_slider;
MAUI_Slider pan_disp_slider;
MAUI_Slider osc_freq_slider;
MAUI_Slider pitch_disp_slider;
MAUI_Slider env_osc_slider;

// set view
control_view.size( 400, 350 );
control_view.name( "Simple Granular Synt" );

// time slider
time_slider.range( g.TMIN, g.TMAX );
time_slider.size( 200, time_slider.height() );
time_slider.position( 0, 0 );
time_slider.value((g.TMIN + g.TMAX)/2 );
time_slider.name( "Time" );
control_view.addElement( time_slider );

// time_disp
time_disp_slider.range( 0, 1 );
time_disp_slider.size( 200, volume_slider.height() );
time_disp_slider.position( 200, 0 );
time_disp_slider.value( 1 );
time_disp_slider.name( "Time disp" );
control_view.addElement( time_disp_slider );

// Pan
pan_slider.range( 0, 2 );
pan_slider.size( 200, pan_slider.height() );
pan_slider.position( 0, 70 );
pan_slider.value( 1 );
pan_slider.name( "Pan" );
control_view.addElement( pan_slider );



// volume
volume_slider.range( 0, 1 );
volume_slider.size( 200, volume_slider.height() );
volume_slider.position( 0, 135 );
volume_slider.value( 0.5 );
volume_slider.name( "Volume" );
control_view.addElement( volume_slider );

// pan_disp
pan_disp_slider.range( 0, 1 );
pan_disp_slider.size( 200, volume_slider.height() );
pan_disp_slider.position( 200, 70 );
pan_disp_slider.value( 1 );
pan_disp_slider.name( "Pan disp" );
control_view.addElement( pan_disp_slider );

// vol_disp_slider
vol_disp_slider.range( 0, 1 );
vol_disp_slider.size( 200, pan_disp_slider.height() );
vol_disp_slider.position( 200, 135 );
vol_disp_slider.value( 0.5 );
vol_disp_slider.name( "volume disp" );
control_view.addElement( vol_disp_slider );

//pitch disp
pitch_disp_slider.range( 0, 1 );
pitch_disp_slider.size( 200, pitch_disp_slider.height() );
pitch_disp_slider.position( 200 , 200 );
pitch_disp_slider.value(0.33);
pitch_disp_slider.name( "Pitch_disp" );
control_view.addElement( pitch_disp_slider );

// OSC_FREQ VOLUME
osc_freq_slider.range( g.PITCH_MIN, g.PITCH_MAX );
osc_freq_slider.size( 200, osc_freq_slider.height() );
osc_freq_slider.position( 0, 200 );
osc_freq_slider.value(g.PITCH_MAX/1.3);
osc_freq_slider.name( "OSC_FREQ" );
control_view.addElement( osc_freq_slider );

// button (noteOn)
//
b_add.pushType();
b_add.size( 115, 80 );
b_add.position( 0, 260 );
b_add.name( "Add thread" );
control_view.addElement( b_add );

// b_remove button
b_remove.pushType();
b_remove.size( b_add.width(), b_add.height() );
b_remove.position( b_add.x() + b_add.width()/1.35, b_add.y() );
b_remove.name( "remove" );
control_view.addElement( b_remove );

control_view.display();

function void addThread()
{
    while( true )
    {
        // wait for the button to be pushed down
        b_add => now;
        if(b_add.state() == 1)
        {
            if(GS_COUNT < g.MAX_THREAD_NUM)
            {
                GrainSync gs;
                gs.setGlobal(g); 
                //gs.setCh(1);
                spork ~ gs.grainLayer();
                gs @=> gs_array[GS_COUNT];
                1 +=> GS_COUNT;
            }
        }
    }
}

function void removeThread()
{
    while( true )
    {
        // wait for button to be pushed down
        b_remove => now;
        if(b_remove.state() == 1)
        {
            if(GS_COUNT > 0)
            {
                gs_array[GS_COUNT - 1].stop();
                1 -=> GS_COUNT;
            }
        }
    }
}

function void setTime()
{
    while( true )
    {
        time_slider => now;
        time_slider.value() => g.SEL_TIME;
    }
}

function void setPan()
{
    while( true )
    {
        pan_slider => now;
        pan_slider.value() => g.PAN;
    }
}

function void setVolume()
{
    while( true )
    {
        volume_slider => now;
        volume_slider.value() => g.SEL_VOLUME;
    }
}

function void setVolDisp()
{
    while( true )
    {
        vol_disp_slider => now;
        vol_disp_slider.value() => g.DISP_VOLUME;
    }
}

function void setTimeDisp()
{
    while( true )
    {
        time_disp_slider => now;
        time_disp_slider.value() => g.TIME_DISP;
    }
}

function void setPanDisp()
{
    while( true )
    {
        pan_disp_slider => now;
        pan_disp_slider.value() => g.PAN_DISP;
    }
}

function void setOscFreq()
{
    while( true )
    {
        pitch_disp_slider => now;
        pitch_disp_slider.value() => g.DISP_PITCH;
    }
}

function void setPitchDisp()
{
    while( true )
    {
        osc_freq_slider => now;
        osc_freq_slider.value() => g.SEL_PITCH;
    }
}


spork ~ addThread();
spork ~ removeThread();
spork ~ setTime();
spork ~ setVolume();
spork ~ setPan();
spork ~ setVolDisp();
spork ~ setTimeDisp();
spork ~ setPanDisp();
spork ~ setOscFreq();
spork ~ setPitchDisp();

while( true )
    1::day => now;


/*main granular synthetizer
*/
"/Users/baidu/software/chuckComposition/exlib/granularSynt_noreverb_variable_volume/"=> string path;
// add foo.ck
    // pass foo and bar as command line arguments
    Machine.add( path + "Global.ck" );
    Machine.add( path + "Grain.ck" );
    Machine.add( path + "GrainSync.ck" );
    
    // replace shred with "bar.ck"
    // pass foo and bar as command line arguments
    
MAUI_View main_window;
MAUI_Button b_add;
main_window.size( 400, 275 );
main_window.name( "Simple Granular Synt" );

b_add.pushType();
b_add.size( 0, 0 );
b_add.position( 0, 200 );
b_add.name( "Add thread" );
main_window.addElement( b_add );

function void addThread()
{
    while( true )
    {
        b_add => now;
        if(b_add.state() == 1)
        {
            Machine.add( "/SyncWindow.ch" );
        }
    }    
}

spork ~ addThread();
while( true )
    1::day => now;

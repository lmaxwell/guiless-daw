// Chuck Lab:  Guitar Lab and Synth Lab Combined!
// Copyright 2008 Les Hall
// This software is protected by the GNU General Public License


// varibles

// create an instance of each class
Guitar_Lab GL;
Synth_Lab SL;

// send Guitar Lab's output to Synth Lab's input
GL.out => SL.in;

// loop forever
while (true) {
    day => now;
}






// Guitar Lab with MAUI Control Interface
// copyright 2008 Les Hall
// this software is protected by the GNU General Public License

// make the whole program be a class
class Guitar_Lab {
    
    // control variables
    2 => int n;  // base of count
    12 => int num_digits;  // number of digits in base-n count
    8 => int num_and_terms;  // number of and terms
    2 => int num_and_pages;  // number of pages of and terms
    0 => int and_page;  // the current and page
    0 => int instrument;  // the current instrument
    11 => int num_instruments;  // number of instruments
    9 => int num_scales;  // number of scales
    0 => int scale;  // the current scale index
    [20.0, 60.0, 30.0, 10.0, 30.0, 40.0, 20.0, 20.0, 20.0, 20.0, 30.0] @=> float freq_offset_values[];  // frequency offset values
    int freq;  // the frequency index of the next note
    float frequency; // the frequency of the next note
    int play_note;  // 1 to play this note
    int page_term_index;  // holds calculated index value
    int dont_care;  // adds up don't care bits
    int and_term;  // 1 if play_note should be true
    float playback_rate;  // 1 for normal speed, 16 for fast forward
    int j[num_digits];  // the base-n count
    int freq_amount[num_instruments][num_digits];  // frequency bit values
    int note[num_instruments][num_and_pages][num_and_terms];  // notes to play
    int and_values[num_instruments][num_and_pages*num_and_terms][num_digits];  // holds current value of buttons
    int note_prob[num_digits];  // the note probability for each bit position
    
    
    // variables for handling shred sporking and shred removing
    int shred_id_frequency_offset;
    int shred_id_and_buttons[num_and_terms][num_digits];
    int shred_id_plus_buttons[num_digits];
    int shred_id_minus_buttons[num_digits];
    int shred_id_note_plus_buttons[num_and_terms];
    int shred_id_note_minus_buttons[num_and_terms];
    int shred_id_scales[num_scales];
    10 => int num_guitar_shreds;
    int shred_id_guitar[num_guitar_shreds];
    7 => int num_flute_shreds;
    int shred_id_flute[num_flute_shreds];
    5 => int num_snare_shreds;
    int shred_id_snare[num_snare_shreds];
    8 => int num_drum_shreds;
    int shred_id_drum[num_drum_shreds];
    12 => int num_mandolin_shreds;
    int shred_id_mandolin[num_mandolin_shreds];
    10 => int num_saxophone_shreds;
    int shred_id_saxophone[num_saxophone_shreds];
    1 => int num_thunder_shreds;
    int shred_id_thunder[num_thunder_shreds];
    1 => int num_delaysnare_shreds;
    int shred_id_delaysnare[num_delaysnare_shreds];
    5 => int num_mic_shreds;
    int shred_id_mic[num_mic_shreds];
    5 => int num_shakers_shreds;
    int shred_id_shakers[num_shakers_shreds];
    5 => int num_stifkarp_shreds;
    int shred_id_stifkarp[num_stifkarp_shreds];
    3 => int num_ocean1_shreds;
    int shred_id_ocean1[num_ocean1_shreds];
    2 => int num_rain1_shreds;
    int shred_id_rain1[num_rain1_shreds];
    1 => int num_rain2_shreds;
    int shred_id_rain2[num_rain2_shreds];
    2 => int num_effects_shreds;
    int shred_id_effects[num_effects_shreds];
    
    
    
    MAUI_View control_view;
    MAUI_View string_view;
    MAUI_View percussion_view;
    MAUI_View wind_view;
    MAUI_View scales_view;
    MAUI_Button start_button, record_button, clear_button, ffwd_button;
    MAUI_Button instrument_minus_button, instrument_plus_button, instrument_button;
    MAUI_Button xor_button;
    MAUI_Button and_buttons[num_and_terms][num_digits];
    MAUI_Button and_plus_button, and_minus_button, and_page_button;
    MAUI_LED count[num_digits];
    MAUI_LED logic[num_and_terms];
    MAUI_LED playing_note;
    MAUI_Button plus_buttons[num_digits];
    MAUI_Button minus_buttons[num_digits];
    MAUI_Button freq_buttons[num_digits];
    MAUI_Button note_plus_buttons[num_and_terms];
    MAUI_Button note_minus_buttons[num_and_terms];
    MAUI_Button note_buttons[num_and_terms];
    MAUI_Slider master_volume;
    MAUI_Slider base;
    MAUI_Slider freq_offset;
    MAUI_Slider notes_per_second;
    MAUI_Slider reverb, body_size, pluck_pos;
    MAUI_Slider string_damping, string_detune, after_touch;
    MAUI_Slider guitar_echo_delay, guitar_echo_max, guitar_echo_mix;
    MAUI_Slider jet_delay, jet_reflection, end_reflection;
    MAUI_Slider noise_gain, vibrato_freq, vibrato_gain;
    MAUI_Slider snare_freq, snare_Q, snare_decay, snare_attack;
    MAUI_Slider drum_freq, drum_pitch_decay, drum_pitch_attack;
    MAUI_Slider drum_decay, drum_attack, drum_drive_gain;
    MAUI_Slider drum_filter;
    MAUI_Slider mandolin_body_size, mandolin_pluck_pos, mandolin_after_touch;
    MAUI_Slider mandolin_string_damping, mandolin_string_detune;
    MAUI_Slider mandolin_gain1, mandolin_gain2;
    MAUI_Slider saxophone_stiffness, saxophone_aperture, saxophone_pressure;
    MAUI_Slider saxophone_noise_gain, saxophone_vibrato_freq, saxophone_vibrato_gain;
    MAUI_Slider saxophone_blow_position, saxophone_rate, saxophone_reverb;
    MAUI_Slider thunder_probability;
    MAUI_Slider mic_chorus_mod_freq, mic_chorus_mod_depth, mic_chorus_mix;
    MAUI_Slider mic_nrev_mix;
    MAUI_Slider shakers_preset, shakers_objects, shakers_decay, shakers_energy;
    MAUI_Slider stifkarp_pickupPosition, stifkarp_sustain;
    MAUI_Slider stifkarp_stretch, stifkarp_baseLoopGain;
    MAUI_Slider wahwah_freq, jcreverb_mix;
    MAUI_Button Guitar, Flute, Snare, Drum;
    MAUI_Button Mandolin, Saxophone, Thunder, DelaySnare;
    MAUI_Button Microphone, Shakers, StifKarp;
    MAUI_Button WahWah, JCReverb, Ocean1, Rain1, Rain2;
    MAUI_Slider guitar_gain, flute_gain, snare_gain, drum_gain;
    MAUI_Slider mandolin_gain, saxophone_gain, thunder_gain, delaysnare_gain;
    MAUI_Slider microphone_gain, shakers_gain, stifkarp_gain, ocean1_gain;
    MAUI_Slider rain1_gain, rain2_gain;
    MAUI_Button M1_Dyno_limit, M1_Dyno_compress, M1_Dyno_expand, M1_Dyno_gate;
    MAUI_Button scales[num_scales];
    MAUI_Button author;
    
    
    
    control_view.size (800, 600);
    control_view.name ("Guitar Lab - Logic Matrix"); 
    string_view.size (800, 600);
    string_view.name ("Guitar Lab - String Instruments"); 
    percussion_view.size (800, 600);
    percussion_view.name ("Guitar Lab - Percussion Instruments"); 
    wind_view.size (800, 600);
    wind_view.name ("Guitar Lab - Wind Instruments"); 
    scales_view.size (800, 600);
    scales_view.name ("Guitar Lab - Scales"); 
    
    start_button.toggleType ();
    start_button.size (100, 60);
    start_button.position (360, 0);
    start_button.name ("Play");
    control_view.addElement (start_button);
    
    record_button.toggleType ();
    record_button.size (100, 60);
    record_button.position (440, 0);
    record_button.name ("Record");
    control_view.addElement (record_button);
    
    clear_button.pushType ();
    clear_button.size (100, 60);
    clear_button.position (600, 0);
    clear_button.name ("Clear");
    control_view.addElement (clear_button);
    
    ffwd_button.pushType ();
    ffwd_button.size (100, 60);
    ffwd_button.position (520, 0);
    ffwd_button.name ("FFwd");
    control_view.addElement (ffwd_button);
    
    xor_button.toggleType ();
    xor_button.size (100, 60);
    xor_button.position (680, 0);
    xor_button.name ("OR");
    control_view.addElement (xor_button);
    
    instrument_plus_button.pushType ();
    instrument_plus_button.size (60, 60);
    instrument_plus_button.position (120, 0);
    instrument_plus_button.name ("+");
    control_view.addElement (instrument_plus_button);
    
    instrument_minus_button.pushType ();
    instrument_minus_button.size (60, 60);
    instrument_minus_button.position (0, 0);
    instrument_minus_button.name ("-");
    control_view.addElement (instrument_minus_button);
    
    instrument_button.pushType ();
    instrument_button.size (120, 60);
    instrument_button.position (30, 0);
    instrument_button.name ("Guitar");
    control_view.addElement (instrument_button);
    
    and_plus_button.pushType ();
    and_plus_button.size (60, 60);
    and_plus_button.position (300, 0);
    and_plus_button.name ("+");
    control_view.addElement (and_plus_button);
    
    and_minus_button.pushType ();
    and_minus_button.size (60, 60);
    and_minus_button.position (180, 0);
    and_minus_button.name ("-");
    control_view.addElement (and_minus_button);
    
    and_page_button.pushType ();
    and_page_button.size (120, 60);
    and_page_button.position (210, 0);
    and_page_button.name ("page " + and_page);
    control_view.addElement (and_page_button);
    
    for (0 => int a; a < num_and_terms; a++) {
        for (0 => int b; b < num_digits; b++) {
            for (0 => int p; p < num_and_pages; p++) {
                0 => and_values[instrument][p*num_and_terms+a][b];
            }
            and_buttons[a][b].pushType ();
            and_buttons[a][b].size (65, 65);
            and_buttons[a][b].position (40*(num_digits-b-1), 75+40*a);
            and_buttons[a][b].name ("");
            control_view.addElement (and_buttons[a][b]);
        }    
    }
    
    for (0 => int b; b < num_digits; b++) {
        count[b].color (count[b].red);
        count[b].size (50, 50);
        count[b].position (8+40*(num_digits-b-1), 42);
        control_view.addElement (count[b]);
    }
    
    for (0 => int a; a < num_and_terms; a++) {
        logic[a].color (logic[a].green);
        logic[a].size (50, 50);
        logic[a].position (8+40*num_digits, 82+40*a);
        control_view.addElement (logic[a]);
    }
    
    playing_note.color (playing_note.blue);
    playing_note.size (50, 50);
    playing_note.position (8+40*num_digits, 42);
    control_view.addElement (playing_note);
    
    for (0 => int b; b < num_digits; b++) {
        plus_buttons[b].pushType ();
        plus_buttons[b].size (60, 60);
        plus_buttons[b].position (40*(num_digits-b-1)+2, 40+10+40*(num_and_terms+1));
        plus_buttons[b].name ("+");
        control_view.addElement (plus_buttons[b]);
    }    
    
    for (0 => int b; b < num_digits; b++) {
        minus_buttons[b].pushType ();
        minus_buttons[b].size (60, 60);
        minus_buttons[b].position (40*(num_digits-b-1)+2, 40-5+40*(num_and_terms+3));
        minus_buttons[b].name ("-");
        control_view.addElement (minus_buttons[b]);
    }    
    
    for (0 => int b; b < num_digits; b++) {
        for (0 => int i; i < num_instruments; i++) {
            0 => freq_amount[i][b];
        }
        freq_buttons[b].pushType ();
        freq_buttons[b].size (65, 65);
        freq_buttons[b].position (40*(num_digits-b-1), 40+40*(num_and_terms+2));
        freq_buttons[b].name ("" + freq_amount[instrument][b]);
        control_view.addElement (freq_buttons[b]);
    }    
    
    for (0 => int b; b < num_and_terms; b++) {
        note_plus_buttons[b].pushType ();
        note_plus_buttons[b].size (60, 60);
        note_plus_buttons[b].position (40*(num_digits+1)+60, 75+40*b+2);
        note_plus_buttons[b].name ("+");
        control_view.addElement (note_plus_buttons[b]);
    }    
    
    for (0 => int b; b < num_and_terms; b++) {
        note_minus_buttons[b].pushType ();
        note_minus_buttons[b].size (60, 60);
        note_minus_buttons[b].position (40*(num_digits+1), 75+40*b+2);
        note_minus_buttons[b].name ("-");
        control_view.addElement (note_minus_buttons[b]);
    }    
    
    for (0 => int b; b < num_and_terms; b++) {
        for (0 => int p; p < num_and_pages; p++) {
            for (0 => int i; i < num_instruments; i++) {
                5 => note[i][p][b];
            }
        }
        note_buttons[b].pushType ();
        note_buttons[b].size (65, 65);
        note_buttons[b].position (40*(num_digits+1)+28, 75+40*b);
        note_buttons[b].name ("" + note[instrument][0][b]);
        control_view.addElement (note_buttons[b]);
    }    
    
    "Volume" => master_volume.name;
    master_volume.range (0, 1);
    master_volume.value (0.5);
    master_volume.size (140, 75);
    master_volume.position (650, 400);
    control_view.addElement (master_volume);
    
    "Base" => base.name;
    base.range (2, 10);
    base.value (2);
    base.size (140, 75);
    base.position (650, 450);
    base.displayFormat (base.integerFormat);
    control_view.addElement (base);
    
    "Base Note" => freq_offset.name;
    freq_offset.range (0, 127);
    freq_offset.value (freq_offset_values[instrument]);
    freq_offset.size (140, 75);
    freq_offset.position (500, 450);
    freq_offset.displayFormat (freq_offset.integerFormat);
    control_view.addElement (freq_offset);
    
    "Notes/Sec" => notes_per_second.name;
    notes_per_second.range (1, 16);
    notes_per_second.value (6);
    notes_per_second.size (140, 75);
    notes_per_second.position (500, 400);
    notes_per_second.displayFormat (notes_per_second.integerFormat);
    control_view.addElement (notes_per_second);
    
    "Reverb" => reverb.name;
    reverb.range (0, 1);
    reverb.value (0.1);
    reverb.size (200, 75);
    reverb.position (150, 0);
    string_view.addElement (reverb);
    
    "Body Size" => body_size.name;
    body_size.range (0, 1);
    body_size.value (0.3);
    body_size.size (200, 75);
    body_size.position (350, 0);
    string_view.addElement (body_size);
    
    "Pluck Pos" => pluck_pos.name;
    pluck_pos.range (0, 1);
    pluck_pos.value (0.3);
    pluck_pos.size (200, 75);
    pluck_pos.position (550, 0);
    string_view.addElement (pluck_pos);
    
    "String Damping" => string_damping.name;
    string_damping.range (0, 1);
    string_damping.value (0.3);
    string_damping.size (200, 75);
    string_damping.position (150, 50);
    string_view.addElement (string_damping);
    
    "String Detune" => string_detune.name;
    string_detune.range (0, 1);
    string_detune.value (0.3);
    string_detune.size (200, 75);
    string_detune.position (350, 50);
    string_view.addElement (string_detune);
    
    "After Touch" => after_touch.name;
    after_touch.range (0, 1);
    after_touch.value (0.3);
    after_touch.size (200, 75);
    after_touch.position (550, 50);
    string_view.addElement (after_touch);
    
    "Echo Delay" => guitar_echo_delay.name;
    guitar_echo_delay.range (0, 1);
    guitar_echo_delay.value (0.2);
    guitar_echo_delay.size (200, 75);
    guitar_echo_delay.position (150, 100);
    string_view.addElement (guitar_echo_delay);
    
    "Echo Max" => guitar_echo_max.name;
    guitar_echo_max.range (0, 10);
    guitar_echo_max.value (5);
    guitar_echo_max.size (200, 75);
    guitar_echo_max.position (350, 100);
    string_view.addElement (guitar_echo_max);
    
    "Echo Mix" => guitar_echo_mix.name;
    guitar_echo_mix.range (0, 1);
    guitar_echo_mix.value (0.3);
    guitar_echo_mix.size (200, 75);
    guitar_echo_mix.position (550, 100);
    string_view.addElement (guitar_echo_mix);
    
    "Jet Delay" => jet_delay.name;
    jet_delay.range (0, 1);
    jet_delay.value (0.3);
    jet_delay.size (200, 75);
    jet_delay.position (150, 200);
    wind_view.addElement (jet_delay);
    
    "Jet Reflection" => jet_reflection.name;
    jet_reflection.range (0, 1);
    jet_reflection.value (0.9);
    jet_reflection.size (200, 75);
    jet_reflection.position (350, 200);
    wind_view.addElement (jet_reflection);
    
    "End Reflection" => end_reflection.name;
    end_reflection.range (0, 1);
    end_reflection.value (0.9);
    end_reflection.size (200, 75);
    end_reflection.position (550, 200);
    wind_view.addElement (end_reflection);
    
    "Noise Gain" => noise_gain.name;
    noise_gain.range (0, 1);
    noise_gain.value (0.5);
    noise_gain.size (200, 75);
    noise_gain.position (150, 250);
    wind_view.addElement (noise_gain);
    
    "Vibrato Freq" => vibrato_freq.name;
    vibrato_freq.range (0, 12);
    vibrato_freq.value (5);
    vibrato_freq.size (200, 75);
    vibrato_freq.position (350, 250);
    wind_view.addElement (vibrato_freq);
    
    "Vibrato Gain" => vibrato_gain.name;
    vibrato_gain.range (0, 1);
    vibrato_gain.value (0.5);
    vibrato_gain.size (200, 75);
    vibrato_gain.position (550, 250);
    wind_view.addElement (vibrato_gain);
    
    "Frequency" => snare_freq.name;
    snare_freq.range (0, 10000);
    snare_freq.value (3000);
    snare_freq.size (200, 75);
    snare_freq.position (150, 0);
    percussion_view.addElement (snare_freq);
    
    "Q" => snare_Q.name;
    snare_Q.range (0, 100);
    snare_Q.value (10);
    snare_Q.size (200, 75);
    snare_Q.position (350, 0);
    percussion_view.addElement (snare_Q);
    
    "Decay" => snare_decay.name;
    snare_decay.range (0, 10000);
    snare_decay.value (5000);
    snare_decay.size (200, 75);
    snare_decay.position (550, 0);
    percussion_view.addElement (snare_decay);
    
    "Attack" => snare_attack.name;
    snare_attack.range (0, 10000);
    snare_attack.value (2000);
    snare_attack.size (200, 75);
    snare_attack.position (150, 50);
    percussion_view.addElement (snare_attack);
    
    "Frequency" => drum_freq.name;
    drum_freq.range (0, 1000);
    drum_freq.value (150);
    drum_freq.size (200, 75);
    drum_freq.position (150, 100);
    percussion_view.addElement (drum_freq);
    
    "Pitch Decay" => drum_pitch_decay.name;
    drum_pitch_decay.range (0.99, 0.9999);
    drum_pitch_decay.value (0.9995);
    drum_pitch_decay.size (200, 75);
    drum_pitch_decay.position (350, 100);
    percussion_view.addElement (drum_pitch_decay);
    
    "Pitch Attack" => drum_pitch_attack.name;
    drum_pitch_attack.range (0, 1000);
    drum_pitch_attack.value (150);
    drum_pitch_attack.size (200, 75);
    drum_pitch_attack.position (550, 100);
    percussion_view.addElement (drum_pitch_attack);
    
    "Decay" => drum_decay.name;
    drum_decay.range (0.99, 0.9999);
    drum_decay.value (0.9997);
    drum_decay.size (200, 75);
    drum_decay.position (150, 150);
    percussion_view.addElement (drum_decay);
    
    "Attack" => drum_attack.name;
    drum_attack.range (0, 1000);
    drum_attack.value (150);
    drum_attack.size (200, 75);
    drum_attack.position (350, 150);
    percussion_view.addElement (drum_attack);
    
    "Drive Gain" => drum_drive_gain.name;
    drum_drive_gain.range (0, 1);
    drum_drive_gain.value (0.1);
    drum_drive_gain.size (200, 75);
    drum_drive_gain.position (550, 150);
    percussion_view.addElement (drum_drive_gain);
    
    "Filter" => drum_filter.name;
    drum_filter.range (0, 1000);
    drum_filter.value (250);
    drum_filter.size (200, 75);
    drum_filter.position (150, 200);
    percussion_view.addElement (drum_filter);
    
    "Body Size" => mandolin_body_size.name;
    mandolin_body_size.range (0, 1);
    mandolin_body_size.value (0.3);
    mandolin_body_size.size (200, 75);
    mandolin_body_size.position (150, 200);
    string_view.addElement (mandolin_body_size);
    
    "Pluck Pos" => mandolin_pluck_pos.name;
    mandolin_pluck_pos.range (0, 1);
    mandolin_pluck_pos.value (0.3);
    mandolin_pluck_pos.size (200, 75);
    mandolin_pluck_pos.position (350, 200);
    string_view.addElement (mandolin_pluck_pos);
    
    "String Damping" => mandolin_string_damping.name;
    mandolin_string_damping.range (0, 1);
    mandolin_string_damping.value (0.3);
    mandolin_string_damping.size (200, 75);
    mandolin_string_damping.position (150, 250);
    string_view.addElement (mandolin_string_damping);
    
    "String Detune" => mandolin_string_detune.name;
    mandolin_string_detune.range (0, 1);
    mandolin_string_detune.value (0.3);
    mandolin_string_detune.size (200, 75);
    mandolin_string_detune.position (350, 250);
    string_view.addElement (mandolin_string_detune);
    
    "After Touch" => mandolin_after_touch.name;
    mandolin_after_touch.range (0, 1);
    mandolin_after_touch.value (0.3);
    mandolin_after_touch.size (200, 75);
    mandolin_after_touch.position (550, 200);
    string_view.addElement (mandolin_after_touch);
    
    "Gain 1" => mandolin_gain1.name;
    mandolin_gain1.range (0, 3);
    mandolin_gain1.value (1);
    mandolin_gain1.size (200, 75);
    mandolin_gain1.position (150, 300);
    string_view.addElement (mandolin_gain1);
    
    "Gain 2" => mandolin_gain2.name;
    mandolin_gain2.range (0, 3);
    mandolin_gain2.value (1);
    mandolin_gain2.size (200, 75);
    mandolin_gain2.position (350, 300);
    string_view.addElement (mandolin_gain2);
    
    "Stiffness" => saxophone_stiffness.name;
    saxophone_stiffness.range (0, 1);
    saxophone_stiffness.value (0.0);
    saxophone_stiffness.size (200, 75);
    saxophone_stiffness.position (150, 0);
    wind_view.addElement (saxophone_stiffness);
    
    "Aperture" => saxophone_aperture.name;
    saxophone_aperture.range (0, 1);
    saxophone_aperture.value (0);
    saxophone_aperture.size (200, 75);
    saxophone_aperture.position (350, 0);
    wind_view.addElement (saxophone_aperture);
    
    "Pressure" => saxophone_pressure.name;
    saxophone_pressure.range (0, 1);
    saxophone_pressure.value (0.8);
    saxophone_pressure.size (200, 75);
    saxophone_pressure.position (550, 0);
    wind_view.addElement (saxophone_pressure);
    
    "Noise Gain" => saxophone_noise_gain.name;
    saxophone_noise_gain.range (0, 1);
    saxophone_noise_gain.value (0.5);
    saxophone_noise_gain.size (200, 75);
    saxophone_noise_gain.position (150, 50);
    wind_view.addElement (saxophone_noise_gain);
    
    "Vibrato Freq" => saxophone_vibrato_freq.name;
    saxophone_vibrato_freq.range (0, 12);
    saxophone_vibrato_freq.value (5);
    saxophone_vibrato_freq.size (200, 75);
    saxophone_vibrato_freq.position (350, 50);
    wind_view.addElement (saxophone_vibrato_freq);
    
    "Vibrato Gain" => saxophone_vibrato_gain.name;
    saxophone_vibrato_gain.range (0, 1);
    saxophone_vibrato_gain.value (0.5);
    saxophone_vibrato_gain.size (200, 75);
    saxophone_vibrato_gain.position (550, 50);
    wind_view.addElement (saxophone_vibrato_gain);
    
    "Blow Position" => saxophone_blow_position.name;
    saxophone_blow_position.range (0, 1);
    saxophone_blow_position.value (0.3);
    saxophone_blow_position.size (200, 75);
    saxophone_blow_position.position (150, 100);
    wind_view.addElement (saxophone_blow_position);
    
    "Rate" => saxophone_rate.name;
    saxophone_rate.range (0, 10);
    saxophone_rate.value (5);
    saxophone_rate.size (200, 75);
    saxophone_rate.position (350, 100);
    wind_view.addElement (saxophone_rate);
    
    "Reverb" => saxophone_reverb.name;
    saxophone_reverb.range (0, 1);
    saxophone_reverb.value (0.3);
    saxophone_reverb.size (200, 75);
    saxophone_reverb.position (550, 100);
    wind_view.addElement (saxophone_reverb);
    
    "Probability" => thunder_probability.name;
    thunder_probability.range (0, 1);
    thunder_probability.value (0.3);
    thunder_probability.size (200, 75);
    thunder_probability.position (150, 250);
    percussion_view.addElement (thunder_probability);
    
    "Chorus Mod Freq" => mic_chorus_mod_freq.name;
    mic_chorus_mod_freq.range (0, 1000);
    mic_chorus_mod_freq.value (100);
    mic_chorus_mod_freq.size (200, 75);
    mic_chorus_mod_freq.position (150, 350);
    wind_view.addElement (mic_chorus_mod_freq);
    
    "Chorus Mod Depth" => mic_chorus_mod_depth.name;
    mic_chorus_mod_depth.range (0, 1);
    mic_chorus_mod_depth.value (0.5);
    mic_chorus_mod_depth.size (200, 75);
    mic_chorus_mod_depth.position (350, 350);
    wind_view.addElement (mic_chorus_mod_depth);
    
    "Chorus Mix" => mic_chorus_mix.name;
    mic_chorus_mix.range (0, 1);
    mic_chorus_mix.value (0);
    mic_chorus_mix.size (200, 75);
    mic_chorus_mix.position (550, 350);
    wind_view.addElement (mic_chorus_mix);
    
    "Reverb" => mic_nrev_mix.name;
    mic_nrev_mix.range (0, 1);
    mic_nrev_mix.value (0.2);
    mic_nrev_mix.size (200, 75);
    mic_nrev_mix.position (150, 400);
    wind_view.addElement (mic_nrev_mix);
    
    "Preset" => shakers_preset.name;
    shakers_preset.range (2, 22);
    shakers_preset.value (4);
    shakers_preset.size (200, 75);
    shakers_preset.position (150, 450);
    shakers_preset.displayFormat (shakers_preset.integerFormat);
    percussion_view.addElement (shakers_preset);
    
    "Objects" => shakers_objects.name;
    shakers_objects.range (0, 127);
    shakers_objects.value (10);
    shakers_objects.size (200, 75);
    shakers_objects.position (350, 450);
    shakers_objects.displayFormat (shakers_objects.integerFormat);
    percussion_view.addElement (shakers_objects);
    
    "Decay" => shakers_decay.name;
    shakers_decay.range (0, 1);
    shakers_decay.value (0.5);
    shakers_decay.size (200, 75);
    shakers_decay.position (550, 450);
    percussion_view.addElement (shakers_decay);
    
    "Energy" => shakers_energy.name;
    shakers_energy.range (0, 1);
    shakers_energy.value (0.5);
    shakers_energy.size (200, 75);
    shakers_energy.position (150, 500);
    percussion_view.addElement (shakers_energy);
    
    "Pickup Pos" => stifkarp_pickupPosition.name;
    stifkarp_pickupPosition.range (0, 1);
    stifkarp_pickupPosition.value (0.2);
    stifkarp_pickupPosition.size (200, 75);
    stifkarp_pickupPosition.position (150, 400);
    string_view.addElement (stifkarp_pickupPosition);
    
    "Sustain" => stifkarp_sustain.name;
    stifkarp_sustain.range (0, 1);
    stifkarp_sustain.value (0.5);
    stifkarp_sustain.size (200, 75);
    stifkarp_sustain.position (350, 400);
    string_view.addElement (stifkarp_sustain);
    
    "Stretch" => stifkarp_stretch.name;
    stifkarp_stretch.range (0, 1);
    stifkarp_stretch.value (0.5);
    stifkarp_stretch.size (200, 75);
    stifkarp_stretch.position (550, 400);
    string_view.addElement (stifkarp_stretch);
    
    "Base Loop Gain" => stifkarp_baseLoopGain.name;
    stifkarp_baseLoopGain.range (0, 1);
    stifkarp_baseLoopGain.value (1);
    stifkarp_baseLoopGain.size (200, 75);
    stifkarp_baseLoopGain.position (150, 450);
    string_view.addElement (stifkarp_baseLoopGain);
    
    "Frequency" => wahwah_freq.name;
    wahwah_freq.range (0, 60);
    wahwah_freq.value (10);
    wahwah_freq.size (200, 75);
    wahwah_freq.position (350, 0);
    wahwah_freq.displayFormat (wahwah_freq.integerFormat);
    scales_view.addElement (wahwah_freq);
    
    "Mix" => jcreverb_mix.name;
    jcreverb_mix.range (0, 1);
    jcreverb_mix.value (0.2);
    jcreverb_mix.size (200, 75);
    jcreverb_mix.position (350, 100);
    scales_view.addElement (jcreverb_mix);
    
    "Gain" => guitar_gain.name;
    guitar_gain.range (0, 1);
    guitar_gain.value (0.5);
    guitar_gain.size (150, 75);
    guitar_gain.position (0, 35);
    string_view.addElement (guitar_gain);
    
    "Gain" => flute_gain.name;
    flute_gain.range (0, 1);
    flute_gain.value (0.5);
    flute_gain.size (150, 75);
    flute_gain.position (0, 235);
    wind_view.addElement (flute_gain);
    
    "Gain" => snare_gain.name;
    snare_gain.range (0, 1);
    snare_gain.value (0.5);
    snare_gain.size (150, 75);
    snare_gain.position (0, 35);
    percussion_view.addElement (snare_gain);
    
    "Gain" => drum_gain.name;
    drum_gain.range (0, 5);
    drum_gain.value (2.5);
    drum_gain.size (150, 75);
    drum_gain.position (0, 135);
    percussion_view.addElement (drum_gain);
    
    "Gain" => mandolin_gain.name;
    mandolin_gain.range (0, 1);
    mandolin_gain.value (0.5);
    mandolin_gain.size (150, 75);
    mandolin_gain.position (0, 235);
    string_view.addElement (mandolin_gain);
    
    "Gain" => saxophone_gain.name;
    saxophone_gain.range (0, 1);
    saxophone_gain.value (0.5);
    saxophone_gain.size (150, 75);
    saxophone_gain.position (0, 35);
    wind_view.addElement (saxophone_gain);
    
    "Gain" => thunder_gain.name;
    thunder_gain.range (0, 5);
    thunder_gain.value (2.5);
    thunder_gain.size (150, 75);
    thunder_gain.position (0, 285);
    percussion_view.addElement (thunder_gain);
    
    "Gain" => delaysnare_gain.name;
    delaysnare_gain.range (0, 1);
    delaysnare_gain.value (0.5);
    delaysnare_gain.size (150, 75);
    delaysnare_gain.position (0, 385);
    percussion_view.addElement (delaysnare_gain);
    
    "Gain" => microphone_gain.name;
    microphone_gain.range (0, 5);
    microphone_gain.value (2.5);
    microphone_gain.size (150, 75);
    microphone_gain.position (0, 385);
    wind_view.addElement (microphone_gain);
    
    "Gain" => shakers_gain.name;
    shakers_gain.range (0, 1);
    shakers_gain.value (0.5);
    shakers_gain.size (150, 75);
    shakers_gain.position (0, 485);
    percussion_view.addElement (shakers_gain);
    
    "Gain" => stifkarp_gain.name;
    stifkarp_gain.range (0, 1);
    stifkarp_gain.value (0.5);
    stifkarp_gain.size (150, 75);
    stifkarp_gain.position (0, 435);
    string_view.addElement (stifkarp_gain);
    
    "Gain" => ocean1_gain.name;
    ocean1_gain.range (0, 1);
    ocean1_gain.value (0.2);
    ocean1_gain.size (150, 75);
    ocean1_gain.position (200, 235);
    scales_view.addElement (ocean1_gain);
    
    "Gain" => rain1_gain.name;
    rain1_gain.range (0, 1);
    rain1_gain.value (1);
    rain1_gain.size (150, 75);
    rain1_gain.position (200, 335);
    scales_view.addElement (rain1_gain);
    
    "Gain" => rain2_gain.name;
    rain2_gain.range (0, 1);
    rain2_gain.value (0.1);
    rain2_gain.size (150, 75);
    rain2_gain.position (350, 335);
    scales_view.addElement (rain2_gain);
    
    Guitar.toggleType ();
    Guitar.size (120, 60);
    Guitar.position (0, 0);
    Guitar.name ("Guitar");
    Guitar.state (1);
    string_view.addElement (Guitar);
    
    Flute.toggleType ();
    Flute.size (120, 60);
    Flute.position (0, 200);
    Flute.name ("Flute");
    wind_view.addElement (Flute);
    
    Snare.toggleType ();
    Snare.size (120, 60);
    Snare.position (0, 0);
    Snare.name ("Snare");
    percussion_view.addElement (Snare);
    
    Drum.toggleType ();
    Drum.size (120, 60);
    Drum.position (0, 100);
    Drum.name ("Drum");
    percussion_view.addElement (Drum);
    
    Mandolin.toggleType ();
    Mandolin.size (120, 60);
    Mandolin.position (0, 200);
    Mandolin.name ("Mandolin");
    string_view.addElement (Mandolin);
    
    Saxophone.toggleType ();
    Saxophone.size (120, 60);
    Saxophone.position (0, 0);
    Saxophone.name ("Saxophone");
    wind_view.addElement (Saxophone);
    
    Thunder.toggleType ();
    Thunder.size (120, 60);
    Thunder.position (0, 250);
    Thunder.name ("Thunder");
    percussion_view.addElement (Thunder);
    
    DelaySnare.toggleType ();
    DelaySnare.size (120, 60);
    DelaySnare.position (0, 350);
    DelaySnare.name ("Delay Snare");
    percussion_view.addElement (DelaySnare);
    
    Microphone.toggleType ();
    Microphone.size (120, 60);
    Microphone.position (0, 350);
    Microphone.name ("Microphone");
    wind_view.addElement (Microphone);
    
    Shakers.toggleType ();
    Shakers.size (120, 60);
    Shakers.position (0, 450);
    Shakers.name ("Shakers");
    percussion_view.addElement (Shakers);
    
    StifKarp.toggleType ();
    StifKarp.size (120, 60);
    StifKarp.position (0, 400);
    StifKarp.name ("StifKarp");
    string_view.addElement (StifKarp);
    
    WahWah.toggleType ();
    WahWah.size (120, 60);
    WahWah.position (200, 0);
    WahWah.name ("Wah Wah");
    scales_view.addElement (WahWah);
    
    JCReverb.toggleType ();
    JCReverb.size (120, 60);
    JCReverb.position (200, 100);
    JCReverb.name ("JCReverb");
    scales_view.addElement (JCReverb);
    
    Ocean1.toggleType ();
    Ocean1.size (120, 60);
    Ocean1.position (200, 200);
    Ocean1.name ("Ocean 1");
    scales_view.addElement (Ocean1);
    
    Rain1.toggleType ();
    Rain1.size (120, 60);
    Rain1.position (200, 300);
    Rain1.name ("Rain 1");
    scales_view.addElement (Rain1);
    
    Rain2.toggleType ();
    Rain2.size (120, 60);
    Rain2.position (350, 300);
    Rain2.name ("Rain 2");
    scales_view.addElement (Rain2);
    
    M1_Dyno_limit.toggleType ();
    M1_Dyno_limit.size (120, 60);
    M1_Dyno_limit.position (550, 280);
    M1_Dyno_limit.name ("Limiter");
    string_view.addElement (M1_Dyno_limit);
    
    M1_Dyno_compress.toggleType ();
    M1_Dyno_compress.size (120, 60);
    M1_Dyno_compress.position (650, 280);
    M1_Dyno_compress.name ("Compressor");
    string_view.addElement (M1_Dyno_compress);
    
    M1_Dyno_expand.toggleType ();
    M1_Dyno_expand.size (120, 60);
    M1_Dyno_expand.position (550, 310);
    M1_Dyno_expand.name ("Expander");
    string_view.addElement (M1_Dyno_expand);
    
    M1_Dyno_gate.toggleType ();
    M1_Dyno_gate.size (120, 60);
    M1_Dyno_gate.position (650, 310);
    M1_Dyno_gate.name ("Noise Gate");
    string_view.addElement (M1_Dyno_gate);
    
    
    for (0 => int j; j < num_scales; j++) {
        scales[j].pushType ();
        scales[j].size (150, 60);
        scales[j].position (0, 50*j);
        if (j == 0) {
            scales[j].name ("lydian");
        }
        if (j == 1) {
            scales[j].name ("ionian");
        }
        if (j == 2) {
            scales[j].name ("mixolydian");
        }
        if (j == 3) {
            scales[j].name ("dorian");
        }
        if (j == 4) {
            scales[j].name ("aeolian");
        }
        if (j == 5) {
            scales[j].name ("phrygian");
        }
        if (j == 6) {
            scales[j].name ("locrian");
        }
        if (j == 7) {
            scales[j].name ("harmonic minor");
        }
        if (j == 8) {
            scales[j].name ("melodic minor");
        }
        scales_view.addElement (scales[j]);
    }
    
    author.pushType ();
    author.size (500, 60);
    author.position (0, 535);
    author.name ("copyright 2008 Les Hall, Kijjasak Triyanond, and Pyry Pakkanen");
    control_view.addElement (author);
    
    
    
    scales_view.display ();
    wind_view.display ();
    percussion_view.display ();
    string_view.display ();
    control_view.display ();
    
    
    
    kjzGuitar101 A;  // lead guitar
    A.output => Echo guitar_echo => LPF wahwah => JCRev jcrev => Gain master => Gain out => Gain volume => WvOut wave_out => blackhole;
    out => blackhole;
    //0 => master.op;
    
    
    // flute instrument
    Flute B;
    
    kjzSnare101 C;
    
    kjzBD101 D;
    
    // will make an arcade noise when author button is pressed
    kjzBD101 arcade_shot;
    arcade_shot.setFreq (300);
    arcade_shot.setPitchDecay (0.9999);
    arcade_shot.setPitchAttack (300);
    arcade_shot.setDecay (0.9999);
    arcade_shot.setAttack (300);
    arcade_shot.setDriveGain (1.0);
    arcade_shot.setFilter (1000);
    
    // mandolin instrument
    Mandolin E;
    Gain M1_gain => LPF M1_lpf => Dyno M1_Dyno => Gain M2_gain => Dyno M2_Dyno => master;
    M2_gain => FullRect rect => Gain M3_gain => LPF M2_lpf => blackhole;  // wah-wah feedback
    M3_gain.gain (0.95);
    M2_Dyno.limit ();
    M2_lpf.set (5, 2);
    
    fun void AutoWah () {
        while (ms => now) {
            M2_lpf.last() * 1000 + 100 => M1_lpf.freq;
        }
    }
    spork ~ AutoWah ();
    
    // saxophone instrument
    Saxofony F;
    JCRev F_rev => master;  // will chuck to F_rev later
    
    
    
    kjz_thunder G;
    LPF G_lpf => Dyno G1_limit => master;  // will ChucK G.go up to this later
    G_lpf.freq (2000);
    G_lpf.gain (2);
    G1_limit.limit ();
    
    
    
    
    DelaylineSnare01 H;
    
    
    // the microphone input
    adc => Chorus mic_chorus => NRev mic_nrev => Gain microphone;
    
    
    // the Shakers for water drops among other sounds
    Shakers I;
    
    
    // the StifKarp for a fun guitar sound
    StifKarp J;
    
    
    
    ocean1 K;
    
    // here comes the rain!
    Les_Rain1 L;
    
    
    // here comes more rain!
    Les_Rain2 M;
    
    
    Modedular Mod;
    
    
    
    
    // spork the matrix button shreds
    fun void spork_shred_matrix () {
        // spork the and button shreds
        for (0 => int a; a < num_and_terms; a++) {
            for (0 => int b; b < num_digits; b++) {
                spork ~ and_buttons_adj (a, b);
            }
        }
        // spork shreds for bottom row plus and minus buttons
        for (0 => int b; b < num_digits; b++) {
            spork ~ plus_buttons_adj (b);
            spork ~ minus_buttons_adj (b);
        }
        // spork shreds for right side plus and minus buttons
        for (0 => int a; a < num_and_terms; a++) {
            spork ~ note_plus_buttons_adj (a);
            spork ~ note_minus_buttons_adj (a);
        }
    }
    
    // remove the matrix button shreds
    fun void remove_shred_matrix () {
        // remove the and button shreds
        for (0 => int a; a < num_and_terms; a++) {
            for (0 => int b; b < num_digits; b++) {
                Machine.remove (shred_id_and_buttons[a][b]);
            }
        }
        // remove shreds for bottom row plus and minus buttons
        for (0 => int b; b < num_digits; b++) {
            Machine.remove (shred_id_plus_buttons[b]);
            Machine.remove (shred_id_minus_buttons[b]);
        }
        // remove shreds for right side plus and minus buttons
        for (0 => int a; a < num_and_terms; a++) {
            Machine.remove (shred_id_note_plus_buttons[a]);
            Machine.remove (shred_id_note_minus_buttons[a]);
        }
    }
    
    fun void start () {
        while (true) {
            // wait for the start button to be pushed
            start_button.onChange () => now;
            if (start_button.state ()) {
                //1 => master.op;
                start_button.name ("Stop");
                remove_shred_matrix ();
                remove_shred_scales ();
            } else {
                //0 => master.op;
                start_button.name ("Play");
                if (record_button.state ()) {
                    record_button.state (0);
                    wave_out.closeFile ();
                }
                spork_shred_matrix ();
                spork_shred_scales ();
                initialize_instruments ();
            }
        }
    }
    
    fun void record () {
        while (true) {
            // wait for the start button to be pushed
            record_button.onChange () => now;
            if (record_button.state ()) {
                //1 => master.op;
                start_button.state (1);
                start_button.name ("Stop");
                "Guitar_Lab.wav" => wave_out.wavFilename;
                remove_shred_matrix ();
                remove_shred_scales ();
            } else {
                //0 => master.op;
                start_button.state (0);
                start_button.name ("Play");
                wave_out.closeFile ();
                spork_shred_matrix ();
                spork_shred_scales ();
                initialize_instruments ();
            }
        }
    }
    
    fun void clear () {
        while (true) {
            // wait for the start button to be pushed
            clear_button.onChange () => now;
            for (0 => int b; b < num_digits; b++) {
                0 => j[b];
                count[b].unlight ();
            }
        }
    }
    
    fun void or_xor () {
        while (true) {
            xor_button.onChange () => now;
            if (xor_button.state ()) {
                xor_button.name ("XOR");
            } else {
                xor_button.name ("OR");
            }
        }
    }
    
    fun void freq_offset_values_adj () {
        while (true) {
            freq_offset.onChange () => now;
            freq_offset.value () => freq_offset_values[instrument];
        }
    }
    
    fun void instrument_plus () {
        while (true) {
            instrument_plus_button.onChange () => now;
            if (!instrument_plus_button.state ()) {
                (instrument + 1) % num_instruments => instrument;
                change_current_instrument ();
            }
        }
    }
    
    fun void instrument_minus () {
        while (true) {
            instrument_minus_button.onChange () => now;
            if (!instrument_minus_button.state ()) {
                if (instrument == 0) {
                    num_instruments => instrument;
                }
                instrument - 1 => instrument;
                change_current_instrument ();
            }
        }
    }
    
    fun void and_plus () {
        while (true) {
            and_plus_button.onChange () => now;
            if (and_plus_button.state ()) {
                (and_page + 1) % num_and_pages => and_page;
                change_current_instrument ();
                and_page_button.name ("page "+and_page);
            }
        }
    }
    
    fun void and_minus () {
        while (true) {
            and_minus_button.onChange () => now;
            if (and_minus_button.state ()) {
                if (and_page == 0) {
                    num_and_pages => and_page;
                }
                (and_page - 1) % num_and_pages => and_page;
                change_current_instrument ();
                and_page_button.name ("page "+and_page);
            }
        }
    }
    
    fun void change_current_instrument () {
        if (instrument == 0) {
            instrument_button.name ("Guitar");
        }
        if (instrument == 1) {
            instrument_button.name ("Flute");
        }
        if (instrument == 2) {
            instrument_button.name ("Snare");
        }
        if (instrument == 3) {
            instrument_button.name ("Drum");
        }
        if (instrument == 4) {
            instrument_button.name ("Mandolin");
        }
        if (instrument == 5) {
            instrument_button.name ("Saxophone");
        }
        if (instrument == 6) {
            instrument_button.name ("Thunder");
        }
        if (instrument == 7) {
            instrument_button.name ("Delay Snare");
        }
        if (instrument == 8) {
            instrument_button.name ("Microphone");
        }
        if (instrument == 9) {
            instrument_button.name ("Shakers");
        }
        if (instrument == 10) {
            instrument_button.name ("StifKarp");
        }
        for (0 => int a; a < num_and_terms; a++) {
            for (0 => int b; b < num_digits; b++) {
                if (and_values[instrument][and_page*num_and_terms+a][b] == 0) {
                    and_buttons[a][b].name ("");
                }
                if (and_values[instrument][and_page*num_and_terms+a][b] == 1) {
                    and_buttons[a][b].name ("1");
                }
                if (and_values[instrument][and_page*num_and_terms+a][b] == 2) {
                    and_buttons[a][b].name ("0");
                }
                if (and_values[instrument][and_page*num_and_terms+a][b] == 3) {
                    and_buttons[a][b].name ("?");
                }
                if (and_values[instrument][and_page*num_and_terms+a][b] > 3) {
                    0 => and_values[instrument][a][b];
                    and_buttons[a][b].name ("");
                }
            }
        }
        for (0 => int b; b < num_digits; b++) {
            freq_buttons[b].name ("" + freq_amount[instrument][b]);
        }
        for (0 => int b; b < num_and_terms; b++) {
            note_buttons[b].name ("" + note[instrument][and_page][b]);
        }
        freq_offset.value (freq_offset_values[instrument]);
    }
    
    fun void and_buttons_adj (int a, int b) {
        me.id () => shred_id_and_buttons[a][b];
        while (true) {
            and_buttons[a][b].onChange () => now;
            1 +=> and_values[instrument][and_page*num_and_terms+a][b];
            if (and_values[instrument][and_page*num_and_terms+a][b] == 0) {
                and_buttons[a][b].name ("");
            }
            if (and_values[instrument][and_page*num_and_terms+a][b] == 1) {
                and_buttons[a][b].name ("1");
            }
            if (and_values[instrument][and_page*num_and_terms+a][b] == 2) {
                and_buttons[a][b].name ("0");
            }
            if (and_values[instrument][and_page*num_and_terms+a][b] == 3) {
                and_buttons[a][b].name ("?");
            }
            if (and_values[instrument][and_page*num_and_terms+a][b] > 3) {
                0 => and_values[instrument][and_page*num_and_terms+a][b];
                and_buttons[a][b].name ("");
            }
            and_buttons[a][b].onChange () => now;
        }
    }
    
    fun void plus_buttons_adj (int b) {
        me.id () => shred_id_plus_buttons[b];
        while (true) {
            plus_buttons[b].onChange () => now;
            if (plus_buttons[b].state ()) {
                1 +=> freq_amount[instrument][b];
                freq_buttons[b].name ("" + freq_amount[instrument][b]);
            }
        }
    }
    
    fun void minus_buttons_adj (int b) {
        me.id () => shred_id_minus_buttons[b];
        while (true) {
            minus_buttons[b].onChange () => now;
            if (minus_buttons[b].state ()) {
                1 -=> freq_amount[instrument][b];
                freq_buttons[b].name ("" + freq_amount[instrument][b]);
            }
        }
    }
    
    fun void note_plus_buttons_adj (int a) {
        me.id () => shred_id_note_plus_buttons[a];
        while (true) {
            note_plus_buttons[a].onChange () => now;
            if (note_plus_buttons[a].state ()) {
                1 +=> note[instrument][and_page][a];
                note_buttons[a].name ("" + note[instrument][and_page][a]);
            }
        }
    }
    
    fun void note_minus_buttons_adj (int a) {
        me.id () => shred_id_note_minus_buttons[a];
        while (true) {
            note_minus_buttons[a].onChange () => now;
            if (note_minus_buttons[a].state ()) {
                1 -=> note[instrument][and_page][a];
                note_buttons[a].name (""+note[instrument][and_page][a]);
            }
        }
    }
    
    fun void volume_adj () {
        while (true) {
            master_volume.onChange () => now;
            master_volume.value () => volume.gain;
        }
    }
    
    fun void author_adj () {
        while (true) {
            author.onChange () => now;
            if (author.state ()) {
                arcade_shot.output => master;
                arcade_shot.hit (1.0);
            } else {
                arcade_shot.output =< master;
            }
        }
    }
    
    fun void initialize_volume () {
        master_volume.value () => volume.gain;
    }
    
    fun void initialize_base () {
        base.value () $ int => n;
    }
    
    
    
    
    
    // spork insturment button shreds
    fun void spork_shred_instruments () {
        spork ~ guitar_adj ();
        spork ~ flute_adj ();
        spork ~ snare_adj ();
        spork ~ drum_adj ();
        spork ~ mandolin_adj ();
        spork ~ saxophone_adj ();
        spork ~ thunder_adj ();
        spork ~ delaysnare_adj ();
        spork ~ microphone_adj ();
        spork ~ shakers_adj ();
        spork ~ stifkarp_adj ();
        spork ~ ocean1_adj ();
        spork ~ rain1_adj ();
        spork ~ rain2_adj ();
    }
    
    
    
    
    
    // guitar functions
    // spork guitar shreds
    fun void spork_shred_guitar () {
        spork ~ guitar_gain_adj ();
        spork ~ reverb_adj ();
        spork ~ body_size_adj ();
        spork ~ pluck_pos_adj ();
        spork ~ string_damping_adj ();
        spork ~ string_detune_adj ();
        spork ~ after_touch_adj ();
        spork ~ guitar_echo_delay_adj ();
        spork ~ guitar_echo_max_adj ();
        spork ~ guitar_echo_mix_adj ();
    }
    // remove guitar shreds
    fun void remove_shred_guitar () {
        for (0 => int i; i < num_guitar_shreds; i++) {
            Machine.remove (shred_id_guitar[i]);
        }
    }
    // adjust guitar button
    fun void guitar_adj () {
        while (true) {
            Guitar.onChange () => now;
            if (Guitar.state ()) {
                A.output => guitar_echo;
                initialize_guitar ();
                spork_shred_guitar ();
            } else {
                A.output =< guitar_echo;
                remove_shred_guitar ();
            }
        }
    }
    // adjust guitar gain
    fun void guitar_gain_adj () {
        me.id () => shred_id_guitar[0];
        while (true) {
            guitar_gain.onChange () => now;
            A.output.gain (guitar_gain.value ());
        }
    }
    // adjust guitar reverb
    fun void reverb_adj () {
        me.id () => shred_id_guitar[1];
        while (true) {
            reverb.onChange () => now;
            reverb.value () => A.rev.mix;
        }
    }
    // adjust guitar body size
    fun void body_size_adj () {
        me.id () => shred_id_guitar[2];
        while (true) {
            body_size.onChange () => now;
            for(int i; i < 3; i++) {
                body_size.value () => A.str[i].bodySize;
            }
        }
    }
    // adjust guitar pluck position
    fun void pluck_pos_adj () {
        me.id () => shred_id_guitar[3];
        while (true) {
            pluck_pos.onChange () => now;
            for(int i; i < 3; i++) {
                pluck_pos.value () => A.str[i].pluckPos;
            }
        }
    }
    // adjust guitar string damping
    fun void string_damping_adj () {
        me.id () => shred_id_guitar[4];
        while (true) {
            string_damping.onChange () => now;
            for(int i; i < 3; i++) {
                string_damping.value () => A.str[i].stringDamping;
            }
        }
    }
    // adjust guitar string detune
    fun void string_detune_adj () {
        me.id () => shred_id_guitar[5];
        while (true) {
            string_detune.onChange () => now;
            for(int i; i < 3; i++) {
                string_detune.value () => A.str[i].stringDetune;
            }
        }
    }
    // adjust guitar after touch
    fun void after_touch_adj () {
        me.id () => shred_id_guitar[6];
        while (true) {
            after_touch.onChange () => now;
            for(int i; i < 3; i++) {
                after_touch.value () => A.str[i].afterTouch;
            }
        }
    }
    // adjust guitar echo delay
    fun void guitar_echo_delay_adj () {
        me.id () => shred_id_guitar[7];
        while (true) {
            guitar_echo_delay.onChange () => now;
            (guitar_echo_delay.value ())::second => guitar_echo.delay;
        }
    }
    // adjust guitar echo max
    fun void guitar_echo_max_adj () {
        me.id () => shred_id_guitar[8];
        while (true) {
            guitar_echo_max.onChange () => now;
            (guitar_echo_max.value ())::second => guitar_echo.max;
        }
    }
    // adjust guitar echo mix
    fun void guitar_echo_mix_adj () {
        me.id () => shred_id_guitar[9];
        while (true) {
            guitar_echo_mix.onChange () => now;
            guitar_echo_mix.value () => guitar_echo.mix;
        }
    }
    
    
    
    
    // flute functions
    // spork flute shreds
    fun void spork_shred_flute () {
        spork ~ flute_gain_adj ();
        spork ~ jet_delay_adj ();
        spork ~ jet_reflection_adj ();
        spork ~ end_reflection_adj ();
        spork ~ noise_gain_adj ();
        spork ~ vibrato_freq_adj ();
        spork ~ vibrato_gain_adj ();
    }
    // remove flute shreds
    fun void remove_shred_flute () {
        for (0 => int i; i < num_flute_shreds; i++) {
            Machine.remove (shred_id_flute[i]);
        }
    }
    // adjust flute button
    fun void flute_adj () {
        while (true) {
            Flute.onChange () => now;
            if (Flute.state ()) {
                B => wahwah;
                initialize_flute ();
                spork_shred_flute ();
            } else {
                B =< wahwah;
                B.noteOn (0);
                remove_shred_flute ();
            }
        }
    }
    // adjust flute gain
    fun void flute_gain_adj () {
        me.id () => shred_id_flute[0];
        while (true) {
            flute_gain.onChange () => now;
            B.gain (flute_gain.value ());
        }
    }
    // adjust flute jet delay
    fun void jet_delay_adj () {
        me.id () => shred_id_flute[1];
        while (true) {
            jet_delay.onChange () => now;
            jet_delay.value () => B.jetDelay;
        }
    }
    // adjust flute jet reflection
    fun void jet_reflection_adj () {
        me.id () => shred_id_flute[2];
        while (true) {
            jet_reflection.onChange () => now;
            jet_reflection.value () => B.jetReflection;
        }
    }
    // adjust flute end reflection
    fun void end_reflection_adj () {
        me.id () => shred_id_flute[3];
        while (true) {
            end_reflection.onChange () => now;
            end_reflection.value () => B.endReflection;
        }
    }
    // adjust flute noise gain
    fun void noise_gain_adj () {
        me.id () => shred_id_flute[4];
        while (true) {
            noise_gain.onChange () => now;
            noise_gain.value () => B.noiseGain;
        }
    }
    // adjust flute vibrato frequency
    fun void vibrato_freq_adj () {
        me.id () => shred_id_flute[5];
        while (true) {
            vibrato_freq.onChange () => now;
            vibrato_freq.value () => B.vibratoFreq;
        }
    }
    // adjust flute vibrato gain
    fun void vibrato_gain_adj () {
        me.id () => shred_id_flute[6];
        while (true) {
            vibrato_gain.onChange () => now;
            vibrato_gain.value () => B.vibratoGain;
        }
    }
    
    
    
    // snare functions
    // spork snare shreds
    fun void spork_shred_snare () {
        spork ~ snare_gain_adj ();
        spork ~ snare_freq_adj ();
        spork ~ snare_Q_adj ();
        spork ~ snare_decay_adj ();
        spork ~ snare_attack_adj ();
    }
    // remove snare shreds
    fun void remove_shred_snare () {
        for (0 => int i; i < num_snare_shreds; i++) {
            Machine.remove (shred_id_snare[i]);
        }
    }
    // adjust snare button
    fun void snare_adj () {
        while (true) {
            Snare.onChange () => now;
            if (Snare.state ()) {
                C.output => master;
                initialize_snare ();
                spork_shred_snare ();
            } else {
                C.output =< master;
                remove_shred_snare ();
            }
        }
    }
    // adjust snare gain
    fun void snare_gain_adj () {
        me.id () => shred_id_snare[0];
        while (true) {
            snare_gain.onChange () => now;
            C.output.gain (snare_gain.value ());
        }
    }
    // adjust snare frequency
    fun void snare_freq_adj () {
        me.id () => shred_id_snare[1];
        while (true) {
            snare_freq.onChange () => now;
            C.setFilter (snare_freq.value (), snare_Q.value());
        }
    }
    // adjust snare Q
    fun void snare_Q_adj () {
        me.id () => shred_id_snare[2];
        while (true) {
            snare_Q.onChange () => now;
            C.setFilter (snare_freq.value (), snare_Q.value());
        }
    }
    // adjust snare decay
    fun void snare_decay_adj () {
        me.id () => shred_id_snare[3];
        while (true) {
            snare_decay.onChange () => now;
            C.setDecay (snare_decay.value ());
        }
    }
    // adjust snare attack
    fun void snare_attack_adj () {
        me.id () => shred_id_snare[4];
        while (true) {
            snare_attack.onChange () => now;
            C.setAttack (snare_attack.value ());
        }
    }
    
    
    
    
    // drum functions
    // spork drum shreds
    fun void spork_shred_drum () {
        spork ~ drum_gain_adj ();
        spork ~ drum_freq_adj ();
        spork ~ drum_pitch_decay_adj ();
        spork ~ drum_pitch_attack_adj ();
        spork ~ drum_decay_adj ();
        spork ~ drum_attack_adj ();
        spork ~ drum_drive_gain_adj ();
        spork ~ drum_filter_adj ();
    }
    // remove drum shreds
    fun void remove_shred_drum () {
        for (0 => int i; i < num_drum_shreds; i++) {
            Machine.remove (shred_id_drum[i]);
        }
    }
    // adjust drum button
    fun void drum_adj () {
        while (true) {
            Drum.onChange () => now;
            if (Drum.state ()) {
                D.output => master;
                initialize_drum ();
                spork_shred_drum ();
            } else {
                D.output =< master;
                remove_shred_drum ();
            }
        }
    }
    // adjust drum gain
    fun void drum_gain_adj () {
        me.id () => shred_id_drum[0];
        while (true) {
            drum_gain.onChange () => now;
            D.output.gain (drum_gain.value ());
        }
    }
    // adjust drum frequency
    fun void drum_freq_adj () {
        me.id () => shred_id_drum[1];
        while (true) {
            drum_freq.onChange () => now;
            D.setFreq (drum_freq.value ());
        }
    }
    // adjust drum pitch decay
    fun void drum_pitch_decay_adj () {
        me.id () => shred_id_drum[2];
        while (true) {
            drum_pitch_decay.onChange () => now;
            D.setPitchDecay (drum_pitch_decay.value ());
        }
    }
    // adjust drum pitch attack
    fun void drum_pitch_attack_adj () {
        me.id () => shred_id_drum[3];
        while (true) {
            drum_pitch_attack.onChange () => now;
            D.setPitchAttack (drum_pitch_attack.value ());
        }
    }
    // adjust drum decay
    fun void drum_decay_adj () {
        me.id () => shred_id_drum[4];
        while (true) {
            drum_decay.onChange () => now;
            D.setDecay (drum_decay.value ());
        }
    }
    // adjust drum attack
    fun void drum_attack_adj () {
        me.id () => shred_id_drum[5];
        while (true) {
            drum_attack.onChange () => now;
            D.setAttack (drum_attack.value ());
        }
    }
    // adjust drum drive gain
    fun void drum_drive_gain_adj () {
        me.id () => shred_id_drum[6];
        while (true) {
            drum_drive_gain.onChange () => now;
            D.setDriveGain (drum_drive_gain.value ());
        }
    }
    // adjust drum filter
    fun void drum_filter_adj () {
        me.id () => shred_id_drum[7];
        while (true) {
            drum_filter.onChange () => now;
            D.setFilter (drum_filter.value ());
        }
    }
    
    
    
    
    // mandolin functions
    // spork mandolin shreds
    fun void spork_shred_mandolin () {
        spork ~ mandolin_gain_adj ();
        spork ~ mandolin_body_size_adj ();
        spork ~ mandolin_pluck_pos_adj ();
        spork ~ mandolin_string_damping_adj ();
        spork ~ mandolin_string_detune_adj ();
        spork ~ mandolin_after_touch_adj ();
        spork ~ mandolin_gain1_adj ();
        spork ~ mandolin_gain2_adj ();
        spork ~ M1_Dyno_limit_adj ();
        spork ~ M1_Dyno_compress_adj ();
        spork ~ M1_Dyno_expand_adj ();
        spork ~ M1_Dyno_gate_adj ();
    }
    // remove mandolin shreds
    fun void remove_shred_mandolin () {
        for (0 => int i; i < num_mandolin_shreds; i++) {
            Machine.remove (shred_id_mandolin[i]);
        }
    }
    // adjust mandolin button
    fun void mandolin_adj () {
        while (true) {
            Mandolin.onChange () => now;
            if (Mandolin.state ()) {
                E => M1_gain;
                initialize_mandolin ();
                spork_shred_mandolin ();
            } else {
                E =< M1_gain;
                remove_shred_mandolin ();
            }
        }
    }
    // adjust manolin gain
    fun void mandolin_gain_adj () {
        me.id () => shred_id_mandolin[0];
        while (true) {
            mandolin_gain.onChange () => now;
            E.gain (mandolin_gain.value ());
        }
    }
    // adjust mandolin body size
    fun void mandolin_body_size_adj () {
        me.id () => shred_id_mandolin[1];
        while (true) {
            mandolin_body_size.onChange () => now;
            E.bodySize (mandolin_body_size.value ());
        }
    }
    // adjust mandolin pluck position
    fun void mandolin_pluck_pos_adj () {
        me.id () => shred_id_mandolin[2];
        while (true) {
            mandolin_pluck_pos.onChange () => now;
            E.pluckPos (mandolin_pluck_pos.value ());
        }
    }
    // adjust mandolin string damping
    fun void mandolin_string_damping_adj () {
        me.id () => shred_id_mandolin[3];
        while (true) {
            mandolin_string_damping.onChange () => now;
            E.stringDamping (mandolin_string_damping.value ());
        }
    }
    // adjust mandolin string detune
    fun void mandolin_string_detune_adj () {
        me.id () => shred_id_mandolin[4];
        while (true) {
            mandolin_string_detune.onChange () => now;
            E.stringDetune (mandolin_string_detune.value ());
        }
    }
    // adjust mandolin after touch
    fun void mandolin_after_touch_adj () {
        me.id () => shred_id_mandolin[5];
        while (true) {
            mandolin_after_touch.onChange () => now;
            E.afterTouch (mandolin_after_touch.value ());
        }
    }
    // adjust mandolin gain1
    fun void mandolin_gain1_adj () {
        me.id () => shred_id_mandolin[6];
        while (true) {
            mandolin_gain1.onChange () => now;
            M1_gain.gain (mandolin_gain1.value ());
        }
    }
    // adjust mandolin gain2
    fun void mandolin_gain2_adj () {
        me.id () => shred_id_mandolin[7];
        while (true) {
            mandolin_gain2.onChange () => now;
            M2_gain.gain (mandolin_gain2.value ());
        }
    }
    // adjust mandolin dyno limit button
    fun void M1_Dyno_limit_adj () {
        me.id () => shred_id_mandolin[8];
        while (true) {
            M1_Dyno_limit.onChange () => now;
            if (M1_Dyno_limit.state ()) {
                M1_Dyno_compress.state (0);
                M1_Dyno_expand.state (0);
                M1_Dyno_gate.state (0);
                M1_Dyno.limit ();
            } else {
                M1_Dyno_limit.state (1);
            }
        }
    }
    // adjust mandolin dyno compress button
    fun void M1_Dyno_compress_adj () {
        me.id () => shred_id_mandolin[9];
        while (true) {
            M1_Dyno_compress.onChange () => now;
            if (M1_Dyno_compress.state ()) {
                M1_Dyno_limit.state (0);
                M1_Dyno_expand.state (0);
                M1_Dyno_gate.state (0);
                M1_Dyno.compress ();
            } else {
                M1_Dyno_compress.state (1);
            }
        }
    }
    // adjust mandolin dyno expand button
    fun void M1_Dyno_expand_adj () {
        me.id () => shred_id_mandolin[10];
        while (true) {
            M1_Dyno_expand.onChange () => now;
            if (M1_Dyno_expand.state ()) {
                M1_Dyno_limit.state (0);
                M1_Dyno_compress.state (0);
                M1_Dyno_gate.state (0);
                M1_Dyno.expand ();
            } else {
                M1_Dyno_expand.state (1);
            }
        }
    }
    // adjust mandolin dyno gate button
    fun void M1_Dyno_gate_adj () {
        me.id () => shred_id_mandolin[11];
        while (true) {
            M1_Dyno_gate.onChange () => now;
            if (M1_Dyno_gate.state ()) {
                M1_Dyno_limit.state (0);
                M1_Dyno_compress.state (0);
                M1_Dyno_expand.state (0);
                M1_Dyno.gate ();
            } else {
                M1_Dyno_gate.state (1);
            }
        }
    }
    
    
    
    
    // saxophone functions
    fun void spork_shred_saxophone () {
        spork ~ saxophone_gain_adj ();
        spork ~ saxophone_stiffness_adj ();
        spork ~ saxophone_aperture_adj ();
        spork ~ saxophone_pressure_adj ();
        spork ~ saxophone_noise_gain_adj ();
        spork ~ saxophone_vibrato_freq_adj ();
        spork ~ saxophone_vibrato_gain_adj ();
        spork ~ saxophone_blow_position_adj ();
        spork ~ saxophone_rate_adj ();
        spork ~ saxophone_reverb_adj ();
    }
    // remove saxophone shreds
    fun void remove_shred_saxophone () {
        for (0 => int i; i < num_saxophone_shreds; i++) {
            Machine.remove (shred_id_saxophone[i]);
        }
    }
    // adjust saxophone button
    fun void saxophone_adj () {
        while (true) {
            Saxophone.onChange () => now;
            if (Saxophone.state ()) {
                F => F_rev;
                initialize_saxophone ();
                spork_shred_saxophone ();
            } else {
                F =< F_rev;
                F.noteOff (1.0);
                remove_shred_saxophone ();
            }
        }
    }
    // adjust saxophone gain
    fun void saxophone_gain_adj () {
        me.id () => shred_id_saxophone[0];
        while (true) {
            saxophone_gain.onChange () => now;
            F.gain (saxophone_gain.value ());
        }
    }
    // adjust saxophone stiffness
    fun void saxophone_stiffness_adj () {
        me.id () => shred_id_saxophone[1];
        while (true) {
            saxophone_stiffness.onChange () => now;
            F.stiffness (saxophone_stiffness.value ());
        }
    }
    // adjust saxophone aperture
    fun void saxophone_aperture_adj () {
        me.id () => shred_id_saxophone[2];
        while (true) {
            saxophone_aperture.onChange () => now;
            F.stiffness (saxophone_aperture.value ());
        }
    }
    // adjust saxophone pressure
    fun void saxophone_pressure_adj () {
        me.id () => shred_id_saxophone[3];
        while (true) {
            saxophone_pressure.onChange () => now;
            F.pressure (saxophone_pressure.value ());
        }
    }
    // adjust saxophone noise gain
    fun void saxophone_noise_gain_adj () {
        me.id () => shred_id_saxophone[4];
        while (true) {
            saxophone_noise_gain.onChange () => now;
            F.noiseGain (saxophone_noise_gain.value ());
        }
    }
    // adjust saxophone vibrato frequency
    fun void saxophone_vibrato_freq_adj () {
        me.id () => shred_id_saxophone[5];
        while (true) {
            saxophone_vibrato_freq.onChange () => now;
            F.vibratoFreq (saxophone_vibrato_freq.value ());
        }
    }
    // adjust saxophone vibrato gain
    fun void saxophone_vibrato_gain_adj () {
        me.id () => shred_id_saxophone[6];
        while (true) {
            saxophone_vibrato_gain.onChange () => now;
            F.vibratoGain (saxophone_vibrato_gain.value ());
        }
    }
    // adjust saxophone blow position
    fun void saxophone_blow_position_adj () {
        me.id () => shred_id_saxophone[7];
        while (true) {
            saxophone_blow_position.onChange () => now;
            F.blowPosition (saxophone_blow_position.value ());
        }
    }
    // adjust saxophone rate
    fun void saxophone_rate_adj () {
        me.id () => shred_id_saxophone[8];
        while (true) {
            saxophone_rate.onChange () => now;
            F.rate (saxophone_rate.value ());
        }
    }
    // adjust saxoophone reverb
    fun void saxophone_reverb_adj () {
        me.id () => shred_id_saxophone[9];
        while (true) {
            saxophone_reverb.onChange () => now;
            F_rev.mix (saxophone_reverb.value ());
        }
    }
    
    
    
    
    
    
    
    // thunder functions
    // spork thunder shreds
    fun void spork_shred_thunder () {
        spork ~ thunder_gain_adj ();
    }
    // remove thunder shreds
    fun void remove_shred_thunder () {
        for (0 => int i; i < num_thunder_shreds; i++) {
            Machine.remove (shred_id_thunder[i]);
        }
    }
    // adjust thunder button
    fun void thunder_adj () {
        while (true) {
            Thunder.onChange () => now;
            if (Thunder.state ()) {
                G.go => G_lpf;
                initialize_thunder ();
                spork_shred_thunder ();
            } else {
                G.go =< G_lpf;
                remove_shred_thunder ();
            }
        }
    }
    // adjust thunder gain
    fun void thunder_gain_adj () {
        me.id () => shred_id_thunder[0];
        while (true) {
            thunder_gain.onChange () => now;
            G.go.gain (thunder_gain.value ());
        }
    }
    
    
    
    
    // delay snare functions
    // spork delay snare shred
    fun void spork_shred_delaysnare () {
        spork ~ delaysnare_gain_adj ();
    }
    // remove delay snare shreds
    fun void remove_shred_delaysnare () {
        for (0 => int i; i < num_delaysnare_shreds; i++) {
            Machine.remove (shred_id_delaysnare[i]);
        }
    }
    // adjust delay snare button
    fun void delaysnare_adj () {
        while (true) {
            DelaySnare.onChange () => now;
            if (DelaySnare.state ()) {
                H.outputLimit => master;
                initialize_delaysnare ();
                spork_shred_delaysnare ();
            } else {
                H.outputLimit =< master;
                remove_shred_delaysnare ();
            }
        }
    }
    // adjust delay snare gain
    fun void delaysnare_gain_adj () {
        me.id () => shred_id_delaysnare[0];
        while (true) {
            delaysnare_gain.onChange () => now;
            H.outputLimit.gain (delaysnare_gain.value ());
        }
    }
    
    
    
    
    // microphone functions
    // spork microphone shreds
    fun void spork_shred_microphone () {
        spork ~ microphone_gain_adj ();
        spork ~ mic_chorus_mod_freq_adj ();
        spork ~ mic_chorus_mod_depth_adj ();
        spork ~ mic_chorus_mix_adj ();
        spork ~ mic_nrev_mix_adj ();
    }
    // remove microphone shreds
    fun void remove_shred_mic () {
        for (0 => int i; i < num_mic_shreds; i++) {
            Machine.remove (shred_id_mic[i]);
        }
    }
    // adjust microphone button
    fun void microphone_adj () {
        while (true) {
            Microphone.onChange () => now;
            if (Microphone.state ()) {
                microphone => master;
                initialize_microphone ();
                spork_shred_microphone ();
            } else {
                microphone =< master;
                remove_shred_mic ();
            }
        }
    }
    // adjust microphone gain
    fun void microphone_gain_adj () {
        me.id () => shred_id_mic[0];
        while (true) {
            microphone_gain.onChange () => now;
            microphone.gain (microphone_gain.value ());
        }
    }
    // adjust microphone chorus modulation frequency
    fun void mic_chorus_mod_freq_adj () {
        me.id () => shred_id_mic[1];
        while (true) {
            mic_chorus_mod_freq.onChange () => now;
            mic_chorus.modFreq (mic_chorus_mod_freq.value ());
        }
    }
    // adjust microphone chourus modulation depth
    fun void mic_chorus_mod_depth_adj () {
        me.id () => shred_id_mic[2];
        while (true) {
            mic_chorus_mod_depth.onChange () => now;
            mic_chorus.modDepth (mic_chorus_mod_depth.value ());
        }
    }
    // adjust microphone chorus mix
    fun void mic_chorus_mix_adj () {
        me.id () => shred_id_mic[3];
        while (true) {
            mic_chorus_mix.onChange () => now;
            mic_chorus.mix (mic_chorus_mix.value ());
        }
    }
    // adjust microphone nrev mix
    fun void mic_nrev_mix_adj () {
        me.id () => shred_id_mic[4];
        while (true) {
            mic_nrev_mix.onChange () => now;
            mic_nrev.mix (mic_nrev_mix.value ());
        }
    }
    
    
    
    
    // shakers functions
    // spork shakers shreds
    fun void spork_shred_shakers () {
        spork ~ shakers_gain_adj ();
        spork ~ shakers_preset_adj ();
        spork ~ shakers_objects_adj ();
        spork ~ shakers_decay_adj ();
        spork ~ shakers_energy_adj ();
    }
    // remove shakers shreds
    fun void remove_shred_shakers () {
        for (0 => int i; i < num_shakers_shreds; i++) {
            Machine.remove (shred_id_shakers[i]);
        }
    }
    // adjust shakers button
    fun void shakers_adj () {
        while (true) {
            Shakers.onChange () => now;
            if (Shakers.state ()) {
                I => master;
                initialize_shakers ();
                spork_shred_shakers ();
            } else {
                I =< master;
                remove_shred_shakers ();
            }
        }
    }
    // adjust shakers gain
    fun void shakers_gain_adj () {
        me.id () => shred_id_shakers[0];
        while (true) {
            shakers_gain.onChange () => now;
            I.gain (shakers_gain.value ());
        }
    }
    // adjust shakers preset
    fun void shakers_preset_adj () {
        me.id () => shred_id_shakers[1];
        while (true) {
            shakers_preset.onChange () => now;
            I.preset (shakers_preset.value () $ int);
        }
    }
    // adjust shakers objects
    fun void shakers_objects_adj () {
        me.id () => shred_id_shakers[2];
        while (true) {
            shakers_objects.onChange () => now;
            I.objects (shakers_objects.value ());
        }
    }
    // adjust shakers decay
    fun void shakers_decay_adj () {
        me.id () => shred_id_shakers[3];
        while (true) {
            shakers_decay.onChange () => now;
            I.decay (shakers_decay.value ());
        }
    }
    // adjust shakers energy
    fun void shakers_energy_adj () {
        me.id () => shred_id_shakers[4];
        while (true) {
            shakers_energy.onChange () => now;
            I.energy (shakers_energy.value ());
        }
    }
    
    
    
    
    // stifkarp functions
    // spork stifkarp shreds
    fun void spork_shred_stifkarp () {
        spork ~ stifkarp_gain_adj ();
        spork ~ stifkarp_pickupPosition_adj ();
        spork ~ stifkarp_sustain_adj ();
        spork ~ stifkarp_stretch_adj ();
        spork ~ stifkarp_baseLoopGain_adj ();
    }
    // remove stifkarp shreds
    fun void remove_shred_stifkarp () {
        for (0 => int i; i < num_stifkarp_shreds; i++) {
            Machine.remove (shred_id_stifkarp[i]);
        }
    }
    // adjust stifkarp button
    fun void stifkarp_adj () {
        while (true) {
            StifKarp.onChange () => now;
            if (StifKarp.state ()) {
                J => wahwah;
                initialize_stifkarp ();
                spork_shred_stifkarp ();
            } else {
                J =< wahwah;
                remove_shred_stifkarp ();
            }
        }
    }
    // adjust stifkarp gain
    fun void stifkarp_gain_adj () {
        me.id () => shred_id_stifkarp[0];
        while (true) {
            stifkarp_gain.onChange () => now;
            J.gain (stifkarp_gain.value ());
        }
    }
    // adjust stifkarp pickup position
    fun void stifkarp_pickupPosition_adj () {
        me.id () => shred_id_stifkarp[1];
        while (true) {
            stifkarp_pickupPosition.onChange () => now;
            J.pickupPosition (stifkarp_pickupPosition.value ());
        }
    }
    // adjust stifkarp sustain
    fun void stifkarp_sustain_adj () {
        me.id () => shred_id_stifkarp[2];
        while (true) {
            stifkarp_sustain.onChange () => now;
            J.sustain (stifkarp_sustain.value ());
        }
    }
    // adjust stifkarp stretch
    fun void stifkarp_stretch_adj () {
        me.id () => shred_id_stifkarp[3];
        while (true) {
            stifkarp_stretch.onChange () => now;
            J.stretch (stifkarp_stretch.value ());
        }
    }
    // adjust stifkarp base loop gain
    fun void stifkarp_baseLoopGain_adj () {
        me.id () => shred_id_stifkarp[4];
        while (true) {
            stifkarp_baseLoopGain.onChange () => now;
            J.baseLoopGain (stifkarp_baseLoopGain.value ());
        }
    }
    
    
    
    
    // ocean1 functions
    // spork ocean1 shreds
    fun void spork_shred_ocean1 () {
        spork ~ ocean1_gain_adj ();
        spork ~ ocean1_lpf1_adj ();
        spork ~ ocean1_lpf2_adj ();
    }
    // remove ocean1 shreds
    fun void remove_shred_ocean1 () {
        for (0 => int i; i < num_ocean1_shreds; i++) {
            Machine.remove (shred_id_ocean1[i]);
        }
    }
    // adjust ocean1 button
    fun void ocean1_adj () {
        while (true) {
            Ocean1.onChange () => now;
            if (Ocean1.state ()) {
                K.output => master;
                initialize_ocean1 ();
                spork_shred_ocean1 ();
            } else {
                K.output =< master;
                remove_shred_ocean1 ();
            }
        }
    }
    // adjust ocean1 gain
    fun void ocean1_gain_adj () {
        me.id () => shred_id_ocean1[0];
        while (true) {
            ocean1_gain.onChange () => now;
            K.output.gain (ocean1_gain.value ());
        }
    }
    // adjust ocean1 lpf1
    fun void ocean1_lpf1_adj () {
        me.id () => shred_id_ocean1[1];
        0 => float t;
        while (true) {
            (1 + Math.sin (2*pi * 0.1 * t) ) / 2 => float wave;
            K.ocean_lpf1.gain ((1 + wave) / 2);
            K.ocean_lpf1.freq (1000 * wave + 500);
            0.001 +=> t;
            1::ms => now;
        }
    }
    // adjust ocean1 lpf2
    fun void ocean1_lpf2_adj () {
        me.id () => shred_id_ocean1[2];
        0 => float t;
        while (true) {
            (1 + Math.cos (2*pi * 0.1 * t) ) / 2 => float wave;
            K.ocean_lpf2.gain ((1 + wave) / 2);
            K.ocean_lpf2.freq (12000 * wave + 1000);
            0.001 +=> t;
            1::ms => now;
        }
    }
    
    
    
    
    // rain1 functions
    // spork rain1 shreds
    fun void spork_shred_rain1 () {
        spork ~ rain1_gain_adj ();
        spork ~ rain1_drops_adj ();
    }
    // remove rain1 shreds
    fun void remove_shred_rain1 () {
        for (0 => int i; i < num_rain1_shreds; i++) {
            Machine.remove (shred_id_rain1[i]);
        }
    }
    // adjust rain1 button
    fun void rain1_adj () {
        while (true) {
            Rain1.onChange () => now;
            if (Rain1.state ()) {
                L.lpf.freq (6000);
                L.bpf.freq (15000);
                L.bpf.Q (4);
                L.n.gain (0.3);
                L.output => master;
                initialize_rain1 ();
                spork_shred_rain1 ();
            } else {
                L.output =< master;
                remove_shred_rain1 ();
            }
        }
    }
    // adjust rain1 gain
    fun void rain1_gain_adj () {
        me.id () => shred_id_rain1[0];
        while (true) {
            rain1_gain.onChange () => now;
            L.output.gain (rain1_gain.value ());
        }
    }
    // adjust rain1 drops
    fun void rain1_drops_adj () {
        me.id () => shred_id_rain1[1];
        while (true) {
            L.i.next (5*(maybe+maybe+maybe+maybe));
            (maybe+maybe+maybe+maybe) * 10::ms => now;
        }
    }
    
    
    
    
    // rain2 functions
    // spork rain2 shreds
    fun void spork_shred_rain2 () {
        spork ~ rain2_gain_adj ();
    }
    // remove rain2 shreds
    fun void remove_shred_rain2 () {
        for (0 => int i; i < num_rain2_shreds; i++) {
            Machine.remove (shred_id_rain2[i]);
        }
    }
    // adjust rain2 button
    fun void rain2_adj () {
        while (true) {
            Rain2.onChange () => now;
            if (Rain2.state ()) {
                M.output => master;
                initialize_rain2 ();
                spork_shred_rain2 ();
            } else {
                M.output =< master;
                remove_shred_rain2 ();
            }
        }
    }
    // adjust rain2 gain
    fun void rain2_gain_adj () {
        me.id () => shred_id_rain1[0];
        while (true) {
            rain2_gain.onChange () => now;
            M.output.gain (rain2_gain.value ());
        }
    }
    
    
    
    
    
    // effects functions
    fun void spork_shred_effects () {
        spork ~ jcreverb_mix_adj ();
        spork ~ wah_wah_adj ();
    }
    // remove drum shreds
    fun void remove_shred_drum () {
        for (0 => int i; i < num_drum_shreds; i++) {
            Machine.remove (shred_id_drum[i]);
        }
    }
    // adjust jcreverb mix effect
    fun void jcreverb_mix_adj () {
        me.id () => shred_id_effects[0];
        while (true) {
            jcreverb_mix.onChange () => now;
            jcrev.mix (jcreverb_mix.value ());
        }
    }
    // adjust wah wah effect
    fun void wah_wah_adj () {
        me.id () => shred_id_effects[1];
        0 => float t;
        while (true) {
            wahwah.freq (4000 * (1 + Math.sin(2 * pi * wahwah_freq.value () * t)) + 1000);
            0.001 +=> t;
            1::ms => now;
        }
    }
    
    
    
    
    
    // scales functions
    // spork scales shreds
    fun void spork_shred_scales () {
        for (0 => int s; s < num_scales; s++) {
            spork ~ scales_adj (s);
        }
    }
    // remove scales shreds
    fun void remove_shred_scales () {
        for (0 => int s; s < num_scales; s++) {
            Machine.remove (shred_id_scales[s]);
        }
    }
    // adjust scales buttons
    fun void scales_adj (int s) {
        me.id () => shred_id_scales[s];
        while (true) {
            scales[s].onChange () => now;
            if (scales[s].state ()) {
                // change the old scale setting to lower case
                if (scale == 0) {
                    scales[scale].name ("lydian");
                }
                if (scale == 1) {
                    scales[scale].name ("ionian");
                }
                if (scale == 2) {
                    scales[scale].name ("mixolydian");
                }
                if (scale == 3) {
                    scales[scale].name ("dorian");
                }
                if (scale == 4) {
                    scales[scale].name ("aeolian");
                }
                if (scale == 5) {
                    scales[scale].name ("phrygian");
                }
                if (scale == 6) {
                    scales[scale].name ("locrian");
                }
                if (scale == 7) {
                    scales[scale].name ("harmonic minor");
                }
                if (scale == 8) {
                    scales[scale].name ("melodic minor");
                }
                // set the Modecular class scale and
                // change new scale setting to upper case
                if (s == 0) {
                    Mod.set ("lydian");
                    scales[s].name ("LYDIAN");
                }
                if (s == 1) {
                    Mod.set ("ionian");
                    scales[s].name ("IONIAN");
                }
                if (s == 2) {
                    Mod.set ("mixolydian");
                    scales[s].name ("MIXOLYDIAN");
                }
                if (s == 3) {
                    Mod.set ("dorian");
                    scales[s].name ("DORIAN");
                }
                if (s == 4) {
                    Mod.set ("aeolian");
                    scales[s].name ("AEOLIAN");
                }
                if (s == 5) {
                    Mod.set ("phrygian");
                    scales[s].name ("PHRYGIAN");
                }
                if (s == 6) {
                    Mod.set ("locrian");
                    scales[s].name ("LOCRIAN");
                }
                if (s == 7) {
                    Mod.set ("harmonic minor");
                    scales[s].name ("HARMONIC MINOR");
                }
                if (s == 8) {
                    Mod.set ("melodic minor");
                    scales[s].name ("MELODIC MINOR");
                }
                // save the scale index
                s => scale;
            }
        }
    }
    
    
    
    
    
    
    fun void initialize_guitar () {
        A.output.gain (guitar_gain.value ());
        reverb.value () => A.rev.mix;
        for(int i; i < 3; i++) {
            body_size.value () => A.str[i].bodySize;
            pluck_pos.value () => A.str[i].pluckPos;
            string_damping.value () => A.str[i].stringDamping;
            string_detune.value () => A.str[i].stringDetune;
            after_touch.value () => A.str[i].afterTouch;
        }
        guitar_echo.delay ((guitar_echo_delay.value ())::second);
        guitar_echo.max ((guitar_echo_max.value ())::second);
        guitar_echo.mix (guitar_echo_mix.value ());
    }
    
    fun void initialize_flute () {
        jet_delay.value () => B.jetDelay;
        jet_reflection.value () => B.jetReflection;
        end_reflection.value () => B.endReflection;
        noise_gain.value () => B.noiseGain;
        vibrato_freq.value () => B.vibratoFreq;
        vibrato_gain.value () => B.vibratoGain;
        B.gain (flute_gain.value ());
    }
    
    fun void initialize_snare () {
        C.output.gain (snare_gain.value ());
        C.setFilter (snare_freq.value (), snare_Q.value());
        C.setFilter (snare_freq.value (), snare_Q.value());
        C.setDecay (snare_decay.value ());
        C.setAttack (snare_attack.value ());
    }
    
    fun void initialize_drum () {
        D.output.gain (drum_gain.value ());
        D.setFreq (drum_freq.value ());
        D.setPitchDecay (drum_pitch_decay.value ());
        D.setPitchAttack (drum_pitch_attack.value ());
        D.setDecay (drum_decay.value ());
        D.setAttack (drum_attack.value ());
        D.setDriveGain (drum_drive_gain.value ());
        D.setFilter (drum_filter.value ());
    }
    
    fun void initialize_mandolin () {
        E.gain (mandolin_gain.value ());
        E.bodySize (mandolin_body_size.value ());
        E.pluckPos (mandolin_pluck_pos.value ());
        E.stringDamping (mandolin_string_damping.value ());
        E.stringDetune (mandolin_string_detune.value ());
        E.afterTouch (mandolin_after_touch.value ());
        M1_Dyno_limit.state (1);
        M1_Dyno.limit ();
        M1_gain.gain (mandolin_gain1.value ());
        M2_gain.gain (mandolin_gain2.value ());
    }
    
    fun void initialize_saxophone () {
        F.gain (saxophone_gain.value ());
        F.stiffness (saxophone_stiffness.value ());
        F.aperture (saxophone_aperture.value ());
        F.pressure (saxophone_pressure.value ());
        F.noiseGain (saxophone_noise_gain.value ());
        F.vibratoFreq (saxophone_vibrato_freq.value ());
        F.vibratoGain (saxophone_vibrato_gain.value ());
        F.blowPosition (saxophone_blow_position.value ());
        F.rate (saxophone_rate.value ());
        F_rev.mix (saxophone_reverb.value ());
        F.noteOff (1.0);
    }
    
    fun void initialize_thunder () {
        G.go.gain (thunder_gain.value ());
    }
    
    fun void initialize_delaysnare () {
        H.outputLimit.gain (delaysnare_gain.value ());
    }
    
    fun void initialize_microphone () {
        microphone.gain (microphone_gain.value ());
        mic_chorus.modFreq (mic_chorus_mod_freq.value ());
        mic_chorus.modDepth (mic_chorus_mod_depth.value ());
        mic_chorus.mix (mic_chorus_mix.value ());
        mic_nrev.mix (mic_nrev_mix.value ());
    }
    
    fun void initialize_shakers () {
        I.gain (shakers_gain.value ());
        I.preset (shakers_preset.value () $ int);
        I.objects (shakers_objects.value ());
        I.decay (shakers_decay.value ());
        I.energy (shakers_energy.value ());
    }
    
    fun void initialize_stifkarp () {
        J.gain (stifkarp_gain.value ());
        J.pickupPosition (stifkarp_pickupPosition.value ());
        J.sustain (stifkarp_sustain.value ());
        J.stretch (stifkarp_stretch.value ());
        J.baseLoopGain (stifkarp_baseLoopGain.value ());
    }
    
    fun void initialize_ocean1 () {
        K.output.gain (ocean1_gain.value ());
    }
    
    fun void initialize_rain1 () {
        L.output.gain (rain1_gain.value ());
    }
    
    fun void initialize_rain2 () {
        M.output.gain (rain2_gain.value ());
    }
    
    fun void initialize_effects () {
        wahwah.freq (20000);
        jcrev.mix (jcreverb_mix.value ());
    }
    
    fun void initialize_scales () {
        Mod.set ("lydian");
        scales[0].name ("LYDIAN");
    }
    
    fun void initialize_instruments () {
        initialize_volume ();
        initialize_base ();
        initialize_guitar ();
        initialize_flute ();
        initialize_snare ();
        initialize_drum ();
        initialize_mandolin ();
        initialize_saxophone ();
        initialize_delaysnare ();
        initialize_microphone ();
        initialize_shakers ();
        initialize_stifkarp ();
        initialize_ocean1 ();
        initialize_rain1 ();
        initialize_rain2 ();
        initialize_effects ();
        initialize_scales ();
    }
    
    
    
    
    
    
    
    
    
    // initialization sporks
    spork ~ start ();
    spork ~ record ();
    spork ~ clear ();
    spork ~ or_xor ();
    spork ~ volume_adj ();
    spork ~ author_adj ();
    spork ~ freq_offset_values_adj ();
    spork ~ instrument_plus ();
    spork ~ instrument_minus ();
    spork ~ and_plus ();
    spork ~ and_minus ();
    spork_shred_matrix ();
    spork_shred_guitar ();
    spork_shred_instruments ();
    spork_shred_scales ();
    
    
    
    
    // put slider values into instruments
    initialize_instruments ();
    
    // count out the binary sequence and play notes
    fun void main_loop () {
    while (true) {
        for (0 => j[11]; j[11] < n; j[11]++) {
            maybe => note_prob[11];
            if (j[11]) {count[11].light ();} else {count[11].unlight ();}
            for (0 => j[10]; j[10] < n; j[10]++) {
                maybe => note_prob[10];
                if (j[10]) {count[10].light ();} else {count[10].unlight ();}
                for (0 => j[9]; j[9] < n; j[9]++) {
                    maybe => note_prob[9];
                    if (j[9]) {count[9].light ();} else {count[9].unlight ();}
                    for (0 => j[8]; j[8] < n; j[8]++) {
                        maybe => note_prob[8];
                        if (j[8]) {count[8].light ();} else {count[8].unlight ();}
                        for (0 => j[7]; j[7] < n; j[7]++) {
                            maybe => note_prob[7];
                            if (j[7]) {count[7].light ();} else {count[7].unlight ();}
                            for (0 => j[6]; j[6] < n; j[6]++) {
                                maybe => note_prob[6];
                                if (j[6]) {count[6].light ();} else {count[6].unlight ();}
                                for (0 => j[5]; j[5] < n; j[5]++) {
                                    maybe => note_prob[5];
                                    if (j[5]) {count[5].light ();} else {count[5].unlight ();}
                                    for (0 => j[4]; j[4] < n; j[4]++) {
                                        maybe => note_prob[4];
                                        if (j[4]) {count[4].light ();} else {count[4].unlight ();}
                                        for (0 => j[3]; j[3] < n; j[3]++) {
                                            maybe => note_prob[3];
                                            if (j[3]) {count[3].light ();} else {count[3].unlight ();}
                                            for (0 => j[2]; j[2] < n; j[2]++) {
                                                maybe => note_prob[2];
                                                if (j[2]) {count[2].light ();} else {count[2].unlight ();}
                                                for (0 => j[1]; j[1] < n; j[1]++) {
                                                    maybe => note_prob[1];
                                                    if (j[1]) {count[1].light ();} else {count[1].unlight ();}
                                                    for (0 => j[0]; j[0] < n; j[0]++) {
                                                        maybe => note_prob[0];
                                                        if (j[0]) {count[0].light ();} else {count[0].unlight ();}
                                                        // loop thru the insruments
                                                        for (0 => int i; i < num_instruments; i++) {
                                                            // only calculate logic if the insturment is enabled
                                                            if ( (Guitar.state () && (i == 0)) || (Flute.state () && (i == 1)) || 
                                                            (Snare.state () && (i == 2)) || (Drum.state () && (i == 3)) ||
                                                            (Mandolin.state () && (i == 4)) || (Saxophone.state () && (i == 5)) ||
                                                            (Thunder.state () && (i == 6)) || (DelaySnare.state () && (i == 7)) ||
                                                            (Shakers.state () && (i == 9)) || (StifKarp.state () && (i == 10)) ) {
                                                                0 => play_note;  // initialize the note play / don't play flag
                                                                0 => freq;  // initialize the frequency index
                                                                // loop thru the matrix pages
                                                                for (0 => int p; p < num_and_pages; p++) {
                                                                    // loop thru the vertical and terms
                                                                    for (0 => int a; a < num_and_terms; a++) {
                                                                        p * num_and_terms + a => page_term_index;  // calculate index once to save cpu
                                                                        0 => dont_care;  // sete don't care total to zero
                                                                        1 => and_term;  // set this logic term's value to 1
                                                                        // loop thru the horizontal binary digits
                                                                        for (0 => int b; b < num_digits; b++) {
                                                                            // check to see if the matrix bit is set to don't care
                                                                            if (and_values[i][page_term_index][b] == 0) {
                                                                                // increment don't care bit counter
                                                                                dont_care++;
                                                                            }
                                                                            // check to see if the matrix bit is set to one
                                                                            if (and_values[i][page_term_index][b] == 1) {
                                                                                // and the bit with the logic term
                                                                                j[b] & and_term => and_term;
                                                                            }
                                                                            // check to see if the matrix bit is set to zero
                                                                            if (and_values[i][page_term_index][b] == 2) {
                                                                                // and the inverted bit with the logic term
                                                                                (!j[b]) & and_term => and_term;
                                                                            }
                                                                            // check to see if the matrix bit is set to random
                                                                            if (and_values[i][page_term_index][b] == 3) {
                                                                                // and random the note probability with the logic term
                                                                                note_prob[b] & and_term => and_term;
                                                                            }
                                                                        }
                                                                        // check to see if all of the logic term bits are don't cares
                                                                        if (dont_care == num_digits) {
                                                                            0 => and_term;  // set the logic term to zero
                                                                        }
                                                                        // check to see if the XOR button is pressed
                                                                        if (xor_button.state ()) {
                                                                            // XOR the play_note with this logic term
                                                                            play_note ^ and_term => play_note;
                                                                        } else {
                                                                            // OR the play_note with this logic term
                                                                            play_note | and_term => play_note;
                                                                        }
                                                                        // check to see if the term is logic one
                                                                        if (and_term) {
                                                                            // if we are using this instrument and on the displayed page
                                                                            if ( (i == instrument) && (p == and_page) ) {
                                                                                logic[a].light ();  // light the green LED for this logic term
                                                                            }
                                                                            // add the note frequency index to the frequency tally
                                                                            note[i][p][a] +=> freq;
                                                                        } else {
                                                                            // if we are using this instrument and on the displayed page
                                                                            if ( (i == instrument) && (p == and_page) ) {
                                                                                logic[a].unlight ();  // turn off the LED for this logic term
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            // if this is the current active instrument
                                                            if (i == instrument) {
                                                                // if we are playing a note on this instrument
                                                                if (play_note) {
                                                                    playing_note.light ();  // light the blue LED
                                                                } else {
                                                                    playing_note.unlight ();  // turn off the blue LED
                                                                }
                                                            }
                                                            // if we are playing a note
                                                            if (play_note) {
                                                                // loop thru all the binary digits
                                                                for (0 => int b; b < num_digits; b++) {
                                                                    // if this bit is a one
                                                                    if (j[b]) {
                                                                        // add in the frequency contribution
                                                                        freq_amount[i][b] +=> freq;
                                                                    }
                                                                }
                                                                // play the guitar
                                                                if (Guitar.state () && (i == 0)) {
                                                                    for (0 => int j; j < 3; j++) {
                                                                        Mod.note (freq) + freq_offset_values[i] => Std.mtof => frequency;
                                                                        frequency * (j+1) => A.str[j].freq;
                                                                    }
                                                                    for (0 => int j; j < 3; j++) {
                                                                        0.8 - i/4.0 => A.str[j].pluck;
                                                                    }
                                                                }
                                                                // play the flute
                                                                if (Flute.state () && (i == 1)) {
                                                                    // set the note frequency
                                                                    Mod.note (freq) + freq_offset_values[i] => Std.mtof => B.freq;
                                                                    // play the note
                                                                    B.noteOn (0.5);
                                                                }
                                                                // play the snare
                                                                if (Snare.state () && (i == 2)) {
                                                                    // play the note
                                                                    C.hit (0.8);
                                                                }
                                                                // play the drum
                                                                if (Drum.state () && (i == 3)) {
                                                                    // play the note
                                                                    D.hit ((freq + freq_offset_values[i])/20.0);
                                                                }
                                                                // play the mandolin
                                                                if (Mandolin.state () && (i == 4)) {
                                                                    // set the note frequency
                                                                    Mod.note (freq) + freq_offset_values[i] => Std.mtof => E.freq;
                                                                    // play the note
                                                                    E.pluck (1.0);
                                                                }
                                                                // play the saxophone
                                                                if (Saxophone.state () && (i == 5)) {
                                                                    // set the note frequency
                                                                    Mod.note (freq) + freq_offset_values[i] => Std.mtof => F.freq;
                                                                    // play the note
                                                                    F.noteOn (1.0);
                                                                }
                                                                // play the thunder
                                                                if (Thunder.state () && (i == 6)) {
                                                                    // set the gain as a function of frequency
                                                                    G.go.gain(thunder_gain.value () * freq);
                                                                    // check to see if thunder happens this time
                                                                    if (Std.rand2f(0,1) <= thunder_probability.value ()) {
                                                                        // play the thunder
                                                                        G.i2.next (1);
                                                                    }
                                                                }
                                                                // play the delay snare
                                                                if (DelaySnare.state () && (i == 7)) {
                                                                    // loop thru the delay model parameter
                                                                    for(0 => int j; j < 4; j++) {
                                                                        // play the note
                                                                        H.hit(j + 1 + freq);
                                                                    }    
                                                                }
                                                                // play the shakers
                                                                if (Shakers.state () && (i == 9)) {
                                                                    // set the note frequency
                                                                    Mod.note (freq) + freq_offset_values[i] => Std.mtof => I.freq;
                                                                    // play the note
                                                                    I.noteOn (1.0);
                                                                }
                                                                // pjay the StifKarp
                                                                if (StifKarp.state () && (i == 10)) {
                                                                    // set the note frequency
                                                                    Mod.note (freq) + freq_offset_values[i] => Std.mtof => J.freq;
                                                                    // play the note
                                                                    J.pluck (1.0);
                                                                }
                                                            }
                                                        }
                                                        // infinite loop here if start button is not pressed
                                                        while (!start_button.state ()) {
                                                            100::ms => now;
                                                        }
                                                        // advance time, and do it quickly if ffwd button is pressed
                                                        if (ffwd_button.state ()) {
                                                            16 => playback_rate;
                                                        } else {
                                                            1 => playback_rate;
                                                        }
                                                        1::second / (playback_rate * notes_per_second.value ()) => now;  
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
spork ~ main_loop ();
    
} // end of class declaration




// Instrument and other classes


// many thanks to kijjaz for the mandolin-based Stratocaster guitar sound with overdrive:  
// Mandolin as the electric guitar test: by kijjaz (kijjaz@yahoo.com)
// feel free to use, modify, publish
class kjzGuitar101 {
    Mandolin str[3]; // create mandolin strings
    SinOsc overdrive => NRev rev => Gain output; // create overdrive to reverb to dac
    overdrive.sync(1); // make overdrive do Sine waveshaping
    rev.mix(0.02); // set reverb mix
rev.gain(0.6); // set master gain
output.gain(1.0); // set output gain

// connect strings, set string damping
for(int i; i < 3; i++) {
    str[i] => overdrive;
    .9 => str[i].stringDamping;
    0.5 => str[i].bodySize;
}
}


// many thanks to kijjaz (kijjaz@yahoo.com) for the snare code examples, rock on kijjaz!  
// easy white noise snare
class kjzSnare101 {
    // note: connect output to external sources to connect
    Noise s => Gain s_env => LPF s_f => Gain output; // white noise source
    Impulse i => Gain g => Gain g_fb => g => LPF g_f => s_env;
    
    3 => s_env.op; // make s envelope a multiplier
    s_f.set(3000, 4); // set default drum filter
    g_fb.gain(1.0 - 1.0/3000); // set default drum decay
    g_f.set(200, 1); // set default drum attack
    
    fun void setFilter(float f, float Q)
    {
        s_f.set(f, Q);
    }
    fun void setDecay(float decay)
    {
        g_fb.gain(1.0 - 1.0 / decay); // decay unit: samples!
    }
    fun void setAttack(float attack)
    {
        g_f.freq(attack); // attack unit: Hz!
    }
    fun void hit(float velocity)
    {
        velocity => i.next;
    }
}


// simple analog-sounding bass drum with pitch and amp decay and sine overdrive
class kjzBD101 {
    Impulse i; // the attack
    i => Gain g1 => Gain g1_fb => g1 => LPF g1_f => Gain BDFreq; // BD pitch envelope
    i => Gain g2 => Gain g2_fb => g2 => LPF g2_f; // BD amp envelope
    
    // drum sound oscillator to amp envelope to overdrive to LPF to output
    BDFreq => SinOsc s => Gain ampenv => SinOsc s_ws => LPF s_f => Gain output;
    g2_f => ampenv; // amp envelope of the drum sound
    3 => ampenv.op; // set ampenv a multiplier
    1 => s_ws.sync; // prepare the SinOsc to be used as a waveshaper for overdrive
    
    // set default
    80.0 => BDFreq.gain; // BD initial pitch: 80 hz
    1.0 - 1.0 / 2000 => g1_fb.gain; // BD pitch decay
    g1_f.set(100, 1); // set BD pitch attack
    1.0 - 1.0 / 4000 => g2_fb.gain; // BD amp decay
    g2_f.set(50, 1); // set BD amp attack
    .75 => ampenv.gain; // overdrive gain
    s_f.set(600, 1); // set BD lowpass filter
    
    fun void hit(float v)
    {
        v => i.next;
    }
    fun void setFreq(float f)
    {
        f => BDFreq.gain;
    }
    fun void setPitchDecay(float f)
    {
        f => g1_fb.gain;
    }
    fun void setPitchAttack(float f)
    {
        f => g1_f.freq;
    }
    fun void setDecay(float f)
    {
        f => g2_fb.gain;
    }
    fun void setAttack(float f)
    {
        f => g2_f.freq;
    }
    fun void setDriveGain(float g)
    {
        g => ampenv.gain;
    }
    fun void setFilter(float f)
    {
        f => s_f.freq;
    }
}



// An attempt at thunder fro kijjaz, modified by myself somewhat
class kjz_thunder {
    // Main sound source
    Noise s1 => LPF f1 => Gain env1 => SinOsc overdrive1 => LPF f1_1 => NRev rev1 => Gain go;
    f1.set(160, .5);
    f1_1.set(120, .5);
    3 => env1.op;
    1 => overdrive1.sync;
    .1 => rev1.mix;
    .3 => rev1.gain;
    
    // Amp envelope
    Impulse i2 => Gain g2_1 => Gain g2_1_fb => g2_1 => Gain g2_2 => Gain g2_2_fb => g2_2 => LPF f2 => env1;
    f2.set(3, 1);
    .992 => g2_1_fb.gain => g2_2_fb.gain;
    80 => f2.gain;
}


// Simple Delayline Snare 01 version 0.3 testing
// by kijjaz
// simple delaylines snare drum design: still a testing prototype

// licence: Attribution-Share Alike 3.0
// You are free:
//    * to Share  to copy, distribute and transmit the work
//    * to Remix  to adapt the work
// Under the following conditions:
//    * Attribution. You must attribute the work in the manner specified by the author or licensor
//      (but not in any way that suggests that they endorse you or your use of the work).
//    * Share Alike. If you alter, transform, or build upon this work,
//      you may distribute the resulting work only under the same, similar or a compatible license.

// news: version 0.2 is never released (0.3 is developed in a different direction)
// now includes a way to improve sound and flexibility from version 0.1
// and now is a class for easy integration with other programs

// note: there are 4 output for you to chuck out: outputTop, outputBottom, outputTopDrive, output
// output = sum of the first three outputs. warning! can be very loud
// use (or set) outputLimit if you need limiting

class DelaylineSnare01
{
    // constructing a snare drum: create top head, body, and bottom head
    // connect them by top -> body -> bottom -> body -> then back to top
    DelayA drumTop => Gain g1 => DelayA drumBody1 => Gain g2
    => DelayA drumBottom => Gain g3 => DelayA drumBody2 => Gain g4 => drumTop;
    
    // prepare maximum delay time for the parts
    // (one second is like 315 meters in the air, i hope a snare should not be that big haha!)
    second => drumTop.max => drumBody1.max => drumBottom.max => drumBody2.max;
    
    // make drum top head sustain by applying feedback
    drumTop => Gain g5 => drumTop;
    
    // make drum bottom head sustain and attach noisy snares by AM with Noise
    drumBottom => Gain g6 => drumBottom;
    Noise snare => LPF snare_f => g6;
    g6.op(3);
    
    // prepare a stick and attach to Drum Top Head
    Impulse stickImp => LPF stickImp_f => SinOsc stickDrive => drumTop;    
    stickDrive.sync(1); // prepare overdrive for the stick impulse
    Gain input => stickDrive; // chuck to input for external hitting!
    
    // prepare seperate outputs: outputTop, outputBottom, outputTopDrive
    drumTop => Gain outputTop;
    drumBottom => Gain outputBottom;
    drumTop => Gain drumTop_driveGain => SinOsc drumTop_drive => Gain outputTopDrive;
    drumTop_drive.sync(1);
    
    // prepare one master output: output, outputLimit (output with a Dyno limiter)
    drumTop => Gain outputTopMix => Gain output;
    drumBottom => Gain outputBottomMix => output;
    drumTop_drive => Gain outputTopDriveMix => output;
    output => Dyno outputLimit;
    outputLimit.limit();
    
    // initialization to default sound (by using loadPreset function)
    loadAllValues( [200.0, 600, 1000, .3, .4, .5, .5, .6, 5, 9000, .5, 5, 180, 5, .5, .5, 1, .5], false);
    
    fun void loadAllValues(float values[], int stickDrive)
    {
        values[0] => topFreq;
        values[1] => bottomFreq;
        values[2] => bodyFreq;
        values[3] => topDecay;
        values[4] => bottomDecay;
        values[5] => topGain;
        values[6] => bottomGain;
        values[7] => bodyGain;
        values[8] => snareGain;
        values[9] => snareFreq;
        values[10] => snareQ;
        values[11] => stickGain;
        values[12] => stickFreq;
        values[13] => stickQ;
        values[14] => topDriveGain;
        values[15] => topMix;
        values[16] => bottomMix;
        values[17] => topDriveMix;
        if (stickDrive) stickDriveOn(); else stickDriveOff();
}


// - - - functions - - -
// drum part delay time (set by supplying frequency)
fun void topFreq(float f)
{
    second / f => drumTop.delay;
}
fun void bottomFreq(float f)
{
    second / f => drumBottom.delay;
}
fun void bodyFreq(float f)
{
    second / f => drumBody1.delay => drumBody1.delay;
}
// top and bottom decay rate
fun void topDecay(float rate)
{
    rate => g5.gain;
}
fun void bottomDecay(float rate)
{
    rate => g6.gain;
}
fun void topGain(float g) // gain from top to body
{
    g => g1.gain;
}
fun void bottomGain(float g) // gain from top to body
{
    g => g3.gain;
}    
fun void bodyGain(float g) // gain from body to top and bottom
{
    g => g2.gain => g4.gain;
}
// snare & bottom set up
fun void snareGain(float g)
{
    g => snare.gain;
}
fun void snareFreq(float f)
{
    f => snare_f.freq;
}
fun void snareQ(float Q)
{
    Q => snare_f.Q;
}

// stick
fun void stickGain(float g)
{
    g => stickImp.gain;
}
fun void hit(float velocity)
{        
    velocity => stickImp.next;        
}
fun void stickFreq(float f)
{
    f => stickImp_f.freq;
}
fun void stickQ(float Q)
{
    Q => stickImp_f.Q;
}
fun void stickDriveOn() // compute Sine overdrive
{
    stickDrive.op(1);
}
fun void stickDriveOff() // bypass the drive unit
{
    stickDrive.op(-1);
}

fun void topDriveGain(float g) // set gain for drum top overdrive
{
    g * .5 => drumTop_driveGain.gain;
}
// set balance mix of each sound into the main output (and also the outputLimit)
fun void topMix(float g)
{
    g => outputTopMix.gain;
}
fun void bottomMix(float g)
{
    g => outputBottomMix.gain;
}
fun void topDriveMix(float g)
{
    g => outputTopDriveMix.gain;
}    
}




// Attempt at ocean waves
// copyright 2008 Les Hall
// This software is protected by the GNU General Public License
class ocean1 {
    Noise ocean_noise => LPF ocean_lpf1 => Gain output;
    ocean_noise => LPF ocean_lpf2 => output;
}



// Attempt at rain sounds
// copyright 2008 Les Hall
// This software is protected by the GNU General Public License
class Les_Rain1 {
    Impulse i => LPF lpf => BPF bpf => Gain output;
    Noise n => bpf;
    lpf.freq (6000);
    bpf.freq (15000);
    bpf.Q (4);
    n.gain (0.3);
}


// Heavy downpour from a distance
class Les_Rain2 {
    Noise n => BPF bpf => Gain g => SinOsc osc1 => SinOsc osc2 => Gain output;
    bpf.freq (15000);
    bpf.Q (4);
    osc2 => g;
    g.gain (15000);
    osc1.sync (0);
    osc1.gain (15000);
    osc2.sync (0);
}



// Modedular version 0.2 testing
// by Kijjasak Triyanond (kijjaz) kijjaz@yahoo.com 

// [note] this is still quite experimental, so some functions might have problems
// some more features will be added soon.
// [fixes]
// * now the note function's code had been cleaned up
//   and is greatly reduced (in size) and optimized (generalized); the output is the same.
// * i've decided that the normal rotation should not rotate the whole mode data,
//   but instead set the offset of the readhead while using note function
//   the rotation can by 'Applied' so that it really rotate the interval array.
// * now chord is fully functional, check the test code to see chord in action           

// licence: Attribution-Share Alike 3.0
// You are free:
//    * to Share  to copy, distribute and transmit the work
//    * to Remix  to adapt the work
// Under the following conditions:
//    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
//    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same, similar or a compatible license.

class Modedular
{
    [0] @=> int intervals[]; // array of intervals in the mode
    0 => int octaveSize; // octave size in semitones
    0 => int rotationOffset; // for easy mode rotation
    
    fun int update()
    {
        // use this to octave Octave Size
        0 => octaveSize;
        for(int i; i < intervals.cap(); i++) intervals[i] +=> octaveSize;
    return octaveSize;
}
fun void set(int input[])
{
    // use this to copy intervals from the input array
    new int[input.cap()] @=> intervals;
    for(int i; i < input.cap(); i++) input[i] => intervals[i];
update();
}
fun void set(string input)
{
    // use this to set the mode to a preset value by a string
    if (input == "lydian") set([2,2,2,1,2,2,1]);
if (input == "ionian") set([2,2,1,2,2,2,1]);
if (input == "mixolydian") set([2,2,1,2,2,1,2]);
if (input == "dorian") set([2,1,2,2,2,1,2]);
if (input == "aeolian") set([2,1,2,2,1,2,2]);
if (input == "phrygian") set([1,2,2,2,1,2,2]);
if (input == "locrian") set([1,2,2,1,2,2,2]);

if (input == "harmonic minor") set([2,1,2,2,1,3,1]);
if (input == "melodic minor") set([2,1,2,2,2,2,1]);
update();
}
fun void get(int input[])
{
    // use this to copy to an outside array
    new int[input.cap()] @=> input;
    for(int i; i < input.cap(); i++) intervals[i] => input[i];
}

fun int note(int pitch)
{
    // use this to acquire note (calculated in semitones) from the mode
    // without octave input
    pitch--; // so user can start the first pitch from 1 instead of 0
    0 => int octave; // but we still have to use octave if pitch is negative
    
    // calculate pitch and octave for use the intervals array
    // by limiting pitch in rang 0..intervals.cap()-1 and adjust octave number
    if (pitch < 0) octave--;
pitch / intervals.cap() +=> octave;
(pitch - (pitch / intervals.cap() - 1) * intervals.cap()) % intervals.cap() => pitch;

0 => int sum;
// calculate semitones for the pitch
// with rootPosition for easy mode rotation
for(int i; i < pitch; i++) intervals[(i + rotationOffset) % intervals.cap()] +=> sum; 
octave * octaveSize +=> sum; // select desired octave
return sum; // and we'll have the result in semitone
}
fun int note(int pitch, int octave)
{
    // note, with octave number also
    return note(pitch) + octave * octaveSize;
}   

fun void rotate(int x)
{
    // rotate the mode x times        
    x +=> rotationOffset;
    (rotationOffset - (rotationOffset / intervals.cap() - 1) * intervals.cap()) % intervals.cap() => rotationOffset;
}
fun void setRotate(int x)
{
    // reset rotation point to x
    x => rotationOffset;
    (rotationOffset - (rotationOffset / intervals.cap() - 1) * intervals.cap()) % intervals.cap() => rotationOffset;
}
fun void rotateApply()
{
    // use current rotation offset to really rotate the interval array.
    // then reset the rotation offset.
    int dummy[intervals.cap()];
    for(int i; i < intervals.cap(); i++) intervals[(i + rotationOffset) % intervals.cap()] => dummy[i];
for(int i; i < intervals.cap(); i++) dummy[i] => intervals[i];
0 => rotationOffset;
}
fun void rotateApply(int x)
{
    // use in supplied number as the rotation offset, then really rotate the interval array.
    // then reset the rotation offset, also.        
    setRotate(x);
    rotateApply();
}

fun void chord(int root, int positions[], int result[])
{
    // make a chord from position list (chord degrees)
    for(int i; i < positions.cap() && i < result.cap(); i++)
    {
        note(root + positions[i] - 1) => result[i];
    }
}
fun void chord(int root, int octave, int positions[], int result[])
{
    // make a chord from position list, with octave
    for(int i; i < positions.cap() && i < result.cap(); i++)
    {
        note(root + positions[i] - 1) + octave * octaveSize => result[i];
    }
}   
}











// Synth Lab
// copyright 2008 Les Hall
// This software is protected by the GNU General Public License


// make the whole thing be a class
class Synth_Lab {
    
    
    // parameter default values for introductory configuration screen controls
    15 => int num_nodes;  // number of nodes available for connection
    8 => int num_gains;  // number of gains
    3 => int num_osc;  // number of oscillators
    2 => int num_filters;  // number of filters
    2 => int num_delays;  // number of delay lines
    1 => int num_reverbs;  // number of reverbs
    1 => int num_counters; // number of counters
    8 => int num_bits;  // number of bits in each counter
    1 => int num_rects;  // number of rectifiers
    1 => int num_zerox;  // number of zero crossing detectors
    3 => int num_envelopes;  // number of envelope generators
    8 => int num_logic_gates;  // number of logic gates
    3 => int num_logic_inputs;  // number of inputs to each logic gate
    1 => int num_dynos;  // number of dynos
    1 => int num_echos;  // number of echos
    140 => int slot_width;  // width in pixels of each card slot, increase for better slider resolution
    1280 => int screen_width;  // horizontal size of screen
    960 => int screen_height;  // vertical size of screen
    1 => int misc_view_select;  // enable/disable misc view
    1 => int patch_view_select;  // enable/disable patch view
    1 => int kbd_view_select;  // enable/disable kbd view
    1 => int lisa_view_select;  // enable/disable lisa view
    
    
    // define the intro screen page
    MAUI_View intro_view;
    intro_view.size (3 * slot_width, 525);
    intro_view.position (screen_width / 2 - 3 * slot_width / 2, screen_height / 2 - 525 / 2);
    intro_view.name ("Synth Lab Configuration");
    
    // define the intro controls
    MAUI_Slider intro_num_nodes;
    MAUI_Slider intro_num_gains;
    MAUI_Slider intro_misc_view;
    MAUI_Slider intro_num_osc;
    MAUI_Slider intro_num_filters;
    MAUI_Slider intro_patch_view;
    MAUI_Slider intro_num_delays;
    MAUI_Slider intro_num_reverbs;
    MAUI_Slider intro_kbd_view;
    MAUI_Slider intro_num_counters;
    MAUI_Slider intro_num_bits;
    MAUI_Slider intro_lisa_view;
    MAUI_Slider intro_num_rects;
    MAUI_Slider intro_num_zerox;
    MAUI_Slider intro_num_envelopes;
    MAUI_Slider intro_num_dynos;
    MAUI_Slider intro_num_logic_gates;
    MAUI_Slider intro_num_logic_inputs;
    MAUI_Slider intro_num_echos;
    MAUI_Slider intro_slot_width;
    MAUI_Slider intro_screen_height;
    MAUI_Slider intro_screen_width;
    MAUI_Button intro_begin;
    
    // Set up the intro controls
    // num_nodes
    intro_num_nodes.name ("Nodes");
    intro_num_nodes.range (0, 40);
    intro_num_nodes.value (num_nodes);
    intro_num_nodes.size (slot_width, 75);
    intro_num_nodes.position (0, 0);
    intro_num_nodes.displayFormat (intro_num_nodes.integerFormat);
    intro_view.addElement (intro_num_nodes);
    // num_gains
    intro_num_gains.name ("Gains");
    intro_num_gains.range (0, 20);
    intro_num_gains.value (num_gains);
    intro_num_gains.size (slot_width, 75);
    intro_num_gains.position (slot_width, 0);
    intro_num_gains.displayFormat (intro_num_gains.integerFormat);
    intro_view.addElement (intro_num_gains);
    // misc_view_select
    intro_misc_view.name ("Misc View");
    intro_misc_view.range (0, 1);
    intro_misc_view.value (misc_view_select);
    intro_misc_view.size (slot_width, 75);
    intro_misc_view.position (2 * slot_width, 0);
    intro_misc_view.displayFormat (intro_misc_view.integerFormat);
    intro_view.addElement (intro_misc_view);
    // num_osc
    intro_num_osc.name ("Oscillators");
    intro_num_osc.range (0, 10);
    intro_num_osc.value (num_osc);
    intro_num_osc.size (slot_width, 75);
    intro_num_osc.position (0, 50);
    intro_num_osc.displayFormat (intro_num_osc.integerFormat);
    intro_view.addElement (intro_num_osc);
    // num_filters
    intro_num_filters.name ("Filters");
    intro_num_filters.range (0, 10);
    intro_num_filters.value (num_filters);
    intro_num_filters.size (slot_width, 75);
    intro_num_filters.position (slot_width, 50);
    intro_num_filters.displayFormat (intro_num_filters.integerFormat);
    intro_view.addElement (intro_num_filters);
    // patch_view_select
    intro_patch_view.name ("Patch View");
    intro_patch_view.range (0, 1);
    intro_patch_view.value (patch_view_select);
    intro_patch_view.size (slot_width, 75);
    intro_patch_view.position (2 * slot_width, 50);
    intro_patch_view.displayFormat (intro_patch_view.integerFormat);
    intro_view.addElement (intro_patch_view);
    // num_delays
    intro_num_delays.name ("Delays");
    intro_num_delays.range (0, 10);
    intro_num_delays.value (num_delays);
    intro_num_delays.size (slot_width, 75);
    intro_num_delays.position (0, 100);
    intro_num_delays.displayFormat (intro_num_delays.integerFormat);
    intro_view.addElement (intro_num_delays);
    // num_reverbs
    intro_num_reverbs.name ("Reverbs");
    intro_num_reverbs.range (0, 10);
    intro_num_reverbs.value (num_reverbs);
    intro_num_reverbs.size (slot_width, 75);
    intro_num_reverbs.position (slot_width, 100);
    intro_num_reverbs.displayFormat (intro_num_reverbs.integerFormat);
    intro_view.addElement (intro_num_reverbs);
    // kbd_view_select
    intro_kbd_view.name ("Keyboard View");
    intro_kbd_view.range (0, 1);
    intro_kbd_view.value (kbd_view_select);
    intro_kbd_view.size (slot_width, 75);
    intro_kbd_view.position (2 * slot_width, 100);
    intro_kbd_view.displayFormat (intro_kbd_view.integerFormat);
    intro_view.addElement (intro_kbd_view);
    // num_counters
    intro_num_counters.name ("Counters");
    intro_num_counters.range (0, 10);
    intro_num_counters.value (num_counters);
    intro_num_counters.size (slot_width, 75);
    intro_num_counters.position (0, 150);
    intro_num_counters.displayFormat (intro_num_counters.integerFormat);
    intro_view.addElement (intro_num_counters);
    // num_bits
    intro_num_bits.name ("Counter Bits");
    intro_num_bits.range (1, 16);
    intro_num_bits.value (num_bits);
    intro_num_bits.size (slot_width, 75);
    intro_num_bits.position (slot_width, 150);
    intro_num_bits.displayFormat (intro_num_bits.integerFormat);
    intro_view.addElement (intro_num_bits);
    // lisa_view_select
    intro_lisa_view.name ("LiSa View");
    intro_lisa_view.range (0, 1);
    intro_lisa_view.value (kbd_view_select);
    intro_lisa_view.size (slot_width, 75);
    intro_lisa_view.position (2 * slot_width, 150);
    intro_lisa_view.displayFormat (intro_lisa_view.integerFormat);
    intro_view.addElement (intro_lisa_view);
    // num_rects
    intro_num_rects.name ("Rectifiers");
    intro_num_rects.range (0, 10);
    intro_num_rects.value (num_rects);
    intro_num_rects.size (slot_width, 75);
    intro_num_rects.position (0, 200);
    intro_num_rects.displayFormat (intro_num_rects.integerFormat);
    intro_view.addElement (intro_num_rects);
    // num_zerox
    intro_num_zerox.name ("ZeroX");
    intro_num_zerox.range (0, 10);
    intro_num_zerox.value (num_zerox);
    intro_num_zerox.size (slot_width, 75);
    intro_num_zerox.position (slot_width, 200);
    intro_num_zerox.displayFormat (intro_num_zerox.integerFormat);
    intro_view.addElement (intro_num_zerox);
    // num_envelopes
    intro_num_envelopes.name ("Envelopes");
    intro_num_envelopes.range (0, 10);
    intro_num_envelopes.value (num_envelopes);
    intro_num_envelopes.size (slot_width, 75);
    intro_num_envelopes.position (0, 250);
    intro_num_envelopes.displayFormat (intro_num_envelopes.integerFormat);
    intro_view.addElement (intro_num_envelopes);
    // num_dynos
    intro_num_dynos.name ("Dynos");
    intro_num_dynos.range (0, 10);
    intro_num_dynos.value (num_dynos);
    intro_num_dynos.size (slot_width, 75);
    intro_num_dynos.position (slot_width, 250);
    intro_num_dynos.displayFormat (intro_num_dynos.integerFormat);
    intro_view.addElement (intro_num_dynos);
    // num_logic_gates
    intro_num_logic_gates.name ("Logic Gates");
    intro_num_logic_gates.range (0, 10);
    intro_num_logic_gates.value (num_logic_gates);
    intro_num_logic_gates.size (slot_width, 75);
    intro_num_logic_gates.position (0, 300);
    intro_num_logic_gates.displayFormat (intro_num_logic_gates.integerFormat);
    intro_view.addElement (intro_num_logic_gates);
    // num_logic_inputs
    intro_num_logic_inputs.name ("Logic Inputs");
    intro_num_logic_inputs.range (1, 10);
    intro_num_logic_inputs.value (num_logic_inputs);
    intro_num_logic_inputs.size (slot_width, 75);
    intro_num_logic_inputs.position (slot_width, 300);
    intro_num_logic_inputs.displayFormat (intro_num_logic_inputs.integerFormat);
    intro_view.addElement (intro_num_logic_inputs);
    // num_echos
    intro_num_echos.name ("Echos");
    intro_num_echos.range (0, 10);
    intro_num_echos.value (num_echos);
    intro_num_echos.size (slot_width, 75);
    intro_num_echos.position (0, 350);
    intro_num_echos.displayFormat (intro_num_echos.integerFormat);
    intro_view.addElement (intro_num_echos);
    // slot_width
    intro_slot_width.name ("Slot Width");
    intro_slot_width.range (140, 300);
    intro_slot_width.value (slot_width);
    intro_slot_width.size (slot_width, 75);
    intro_slot_width.position (slot_width, 350);
    intro_slot_width.displayFormat (intro_slot_width.integerFormat);
    intro_view.addElement (intro_slot_width);
    // screen_width
    intro_screen_width.name ("Screen W");
    intro_screen_width.range (1000, 4000);
    intro_screen_width.value (screen_width);
    intro_screen_width.size (slot_width, 75);
    intro_screen_width.position (0, 400);
    intro_screen_width.displayFormat (intro_screen_width.integerFormat);
    intro_view.addElement (intro_screen_width);
    // screen_height
    intro_screen_height.name ("Screen H");
    intro_screen_height.range (800, 2000);
    intro_screen_height.value (screen_height);
    intro_screen_height.size (slot_width, 75);
    intro_screen_height.position (slot_width, 400);
    intro_screen_height.displayFormat (intro_screen_height.integerFormat);
    intro_view.addElement (intro_screen_height);
    // begin button
    intro_begin.pushType ();
    intro_begin.size (3 * slot_width, 60);
    intro_begin.position (0, 460);
    intro_begin.name ("Begin Synth Lab");
    intro_view.addElement (intro_begin);
    
    // display the intro panel
    intro_view.display ();
    
    // wait for the user to press the begin button, then record variables
    intro_begin => now;
    intro_num_nodes.value () $ int => num_nodes;
    intro_num_gains.value () $ int => num_gains;
    intro_misc_view.value () $ int => misc_view_select;
    intro_num_osc.value () $ int => num_osc;
    intro_num_filters.value () $ int => num_filters;
    intro_patch_view.value () $ int => patch_view_select;
    intro_num_delays.value () $ int => num_delays;
    intro_num_reverbs.value () $ int => num_reverbs;
    intro_kbd_view.value () $ int => kbd_view_select;
    intro_num_counters.value () $ int => num_counters;
    intro_num_bits.value () $ int => num_bits;
    intro_lisa_view.value () $ int => lisa_view_select;
    intro_num_rects.value () $ int => num_rects;
    intro_num_zerox.value () $ int => num_zerox;
    intro_num_envelopes.value () $ int => num_envelopes;
    intro_num_dynos.value () $ int => num_dynos;
    intro_num_logic_gates.value () $ int => num_logic_gates;
    intro_num_logic_inputs.value () $ int => num_logic_inputs;
    intro_num_echos.value () $ int => num_echos;
    intro_slot_width.value () $ int => slot_width;
    intro_screen_height.value () $ int => screen_height;
    intro_screen_width.value () $ int => screen_width;
    
    // destroy the intro screen;
    intro_view.destroy ();
    
    
    // variables
    // note must be defined after defaults are set so arrays can be sized correctly
    int exit;  // 1 to indicate an exit when self-destruct is pressed
    dur clock_period;  // system clock, for shreds that run continuously
    dur note_period;  // 1 / notes per second, for note playing delays
    float node_boost_val[num_nodes+1];  // boost value for nodes
    int mic_out;  // output node of microphone
    int dac_left_in;  // left input node of dac
    int dac_right_in;  // right input node of dac
    int gain_boost_val[num_gains];  // boost value for gains
    int gain_in[num_gains];  // the previous value of input node
    int gain_out[num_gains];  // the previous value of output node
    int osc_sel[num_osc];  // the selected oscillators
    int osc_in[num_osc];  // the previous value of input node
    int osc_out[num_osc];  // the previous value of output node
    int filter_sel[num_filters];  // the selected filters
    int filter_in[num_filters];  // the previous value of input node
    int filter_out[num_filters];  // the previous value of output node
    int filter_wah[num_filters];  // the previous value of wahwah node
    int delay_sel[num_delays];  // the selected delays
    int delay_in[num_delays];  // the previous value of input node
    int delay_out[num_delays];  // the previous value of output node
    int reverb_sel[num_reverbs];  // the selected reverbs
    int reverb_in[num_reverbs];  // the previous value of input node
    int reverb_out[num_reverbs];  // the previous value of output node
    int counter_in[num_counters];  // the previous value of the input node
    int counter_out[num_counters][num_bits];  // the previous value of the output node
    int envelope_in[num_envelopes];  // the previous value of input node
    int envelope_out[num_envelopes];  // the previous value of output node
    int envelope_trig[num_envelopes];  // the previous value of trigger node
    int noise_out;  // the previous value of output node
    int pitshift_in;  // the previous value of input node
    int pitshift_out;  // the previous value of output node
    int rect_sel[num_rects];  // the selected rectifiers
    int rect_in[num_rects];  // the previous value of input node
    int rect_out[num_rects];  // the previous value of output node
    int zerox_in[num_zerox];  // the previous value of input node
    int zerox_out[num_zerox];  // the previous value of output node
    int kbd_out;  // the previous value of output node
    0 => int kbd_device;  // device number of the keyboard
    10::ms => dur kbd_env_dur;  // keyboard envelope duration
    int logic_gate_sel[num_logic_gates];  // the selected logic gates
    int logic_gate_in[num_logic_gates][num_logic_inputs];  // the previous value of input node
    int logic_gate_out[num_logic_gates];  // the previous value of output node
    int dyno_sel[num_dynos];  // the selected dynos
    int dyno_in[num_dynos];  // the previous value of input node
    int dyno_out[num_dynos];  // the previous value of output node
    int echo_in[num_echos];  // the previous value of input node
    int echo_out[num_echos];  // the previous value of output node
    int lisa_voice_in;  // the previous value of input node
    int lisa_rate_in;  // the previous value of input node
    int lisa_clear_in;  // the previous value of input node
    int lisa_record_in;  // the previous value of input node
    int lisa_play_in;  // the previous value of input node
    int lisa_backward_in;  // the previous value of input node
    int lisa_in;  // the previous value of input node
    int lisa_out;  // the previous value of output node
    100::ms => dur lisa_ramp_duration;  // duration of rampUp and rampDown
    1::minute => dur lisa_buffer_duration;  // lisa buffer size
    10 => int lisa_max_voices;  // number of voices to use in lisa (hard limit 200)
    int guitar_lab_out;  // the previous value of output node
    
    
    // define the pages
    MAUI_View main_view;
    main_view.size (2 * slot_width, 500);
    main_view.position (0, screen_height - 500);
    main_view.name ("Synth Lab");
    MAUI_View node_view;
    node_view.size (3 * slot_width, 50 * num_nodes + 25);
    node_view.position (screen_width - 3 * slot_width - 50, screen_height - (50 * num_nodes + 25));
    node_view.name ("Nodes");
    MAUI_View gain_view;
    gain_view.size (num_gains * slot_width, 175);
    gain_view.position (0, 50);
    gain_view.name ("Gains");
    MAUI_View osc_view;
    osc_view.size (num_osc * slot_width, 475);
    osc_view.position (screen_width - (num_osc +3) * slot_width, screen_height - 475 - 100);
    osc_view.name ("Oscillators");
    MAUI_View filter_view;
    filter_view.size (num_filters * slot_width, 475);
    filter_view.position (2 * slot_width, screen_height - 475 - 300);
    filter_view.name ("Filters");
    MAUI_View delay_view;
    delay_view.size (num_delays * slot_width, 275);
    delay_view.position (50, screen_height - 300 - 275);
    delay_view.name ("Delays");
    MAUI_View reverb_view;
    reverb_view.size (num_reverbs * slot_width, 225);
    reverb_view.position (0, screen_height - 300 - 275 - 225);
    reverb_view.name ("Reverbs");
    MAUI_View counter_view;
    counter_view.size (num_counters * slot_width, (3 + num_bits) * 50 + 10);
    counter_view.position (screen_width - (num_counters + 3) * slot_width, 50);
    counter_view.name ("Counters");
    MAUI_View envelope_view;
    envelope_view.size (num_envelopes * slot_width, 275);
    envelope_view.position (slot_width, screen_height - 300 - 275);
    envelope_view.name ("Envelopes");
    MAUI_View misc_view;
    misc_view.size ((2 + num_rects + num_zerox) * slot_width, 275);
    misc_view.position (2 * slot_width, screen_height - 275 - 100);
    misc_view.name ("Misc.");
    MAUI_View kbd_view;
    kbd_view.size (slot_width, 175);
    kbd_view.position (slot_width, 200);
    kbd_view.name ("Keyboard");
    MAUI_View logic_gate_view;
    logic_gate_view.size (num_logic_gates * slot_width, (2 + num_logic_inputs) * 50 + 25);
    logic_gate_view.position (screen_width - num_logic_gates * slot_width, 50);
    logic_gate_view.name ("Logic Gates");
    MAUI_View dyno_view;
    dyno_view.size (num_dynos * slot_width, 175);
    dyno_view.position (screen_width - num_dynos * slot_width, screen_height - 175);
    dyno_view.name ("Dynos");
    MAUI_View echo_view;
    echo_view.size (num_echos * slot_width, 275);
    echo_view.position (screen_width - (num_dynos + num_echos) * slot_width, screen_height - 275);
    echo_view.name ("Echos");
    MAUI_View led_view;
    led_view.size (num_nodes * 50 + 25, 100);
    led_view.position (screen_width / 2 - (num_nodes * 50 + 25) / 2, screen_height - 100);
    led_view.name ("Node Logic Values");
    MAUI_View patch_view;
    patch_view.size ((2 + num_nodes) * 35, (2 + num_nodes) * 35 + 20);
    patch_view.position (0, screen_height / 2 - ((2 + num_nodes) * 35 + 20) / 2);
    patch_view.name ("Patch Matrix");
    MAUI_View lisa_view;
    lisa_view.size (2 * slot_width, 425);
    lisa_view.position (screen_width - 2 * slot_width, screen_height/2 - 425 / 2);
    lisa_view.name ("LiSa Live Sampling Utility");
    
    
    // control declarations
    // main panel controls
    MAUI_Slider main_volume;
    MAUI_Button main_record;
    MAUI_Button main_playback;
    MAUI_Slider main_clock_freq;
    MAUI_Slider main_note_freq;
    MAUI_Button main_copyright;
    MAUI_Button main_credits;
    MAUI_Button main_self_destruct;
    MAUI_Slider main_mic_output;
    MAUI_Slider main_dac_left_input;
    MAUI_Slider main_dac_right_input;
    MAUI_Button main_fortune_cookie;
    MAUI_Slider guitar_lab_output;
    // node controls
    MAUI_Slider node_gain[num_nodes+1];
    MAUI_Button node_boost[num_nodes+1];
    MAUI_Slider node_op[num_nodes+1];
    // gain controls
    MAUI_Slider gain_input[num_gains];
    MAUI_Slider gain_output[num_gains];
    MAUI_Slider gain_gain[num_gains];
    // oscillator controls
    MAUI_Button osc_label[num_osc];
    MAUI_Slider osc_input[num_osc];
    MAUI_Slider osc_output[num_osc];
    MAUI_Slider osc_gain[num_osc];
    MAUI_Slider osc_freq1[num_osc];
    MAUI_Slider osc_freq2[num_osc];
    MAUI_Slider osc_phase[num_osc];
    MAUI_Slider osc_width[num_osc];
    MAUI_Slider osc_sync[num_osc];
    // filter panel controls
    MAUI_Button filter_label[num_filters];
    MAUI_Slider filter_input[num_filters];
    MAUI_Slider filter_output[num_filters];
    MAUI_Slider filter_wahwah[num_filters];
    MAUI_Slider filter_gain[num_filters];
    MAUI_Slider filter_freq1[num_filters];
    MAUI_Slider filter_freq2[num_filters];
    MAUI_Slider filter_q[num_filters];
    MAUI_Button filter_reset;
    // delay panel controls
    MAUI_Button delay_label[num_delays];
    MAUI_Slider delay_input[num_delays];
    MAUI_Slider delay_output[num_delays];
    MAUI_Slider delay_gain[num_delays];
    MAUI_Slider delay_dur[num_delays];
    // reverb panel controls
    MAUI_Button reverb_label[num_reverbs];
    MAUI_Slider reverb_input[num_reverbs];
    MAUI_Slider reverb_output[num_reverbs];
    MAUI_Slider reverb_mix[num_reverbs];
    // counter panel controls
    MAUI_Button counter_label[num_counters];
    MAUI_Slider counter_input[num_counters];
    MAUI_Slider counter_output[num_counters][num_bits];
    MAUI_Button counter_pk2pk[num_counters];
    // envelope panel controls
    MAUI_Button envelope_label[num_envelopes];
    MAUI_Slider envelope_input[num_envelopes];
    MAUI_Slider envelope_output[num_envelopes];
    MAUI_Slider envelope_trigger[num_envelopes];
    MAUI_Slider envelope_duration[num_envelopes];
    // misc panel controls
    MAUI_Button noise_label;
    MAUI_Slider noise_output;
    MAUI_Slider noise_gain;
    MAUI_Button pitshift_label;
    MAUI_Slider pitshift_input;
    MAUI_Slider pitshift_output;
    MAUI_Slider pitshift_mix;
    MAUI_Slider pitshift_shift;
    MAUI_Button rect_label[num_rects];
    MAUI_Slider rect_input[num_rects];
    MAUI_Slider rect_output[num_rects];
    MAUI_Button zerox_label[num_zerox];
    MAUI_Slider zerox_input[num_zerox];
    MAUI_Slider zerox_output[num_zerox];
    // keyboard panel controls
    MAUI_Button kbd_label;
    MAUI_Slider kbd_output;
    MAUI_Slider kbd_base_note;
    // logic gate panel controls
    MAUI_Button logic_gate_label[num_logic_gates];
    MAUI_Slider logic_gate_input[num_logic_gates][num_logic_inputs];
    MAUI_Slider logic_gate_output[num_logic_gates];
    // dyno panel controls
    MAUI_Button dyno_label[num_dynos];
    MAUI_Slider dyno_input[num_dynos];
    MAUI_Slider dyno_output[num_dynos];
    // echo panel controls
    MAUI_Button echo_label[num_echos];
    MAUI_Slider echo_input[num_echos];
    MAUI_Slider echo_output[num_echos];
    MAUI_Slider echo_delay[num_echos];
    MAUI_Slider echo_mix[num_echos];
    // led panel controls
    MAUI_Button led_label[num_nodes];
    MAUI_LED led_led[num_nodes];
    // patch panel controls
    MAUI_Button patch_dot[num_nodes][num_nodes];
    MAUI_Button patch_x_label[num_nodes];
    MAUI_Button patch_y_label[num_nodes];
    MAUI_Button patch_connect;
    // lisa panel controls
    MAUI_Slider lisa_voice;
    MAUI_Slider lisa_voice_input;
    MAUI_Slider lisa_rate;
    MAUI_Slider lisa_rate_input;
    MAUI_Button lisa_clear;
    MAUI_Slider lisa_clear_input;
    MAUI_Button lisa_record;
    MAUI_Slider lisa_record_input;
    MAUI_Button lisa_play;
    MAUI_Slider lisa_play_input;
    MAUI_Button lisa_backward;
    MAUI_Slider lisa_backward_input;
    MAUI_Slider lisa_input;
    MAUI_Slider lisa_output;
    
    
    // main panel controls
    // main volume slider
    main_volume.name ("Volume");
    main_volume.range (0, 1);
    main_volume.value (0.5);
    main_volume.size (slot_width, 75);
    main_volume.position (0, 0);
    main_view.addElement (main_volume);
    // main clock frequency slider
    main_clock_freq.name ("Clock, Hz");
    main_clock_freq.range (1, 1000);
    main_clock_freq.value (100);
    main_clock_freq.size (slot_width, 75);
    main_clock_freq.position (0, 50);
    main_clock_freq.displayFormat (main_clock_freq.integerFormat);
    main_view.addElement (main_clock_freq);
    // main note frequency slider
    main_note_freq.name ("Notes/Sec");
    main_note_freq.range (1, 10);
    main_note_freq.value (4);
    main_note_freq.size (slot_width, 75);
    main_note_freq.position (0, 100);
    main_note_freq.displayFormat (main_note_freq.integerFormat);
    main_view.addElement (main_note_freq);
    // main record button
    main_record.toggleType ();
    main_record.size (slot_width, 60);
    main_record.position (0, 170);
    main_record.name ("Record");
    main_view.addElement (main_record);
    // main playback button
    main_playback.pushType ();
    main_playback.size (slot_width, 60);
    main_playback.position (slot_width, 170);
    main_playback.name ("Playback");
    main_view.addElement (main_playback);
    // main copyright button
    main_copyright.toggleType ();
    main_copyright.size (2*slot_width, 60);
    main_copyright.position (0, 220);
    main_copyright.name ("Copyright 2008 Les Hall");
    main_view.addElement (main_copyright);
    // main credits button
    main_credits.toggleType ();
    main_credits.size (2*slot_width, 60);
    main_credits.position (0, 270);
    main_credits.name ("Thanks to www.electro-music.com");
    main_view.addElement (main_credits);
    // main fortune cookie button
    main_fortune_cookie.toggleType ();
    main_fortune_cookie.size (2*slot_width, 60);
    main_fortune_cookie.position (0, 320);
    main_fortune_cookie.name ("Fortune Cookie");
    main_view.addElement (main_fortune_cookie);
    // main self-destruct button
    main_self_destruct.pushType ();
    main_self_destruct.size (2 * slot_width, 60);
    main_self_destruct.position (0, 370);
    main_self_destruct.name ("Self Destruct");
    main_view.addElement (main_self_destruct);
    // main mic output node slider
    main_mic_output.name ("Mic Output");
    main_mic_output.range (0, num_nodes);
    main_mic_output.value (0);
    main_mic_output.size (slot_width, 75);
    main_mic_output.position (slot_width, 0);
    main_mic_output.displayFormat (main_mic_output.integerFormat);
    main_view.addElement (main_mic_output);
    // main dac left output node slider
    main_dac_left_input.name ("DAC Left");
    main_dac_left_input.range (0, num_nodes);
    main_dac_left_input.value (num_nodes);
    main_dac_left_input.size (slot_width, 75);
    main_dac_left_input.position (slot_width, 50);
    main_dac_left_input.displayFormat (main_dac_left_input.integerFormat);
    main_view.addElement (main_dac_left_input);
    // main dac right output node slider
    main_dac_right_input.name ("DAC Right");
    main_dac_right_input.range (0, num_nodes);
    main_dac_right_input.value (num_nodes);
    main_dac_right_input.size (slot_width, 75);
    main_dac_right_input.position (slot_width, 100);
    main_dac_right_input.displayFormat (main_dac_right_input.integerFormat);
    main_view.addElement (main_dac_right_input);
    // guitar lab output node slider
    guitar_lab_output.name ("Guitar Lab Output Node");
    guitar_lab_output.range (0, num_nodes);
    guitar_lab_output.value (0);
    guitar_lab_output.size (2 * slot_width, 75);
    guitar_lab_output.position (0, 420);
    guitar_lab_output.displayFormat (guitar_lab_output.integerFormat);
    main_view.addElement (guitar_lab_output);
    
    
    // nodes
    for (1 => int n; n <= num_nodes; n++) {
        // node gain slider
        node_gain[n].name ("Gain " + n);
        node_gain[n].range (-1, 1);
        node_gain[n].value (1);
        node_gain[n].size (slot_width, 75);
        node_gain[n].position (0, 50 * (n - 1));
        node_view.addElement (node_gain[n]);
        // node boost button
        node_boost[n].pushType ();
        node_boost[n].size (slot_width, 60);
        node_boost[n].position (slot_width, 50 * (n -1) + 10);
        node_boost[n].name ("x1");
        node_view.addElement (node_boost[n]);
        // node op slider
        node_op[n].name ("op " + n);
        node_op[n].range (-1, 4);
        node_op[n].value (1);
        node_op[n].size (slot_width, 75);
        node_op[n].position (2 * slot_width, 50 * (n - 1));
        node_op[n].displayFormat (node_op[n].integerFormat);
        node_view.addElement (node_op[n]);
    }
    
    
    // gains
    for (0 => int g; g < num_gains; g++) {
        // gain input node slider
        gain_input[g].name ("Input Node");
        gain_input[g].range (0, num_nodes);
        gain_input[g].value (0);
        gain_input[g].size (slot_width, 75);
        gain_input[g].position (slot_width * g, 0);
        gain_input[g].displayFormat (gain_input[g].integerFormat);
        gain_view.addElement (gain_input[g]);
        // gain output node slider
        gain_output[g].name ("Output Node");
        gain_output[g].range (0, num_nodes);
        gain_output[g].value (0);
        gain_output[g].size (slot_width, 75);
        gain_output[g].position (slot_width * g, 50);
        gain_output[g].displayFormat (gain_output[g].integerFormat);
        gain_view.addElement (gain_output[g]);
        // gain gain slider
        gain_gain[g].name ("Gain " + g);
        gain_gain[g].range (-1, 1);
        gain_gain[g].value (1);
        gain_gain[g].size (slot_width, 75);
        gain_gain[g].position (slot_width * g, 100);
        gain_view.addElement (gain_gain[g]);
    }
    
    
    // oscillators
    for (0 => int o; o < num_osc; o++) {
        // initialize oscillator selection
        1 => osc_sel[o];
        // osc label button
        osc_label[o].pushType ();
        osc_label[o].size (slot_width, 60);
        osc_label[o].position (slot_width*o, 0);
        osc_label[o].name ("SinOsc " + o);
        osc_view.addElement (osc_label[o]);
        // osc input node slider
        osc_input[o].name ("Input Node");
        osc_input[o].range (0, num_nodes);
        osc_input[o].value (0);
        osc_input[o].size (slot_width, 75);
        osc_input[o].position (slot_width*o, 50);
        osc_input[o].displayFormat (osc_input[o].integerFormat);
        osc_view.addElement (osc_input[o]);
        // osc output node slider
        osc_output[o].name ("Output Node");
        osc_output[o].range (0, num_nodes);
        osc_output[o].value (0);
        osc_output[o].size (slot_width, 75);
        osc_output[o].position (slot_width*o, 100);
        osc_output[o].displayFormat (osc_output[o].integerFormat);
        osc_view.addElement (osc_output[o]);
        // osc gain slider
        osc_gain[o].name ("Gain");
        osc_gain[o].range (-1, 1);
        osc_gain[o].value (1);
        osc_gain[o].size (slot_width, 75);
        osc_gain[o].position (slot_width*o, 150);
        osc_view.addElement (osc_gain[o]);
        // osc freq1 slider
        osc_freq1[o].name ("Freq");
        osc_freq1[o].range (0, 10);
        osc_freq1[o].value (5);
        osc_freq1[o].size (slot_width, 75);
        osc_freq1[o].position (slot_width*o, 200);
        osc_view.addElement (osc_freq1[o]);
        // osc freq2 slider
        osc_freq2[o].name ("Freq Exp");
        osc_freq2[o].range (-2, 4);
        osc_freq2[o].value (2);
        osc_freq2[o].size (slot_width, 75);
        osc_freq2[o].position (slot_width*o, 250);
        osc_freq2[o].displayFormat (osc_freq2[o].integerFormat);
        osc_view.addElement (osc_freq2[o]);
        // osc phase slider
        osc_phase[o].name ("Phase");
        osc_phase[o].range (0, 2*pi);
        osc_phase[o].value (0);
        osc_phase[o].size (slot_width, 75);
        osc_phase[o].position (slot_width*o, 300);
        osc_view.addElement (osc_phase[o]);
        // osc width slider
        osc_width[o].name ("Width");
        osc_width[o].range (0, 1);
        osc_width[o].value (0.5);
        osc_width[o].size (slot_width, 75);
        osc_width[o].position (slot_width*o, 350);
        osc_view.addElement (osc_width[o]);
        // osc synch slider
        osc_sync[o].name ("Sync");
        osc_sync[o].range (0, 2);
        osc_sync[o].value (0);
        osc_sync[o].size (slot_width, 75);
        osc_sync[o].position (slot_width*o, 400);
        osc_sync[o].displayFormat (osc_sync[o].integerFormat);
        osc_view.addElement (osc_sync[o]);
    }
    
    
    // filters
    for (0 => int f; f < num_filters; f++) {
        // initialize filter selection
        0 => filter_sel[f];
        // filter label button
        filter_label[f].pushType ();
        filter_label[f].size (slot_width, 60);
        filter_label[f].position (slot_width*f, 0);
        filter_label[f].name ("LPF " + f);
        filter_view.addElement (filter_label[f]);
        // filter input node slider
        filter_input[f].name ("Input Node");
        filter_input[f].range (0, num_nodes);
        filter_input[f].value (0);
        filter_input[f].size (slot_width, 75);
        filter_input[f].position (slot_width*f, 50);
        filter_input[f].displayFormat (filter_input[f].integerFormat);
        filter_view.addElement (filter_input[f]);
        // filter output node slider
        filter_output[f].name ("Output Node");
        filter_output[f].range (0, num_nodes);
        filter_output[f].value (0);
        filter_output[f].size (slot_width, 75);
        filter_output[f].position (slot_width*f, 100);
        filter_output[f].displayFormat (filter_output[f].integerFormat);
        filter_view.addElement (filter_output[f]);
        // filter output node slider
        filter_wahwah[f].name ("WahWah Node");
        filter_wahwah[f].range (0, num_nodes);
        filter_wahwah[f].value (0);
        filter_wahwah[f].size (slot_width, 75);
        filter_wahwah[f].position (slot_width*f, 150);
        filter_wahwah[f].displayFormat (filter_wahwah[f].integerFormat);
        filter_view.addElement (filter_wahwah[f]);
        // filter gain slider
        filter_gain[f].name ("Gain");
        filter_gain[f].range (-1, 1);
        filter_gain[f].value (1);
        filter_gain[f].size (slot_width, 75);
        filter_gain[f].position (slot_width*f, 200);
        filter_view.addElement (filter_gain[f]);
        // filter freq1 slider
        filter_freq1[f].name ("Freq");
        filter_freq1[f].range (0, 10);
        filter_freq1[f].value (5);
        filter_freq1[f].size (slot_width, 75);
        filter_freq1[f].position (slot_width*f, 250);
        filter_view.addElement (filter_freq1[f]);
        // filter freq2 slider
        filter_freq2[f].name ("Freq Exp");
        filter_freq2[f].range (-2, 4);
        filter_freq2[f].value (2);
        filter_freq2[f].size (slot_width, 75);
        filter_freq2[f].position (slot_width*f, 300);
        filter_freq2[f].displayFormat (filter_freq2[f].integerFormat);
        filter_view.addElement (filter_freq2[f]);
        // filter Q slider
        filter_q[f].name ("Q");
        filter_q[f].range (0, 50);
        filter_q[f].value (4);
        filter_q[f].size (slot_width, 75);
        filter_q[f].position (slot_width*f, 350);
        filter_q[f].displayFormat (filter_q[f].integerFormat);
        filter_view.addElement (filter_q[f]);
    }
    // filter reset button
    filter_reset.pushType ();
    filter_reset.size (num_filters * slot_width, 60);
    filter_reset.position (0, 410);
    filter_reset.name ("Reset Q's");
    filter_view.addElement (filter_reset);
    
    
    // delays
    for (0 => int d; d < num_delays; d++) {
        // initialize delay selection
        0 => delay_sel[d];
        // delay label button
        delay_label[d].pushType ();
        delay_label[d].size (slot_width, 60);
        delay_label[d].position (slot_width*d, 0);
        delay_label[d].name ("Delay " + d);
        delay_view.addElement (delay_label[d]);
        // delay input node slider
        delay_input[d].name ("Input Node");
        delay_input[d].range (0, num_nodes);
        delay_input[d].value (0);
        delay_input[d].size (slot_width, 75);
        delay_input[d].position (slot_width*d, 50);
        delay_input[d].displayFormat (delay_input[d].integerFormat);
        delay_view.addElement (delay_input[d]);
        // delay output node slider
        delay_output[d].name ("Output Node");
        delay_output[d].range (0, num_nodes);
        delay_output[d].value (0);
        delay_output[d].size (slot_width, 75);
        delay_output[d].position (slot_width*d, 100);
        delay_output[d].displayFormat (delay_output[d].integerFormat);
        delay_view.addElement (delay_output[d]);
        // delay gain slider
        delay_gain[d].name ("Gain");
        delay_gain[d].range (-1, 1);
        delay_gain[d].value (1);
        delay_gain[d].size (slot_width, 75);
        delay_gain[d].position (slot_width*d, 150);
        delay_view.addElement (delay_gain[d]);
        // delay duration slider
        delay_dur[d].name ("Delay, ms");
        delay_dur[d].range (0.01, 100);
        delay_dur[d].value (10);
        delay_dur[d].size (slot_width, 75);
        delay_dur[d].position (slot_width*d, 200);
        delay_view.addElement (delay_dur[d]);
    }
    
    
    // reverbs
    for (0 => int r; r < num_reverbs; r++) {
        // initialize reverb selection
        0 => reverb_sel[r];
        // reverb label button
        reverb_label[r].pushType ();
        reverb_label[r].size (slot_width, 60);
        reverb_label[r].position (slot_width*r, 0);
        reverb_label[r].name ("JCRev " + r);
        reverb_view.addElement (reverb_label[r]);
        // reverb input node slider
        reverb_input[r].name ("Input Node");
        reverb_input[r].range (0, num_nodes);
        reverb_input[r].value (0);
        reverb_input[r].size (slot_width, 75);
        reverb_input[r].position (slot_width*r, 50);
        reverb_input[r].displayFormat (reverb_input[r].integerFormat);
        reverb_view.addElement (reverb_input[r]);
        // reverb output node slider
        reverb_output[r].name ("Output Node");
        reverb_output[r].range (0, num_nodes);
        reverb_output[r].value (0);
        reverb_output[r].size (slot_width, 75);
        reverb_output[r].position (slot_width*r, 100);
        reverb_output[r].displayFormat (reverb_output[r].integerFormat);
        reverb_view.addElement (reverb_output[r]);
        // reverb mix slider
        reverb_mix[r].name ("Mix");
        reverb_mix[r].range (0, 1);
        reverb_mix[r].value (0.1);
        reverb_mix[r].size (slot_width, 75);
        reverb_mix[r].position (slot_width*r, 150);
        reverb_view.addElement (reverb_mix[r]);
    }
    
    
    // counters
    for (0 => int c; c < num_counters; c++) {
        // counter label buttons
        counter_label[c].pushType ();
        counter_label[c].size (slot_width, 60);
        counter_label[c].position (c * slot_width, 0);
        counter_label[c].name ("Counter " + c);
        counter_view.addElement (counter_label[c]);
        // counter input node slider
        counter_input[c].name ("Input Node");
        counter_input[c].range (0, num_nodes);
        counter_input[c].value (0);
        counter_input[c].size (slot_width, 75);
        counter_input[c].position (c * slot_width, 50);
        counter_input[c].displayFormat (counter_input[c].integerFormat);
        counter_view.addElement (counter_input[c]);
        for (0 => int b; b < num_bits; b++) {
            // counter output node slider
            counter_output[c][b].name ("Bit " + b + " Output");
            counter_output[c][b].range (0, num_nodes);
            counter_output[c][b].value (0);
            counter_output[c][b].size (slot_width, 75);
            counter_output[c][b].position (c * slot_width, (2 + b) * 50);
            counter_output[c][b].displayFormat (counter_output[c][b].integerFormat);
            counter_view.addElement (counter_output[c][b]);
        }
        // counter peak to peak select button
        counter_pk2pk[c].toggleType ();
        counter_pk2pk[c].size (slot_width, 60);
        counter_pk2pk[c].position (c * slot_width, (2 + num_bits) * 50);
        counter_pk2pk[c].name ("0 to 1");
        counter_view.addElement (counter_pk2pk[c]);
    }
    
    
    // envelopes
    for (0 => int e; e < num_envelopes; e++) {
        // envelope label button
        envelope_label[e].pushType ();
        envelope_label[e].size (slot_width, 60);
        envelope_label[e].position (e * slot_width, 0);
        envelope_label[e].name ("Envelope " + e);
        envelope_view.addElement (envelope_label[e]);
        // envelope input node slider
        envelope_input[e].name ("Input Node");
        envelope_input[e].range (0, num_nodes);
        envelope_input[e].value (0);
        envelope_input[e].size (slot_width, 75);
        envelope_input[e].position (e * slot_width, 50);
        envelope_input[e].displayFormat (envelope_input[e].integerFormat);
        envelope_view.addElement (envelope_input[e]);
        // envelope output node slider
        envelope_output[e].name ("Output Node");
        envelope_output[e].range (0, num_nodes);
        envelope_output[e].value (0);
        envelope_output[e].size (slot_width, 75);
        envelope_output[e].position (e * slot_width, 100);
        envelope_output[e].displayFormat (envelope_output[e].integerFormat);
        envelope_view.addElement (envelope_output[e]);
        // envelope trigger node slider
        envelope_trigger[e].name ("Trigger Node");
        envelope_trigger[e].range (0, num_nodes);
        envelope_trigger[e].value (0);
        envelope_trigger[e].size (slot_width, 75);
        envelope_trigger[e].position (e * slot_width, 150);
        envelope_trigger[e].displayFormat (envelope_trigger[e].integerFormat);
        envelope_view.addElement (envelope_trigger[e]);
        // envelope rate slider
        envelope_duration[e].name ("Dur, Sec");
        envelope_duration[e].range (0, 1);
        envelope_duration[e].value (0.1);
        envelope_duration[e].size (slot_width, 75);
        envelope_duration[e].position (e * slot_width, 200);
        envelope_view.addElement (envelope_duration[e]);
    }
    
    
    // misc
    if (misc_view_select) {
        // misc noise label button
        noise_label.pushType ();
        noise_label.size (slot_width, 60);
        noise_label.position (0, 0);
        noise_label.name ("Noise");
        misc_view.addElement (noise_label);
        // misc noise output node slider
        noise_output.name ("Output Node");
        noise_output.range (0, num_nodes);
        noise_output.value (0);
        noise_output.size (slot_width, 75);
        noise_output.position (0, 50);
        noise_output.displayFormat (noise_output.integerFormat);
        misc_view.addElement (noise_output);
        // misc noise gain slider
        noise_gain.name ("Gain");
        noise_gain.range (0, 1);
        noise_gain.value (1);
        noise_gain.size (slot_width, 75);
        noise_gain.position (0, 100);
        misc_view.addElement (noise_gain);
        // pitshift label button
        pitshift_label.pushType ();
        pitshift_label.size (slot_width, 60);
        pitshift_label.position (slot_width, 0);
        pitshift_label.name ("Pitch Shifter");
        misc_view.addElement (pitshift_label);
        // pitshift input node slider
        pitshift_input.name ("Input Node");
        pitshift_input.range (0, num_nodes);
        pitshift_input.value (0);
        pitshift_input.size (slot_width, 75);
        pitshift_input.position (slot_width, 50);
        pitshift_input.displayFormat (pitshift_input.integerFormat);
        misc_view.addElement (pitshift_input);
        // pitshift output node slider
        pitshift_output.name ("Output Node");
        pitshift_output.range (0, num_nodes);
        pitshift_output.value (0);
        pitshift_output.size (slot_width, 75);
        pitshift_output.position (slot_width, 100);
        pitshift_output.displayFormat (pitshift_output.integerFormat);
        misc_view.addElement (pitshift_output);
        // pitshift mix slider
        pitshift_mix.name ("Mix");
        pitshift_mix.range (0, 1);
        pitshift_mix.value (0.5);
        pitshift_mix.size (slot_width, 75);
        pitshift_mix.position (slot_width, 150);
        misc_view.addElement (pitshift_mix);
        // pitshift shift slider
        pitshift_shift.name ("Shift");
        pitshift_shift.range (0, 3);
        pitshift_shift.value (0.5);
        pitshift_shift.size (slot_width, 75);
        pitshift_shift.position (slot_width, 200);
        misc_view.addElement (pitshift_shift);
        // rectifiers
        for (0 => int r; r < num_rects; r++) {
            // initialize rectifier selection
            0 => rect_sel[r];
            // rect label button
            rect_label[r].pushType ();
            rect_label[r].size (slot_width, 60);
            rect_label[r].position ((2 + r) * slot_width, 0);
            rect_label[r].name ("Half Rect " + r);
            misc_view.addElement (rect_label[r]);
            // rect input node slider
            rect_input[r].name ("Input Node");
            rect_input[r].range (0, num_nodes);
            rect_input[r].value (0);
            rect_input[r].size (slot_width, 75);
            rect_input[r].position ((2 + r) * slot_width, 50);
            rect_input[r].displayFormat (rect_input[r].integerFormat);
            misc_view.addElement (rect_input[r]);
            // rect output node slider
            rect_output[r].name ("Output Node");
            rect_output[r].range (0, num_nodes);
            rect_output[r].value (0);
            rect_output[r].size (slot_width, 75);
            rect_output[r].position ((2 + r) * slot_width, 100);
            rect_output[r].displayFormat (rect_output[r].integerFormat);
            misc_view.addElement (rect_output[r]);
        }
        // ZeroX zero crossing detectors
        for (0 => int z; z < num_zerox; z++) {
            // zerox label button
            zerox_label[z].pushType ();
            zerox_label[z].size (slot_width, 60);
            zerox_label[z].position ((2 + num_rects + z) * slot_width, 0);
            zerox_label[z].name ("ZeroX " + z);
            misc_view.addElement (zerox_label[z]);
            // zerox input node slider
            zerox_input[z].name ("Input Node");
            zerox_input[z].range (0, num_nodes);
            zerox_input[z].value (0);
            zerox_input[z].size (slot_width, 75);
            zerox_input[z].position ((2 + num_rects + z) * slot_width, 50);
            zerox_input[z].displayFormat (zerox_input[z].integerFormat);
            misc_view.addElement (zerox_input[z]);
            // zerox output node slider
            zerox_output[z].name ("Output Node");
            zerox_output[z].range (0, num_nodes);
            zerox_output[z].value (0);
            zerox_output[z].size (slot_width, 75);
            zerox_output[z].position ((2 + num_rects + z) * slot_width, 100);
            zerox_output[z].displayFormat (zerox_output[z].integerFormat);
            misc_view.addElement (zerox_output[z]);
        }
    }
    
    // keyboard
    if (kbd_view_select) {
        // keyboard label button
        kbd_label.pushType ();
        kbd_label.size (slot_width, 60);
        kbd_label.position (0, 0);
        kbd_label.name ("Keyboard");
        kbd_view.addElement (kbd_label);
        // keyboard output node slider
        kbd_output.name ("Output Node");
        kbd_output.range (0, num_nodes);
        kbd_output.value (0);
        kbd_output.size (slot_width, 75);
        kbd_output.position (0, 50);
        kbd_output.displayFormat (kbd_output.integerFormat);
        kbd_view.addElement (kbd_output);
        // keyboard base note node slider
        kbd_base_note.name ("Base Note");
        kbd_base_note.range (0, 127);
        kbd_base_note.value (50);
        kbd_base_note.size (slot_width, 75);
        kbd_base_note.position (0, 100);
        kbd_base_note.displayFormat (kbd_base_note.integerFormat);
        kbd_view.addElement (kbd_base_note);
    }
    
    
    // logic gates
    for (0 => int g; g < num_logic_gates; g++) {
        // logic gate label buttons
        logic_gate_label[g].pushType ();
        logic_gate_label[g].size (slot_width, 60);
        logic_gate_label[g].position (g * slot_width, 0);
        logic_gate_label[g].name ("AND " + g);
        logic_gate_view.addElement (logic_gate_label[g]);
        for (0 => int i; i < num_logic_inputs; i++) {
            // logic gate input node slider
            logic_gate_input[g][i].name ("Input " + i);
            logic_gate_input[g][i].range (0, num_nodes);
            logic_gate_input[g][i].value (0);
            logic_gate_input[g][i].size (slot_width, 75);
            logic_gate_input[g][i].position (g * slot_width, (1 + i) * 50);
            logic_gate_input[g][i].displayFormat (logic_gate_input[g][i].integerFormat);
            logic_gate_view.addElement (logic_gate_input[g][i]);
        }
        // logic gate output node slider
        logic_gate_output[g].name ("Output");
        logic_gate_output[g].range (0, num_nodes);
        logic_gate_output[g].value (0);
        logic_gate_output[g].size (slot_width, 75);
        logic_gate_output[g].position (g * slot_width, (1 + num_logic_inputs) * 50);
        logic_gate_output[g].displayFormat (logic_gate_output[g].integerFormat);
        logic_gate_view.addElement (logic_gate_output[g]);
    }
    
    
    // dynos
    for (0 => int d; d < num_dynos; d++) {
        // dyno label button
        dyno_label[d].pushType ();
        dyno_label[d].size (slot_width, 60);
        dyno_label[d].position (d * slot_width, 0);
        dyno_label[d].name ("Limiter " + d);
        dyno_view.addElement (dyno_label[d]);
        // dyno input node slider
        dyno_input[d].name ("Input Node");
        dyno_input[d].range (0, num_nodes);
        dyno_input[d].value (0);
        dyno_input[d].size (slot_width, 75);
        dyno_input[d].position (d * slot_width, 50);
        dyno_input[d].displayFormat (dyno_input[d].integerFormat);
        dyno_view.addElement (dyno_input[d]);
        // dyno output node slider
        dyno_output[d].name ("Output Node");
        dyno_output[d].range (0, num_nodes);
        dyno_output[d].value (0);
        dyno_output[d].size (slot_width, 75);
        dyno_output[d].position (d * slot_width, 100);
        dyno_output[d].displayFormat (dyno_output[d].integerFormat);
        dyno_view.addElement (dyno_output[d]);
    }
    
    
    // echos
    for (0 => int e; e < num_echos; e++) {
        // echo label button
        echo_label[e].pushType ();
        echo_label[e].size (slot_width, 60);
        echo_label[e].position (e * slot_width, 0);
        echo_label[e].name ("Echo " + e);
        echo_view.addElement (echo_label[e]);
        // echo input node slider
        echo_input[e].name ("Input Node");
        echo_input[e].range (0, num_nodes);
        echo_input[e].value (0);
        echo_input[e].size (slot_width, 75);
        echo_input[e].position (e * slot_width, 50);
        echo_input[e].displayFormat (echo_input[e].integerFormat);
        echo_view.addElement (echo_input[e]);
        // echo output node slider
        echo_output[e].name ("Output Node");
        echo_output[e].range (0, num_nodes);
        echo_output[e].value (0);
        echo_output[e].size (slot_width, 75);
        echo_output[e].position (e * slot_width, 100);
        echo_output[e].displayFormat (echo_output[e].integerFormat);
        echo_view.addElement (echo_output[e]);
        // echo delay slider
        echo_delay[e].name ("Delay, ms");
        echo_delay[e].range (0, 1000);
        echo_delay[e].value (100);
        echo_delay[e].size (slot_width, 75);
        echo_delay[e].position (e * slot_width, 150);
        echo_view.addElement (echo_delay[e]);
        // echo mix slider
        echo_mix[e].name ("mix");
        echo_mix[e].range (0, 1);
        echo_mix[e].value (0.5);
        echo_mix[e].size (slot_width, 75);
        echo_mix[e].position (e * slot_width, 200);
        echo_view.addElement (echo_mix[e]);
    }
    
    
    // LEDs
    if (num_nodes) {
        for (0 => int l; l < num_nodes; l++) {
            // led label button
            led_label[l].pushType ();
            led_label[l].size (70, 60);
            led_label[l].position (l * 50, 0);
            led_label[l].name ("" + (l + 1));
            led_view.addElement (led_label[l]);
            // the LEDs
            led_led[l].position (l * 50, 40);
            led_led[l].color (led_led[l].blue);
            led_view.addElement (led_led[l]);
        }
    }
    
    
    // Patches
    if (patch_view_select) {
        // patch x label buttons
        for (0 => int nx; nx < num_nodes; nx++) {
            patch_x_label[nx].toggleType ();
            patch_x_label[nx].size (65, 65);
            patch_x_label[nx].position ((1 + nx) * 35, num_nodes * 35);
            patch_x_label[nx].name ("" + (nx + 1));
            patch_view.addElement (patch_x_label[nx]);
        }
        // patch y label buttons
        for (0 => int ny; ny < num_nodes; ny++) {
            patch_y_label[ny].toggleType ();
            patch_y_label[ny].size (65, 65);
            patch_y_label[ny].position (0, (num_nodes - ny - 1) * 35);
            patch_y_label[ny].name ("" + (ny + 1));
            patch_view.addElement (patch_y_label[ny]);
        }
        // patch dot buttons
        for (0 => int nx; nx < num_nodes; nx++) {
            for (0 => int ny; ny < num_nodes; ny++) {
                patch_dot[nx][ny].toggleType ();
                patch_dot[nx][ny].size (65, 65);
                patch_dot[nx][ny].position ((1 + nx) * 35, (num_nodes - ny -1) * 35);
                patch_dot[nx][ny].name ("");
                patch_view.addElement (patch_dot[nx][ny]);
            }
        }
        // patch connect button
        patch_connect.pushType ();
        patch_connect.size (2 * slot_width, 60);
        patch_connect.position (((1 + num_nodes) / 2) * 35 - slot_width, (1 + num_nodes) * 35);
        patch_connect.name ("Make Connections");
        patch_view.addElement (patch_connect);
    }
    
    
    // lisa panel controls
    if (lisa_view_select) {
        // lisa voice input node slider
        lisa_voice_input.name ("Voice In Node");
        lisa_voice_input.range (0, num_nodes);
        lisa_voice_input.value (0);
        lisa_voice_input.size (slot_width, 75);
        lisa_voice_input.position (0, 0);
        lisa_voice_input.displayFormat (lisa_voice_input.integerFormat);
        lisa_view.addElement (lisa_voice_input);
        // lisa voice input slider
        lisa_voice.name ("Voice");
        lisa_voice.range (0, lisa_max_voices - 1);
        lisa_voice.value (0);
        lisa_voice.size (slot_width, 75);
        lisa_voice.position (slot_width, 0);
        lisa_voice.displayFormat (lisa_voice.integerFormat);
        lisa_view.addElement (lisa_voice);
        // lisa rate input node slider
        lisa_rate_input.name ("Rate In Node");
        lisa_rate_input.range (0, num_nodes);
        lisa_rate_input.value (0);
        lisa_rate_input.size (slot_width, 75);
        lisa_rate_input.position (0, 50);
        lisa_rate_input.displayFormat (lisa_rate_input.integerFormat);
        lisa_view.addElement (lisa_rate_input);
        // lisa rate slider
        lisa_rate.name ("Rate");
        lisa_rate.range (0, 4);
        lisa_rate.value (1);
        lisa_rate.size (slot_width, 75);
        lisa_rate.position (slot_width, 50);
        lisa_view.addElement (lisa_rate);
        // lisa clear input node slider
        lisa_clear_input.name ("Clear In Node");
        lisa_clear_input.range (0, num_nodes);
        lisa_clear_input.value (0);
        lisa_clear_input.size (slot_width, 75);
        lisa_clear_input.position (0, 100);
        lisa_clear_input.displayFormat (lisa_clear_input.integerFormat);
        lisa_view.addElement (lisa_clear_input);
        // lisa clear button
        lisa_clear.pushType ();
        lisa_clear.size (slot_width, 60);
        lisa_clear.position (slot_width, 110);
        lisa_clear.name ("Clear");
        lisa_view.addElement (lisa_clear);
        // lisa record input node slider
        lisa_record_input.name ("Rec In Node");
        lisa_record_input.range (0, num_nodes);
        lisa_record_input.value (0);
        lisa_record_input.size (slot_width, 75);
        lisa_record_input.position (0, 150);
        lisa_record_input.displayFormat (lisa_record_input.integerFormat);
        lisa_view.addElement (lisa_record_input);
        // lisa record button
        lisa_record.toggleType ();
        lisa_record.size (slot_width, 60);
        lisa_record.position (slot_width, 160);
        lisa_record.name ("Record");
        lisa_view.addElement (lisa_record);
        // lisa play input node slider
        lisa_play_input.name ("Play In Node");
        lisa_play_input.range (0, num_nodes);
        lisa_play_input.value (0);
        lisa_play_input.size (slot_width, 75);
        lisa_play_input.position (0, 200);
        lisa_play_input.displayFormat (lisa_play_input.integerFormat);
        lisa_view.addElement (lisa_play_input);
        // lisa play button
        lisa_play.pushType ();
        lisa_play.size (slot_width, 60);
        lisa_play.position (slot_width, 210);
        lisa_play.name ("Play");
        lisa_view.addElement (lisa_play);
        // lisa backward input node slider
        lisa_backward_input.name ("Fw/Rev In Node");
        lisa_backward_input.range (0, num_nodes);
        lisa_backward_input.value (0);
        lisa_backward_input.size (slot_width, 75);
        lisa_backward_input.position (0, 250);
        lisa_backward_input.displayFormat (lisa_backward_input.integerFormat);
        lisa_view.addElement (lisa_backward_input);
        // lisa backward button
        lisa_backward.toggleType ();
        lisa_backward.size (slot_width, 60);
        lisa_backward.position (slot_width, 260);
        lisa_backward.name ("Fw/Rev");
        lisa_view.addElement (lisa_backward);
        // lisa input node slider
        lisa_input.name ("Input Node");
        lisa_input.range (0, num_nodes);
        lisa_input.value (0);
        lisa_input.size (slot_width, 75);
        lisa_input.position (0, 300);
        lisa_input.displayFormat (lisa_input.integerFormat);
        lisa_view.addElement (lisa_input);
        // lisa output node slider
        lisa_output.name ("Output Node");
        lisa_output.range (0, num_nodes);
        lisa_output.value (0);
        lisa_output.size (slot_width, 75);
        lisa_output.position (0, 350);
        lisa_output.displayFormat (lisa_output.integerFormat);
        lisa_view.addElement (lisa_output);
    }
    
    
    // display the panels
    if (lisa_view_select) {
        lisa_view.display ();
    }
    if (patch_view_select) {
        patch_view.display ();
    }
    if (num_nodes) {
        led_view.display ();
    }
    echo_view.display ();
    dyno_view.display ();
    logic_gate_view.display ();
    if (kbd_view_select) {
        kbd_view.display ();
    }
    if (misc_view_select) {
        misc_view.display ();
    }
    envelope_view.display ();
    counter_view.display ();
    reverb_view.display ();
    delay_view.display ();
    filter_view.display ();
    osc_view.display ();
    gain_view.display ();
    if (num_nodes) {
        node_view.display ();
    }
    main_view.display ();
    
    
    // bring in Guitar Lab's output
    Gain in => blackhole;
    
    // instantiate the nodes
    // the nodes are implemented as Gain ugens
    Gain node[num_nodes+1];
    // make all nodes always active by sucking samples into blackhole
    for (1 => int n; n <= num_nodes; n++) {
        node[n] => blackhole;
    }
    
    // instantiate the gains
    Gain gain[num_gains];
    
    // instantiate the oscillators
    Phasor phasor[num_osc];
    SinOsc sinosc[num_osc];
    PulseOsc pulseosc[num_osc];
    SqrOsc sqrosc[num_osc];
    TriOsc triosc[num_osc];
    SawOsc sawosc[num_osc];
    
    // instantiate the filters
    LPF lpf[num_filters];
    BPF bpf[num_filters];
    HPF hpf[num_filters];
    BRF brf[num_filters];
    ResonZ resonz[num_filters];
    
    // instantiate delays
    Delay delay[num_delays];
    DelayA delaya[num_delays];
    DelayL delayl[num_delays];
    
    // instantiate reverbs
    JCRev jcrev[num_reverbs];
    NRev nrev[num_reverbs];
    PRCRev prcrev[num_reverbs];
    
    // instantiate the counters
    Step counter_step[num_counters][num_bits];
    
    // instantiate envelopes
    Envelope envelope[num_envelopes];
    
    // instantiate misc view items
    Noise noise;
    PitShift pitshift;
    HalfRect halfrect[num_rects];
    FullRect fullrect[num_rects];
    ZeroX zerox[num_zerox];
    
    // instantiate keyboard stuff
    Hid hid;
    HidMsg hidmsg;
    SinOsc kbd => Envelope kbd_env;
    
    // instantiate logic gate output drivers
    Step logic_gate[num_logic_gates];
    
    // instantiate dynos
    Dyno dyno[num_dynos];
    
    // instantiate echos
    Echo echo[num_echos];
    
    // instantiate patch panel connections
    Gain patch[num_nodes][num_nodes];
    
    // instantiate lisa
    LiSa lisa;
    
    // instantiate fun sound for copyright button
    Noise copyright_n1 => SinOsc copyright_s1 => SinOsc copyright_s2 => SinOsc copyright_s3;
    copyright_s3 => copyright_s1;
    copyright_s1.gain (10);
    copyright_s2.gain (500);
    copyright_s3.gain (1);
    
    // instantiate fun sound for credits button
    PulseOsc credits_s1 => BPF credits_f1 => JCRev credits_n1;
    PulseOsc credits_s2 => credits_f1;
    credits_s1.gain (25);
    credits_s1.freq (1.5);
    credits_s1.width (0.1);
    credits_s2.gain (50);
    credits_s2.freq (2);
    credits_s1.width (0.1);
    credits_f1.freq (440);
    credits_f1.Q (30);
    credits_n1.mix (0.1);
    
    // hook up the output nodes to the DAC and connect wave file ugens
    node[main_dac_left_input.value () $ int] => Gain master_left => Dyno dyno_left => dac.left;
    node[main_dac_right_input.value () $ int] => Gain master_right => Dyno dyno_right => dac.right;
    dyno_left.limit ();
    dyno_right.limit ();
    dac.gain (0.5);
    WvOut wvout;
    dac => wvout => blackhole;
    WvIn wvin;
    wvin => master_left;
    wvin => master_right;
    
    // receive audio from the public class Communication (in Communication.ck)
    //Communication.buffer;


// main panel shreds
// shred for record button on main panel
fun void main_record_adj () {
    while (true) {
        main_record => now;
        if (main_record.state ()) {
            "Synth_Lab.wav" => wvout.wavFilename;
        } else {
            wvout.closeFile ();
        }
    }
}
spork ~ main_record_adj ();
// shred for playback button on main panel
fun void main_playback_adj () {
    while (true) {
        main_playback => now;
        if (main_playback.state () & (!main_record.state ())) {
            1 => wvin.rate;
            "Synth_Lab.wav" => wvin.path;
        }    
    }
}
spork ~ main_playback_adj ();
// shred for volume slider on main panel
fun void main_volume_adj () {
    while (true) {
        main_volume => now;
        master_left.gain (main_volume.value ());
        master_right.gain (main_volume.value ());
    }
}
spork ~ main_volume_adj ();
// shred for clock freq slider on main panel
fun void main_clock_freq_adj () {
    while (true) {
        main_clock_freq => now;
        1::second / main_clock_freq.value () => clock_period;
    }
}
spork ~ main_clock_freq_adj ();
// shred for note freq slider on main panel
fun void main_note_freq_adj () {
    while (true) {
        main_note_freq => now;
        // save the note period
        1::second / main_note_freq.value () => note_period;
    }
}
spork ~ main_note_freq_adj ();
// shred for monitoring self-destruct button
fun void main_self_destruct_adj () {
    while (true) {
        main_self_destruct => now;
        if (main_self_destruct.state ()) {
            1 => exit;
            main_self_destruct.name ("Self Destruct Initiated");
        }
    }
}
spork ~ main_self_destruct_adj ();
// shred for output node slider on mic
fun void main_mic_output_adj () {
    while (true) {
        main_mic_output => now;
        adc =< node[mic_out];
        adc => node[main_mic_output.value () $ int];
        main_mic_output.value () $ int => mic_out;
    }
}
spork ~ main_mic_output_adj ();
// shred for input node slider on dac left
fun void main_dac_left_input_adj () {
    while (true) {
        main_dac_left_input => now;
        node[dac_left_in] =< master_left;
        node[main_dac_left_input.value () $ int] => master_left;
        main_dac_left_input.value () $ int => dac_left_in;
    }
}
spork ~ main_dac_left_input_adj ();
// shred for input node slider on dac right
fun void main_dac_right_input_adj () {
    while (true) {
        main_dac_right_input => now;
        node[dac_right_in] =< master_right;
        node[main_dac_right_input.value () $ int] => master_right;
        main_dac_right_input.value () $ int => dac_right_in;
    }
}
spork ~ main_dac_right_input_adj ();
// shred for copyright button fun noise
fun void main_copyright_adj () {
    while (true) {
        main_copyright => now;
        if (main_copyright.state ()) {
            copyright_s3 => master_left;
            main_copyright.name ("inventor-66@comcast.net");
        } else {
            copyright_s3 =< master_left;
            main_copyright.name ("Copyright 2008 Les Hall");
        }
    }
}
spork ~ main_copyright_adj ();
// shred for credits button fun noise
fun void main_credits_adj () {
    while (true) {
        main_credits => now;
        if (main_credits.state ()) {
            credits_n1 => master_right;
            main_credits.name ("A Community of Music Lovers");
        } else {
            credits_n1 =< master_right;
            main_credits.name ("Thanks to www.electromusic.com");
        }
    }
}
spork ~ main_credits_adj ();
// shred for fortune cooke button on main panel
fun void main_fortune_cookie_adj () {
    ["You have an ear for music", "Now is the time to synthesize", 
    "Vote for a Democrat next time", "You aspire to greatness",
    "You are fond of synthesizers", "You dig retrograde",
    "Visit www.electro-music.com today", "Try synthesizing a love song", 
    "Try Guitar Lab as well", "Your horoscope looks promising", 
    "Judas Priest Rocks", "Your mama didn't raise no fools", 
    "You are very popular", "Domo aregato Mr. Roboto",
    "You will create something wonderful", "Less is more", 
    "Keep your passwords secret", "Kassen is very helpful", 
    "kijjaz is a master ChucKist", "Frostburn is brilliant", 
    "mosc is living synthesizer history", "Ge Wang is a friendly ChucKist", 
    "Blue Hell likes music circuitry", "wppk made an great ChucK rain patch", 
    "AC/DC rocks", "Joan Jett would like to meet you", 
    "Use the force with confidence", "You will have long life", 
    "You are entering a time of prosperity", "Jimmi Hendrix is a legend", 
    "Remember this:  oh, I forgot!", "You can be a good programmer if you try", 
    "You are generous and kind", "The universe is analog", 
    "God does not play dice with the universe", "A penny saved is a penny earned", 
    "You will become a synthesizer wizard", "Never give up", 
    "Visit www.freedomodds.com/music/", "Nostrodamus never saw Synth Lab coming", 
    "Synth Lab is ChucK on steroids", "Synth Lab will bring you happiness", 
    "You are healthy, wealthy, and wise", "Never eat kiwi fruit alone", 
    "You will become a skilled ChucKist", "For sports, visit www.freedomodds.com", 
    "You will master Perl programming", "Macs are the best computers", 
    "Computers are getting smarter", "Captain Picard gave you a promotion", 
    "The force is strong with you"] @=>string fortunes[];
    while (true) {
        main_fortune_cookie => now;
        if (main_fortune_cookie.state ()) {
            main_fortune_cookie.name (fortunes[Std.rand2(0, 50)]);
        } else {
            main_fortune_cookie.name ("Fortune Cookie");
        }
    }
}
spork ~ main_fortune_cookie_adj ();
// shred for output node slider on guitar lab
fun void guitar_lab_output_adj () {
    while (true) {
        guitar_lab_output => now;
        if (guitar_lab_out > 0) {
            in =< node[guitar_lab_out];
        }
        if (guitar_lab_output.value () > 0) {
            in => node[guitar_lab_output.value () $ int];
        }
        guitar_lab_output.value () $ int => guitar_lab_out;
    }
}
spork ~ guitar_lab_output_adj ();


// shreds to watch the ugen buttons and sliders of nodes
// shred for gain slider on nodes
fun void node_gain_adj (int n) {
    while (true) {
        node_gain[n] => now;
        node[n].gain (node_boost_val[n] * node_gain[n].value ());
    }
}
for (1 => int n; n <= num_nodes; n++) {
    spork ~ node_gain_adj (n);
}
// gain boost button
fun void node_boost_adj (int n) {
    while (true) {
        node_boost[n] => now;
        if (node_boost[n].state ()) {
            10 *=> node_boost_val[n];
            if (node_boost_val[n] > 10000) {
                0.1 => node_boost_val[n];
            }
            node_boost[n].name ("x" + node_boost_val[n]);
        }
        node[n].gain (node_boost_val[n] * node_gain[n].value ());
    }
}
for (1 => int n; n <= num_nodes; n++) {
    spork ~ node_boost_adj (n);
}
// shred for op slider on nodes
fun void node_op_adj (int n) {
    while (true) {
        node_op[n] => now;
        node[n].op (node_op[n].value () $ int);
    }
}
for (1 => int n; n <= num_nodes; n++) {
    spork ~ node_op_adj (n);
}


// shreds to watch the ugen buttons and sliders of gains
// shred for input node slider on gains
fun void gain_input_adj (int g) {
    while (true) {
        gain_input[g] => now;
        node[gain_in[g]] =< gain[g];
        node[gain_input[g].value () $ int] => gain[g];
        gain_input[g].value () $ int => gain_in[g];
    }
}
for (0 => int g; g < num_gains; g++) {
    spork ~ gain_input_adj (g);
}
// shred for output node slider on gains
fun void gain_output_adj (int g) {
    while (true) {
        gain_output[g] => now;
        gain[g] =< node[gain_out[g]];
        gain[g] => node[gain_output[g].value () $ int];
        gain_output[g].value () $ int => gain_out[g];
    }
}
for (0 => int g; g < num_gains; g++) {
    spork ~ gain_output_adj (g);
}
// shred for gain slider on gains
fun void gain_gain_adj (int g) {
    while (true) {
        gain_gain[g] => now;
        node[g].gain (gain_gain[g].value ());
    }
}
for (0 => int g; g < num_gains; g++) {
    spork ~ gain_gain_adj (g);
}


// shreds to watch the ugen buttons and sliders of oscillators
// osc label button
fun void osc_label_adj (int o) {
    while (true) {
        osc_label[o] => now;
        if (osc_label[o].state ()) {
            (osc_sel[o] + 1) % 6 => osc_sel[o];
            if (osc_sel[o] == 0) {
                node[osc_in[o]] =< sawosc[o];
                if (osc_out[o] > 0) {
                    node[osc_in[o]] => phasor[o];
                    sawosc[o] =< node[osc_out[o]];
                    phasor[o] => node[osc_out[o]];
                }
                osc_label[o].name ("Phasor " + o);
            }
            if (osc_sel[o] == 1) {
                node[osc_in[o]] =< phasor[o];
                if (osc_out[o] > 0) {
                    node[osc_in[o]] => sinosc[o];
                    phasor[o] =< node[osc_out[o]];
                    sinosc[o] => node[osc_out[o]];
                }
                osc_label[o].name ("SinOsc " + o);
            }
            if (osc_sel[o] == 2) {
                node[osc_in[o]] =< sinosc[o];
                if (osc_out[o] > 0) {
                    node[osc_in[o]] => pulseosc[o];
                    sinosc[o] =< node[osc_out[o]];
                    pulseosc[o] => node[osc_out[o]];
                }
                osc_label[o].name ("PulseOsc " + o);
            }
            if (osc_sel[o] == 3) {
                node[osc_in[o]] =< pulseosc[o];
                if (osc_out[o] > 0) {
                    node[osc_in[o]] => sqrosc[o];
                    pulseosc[o] =< node[osc_out[o]];
                    sqrosc[o] => node[osc_out[o]];
                }
                osc_label[o].name ("SqrOsc " + o);
            }
            if (osc_sel[o] == 4) {
                node[osc_in[o]] =< sqrosc[o];
                if (osc_out[o] > 0) {
                    node[osc_in[o]] => triosc[o];
                    sqrosc[o] =< node[osc_out[o]];
                    triosc[o] => node[osc_out[o]];
                }
                osc_label[o].name ("TriOsc " + o);
            }
            if (osc_sel[o] == 5) {
                node[osc_in[o]] =< triosc[o];
                if (osc_out[o] > 0) {
                    node[osc_in[o]] => sawosc[o];
                    triosc[o] =< node[osc_out[o]];
                    sawosc[o] => node[osc_out[o]];
                }
                osc_label[o].name ("SawOsc " + o);
            }
            phasor[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
            sinosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
            pulseosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
            sqrosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
            triosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
            sawosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        }
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_label_adj (o);
}
// shred for input node slider on oscillators
fun void osc_input_adj (int o) {
    while (true) {
        osc_input[o] => now;
        if (osc_sel[o] == 0) {
            node[osc_in[o]] =< phasor[o];
            if (osc_input[o].value () > 0) {
                node[osc_input[o].value () $ int] => phasor[o];
            }
        }
        if (osc_sel[o] == 1) {
            node[osc_in[o]] =< sinosc[o];
            if (osc_input[o].value () > 0) {
                node[osc_input[o].value () $ int] => sinosc[o];
            }
        }
        if (osc_sel[o] == 2) {
            node[osc_in[o]] =< pulseosc[o];
            if (osc_input[o].value () > 0) {
                node[osc_input[o].value () $ int] => pulseosc[o];
            }
        }
        if (osc_sel[o] == 3) {
            node[osc_in[o]] =< sqrosc[o];
            if (osc_input[o].value () > 0) {
                node[osc_input[o].value () $ int] => sqrosc[o];
            }
        }
        if (osc_sel[o] == 4) {
            node[osc_in[o]] =< triosc[o];
            if (osc_input[o].value () > 0) {
                node[osc_input[o].value () $ int] => triosc[o];
            }
        }
        if (osc_sel[o] == 5) {
            node[osc_in[o]] =< sawosc[o];
            if (osc_input[o].value () > 0) {
                node[osc_input[o].value () $ int] => sawosc[o];
            }
        }
        osc_input[o].value () $ int => osc_in[o];
        phasor[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sinosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        pulseosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sqrosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        triosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sawosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_input_adj (o);
}
// shred for output node slider on oscillators
fun void osc_output_adj (int o) {
    while (true) {
        osc_output[o] => now;
        if (osc_sel[o] == 0) {
            if (osc_out[o] > 0) {
                phasor[o] =< node[osc_out[o]];
            }
            if (osc_output[o].value () > 0) {
                phasor[o] => node[osc_output[o].value () $ int];
            }
        }
        if (osc_sel[o] == 1) {
            if (osc_out[o] > 0) {
                sinosc[o] =< node[osc_out[o]];
            }
            if (osc_output[o].value () > 0) {
                sinosc[o] => node[osc_output[o].value () $ int];
            }
        }
        if (osc_sel[o] == 2) {
            if (osc_out[o] > 0) {
                pulseosc[o] =< node[osc_out[o]];
            }
            if (osc_output[o].value () > 0) {
                pulseosc[o] => node[osc_output[o].value () $ int];
            }
        }
        if (osc_sel[o] == 3) {
            if (osc_out[o] > 0) {
                sqrosc[o] =< node[osc_out[o]];
            }
            if (osc_output[o].value () > 0) {
                sqrosc[o] => node[osc_output[o].value () $ int];
            }
        }
        if (osc_sel[o] == 4) {
            if (osc_out[o] > 0) {
                triosc[o] =< node[osc_out[o]];
            }
            if (osc_output[o].value () > 0) {
                triosc[o] => node[osc_output[o].value () $ int];
            }
        }
        if (osc_sel[o] == 5) {
            if (osc_out[o] > 0) {
                sawosc[o] =< node[osc_out[o]];
            }
            if (osc_output[o].value () > 0) {
                sawosc[o] => node[osc_output[o].value () $ int];
            }
        }
        osc_output[o].value () $ int => osc_out[o];
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_output_adj (o);
}
// shred for gain slider on oscillators
fun void osc_gain_adj (int o) {
    while (true) {
        osc_gain[o] => now;
        phasor[o].gain (osc_gain[o].value ());
        sinosc[o].gain (osc_gain[o].value ());
        pulseosc[o].gain (osc_gain[o].value ());
        sqrosc[o].gain (osc_gain[o].value ());
        triosc[o].gain (osc_gain[o].value ());
        sawosc[o].gain (osc_gain[o].value ());
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_gain_adj (o);
}
// shred for freq1 slider on oscillators
fun void osc_freq1_adj (int o) {
    while (true) {
        osc_freq1[o] => now;
        phasor[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sinosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        pulseosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sqrosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        triosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sawosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_freq1_adj (o);
}
// shred for freq2 slider on oscillators
fun void osc_freq2_adj (int o) {
    while (true) {
        osc_freq2[o] => now;
        phasor[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sinosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        pulseosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sqrosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        triosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sawosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_freq2_adj (o);
}
// shred for phase slider on oscillators
fun void osc_phase_adj (int o) {
    while (true) {
        osc_phase[o] => now;
        phasor[o].phase (osc_phase[o].value ());
        sinosc[o].phase (osc_phase[o].value ());
        pulseosc[o].phase (osc_phase[o].value ());
        sqrosc[o].phase (osc_phase[o].value ());
        triosc[o].phase (osc_phase[o].value ());
        sawosc[o].phase (osc_phase[o].value ());
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_phase_adj (o);
}
// shred for width slider on oscillators
fun void osc_width_adj (int o) {
    while (true) {
        osc_width[o] => now;
        pulseosc[o].width (osc_width[o].value ());
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_width_adj (o);
}
// shred for sync slider on oscillators
fun void osc_sync_adj (int o) {
    while (true) {
        osc_sync[o] => now;
        phasor[o].sync (osc_sync[o].value () $ int);
        sinosc[o].sync (osc_sync[o].value () $ int);
        pulseosc[o].sync (osc_sync[o].value () $ int);
        sqrosc[o].sync (osc_sync[o].value () $ int);
        triosc[o].sync (osc_sync[o].value () $ int);
        sawosc[o].sync (osc_sync[o].value () $ int);
    }
}
for (0 => int o; o < num_osc; o++) {
    spork ~ osc_sync_adj (o);
}


// shreds to watch the ugen buttons and sliders of filters
// filter label button
fun void filter_label_adj (int f) {
    while (true) {
        filter_label[f] => now;
        if (filter_label[f].state ()) {
            (filter_sel[f] + 1) % 5 => filter_sel[f];
            if (filter_sel[f] == 0) {
                node[filter_in[f]] =< resonz[f];
                node[filter_input[f].value () $ int] => lpf[f];
                resonz[f] =< node[filter_out[f]];
                lpf[f] => node[filter_output[f].value () $ int];
                filter_label[f].name ("LPF " + f);
            }
            if (filter_sel[f] == 1) {
                node[filter_in[f]] =< lpf[f];
                node[filter_input[f].value () $ int] => bpf[f];
                lpf[f] =< node[filter_out[f]];
                bpf[f] => node[filter_output[f].value () $ int];
                filter_label[f].name ("BPF " + f);
            }
            if (filter_sel[f] == 2) {
                node[filter_in[f]] =< bpf[f];
                node[filter_input[f].value () $ int] => hpf[f];
                bpf[f] =< node[filter_out[f]];
                hpf[f] => node[filter_output[f].value () $ int];
                filter_label[f].name ("HPF " + f);
            }
            if (filter_sel[f] == 3) {
                node[filter_in[f]] =< hpf[f];
                node[filter_input[f].value () $ int] => brf[f];
                hpf[f] =< node[filter_out[f]];
                brf[f] => node[filter_output[f].value () $ int];
                filter_label[f].name ("BRF " + f);
            }
            if (filter_sel[f] == 4) {
                node[filter_in[f]] =< brf[f];
                node[filter_input[f].value () $ int] => resonz[f];
                brf[f] =< node[filter_out[f]];
                resonz[f] => node[filter_output[f].value () $ int];
                filter_label[f].name ("ResonZ " + f);
            }
        }
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_label_adj (f);
}
// shred for input node slider on filters
fun void filter_input_adj (int f) {
    while (true) {
        filter_input[f] => now;
        if (filter_sel[f] == 0) {
            node[filter_in[f]] =< lpf[f];
            node[filter_input[f].value () $ int] => lpf[f];
        }
        if (filter_sel[f] == 1) {
            node[filter_in[f]] =< bpf[f];
            node[filter_input[f].value () $ int] => bpf[f];
        }
        if (filter_sel[f] == 2) {
            node[filter_in[f]] =< hpf[f];
            node[filter_input[f].value () $ int] => hpf[f];
        }
        if (filter_sel[f] == 3) {
            node[filter_in[f]] =< brf[f];
            node[filter_input[f].value () $ int] => brf[f];
        }
        if (filter_sel[f] == 4) {
            node[filter_in[f]] =< resonz[f];
            node[filter_input[f].value () $ int] => resonz[f];
        }
        filter_input[f].value () $ int => filter_in[f];
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_input_adj (f);
}
// shred for output node slider on filters
fun void filter_output_adj (int f) {
    while (true) {
        filter_output[f] => now;
        if (filter_sel[f] == 0) {
            lpf[f] =< node[filter_out[f]];
            lpf[f] => node[filter_output[f].value () $ int];
        }
        if (filter_sel[f] == 1) {
            bpf[f] =< node[filter_out[f]];
            bpf[f] => node[filter_output[f].value () $ int];
        }
        if (filter_sel[f] == 2) {
            hpf[f] =< node[filter_out[f]];
            hpf[f] => node[filter_output[f].value () $ int];
        }
        if (filter_sel[f] == 3) {
            brf[f] =< node[filter_out[f]];
            brf[f] => node[filter_output[f].value () $ int];
        }
        if (filter_sel[f] == 4) {
            resonz[f] =< node[filter_out[f]];
            resonz[f] => node[filter_output[f].value () $ int];
        }
        filter_output[f].value () $ int => filter_out[f];
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_output_adj (f);
}
// shred for wahwah slider on filters
fun void filter_wahwah_adj (int f) {
    while (true) {
        filter_wahwah[f] => now;
        filter_wahwah[f].value () $ int => filter_wah[f];
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_wahwah_adj (f);
}
// shred to constantly adjust wahwah frequency on filters
fun void filter_wahwah_freq_adj (int f) {
    while (true) {
        if (filter_wah[f] > 0) {
            lpf[f].freq (node[filter_wah[f]].last ());
            bpf[f].freq (node[filter_wah[f]].last ());
            hpf[f].freq (node[filter_wah[f]].last ());
            brf[f].freq (node[filter_wah[f]].last ());
            resonz[f].freq (node[filter_wah[f]].last ());
        } else {
            lpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            bpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            hpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            brf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            resonz[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
        }
        clock_period => now;
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_wahwah_freq_adj (f);
}
// shred for gain slider on filters
fun void filter_gain_adj (int f) {
    while (true) {
        filter_gain[f] => now;
        lpf[f].gain (filter_gain[f].value ());
        bpf[f].gain (filter_gain[f].value ());
        hpf[f].gain (filter_gain[f].value ());
        brf[f].gain (filter_gain[f].value ());
        resonz[f].gain (filter_gain[f].value ());
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_gain_adj (f);
}
// shred for freq1 slider on filters
fun void filter_freq1_adj (int f) {
    while (true) {
        filter_freq1[f] => now;
        if (filter_wah[f] == 0) {
            lpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            bpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            hpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            brf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            resonz[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
        }
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_freq1_adj (f);
}
// shred for freq2 slider on filters
fun void filter_freq2_adj (int f) {
    while (true) {
        filter_freq2[f] => now;
        if (filter_wah[f] == 0) {
            lpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            bpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            hpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            brf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
            resonz[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
        }
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_freq2_adj (f);
}
// shred for Q slider on filters
fun void filter_q_adj (int f) {
    while (true) {
        filter_q[f] => now;
        lpf[f].Q (filter_q[f].value ());
        bpf[f].Q (filter_q[f].value ());
        hpf[f].Q (filter_q[f].value ());
        brf[f].Q (filter_q[f].value ());
        resonz[f].Q (filter_q[f].value ());
    }
}
for (0 => int f; f < num_filters; f++) {
    spork ~ filter_q_adj (f);
}
// shred for resetting the Q of the filters to kill noisy resonance
fun void filter_reset_adj () {
    while (true) {
        filter_reset => now;
        if (filter_reset.state ()) {
            for (0 => int f; f < num_filters; f++) {
                lpf[f].Q (0);
                bpf[f].Q (0);
                hpf[f].Q (0);
                brf[f].Q (0);
            }
        } else {
            for (0 => int f; f < num_filters; f++) {
                lpf[f].Q (filter_q[f].value ());
                bpf[f].Q (filter_q[f].value ());
                hpf[f].Q (filter_q[f].value ());
                brf[f].Q (filter_q[f].value ());
            }
        }
    }
}
spork ~ filter_reset_adj ();



// shreds to watch the ugen buttons and sliders of delays
// delay label button
fun void delay_label_adj (int d) {
    while (true) {
        delay_label[d] => now;
        if (delay_label[d].state ()) {
            (delay_sel[d] + 1) % 3 => delay_sel[d];
            if (delay_sel[d] == 0) {
                node[delay_in[d]] =< delayl[d];
                node[delay_input[d].value () $ int] => delay[d];
                delayl[d] =< node[delay_out[d]];
                delay[d] => node[delay_output[d].value () $ int];
                delay_label[d].name ("Delay " + d);
            }
            if (delay_sel[d] == 1) {
                node[delay_in[d]] =< delay[d];
                node[delay_input[d].value () $ int] => delaya[d];
                delay[d] =< node[delay_out[d]];
                delaya[d] => node[delay_output[d].value () $ int];
                delay_label[d].name ("DelayA " + d);
            }
            if (delay_sel[d] == 2) {
                node[delay_in[d]] =< delaya[d];
                node[delay_input[d].value () $ int] => delayl[d];
                delaya[d] =< node[delay_out[d]];
                delayl[d] => node[delay_output[d].value () $ int];
                delay_label[d].name ("DelayL " + d);
            }
        }
    }
}
for (0 => int d; d < num_delays; d++) {
    spork ~ delay_label_adj (d);
}
// shred for input node slider on delays
fun void delay_input_adj (int d) {
    while (true) {
        delay_input[d] => now;
        if (delay_sel[d] == 0) {
            node[delay_in[d]] =< delay[d];
            node[delay_input[d].value () $ int] => delay[d];
        }
        if (delay_sel[d] == 1) {
            node[delay_in[d]] =< delaya[d];
            node[delay_input[d].value () $ int] => delaya[d];
        }
        if (delay_sel[d] == 2) {
            node[delay_in[d]] =< delayl[d];
            node[delay_input[d].value () $ int] => delayl[d];
        }
        delay_input[d].value () $ int => delay_in[d];
    }
}
for (0 => int d; d < num_delays; d++) {
    spork ~ delay_input_adj (d);
}
// shred for output node slider on delays
fun void delay_output_adj (int d) {
    while (true) {
        delay_output[d] => now;
        if (delay_sel[d] == 0) {
            delay[d] =< node[delay_out[d]];
            delay[d] => node[delay_output[d].value () $ int];
        }
        if (delay_sel[d] == 1) {
            delaya[d] =< node[delay_out[d]];
            delaya[d] => node[delay_output[d].value () $ int];
        }
        if (delay_sel[d] == 2) {
            delayl[d] =< node[delay_out[d]];
            delayl[d] => node[delay_output[d].value () $ int];
        }
        delay_output[d].value () $ int => delay_out[d];
    }
}
for (0 => int d; d < num_delays; d++) {
    spork ~ delay_output_adj (d);
}
// shred for gain slider on delays
fun void delay_gain_adj (int d) {
    while (true) {
        delay_gain[d] => now;
        delay[d].gain (delay_gain[d].value ());
        delaya[d].gain (delay_gain[d].value ());
        delayl[d].gain (delay_gain[d].value ());
    }
}
for (0 => int d; d < num_delays; d++) {
    spork ~ delay_gain_adj (d);
}
// shred for duration slider on delays
fun void delay_dur_adj (int d) {
    while (true) {
        delay_dur[d] => now;
        delay[d].delay (delay_dur[d].value () :: ms);
        delaya[d].delay (delay_dur[d].value () :: ms);
        delayl[d].delay (delay_dur[d].value () :: ms);
    }
}
for (0 => int d; d < num_delays; d++) {
    spork ~ delay_dur_adj (d);
}


// shreds to watch the ugen buttons and sliders of reverbs
// reverb label button
fun void reverb_label_adj (int r) {
    while (true) {
        reverb_label[r] => now;
        if (reverb_label[r].state ()) {
            (reverb_sel[r] + 1) % 3 => reverb_sel[r];
            if (reverb_sel[r] == 0) {
                node[reverb_in[r]] =< prcrev[r];
                node[reverb_input[r].value () $ int] => jcrev[r];
                prcrev[r] =< node[reverb_out[r]];
                jcrev[r] => node[reverb_output[r].value () $ int];
                reverb_label[r].name ("JCRev " + r);
            }
            if (reverb_sel[r] == 1) {
                node[reverb_in[r]] =< jcrev[r];
                node[reverb_input[r].value () $ int] => nrev[r];
                jcrev[r] =< node[reverb_out[r]];
                nrev[r] => node[reverb_output[r].value () $ int];
                reverb_label[r].name ("NRev " + r);
            }
            if (reverb_sel[r] == 2) {
                node[reverb_in[r]] =< nrev[r];
                node[reverb_input[r].value () $ int] => prcrev[r];
                nrev[r] =< node[reverb_out[r]];
                prcrev[r] => node[reverb_output[r].value () $ int];
                reverb_label[r].name ("PRCRev " + r);
            }
        }
    }
}
for (0 => int r; r < num_reverbs; r++) {
    spork ~ reverb_label_adj (r);
}
// shred for input node slider on reverbs
fun void reverb_input_adj (int r) {
    while (true) {
        reverb_input[r] => now;
        if (reverb_sel[r] == 0) {
            node[reverb_in[r]] =< jcrev[r];
            node[reverb_input[r].value () $ int] => jcrev[r];
        }
        if (reverb_sel[r] == 1) {
            node[reverb_in[r]] =< nrev[r];
            node[reverb_input[r].value () $ int] => nrev[r];
        }
        if (reverb_sel[r] == 2) {
            node[reverb_in[r]] =< prcrev[r];
            node[reverb_input[r].value () $ int] => prcrev[r];
        }
        reverb_input[r].value () $ int => reverb_in[r];
    }
}
for (0 => int r; r < num_reverbs; r++) {
    spork ~ reverb_input_adj (r);
}
// shred for output node slider on reverbs
fun void reverb_output_adj (int r) {
    while (true) {
        reverb_output[r] => now;
        if (reverb_sel[r] == 0) {
            jcrev[r] =< node[reverb_out[r]];
            jcrev[r] => node[reverb_output[r].value () $ int];
        }
        if (reverb_sel[r] == 1) {
            nrev[r] =< node[reverb_out[r]];
            nrev[r] => node[reverb_output[r].value () $ int];
        }
        if (reverb_sel[r] == 2) {
            prcrev[r] =< node[reverb_out[r]];
            prcrev[r] => node[reverb_output[r].value () $ int];
        }
        reverb_output[r].value () $ int => reverb_out[r];
    }
}
for (0 => int r; r < num_reverbs; r++) {
    spork ~ reverb_output_adj (r);
}
// shred for mix slider on reverbs
fun void reverb_mix_adj (int r) {
    while (true) {
        reverb_mix[r] => now;
        jcrev[r].mix (reverb_mix[r].value ());
        nrev[r].mix (reverb_mix[r].value ());
        prcrev[r].mix (reverb_mix[r].value ());
    }
}
for (0 => int r; r < num_reverbs; r++) {
    spork ~ reverb_mix_adj (r);
}


// shreds to watch ugen buttons and sliders of counter view
// shred for input node slider on counters
fun void counter_input_adj (int c) {
    while (true) {
        counter_input[c] => now;
        counter_input[c].value () $ int => counter_in[c];
    }
}
for (0 => int c; c < num_counters; c++) {
    spork ~ counter_input_adj (c);
}
// shred for output node slider on counters
fun void counter_output_adj (int c, int b) {
    while (true) {
        counter_output[c][b] => now;
        if (counter_out[c][b] > 0) {
            counter_step[c][b] =< node[counter_out[c][b]];
        }
        if (counter_output[c][b].value () > 0) {
            counter_step[c][b] => node[counter_output[c][b].value () $ int];
        }
        counter_output[c][b].value () $ int => counter_out[c][b];
    }
}
for (0 => int c; c < num_counters; c++) {
    for (0 => int b; b < num_bits; b++) {
        spork ~ counter_output_adj (c, b);
    }
}
// shred to update the pk2pk button on counters
fun void counter_pk2pk_adj (int c) {
    while (true) {
        counter_pk2pk[c] => now;
        if (counter_pk2pk[c].state ()) {
            counter_pk2pk[c].name ("-1 to 1");
        } else {
            counter_pk2pk[c].name ("0 to 1");
        }
    }
}
for (0 => int c; c < num_counters; c++) {
    spork ~ counter_pk2pk_adj (c);
}
// shred to count the counts and output them
fun void counter_adj (int c) {
    0 => int count;
    int direction;
    Math.pow(2, num_bits) $ int => int count_limit;
    float bit_values[num_bits];
    int shift_register;
    while (true) {
        // find the current count direction
        if (counter_in[c] > 0) {
            if (node[counter_in[c]].last () > 0) {  // if input is logic 1
                1 => direction;
            } else {
                -1 => direction;
            }
        } else {
            1 => direction;
        }
        direction +=> count;  // increment / decrement the counter
        // check for down count rollover
        if (count < 0) {
            count_limit +=> count;
        }
        // check for up count rollover
        count % count_limit => count;
        // counter is updated, now obtain the bit values
        count => shift_register;
        for (0 => int b; b < num_bits; b++) {
            shift_register % 2 => bit_values[b];
            shift_register >> 1 => shift_register;
        }
        // set the bit values according to the pk2pk button
        if (counter_pk2pk[c].state ()) {
            for (0 => int b; b < num_bits; b++) {
                2 * bit_values[b] - 1 => bit_values[b];  // change to (-1, 1) logic levels
            }
        }
        // apply the bit values to the Step ugens
        for (0 => int b; b < num_bits; b++) {
            counter_step[c][b].next (bit_values[b]);
        }
        note_period => now;  // wait one note period between counts
    }
}
for (0 => int c; c < num_counters; c++) {
    spork ~ counter_adj (c);
}


// shreds to watch ugen buttons and sliders of envelope view
// shred for input node slider on envelopes
fun void envelope_input_adj (int e) {
    while (true) {
        envelope_input[e] => now;
        node[envelope_in[e]] =< envelope[e];
        node[envelope_input[e].value () $ int] => envelope[e];
        envelope_input[e].value () $ int => envelope_in[e];
    }
}
for (0 => int e; e < num_envelopes; e++) {
    spork ~ envelope_input_adj (e);
}
// shred for output node slider on envelopes
fun void envelope_output_adj (int e) {
    while (true) {
        envelope_output[e] => now;
        envelope[e] =< node[envelope_out[e]];
        envelope[e] => node[envelope_output[e].value () $ int];
        envelope_output[e].value () $ int => envelope_out[e];
    }
}
for (0 => int e; e < num_envelopes; e++) {
    spork ~ envelope_output_adj (e);
}
// shred for trigger node slider on envelopes
fun void envelope_trigger_adj (int e) {
    while (true) {
        envelope_trigger[e] => now;
        envelope_trigger[e].value () $ int => envelope_trig[e];
    }
}
for (0 => int e; e < num_envelopes; e++) {
    spork ~ envelope_trigger_adj (e);
}
// shred to continuously monitor envelope trigger
fun void envelope_onoff_adj (int e) {
    float envelope_previous;  // previous value of envelope trigger input
    float envelope_current;  // current value of envelope trigger input
    while (true) {
        envelope_current => envelope_previous;
        node[envelope_trig[e]].last () => envelope_current;
        if ( (envelope_previous <= 0) & (envelope_current > 0) ) {
            envelope[e].keyOn ();
        }
        if ( (envelope_previous > 0) & (envelope_current <= 0) ) {
            envelope[e].keyOff ();
        }
        clock_period => now;
    }
}
for (0 => int e; e < num_envelopes; e++) {
    spork ~ envelope_onoff_adj (e);
}
// shred for rate slider on envelopes
fun void envelope_duration_adj (int e) {
    while (true) {
        envelope_duration[e] => now;
        envelope[e].duration (envelope_duration[e].value () :: second);
    }
}
for (0 => int e; e < num_envelopes; e++) {
    spork ~ envelope_duration_adj (e);
}


// shreds to watch ugen buttons and sliders of misc view
// shred for output node slider on noise
fun void noise_output_adj () {
    while (true) {
        noise_output => now;
        if (noise_out > 0) {
            noise =< node[noise_out];
        }
        if (noise_output.value () > 0) {
            noise => node[noise_output.value () $ int];
        }
        noise_output.value () $ int => noise_out;
    }
}
spork ~ noise_output_adj ();
// shred for gain slider on noise
fun void noise_gain_adj () {
    while (true) {
        noise_gain => now;
        noise.gain (noise_gain.value ());
    }
}
spork ~ noise_gain_adj ();
// shred for input node slider on pitshift
fun void pitshift_input_adj () {
    while (true) {
        pitshift_input => now;
        node[pitshift_in] =< pitshift;
        node[pitshift_input.value () $ int] => pitshift;
        pitshift_input.value () $ int => pitshift_in;
    }
}
spork ~ pitshift_input_adj ();
// shred for output node slider on pitshift
fun void pitshift_output_adj () {
    while (true) {
        pitshift_output => now;
        pitshift =< node[pitshift_out];
        pitshift => node[pitshift_output.value () $ int];
        pitshift_output.value () $ int => pitshift_out;
    }
}
spork ~ pitshift_output_adj ();
// shred for mix slider on pitshift
fun void pitshift_mix_adj () {
    while (true) {
        pitshift_mix => now;
        pitshift.mix (pitshift_mix.value ());
    }
}
spork ~ pitshift_mix_adj ();
// shred for shift slider on pitshift
fun void pitshift_shift_adj () {
    while (true) {
        pitshift_shift => now;
        pitshift.shift (pitshift_shift.value ());
    }
}
spork ~ pitshift_shift_adj ();
// rect label button
fun void rect_label_adj (int r) {
    while (true) {
        rect_label[r] => now;
        if (rect_label[r].state ()) {
            (rect_sel[r] + 1) % 2 => rect_sel[r];
            if (rect_sel[r] == 0) {
                node[rect_in[r]] =< fullrect[r];
                node[rect_input[r].value () $ int] => halfrect[r];
                fullrect[r] =< node[rect_out[r]];
                halfrect[r] => node[rect_output[r].value () $ int];
                rect_label[r].name ("Half Rect " + r);
            }
            if (rect_sel[r] == 1) {
                node[rect_in[r]] =< halfrect[r];
                node[rect_input[r].value () $ int] => fullrect[r];
                halfrect[r] =< node[rect_out[r]];
                fullrect[r] => node[rect_output[r].value () $ int];
                rect_label[r].name ("Full Rect " + r);
            }
        }
    }
}
for (0 => int r; r < num_rects; r++) {
    spork ~ rect_label_adj (r);
}
// shred for input node slider on rects
fun void rect_input_adj (int r) {
    while (true) {
        rect_input[r] => now;
        if (rect_sel[r] == 0) {
            node[rect_in[r]] =< halfrect[r];
            node[rect_input[r].value () $ int] => halfrect[r];
        }
        if (rect_sel[r] == 1) {
            node[rect_in[r]] =< fullrect[r];
            node[rect_input[r].value () $ int] => fullrect[r];
        }
        rect_input[r].value () $ int => rect_in[r];
    }
}
for (0 => int r; r < num_rects; r++) {
    spork ~ rect_input_adj (r);
}
// shred for output node slider on rects
fun void rect_output_adj (int r) {
    while (true) {
        rect_output[r] => now;
        if (rect_sel[r] == 0) {
            halfrect[r] =< node[rect_out[r]];
            halfrect[r] => node[rect_output[r].value () $ int];
        }
        if (rect_sel[r] == 1) {
            fullrect[r] =< node[rect_out[r]];
            fullrect[r] => node[rect_output[r].value () $ int];
        }
        rect_output[r].value () $ int => rect_out[r];
    }
}
for (0 => int r; r < num_rects; r++) {
    spork ~ rect_output_adj (r);
}
// shred for input node slider on zerox
fun void zerox_input_adj (int z) {
    while (true) {
        zerox_input[z] => now;
        node[zerox_in[z]] =< zerox[z];
        node[zerox_input[z].value () $ int] => zerox[z];
        zerox_input[z].value () $ int => zerox_in[z];
    }
}
for (0 => int z; z < num_zerox; z++) {
    spork ~ zerox_input_adj (z);
}
// shred for output node slider on zerox
fun void zerox_output_adj (int z) {
    while (true) {
        zerox_output[z] => now;
        zerox[z] =< node[zerox_out[z]];
        zerox[z] => node[zerox_output[z].value () $ int];
        zerox_output[z].value () $ int => zerox_out[z];
    }
}
for (0 => int z; z < num_zerox; z++) {
    spork ~ zerox_output_adj (z);
}


// shreds to watch ugen buttons and sliders of kbd view
// shred for output node slider on kbd
fun void kbd_output_adj () {
    while (true) {
        kbd_output => now;
        kbd_env =< node[kbd_out];
        kbd_env => node[kbd_output.value () $ int];
        kbd_output.value () $ int => kbd_out;
    }
}
spork ~ kbd_output_adj ();
// shred for monitoring key presses
fun void kbd_note_adj () {
    while (true) {
        hid => now;  // wait for a key press
        while (hid.recv (hidmsg)) {  // while new keys are in queue
            if (hidmsg.isButtonDown ()) {  // check for button down message
                Std.mtof ((kbd_base_note.value () $ int) + hidmsg.which) => kbd.freq;  // set kbd freq
                1 => kbd.gain;  // turn keyboard source on
                kbd_env.keyOn ();  // turn on envelope
                note_period - kbd_env_dur => now;  // wait for note to play
                kbd_env.keyOff ();  // run off envelope
                kbd_env_dur => now;  // allow envelope to decay
            } else {
                0 => kbd.gain;  // turn keyboard source off
            }
        }
    }
}
spork ~ kbd_note_adj ();


// shreds to watch the ugen buttons and sliders of logic gates
// logic gate label button
fun void logic_gate_label_adj (int g) {
    while (true) {
        logic_gate_label[g] => now;
        if (logic_gate_label[g].state ()) {
            (logic_gate_sel[g] + 1) % 6 => logic_gate_sel[g];
            if (logic_gate_sel[g] == 0) {
                logic_gate_label[g].name ("AND " + g);
            }
            if (logic_gate_sel[g] == 1) {
                logic_gate_label[g].name ("OR " + g);
            }
            if (logic_gate_sel[g] == 2) {
                logic_gate_label[g].name ("XOR " + g);
            }
            if (logic_gate_sel[g] == 3) {
                logic_gate_label[g].name ("NAND " + g);
            }
            if (logic_gate_sel[g] == 4) {
                logic_gate_label[g].name ("NOR " + g);
            }
            if (logic_gate_sel[g] == 5) {
                logic_gate_label[g].name ("XNOR " + g);
            }
        }
    }
}
for (0 => int g; g < num_logic_gates; g++) {
    spork ~ logic_gate_label_adj (g);
}
// shred for output node slider on logic gates
fun void logic_gate_output_adj (int g) {
    while (true) {
        logic_gate_output[g] => now;
        logic_gate[g] =< node[logic_gate_out[g]];
        logic_gate[g] => node[logic_gate_output[g].value () $ int];
        logic_gate_output[g].value () $ int => logic_gate_out[g];
    }
}
for (0 => int g; g < num_logic_gates; g++) {
    spork ~ logic_gate_output_adj (g);
}
// shred to continuously monitor logic gates
fun void logic_gate_adj (int g) {
    int value;
    while (true) {
        // loop through the evaluation many times to allow signals to propagate
        for (0 => int propagate; propagate < num_logic_gates; propagate ++) {
            if ((logic_gate_sel[g] % 3) == 0) {  // AND gate or NAND gate
                1 => value;
                for (0 => int i; i < num_logic_inputs; i++) {
                    if (node[logic_gate_input[g][i].value () $ int].last () > 0) {
                        value & 1 => value;
                    } else {
                        value & 0 => value;
                    }
                }
            }
            if ((logic_gate_sel[g] % 3) == 1) {  // OR gate or NOR gate
                0 => value;
                for (0 => int i; i < num_logic_inputs; i++) {
                    if (node[logic_gate_input[g][i].value () $ int].last () > 0) {
                        value | 1 => value;
                    } else {
                        value | 0 => value;
                    }
                }
            }
            if ((logic_gate_sel[g] % 3) == 2) {  // XOR gate or XNOR gate
                0 => value;
                for (0 => int i; i < num_logic_inputs; i++) {
                    if (node[logic_gate_input[g][i].value () $ int].last () > 0) {
                        value ^ 1 => value;
                    } else {
                        value ^ 0 => value;
                    }
                }
            }
            if (logic_gate_sel[g] > 2) {  // gate with inverted output
                if (value > 0) {
                    0 => value;
                } else {
                    1 => value;
                }
            }
            // set the step output value
            logic_gate[g].next (value);
            num_nodes::samp => now;
        }
        // wait one clock cycle, minus the time spent in the previous loop
        clock_period - (num_nodes * num_logic_gates)::samp => now;
    }
}
for (0 => int g; g < num_logic_gates; g++) {
    spork ~ logic_gate_adj (g);
}


// shreds to watch the ugen buttons and sliders of dynos
// dyno label button
fun void dyno_label_adj (int d) {
    while (true) {
        dyno_label[d] => now;
        if (dyno_label[d].state ()) {
            (dyno_sel[d] + 1) % 4 => dyno_sel[d];
            if (dyno_sel[d] == 0) {
                dyno_label[d].name ("Limiter " + d);
                dyno[d].limit ();
            }
            if (dyno_sel[d] == 1) {
                dyno_label[d].name ("Compressor " + d);
                dyno[d].compress ();
            }
            if (dyno_sel[d] == 2) {
                dyno_label[d].name ("Expander " + d);
                dyno[d].expand ();
            }
            if (dyno_sel[d] == 3) {
                dyno_label[d].name ("Noise Gate " + d);
                dyno[d].gate ();
            }
        }
    }
}
for (0 => int d; d < num_dynos; d++) {
    spork ~ dyno_label_adj (d);
}
// shred for input node slider on dynos
fun void dyno_input_adj (int d) {
    while (true) {
        dyno_input[d] => now;
        node[dyno_in[d]] =< dyno[d];
        node[dyno_input[d].value () $ int] => dyno[d];
        dyno_input[d].value () $ int => dyno_in[d];
    }
}
for (0 => int d; d < num_dynos; d++) {
    spork ~ dyno_input_adj (d);
}
// shred for output node slider on dynos
fun void dyno_output_adj (int d) {
    while (true) {
        dyno_output[d] => now;
        dyno[d] =< node[dyno_out[d]];
        dyno[d] => node[dyno_output[d].value () $ int];
        dyno_output[d].value () $ int => dyno_out[d];
    }
}
for (0 => int d; d < num_dynos; d++) {
    spork ~ dyno_output_adj (d);
}


// shreds to watch ugen buttons and sliders of echo view
// shred for input node slider on echos
fun void echo_input_adj (int e) {
    while (true) {
        echo_input[e] => now;
        node[echo_in[e]] =< echo[e];
        node[echo_input[e].value () $ int] => echo[e];
        echo_input[e].value () $ int => echo_in[e];
    }
}
for (0 => int e; e < num_echos; e++) {
    spork ~ echo_input_adj (e);
}
// shred for output node slider on echos
fun void echo_output_adj (int e) {
    while (true) {
        echo_output[e] => now;
        echo[e] =< node[echo_out[e]];
        echo[e] => node[echo_output[e].value () $ int];
        echo_output[e].value () $ int => echo_out[e];
    }
}
for (0 => int e; e < num_echos; e++) {
    spork ~ echo_output_adj (e);
}
// shred for delay node slider on echos
fun void echo_delay_adj (int e) {
    while (true) {
        echo_delay[e] => now;
        echo[e].delay (echo_delay[e].value () :: ms);
    }
}
for (0 => int e; e < num_echos; e++) {
    spork ~ echo_delay_adj (e);
}
// shred for mix node slider on echos
fun void echo_mix_adj (int e) {
    while (true) {
        echo_mix[e] => now;
        echo[e].mix (echo_mix[e].value ());
    }
}
for (0 => int e; e < num_echos; e++) {
    spork ~ echo_mix_adj (e);
}


// LEDs
// shred to watch nodes and light LEDs
fun void led_adj () {
    while (true) {
        for (1 => int n; n <= num_nodes; n++) {
            if (node[n].last () > 0) {
                led_led[n-1].light ();
            } else {
                led_led[n-1].unlight ();
            }
        }
        note_period / 4 => now;
    }
}
spork ~ led_adj ();


// patch panel
fun void patch_connect_adj () {
    while (true) {
        patch_connect => now;
        if (patch_connect.state ()) {
            for (0 => int nx; nx < num_nodes; nx++) {
                for (0 => int ny; ny < num_nodes; ny++) {
                    if (patch_dot[nx][ny].state ()) {
                        node[nx+1] => patch[nx][ny];
                        patch[nx][ny] => node[ny+1];
                        patch_dot[nx][ny].name ("X");
                    } else {
                        node[nx+1] =< patch[nx][ny];
                        patch[nx][ny] =< node[ny+1];
                        patch_dot[nx][ny].name ("");
                    }
                }
            }
        }
    }
}
spork ~ patch_connect_adj ();


// lisa panel controls
// shred for voice input node slider on lisa
fun void lisa_voice_input_adj () {
    while (true) {
        lisa_voice_input => now;
        lisa_voice_input.value () $ int => lisa_voice_in;
    }
}
spork ~ lisa_voice_input_adj ();
// shred for rate input node slider on lisa
fun void lisa_rate_input_adj () {
    while (true) {
        lisa_rate_input => now;
        lisa_rate_input.value () $ int => lisa_rate_in;
    }
}
spork ~ lisa_rate_input_adj ();
// shred to set rate for lisa
fun void lisa_rate_adj () {
    while (true) {
        lisa_rate => now;
        lisa.rate (lisa_voice.value () $ int, lisa_rate.value ());
    }
}
spork ~ lisa_rate_adj ();
// shred for clear input node slider on lisa
fun void lisa_clear_input_adj () {
    while (true) {
        lisa_clear_input => now;
        lisa_clear_input.value () $ int => lisa_clear_in;
    }
}
spork ~ lisa_clear_input_adj ();
// shred for clear button on lisa
fun void lisa_clear_adj () {
    while (true) {
        lisa_clear => now;
        if (lisa_clear.state ()) {
            lisa.clear ();
        }
    }
}
spork ~ lisa_clear_adj ();
// shred for record input node slider on lisa
fun void lisa_record_input_adj () {
    while (true) {
        lisa_record_input => now;
        lisa_record_input.value () $ int => lisa_record_in;
    }
}
spork ~ lisa_record_input_adj ();
// shred for play input node slider on lisa
fun void lisa_play_input_adj () {
    while (true) {
        lisa_play_input => now;
        lisa_play_input.value () $ int => lisa_play_in;
    }
}
spork ~ lisa_play_input_adj ();
// shred for record button on lisa
fun void lisa_record_adj () {
    while (true) {
        lisa_record => now;
        if (lisa_record.state ()) {
            lisa.recPos (0::second);
            lisa.record (1);
        } else {
            lisa.record (0);
        }
    }
}
spork ~ lisa_record_adj ();
// shred for play button on lisa
fun void lisa_play_adj () {
    while (true) {
        lisa_play => now;
        if (lisa_play.state ()) {
            lisa.playPos (lisa_voice.value () $ int, 0::second);
            lisa.rampUp (lisa_voice.value () $ int, lisa_ramp_duration);
        } else {
            lisa.rampDown (lisa_voice.value () $ int, lisa_ramp_duration);
        }
    }
}
spork ~ lisa_play_adj ();
// shred for backward button on lisa
fun void lisa_backward_adj () {
    while (true) {
        lisa_backward => now;
        if (lisa_backward.state ()) {
            lisa.bi (lisa_voice.value () $ int, 1);
        } else {
            lisa.bi (lisa_voice.value () $ int, 0);
        }
    }
}
spork ~ lisa_backward_adj ();
// shred for input node slider on lisa
fun void lisa_input_adj () {
    while (true) {
        lisa_input => now;
        if (lisa_in > 0) {
            node[lisa_in] =< lisa;
        }
        if (lisa_input.value () > 0) {
            node[lisa_input.value () $ int] => lisa;
        }
        lisa_input.value () $ int => lisa_in;
    }
}
spork ~ lisa_input_adj ();
// shred for output node slider on lisa
fun void lisa_output_adj () {
    while (true) {
        lisa_output => now;
        if (lisa_out >0) {
            lisa =< node[lisa_out];
        }
        if (lisa_output.value () > 0) {
            lisa => node[lisa_output.value () $ int];
        }
        lisa_output.value () $ int => lisa_out;
    }
}
spork ~ lisa_output_adj ();
// shred to monitor control inputs and behave accordingly for lisa
fun void lisa_adj () {
    float voice, clear, record, play, backward;
    // get previous values of control inputs
    float previous_clear, previous_record, previous_play, previous_backward;
    if (lisa_clear_in) {
        node[lisa_clear_in].last () => previous_clear;
    } else {
        0 => previous_clear;
    }
    if (lisa_record_in) {
        node[lisa_record_in].last () => previous_record;
    } else {
        0 => previous_record;
    }
    if (lisa_play_in) {
        node[lisa_play_in].last () => previous_play;
    } else {
        0 => previous_play;
    }
    if (lisa_backward_in) {
        node[lisa_backward_in].last () => previous_backward;
    } else {
        0 => previous_backward;
    }
    while (true) {
        // get input values, null if connected to node 0
        if (lisa_voice_in) {
            node[lisa_voice_in].last () => voice;
        } else {
            0 => voice;
        }
        if (lisa_clear_in) {
            node[lisa_clear_in].last () => clear;
        } else {
            0 => clear;
        }
        if (lisa_record_in) {
            node[lisa_record_in].last () => record;
        } else {
            0 => record;
        }
        if (lisa_play_in) {
            node[lisa_play_in].last () => play;
        } else {
            0 => play;
        }
        if (lisa_backward_in) {
            node[lisa_backward_in].last () => backward;
        } else {
            0 => backward;
        }
        // check for a logic 0 to logic 1 transition on clear input
        if ( (node[lisa_clear_in].last () > 0) & (previous_clear <= 0) ) {
            // call the lisa clear method
            lisa.clear ();
        }
        // if record button is pressed or 0 to 1 transition of record input
        if (lisa_record.state () | (node[lisa_record_in].last () > 0) & (previous_record <= 0) ) {
            // set the record position to the beginning
            lisa.recPos (0::second);
            // call the lisa record method
            lisa.record (1);
        }
        // if record button is released or check for a logic 1 to logic 0 transition on record input
        if (!lisa_record.state () | (node[lisa_record_in].last () <= 0) & (previous_record > 0) ) {
            // call the lisa record method
            lisa.record (0);
        }
        // if either the play button is pressed or we have a logic 0 to 1 transition on the inputt
        if (lisa_play.state () | (node[lisa_play_in].last () > 0) & (previous_play <= 0) ) {
            // set the play position to the beginning
            lisa.playPos (node[lisa_voice_in].last () $ int, 0::second);
            // call the lisa play method
            lisa.rampUp (node[lisa_voice_in].last () $ int, lisa_ramp_duration);
            // check for a logic 1 to logic 0 transition on play input
            if ( (node[lisa_play_in].last () <= 0) & (previous_play > 0) ) {
                // call the lisa play method
                //lisa.rampDown (node[lisa_voice_in].last () $ int, lisa_ramp_duration);
            }
        }
        // make sure the backward button is not pressed
        if (!lisa_backward.state ()) {
            // check for a logic 0 to logic 1 transition on backward input
            if ( (node[lisa_backward_in].last () > 0) & (previous_backward <= 0) ) {
                // call the lisa backward method
                lisa.bi (node[lisa_voice_in].last () $ int, 1);
            }
            // check for a logic 1 to logic 0 transition on backward input
            if ( (node[lisa_backward_in].last () <= 0) & (previous_backward > 0) ) {
                // call the lisa play method
                lisa.bi (node[lisa_voice_in].last () $ int, 0);
            }
        }
        // save previous values of control inputs
        clear => previous_clear;
        record => previous_record;
        play => previous_play;
        backward => previous_backward;
        // time delay
        note_period => now;
    }
}
spork ~ lisa_adj ();


// initialization of instruments
fun void initialize () {
    // initialize clock frequency
    1::second / main_clock_freq.value () => clock_period;
    // initialize note frequency
    1::second / main_note_freq.value () => note_period;
    // initialize main volume
    master_left.gain (main_volume.value ());
    master_right.gain (main_volume.value ());
    // initialize nodes
    for (1 => int n; n <= num_nodes; n++) {
        node[n].gain (node_gain[n].value ());
        // initialize the gain boosts
        1 => node_boost_val[n];
    }
    // initialize gains
    for (0 => int g; g < num_gains; g++) {
        node[g].gain (gain_gain[g].value ());
    }
    // initialize oscillators
    for (0 => int o; o < num_osc; o++) {
        phasor[o].gain (osc_gain[o].value ());
        phasor[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        phasor[o].phase (osc_phase[o].value ());
        sinosc[o].gain (osc_gain[o].value ());
        sinosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sinosc[o].phase (osc_phase[o].value ());
        pulseosc[o].gain (osc_gain[o].value ());
        pulseosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        pulseosc[o].phase (osc_phase[o].value ());
        sqrosc[o].gain (osc_gain[o].value ());
        sqrosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sqrosc[o].phase (osc_phase[o].value ());
        triosc[o].gain (osc_gain[o].value ());
        triosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        triosc[o].phase (osc_phase[o].value ());
        sawosc[o].gain (osc_gain[o].value ());
        sawosc[o].freq (osc_freq1[o].value () * Math.pow(10, osc_freq2[o].value ()));
        sawosc[o].phase (osc_phase[o].value ());
    }
    // initialize filters
    for (0 => int f; f < num_filters; f++) {
        lpf[f].gain (filter_gain[f].value ());
        lpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
        lpf[f].Q (filter_q[f].value ());
        bpf[f].gain (filter_gain[f].value ());
        bpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
        bpf[f].Q (filter_q[f].value ());
        hpf[f].gain (filter_gain[f].value ());
        hpf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
        hpf[f].Q (filter_q[f].value ());
        brf[f].gain (filter_gain[f].value ());
        brf[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
        brf[f].Q (filter_q[f].value ());
        resonz[f].gain (filter_gain[f].value ());
        resonz[f].freq (filter_freq1[f].value () * Math.pow(10, filter_freq2[f].value ()));
        resonz[f].Q (filter_q[f].value ());
    }
    // initialize delays
    for (0 => int d; d < num_delays; d++) {
        delay[d].gain (delay_gain[d].value ());
        delay[d].max (100::ms);
        delay[d].delay (delay_dur[d].value () :: ms);
        delaya[d].gain (delay_gain[d].value ());
        delaya[d].max (100::ms);
        delaya[d].delay (delay_dur[d].value () :: ms);
        delayl[d].gain (delay_gain[d].value ());
        delayl[d].max (100::ms);
        delayl[d].delay (delay_dur[d].value () :: ms);
    }
    // initialize reverbs
    for (0 => int r; r < num_reverbs; r++) {
        jcrev[r].mix (reverb_mix[r].value ());
        nrev[r].mix (reverb_mix[r].value ());
        prcrev[r].mix (reverb_mix[r].value ());
    }
    // initialize envelopes
    for (0 => int e; e < num_envelopes; e++) {
        envelope[e].duration (envelope_duration[e].value () :: second);
    }
    // initialize misc view objects
    noise.gain (noise_gain.value ());
    pitshift.mix (pitshift_mix.value ());
    pitshift.shift (pitshift_shift.value ());
    // initialize keyboard
    if (!hid.openKeyboard (kbd_device)) {
        1 => exit;
    }
    <<<"keyboard " + hid.name () + " ready", "">>>;
    0 => kbd.gain;  // turn keyboard source off
    kbd_env.duration (kbd_env_dur);  // set keyboard envelope duration
    // initialize echos
    for (0 => int e; e < num_echos; e++) {
        echo[e].max (1::second);
        echo[e].delay (echo_delay[e].value () :: ms);
    }
    // initialize patch panel
    for (0 => int nx; nx < num_nodes; nx++) {
        for (0 => int ny; ny < num_nodes; ny++) {
            patch[nx][ny].gain (1);
        }
    }
    // initialize lisa
    lisa.duration (lisa_buffer_duration);
    lisa.maxVoices (lisa_max_voices);
    lisa.clear ();
    // connect sinosc[0] to DAC node so Synth Lab starts up making sound
    //if (num_osc > 0) {
    //    osc_output[0].value (num_nodes);
    //    sinosc[0] => node[osc_output[0].value () $ int];
    //}
}
initialize ();


fun void main_loop () {
// loop until self-destruct signal is received
while (true) {
    note_period => now;
    if (exit) {  // self destruct activated
        break;
    }
}


// oops!  check to see if we exited while recording and if so close the output file
if (main_record.state ()) {
    wvout.closeFile ();
}


// pop up an exit window with a goodbye message (why not?)
MAUI_View self_destruct_view;
self_destruct_view.size (300, 50);
self_destruct_view.position (screen_width / 2 - 300 / 2, screen_height /2 - 50 / 2);
self_destruct_view.name ("Synth Lab Exiting");
self_destruct_view.display ();
MAUI_Button self_destruct_message;
// self destruct message button
self_destruct_message.pushType ();
self_destruct_message.size (300, 60);
self_destruct_message.position (0, 0);
self_destruct_message.name ("May the force be with you!");
self_destruct_view.addElement (self_destruct_message);


// self destruct warning!  make a fun sound just before closing the panels
Phasor exit_phasor => SinOsc exit_sinosc => Gain exit_gain => Dyno exit_dyno => dac;
dac => Delay exit_delay => exit_gain;
exit_phasor.gain (1000);
exit_phasor.freq (2);
exit_gain.gain (2);
exit_dyno.limit ();
exit_delay.gain (1);
exit_delay.max (200::ms);
exit_delay.delay (50::ms);
1.5::second => now;


// ending program due to self-destruct button press, so destroy the GUI
lisa_view.destroy ();
patch_view.destroy ();
led_view.destroy ();
echo_view.destroy ();
dyno_view.destroy ();
logic_gate_view.destroy ();
kbd_view.destroy ();
misc_view.destroy ();
envelope_view.destroy ();
counter_view.destroy ();
reverb_view.destroy ();
delay_view.destroy ();
filter_view.destroy ();
osc_view.destroy ();
gain_view.destroy ();
node_view.destroy ();
main_view.destroy ();
self_destruct_view.destroy ();
}

spork ~ main_loop ();

}  // end of synth lab class definition






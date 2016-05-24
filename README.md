#library for chuck composition

## Required chugins(https://github.com/ccrma/chugins)
1. Gverb

## Description
### The purpose is implementing a text-based DAW(digital audio workstation),including
    1.  a mixer: Master,Bus,Fx Send etc.
    2.  basic music modules: Note(TODO), Scale, Chord
    2.  instruments: drum machine(TODO), bass ,guitar(TODO)  etc.
    3.  effects : FeedBackDelay etc.
    4.  algorithm composition modules
        1.  algorithm sequence generator
            1. implemented: Fibonacci, Euclid
            2. TODO: cellular automata, Markov chain etc
        2.  spectral composition(working on)
            1. risset appregio, resset beat
            2. FibonacciPad
        3.  grain synthesis(working on)


## directory
1. lib : implemented library 
    1. lib/basic : basic libraries for music: scale,chord,bpm etc.
    2. lib/instrument : instruments
    3. lib/effect :  effects
    4. lib/mixer : mixer: master , send ,return
    5. lib/seq : sequence generator
2. exlib : experiment library
3. exlib2 : experement library (not chuck code)
4. composition : compositions
5. test: test unity
6. autogen.sh : generate run.ck automatically

## run
>   chuck run.ck:composition/fibo/fibo.ck
>   chuck run.ck:composition/mando/mando.ck

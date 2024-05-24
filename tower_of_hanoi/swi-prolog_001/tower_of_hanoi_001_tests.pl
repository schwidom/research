
:- use_module( library( plunit)).
:- use_module( library( solution_sequences)).

:- consult( 'tower_of_hanoi_001.pl').

:- set_test_options(format(log)).

:- set_prolog_flag( answer_write_options, [quoted(true), portray(true), max_depth(50), spacing(next_argument)]).

:- begin_tests( toh_001).

test( toh_001) :- toh_create3( OBJ1), bagof( toh_move( X, Y, OBJ1, OBJ2), toh_move( X, Y, OBJ1, OBJ2), L)
, L =@= [
    toh_move(0,1,[[_30888|_30890],_30894,_30900],[_30890,[_30888|_30894],_30900]),
    toh_move(0,2,[[_30824|_30826],_30830,_30836],[_30826,_30830,[_30824|_30836]]),
    toh_move(1,0,[_30760,[_30772|_30774],_30778],[[_30772|_30760],_30774,_30778]),
    toh_move(1,2,[_30696,[_30708|_30710],_30714],[_30696,_30710,[_30708|_30714]]),
    toh_move(2,0,[_30632,_30638,[_30650|_30652]],[[_30650|_30632],_30638,_30652]),
    toh_move(2,1,[_30568,_30574,[_30586|_30588]],[_30568,[_30586|_30574],_30588])]
.

test( toh_002) :- toh_create(4, OBJ1), toh_create(4, OBJ2), L=[1,2,3,4], OBJ1=[L,[],[],[]], OBJ2=[[],[],[],L], length( MOVES,9), limit( 1, toh_search2( OBJ1, OBJ2, MOVES))
, MOVES =@= [0-3, 0-2, 3-2, 0-1, 0-3, 2-0, 1-3, 2-3, 0-3]
.

:- end_tests( toh_001).

% run_tests


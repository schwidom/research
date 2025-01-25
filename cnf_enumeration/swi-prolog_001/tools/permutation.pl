
:- use_module( library( error)). % must_be

:- consult( 'combn.pl').

sorted_to_permutation_indicator( COUNT, L1, L2) :- COUNT = _, L1 = [], L2 = [], !.
sorted_to_permutation_indicator( COUNT, L1, L2) :- L1 = [_], L2 = [COUNT], !. 

sorted_to_permutation_indicator( COUNT, L1, L2) :- L1 = [ H11, H12 | T1], L2 = [ H21, H22 | T2 ]
, ( H11 == H12 
     -> maplist( =( COUNTNEXT ), [ COUNT, H21, H22 ] )
     ; COUNTNEXT is COUNT + 1, H21 = COUNT, H22 = COUNTNEXT
  )
, sorted_to_permutation_indicator( COUNTNEXT, [ H12 | T1 ], [ H22 | T2 ])
.

sorted_to_permutation_indicator0( SORTED, PERMUTATION_CLASS_IDS) :- true
, sorted_to_permutation_indicator( 0, SORTED, PERMUTATION_CLASS_IDS)
.

/*

% (ins)?- sorted_to_permutation_indicator0( [], L).
% L = [].
% 
% (ins)?- sorted_to_permutation_indicator0( [a], L).
% L = [0].
% 
% (ins)?- sorted_to_permutation_indicator0( [a, a], L).
% L = [0, 0].
% 
% (ins)?- sorted_to_permutation_indicator0( [b, a, a], L).
% L = [0, 1, 1].
% 
% (ins)?- sorted_to_permutation_indicator0( [b, b, a], L).
% L = [0, 0, 1].
% 
% (ins)?- sorted_to_permutation_indicator0( [b, b, b], L).
% L = [0, 0, 0].
% 
% (ins)?- sorted_to_permutation_indicator0( [b, a, b], L).
% L = [0, 1, 2].

*/

split_permutation_class( PERMUTATION_CLASS_IDS, L1, L2) :- true 
, transpose( [ PERMUTATION_CLASS_IDS, L1 ], ZIPPED)
, findall( LM, bagof( E1, member( [ _PCID, E1], ZIPPED), LM ), L2)
.

/*

% (ins)?- split_permutation_class( [ 0, 1, 1, 2], [a, b, c, d], L).
% L = [[a], [b, c], [d]].
% 
% (cmd)?- split_permutation_class( [ 0, 0, 2, 2], [a, b, c, d], L).
% L = [[a, b], [c, d]].

% (ins)?- split_permutation_class( [ 0, 0, 2, 2, 2, 3, 3], [a, b, c, d, e, f, g], L), maplist( permutation, L, LP), flatten( LP, LPF), writeln( LPF), false.
% [a,b,c,d,e,f,g]
% [a,b,c,d,e,g,f]
% [a,b,c,e,d,f,g]
% [a,b,c,e,d,g,f]
% [a,b,d,c,e,f,g]
% [a,b,d,c,e,g,f]
% [a,b,d,e,c,f,g]
% [a,b,d,e,c,g,f]
% [a,b,e,c,d,f,g]
% [a,b,e,c,d,g,f]
% [a,b,e,d,c,f,g]
% [a,b,e,d,c,g,f]
% [b,a,c,d,e,f,g]
% [b,a,c,d,e,g,f]
% [b,a,c,e,d,f,g]
% [b,a,c,e,d,g,f]
% [b,a,d,c,e,f,g]
% [b,a,d,c,e,g,f]
% [b,a,d,e,c,f,g]
% [b,a,d,e,c,g,f]
% [b,a,e,c,d,f,g]
% [b,a,e,c,d,g,f]
% [b,a,e,d,c,f,g]
% [b,a,e,d,c,g,f]
% false.


*/

% permutates the classes

interpermutation( PERMUTATION_CLASS_IDS, L1, L2) :- true
, split_permutation_class( PERMUTATION_CLASS_IDS, L1, LSP)
, maplist( permutation, LSP, LP)
% , flatten( LP, L2)
, append( LP, L2)
.

/*

% (ins)?- interpermutation( [ 0, 0, 2, 2, 2, 3, 3], [a, b, c, d, e, f, g], L), writeln( L), false.
% [a,b,c,d,e,f,g]
% [a,b,c,d,e,g,f]
% [a,b,c,e,d,f,g]
% [a,b,c,e,d,g,f]
% [a,b,d,c,e,f,g]
% [a,b,d,c,e,g,f]
% [a,b,d,e,c,f,g]
% [a,b,d,e,c,g,f]
% [a,b,e,c,d,f,g]
% [a,b,e,c,d,g,f]
% [a,b,e,d,c,f,g]
% [a,b,e,d,c,g,f]
% [b,a,c,d,e,f,g]
% [b,a,c,d,e,g,f]
% [b,a,c,e,d,f,g]
% [b,a,c,e,d,g,f]
% [b,a,d,c,e,f,g]
% [b,a,d,c,e,g,f]
% [b,a,d,e,c,f,g]
% [b,a,d,e,c,g,f]
% [b,a,e,c,d,f,g]
% [b,a,e,c,d,g,f]
% [b,a,e,d,c,f,g]
% [b,a,e,d,c,g,f]
% false.

% (cmd)?- interpermutation( [ 0, 0], [a, b], L), writeln( L), false.
% [a,b]
% [b,a]
% false.
% 
% (cmd)?- interpermutation( [ 0, 1], [a, b], L), writeln( L), false.
% [a,b]
% false.
% 
% (cmd)?- interpermutation( [ 0], [a], L), writeln( L), false.
% [a]
% false.
% 
% (cmd)?- interpermutation( [ ], [], L), writeln( L), false.
% []
% false.


*/

% masterpiece, allows the class permutation, that means the permutation without changing the order of the classes
permute_classes( CLASSNUMBERS, L1, L2) :- true
, length( L1, L1_LEN)
, foldl( plus, CLASSNUMBERS, 0, SUM)
, must_be( oneof( [SUM]), L1_LEN)
, iota0( L1_LEN, L1_IOTA)
, scanl( [CN, IDXs, IOTA, REST]>>( combn_rest( IOTA, CN, IDXs, REST) ), CLASSNUMBERS, IDXss, L1_IOTA, _RESULT)
% , writeln( ( idxss - IDXss, res - RESULT))
, append( IDXss, LIDX)
, index0_transposed( LIDX, L1, L2)
.

/*

% (ins)?- aggregate_all( count, permute_classes( [2, 2, 2], [a, b, c, d, e, f], _), C).
% C = 90.
% 
% (ins)> factorial( 6) / 2 / 2 / 2
% [1] 90
% 
% (ins)?- permute_classes( [1, 1, 1], [a, b, c], L).
% L = [a, b, c] ;
% L = [a, c, b] ;
% L = [b, a, c] ;
% L = [c, a, b] ;
% L = [b, c, a] ;
% L = [c, b, a] ;
% false.
% 
% 
% (ins)?- aggregate_all( count, permute_classes( [2, 2, 2, 2, 2, 2], [a, b, c, d, e, f, i, g, h, i, k, l], L), C).
% C = 7484400.
% 
% (ins)> factorial( 12) / (2**6)
% [1] 7484400

% (ins)?- aggregate_all( count, permute_classes( [2, 3, 2, 3], [a, b, c, d, e, f, i, g, h, i], L), C).
% C = 25200.
% 
% 
% (cmd)?- aggregate_all( count, permute_classes( [3, 2, 2, 3], [a, b, c, d, e, f, i, g, h, i], L), C).
% C = 25200.
% 
% (ins)> factorial( 10) / 2 / 2 / factorial( 3)**2
% [1] 25200

% (cmd)> factorial( 14) / factorial( 3) **2 / factorial( 4) **2
% [1] 4204200
% 
% (ins)?- time( aggregate_all( count, permute_classes( [3, 4, 3, 4], [a, b, c, d, e, f, g, h, i, k, z, y, x, w], RES), C)).
% % 656,395,578 inferences, 57.026 CPU in 57.047 seconds (100% CPU, 11510409 Lips)
% C = 4204200.



*/

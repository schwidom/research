
% similar to order in R

order0( LIST, ORDER) :- true
, length( LIST, LEN), LEN0 is LEN-1
, numlist( 0, LEN0, INCLIST)
, pairs_keys_values(PAIRS, LIST, INCLIST)
, msort( PAIRS, SPAIRS)
, pairs_values( SPAIRS, ORDER).

order0_transposed( LIST, ORDER_TRANSPOSED) :- true
, order0( LIST, ORDER)
, order0( ORDER, ORDER_TRANSPOSED)
.

index0( ORDER, LIST, LISTORDERED) :- true
, order0( ORDER, ORDER_TRANSPOSED)
, pairs_keys_values( PAIRS, ORDER_TRANSPOSED, LIST)
, msort( PAIRS, SPAIRS)
, pairs_values( SPAIRS, LISTORDERED)
.

index0_transposed( ORDER, LIST, LISTORDERED) :- true
, pairs_keys_values( PAIRS, ORDER, LIST)
, msort( PAIRS, SPAIRS)
, pairs_values( SPAIRS, LISTORDERED)
.

/*

% (ins)?- order0( [a, a, t, g, t, w, d], ORDER), index0( ORDER, [a, a, t, g, t, w, d], L).
% ORDER = [0, 1, 6, 3, 2, 4, 5],
% L = [a, a, d, g, t, t, w].

% (ins)?- LIST=[a, a, t, g, t, w, d], order0( LIST, ORDER), index0( ORDER, [a, a, t, g, t, w, d], L), index0_transposed( ORDER, L, L2).
% LIST = L2, L2 = [a, a, t, g, t, w, d],
% ORDER = [0, 1, 6, 3, 2, 4, 5],
% L = [a, a, d, g, t, t, w].


*/


iota0( N, L) :- iota0( N, 0, L).

iota0( N, VALUE, L) :- N = 0, VALUE = _, L = [], !.
iota0( N, VALUE, L) :- N \== 0
, NNext is N - 1
, VNext is VALUE + 1
, L = [ VALUE | T ]
, iota0( NNext, VNext, T)
.

bubble_compare_sets( GOAL, L1, L2) :- true
, maplist( is_set, [L1, L2])
, length( L1, LEN)
, length( L2, LEN)
, TERM = ( nth0( IDX1, L1, E1), nth0( IDX2, L2, E2), IDX1 =< IDX2, call( GOAL, E1, E2), member( IDX, [IDX1, IDX2]))
, term_variables( TERM, VARS)
, setof( IDX, VARS^TERM, SET)
, iota0( LEN, IOTA)
, SET == IOTA
.

/*

% (ins)?- bubble_compare_lists( ==, [1, 1, 3], [3, 3, 1]).
% false.
% 
% (ins)?- bubble_compare_lists( ==, [1, 1, 3], [3, 3, 1]).
% false.
% 
% (ins)?- bubble_compare_lists( ==, [1, 2, 3], [3, 2, 1]).
% true.
% 
% (ins)?- bubble_compare_lists( ==, [1, 2, 3], [1, 2, 3, 3]).
% false.

*/

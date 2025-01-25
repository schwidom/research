combine_01( LENGTH, LIST) :- LENGTH #= 0, LIST = [].

combine_01( LENGTH, LIST) :- LENGTH #\= 0, dif( LIST, []) % LIST \== [] geht, LIST \= [] geht nicht
% , length( LIST, LENGTH)
, LEN2 #= LENGTH - 1
, LIST = [H|T]
, member( H, [ 0, 1])
, combine_01( LEN2, T)
.

combine_01_safe( LENGTH, LIST) :- length( LIST, LENGTH), combine_01( LENGTH, LIST).

% TERM= combine_01_safe( LEN, L), TERM, writeln( TERM), false.

combine_01_fast( LENGTH, LIST) :- LENGTH = 0, LIST = [], !.
combine_01_fast( LENGTH, LIST) :- true % LENGTH \== 0, LIST \== []
, LEN2 is LENGTH - 1
, LIST = [H|T]
, member( H, [ 0, 1])
, combine_01_fast( LEN2, T)
.

combine_01_fast_safe( LENGTH, LIST) :- length( LIST, LENGTH), combine_01_fast( LENGTH, LIST).

% TERM= combine_01_fast_safe( LEN, L), TERM, writeln( TERM), false.

combine_012_fast( LENGTH, LIST) :- LENGTH = 0, LIST = [], !.
combine_012_fast( LENGTH, LIST) :- true % LENGTH \== 0, LIST \== []
, LEN2 is LENGTH - 1
, LIST = [H|T]
, member( H, [ 0, 1, 2])
, combine_012_fast( LEN2, T)
.

combine_012_fast_safe( LENGTH, LIST) :- length( LIST, LENGTH), combine_012_fast( LENGTH, LIST).

% TERM= combine_012_fast_safe( LEN, L), TERM, writeln( TERM), false.

combinations( LENGTH, RESULT) :- true
, findall( COMBINATIONS, combine_01_fast( LENGTH, COMBINATIONS), L_COMBINATIONS)
, maplist( msort, L_COMBINATIONS, L_COMBINATIONS2)
, sort( L_COMBINATIONS2, RESULT)
.

combinations_list( LENGTH, RESULT) :- true
, TERM= ( between( 0, LENGTH, B), combinations( B, COMB), length( COMB, COMB_COUNT))

, findall( COMB_COUNT, TERM, RESULT)
.

/*

% (ins)?- combinations_list( 15, L), scanl( plus, L, 0, R).
% L = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
% R = [0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78, 91, 105, 120, 136].
% 
% (ins)?- numlist( 1, 100, L), scanl( plus, L, 0, R).
% L = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100],

*/

combinations_012( LENGTH, RESULT) :- true
, findall( COMBINATIONS, combine_012_fast( LENGTH, COMBINATIONS), L_COMBINATIONS)
, maplist( msort, L_COMBINATIONS, L_COMBINATIONS2)
, sort( L_COMBINATIONS2, RESULT)
.

combinations_012_list( LENGTH, RESULT) :- true
, TERM= ( between( 0, LENGTH, B), combinations_012( B, COMB), length( COMB, COMB_COUNT))

, findall( COMB_COUNT, TERM, RESULT)
.

/*

% (ins)?- combinations_012_list( 13, L).
% L = [1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78, 91, 105].

*/


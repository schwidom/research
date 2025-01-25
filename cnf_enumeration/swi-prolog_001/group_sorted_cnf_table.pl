:- table group_sorted_cnf_table/3 .

group_sorted_cnf_table( RULECOUNT, VARCOUNT, CNF_ORDERED) :- true
, create_cnf( RULECOUNT, VARCOUNT, CNF)
% only the CNFs of a GROUP can represent each other
, maplist( msort, CNF, CNF_GROUP) 
, order0( CNF_GROUP, CNF_GROUP_ORDER)
, index0( CNF_GROUP_ORDER, CNF, CNF_ORDERED)
.

:- table group_sorted_cnf_table/4 .

group_sorted_cnf_table( RULECOUNT, VARCOUNT, CNF_ORDERED, PERMUTATION_CLASS_IDS) :- true
, create_cnf( RULECOUNT, VARCOUNT, CNF)
% only the CNFs of a GROUP can represent each other
, maplist( msort, CNF, CNF_GROUP) 
, order0( CNF_GROUP, CNF_GROUP_ORDER)
, index0( CNF_GROUP_ORDER, CNF_GROUP, CNF_GROUP2) 
, index0( CNF_GROUP_ORDER, CNF, CNF_ORDERED)
, sorted_to_permutation_indicator0( CNF_GROUP2, PERMUTATION_CLASS_IDS)
.

/*
% (cmd)?- aggregate_all( set( PC), cnf(4, 3, _, PC), C).
% C = [[0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 1, 1], [0, 0, 1, 2], [0, 1, 1, 1], [0, 1, 1, 2], [0, 1, 2, 2], [0, 1, 2, 3]].

% (ins)?- aggregate_all( count, cnf(4, 3, _, _), C).
% C = 17550.

% (cmd)?- aggregate_all( count, create_cnf( 4, 3, CNF), C).
% C = 17550.

% (ins)?- aggregate_all( count, cnf(4, 4, _, _), C).
% C = 1663740.

% (cmd)?- aggregate_all( count, create_cnf( 4, 4, CNF), C).
% C = 1663740.

% (ins)?- aggregate( count , set( CNF), cnf(4, 3, CNF, PC), C).
% PC = [0, 0, 0, 0],
% C = 15 ;
% PC = [0, 0, 0, 1],
% C = 293 ;
% PC = [0, 0, 1, 1],
% C = 405 ;
% PC = [0, 0, 1, 2],
% C = 2259 ;
% PC = [0, 1, 1, 1],
% C = 271 ;
% PC = [0, 1, 1, 2],
% C = 3009 ;
% PC = [0, 1, 2, 2],
% C = 2040 ;
% PC = [0, 1, 2, 3],
% C = 9258.


% (ins)?- aggregate( count , set( CNF), cnf(4, 4, CNF, PC), C).
% PC = [0, 0, 0, 0],
% C = 1536 ;
% PC = [0, 0, 0, 1],
% C = 26580 ;
% PC = [0, 0, 1, 1],
% C = 31941 ;
% PC = [0, 0, 1, 2],
% C = 196188 ;
% PC = [0, 1, 1, 1],
% C = 25308 ;
% PC = [0, 1, 1, 2],
% C = 251880 ;
% PC = [0, 1, 2, 2],
% C = 182769 ;
% PC = [0, 1, 2, 3],
% C = 947538.

*/

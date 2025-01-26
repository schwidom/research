
:- table cnf_only_minpermutation1/3.

cnf_only_minpermutation1( RULECOUNT, VARCOUNT, CNF_ONLY_MINPERMUTATION) :- true
, cnf_minpermutation1( RULECOUNT, VARCOUNT, _CNF, CNF_MINPERMUTATION)
, CNF_ONLY_MINPERMUTATION = CNF_MINPERMUTATION
.

:- table cnf_only_minpermutation2/3.

cnf_only_minpermutation2( RULECOUNT, VARCOUNT, CNF_ONLY_MINPERMUTATION) :- true
, cnf_minpermutation2( RULECOUNT, VARCOUNT, _CNF, CNF_MINPERMUTATION)
, CNF_ONLY_MINPERMUTATION = CNF_MINPERMUTATION
.

/*

% (cmd)?- aggregate_all( count, cnf_only_minpermutation1( 3, 3, CNF2), C).
% C = 573. 

% (ins)?- time( aggregate_all( count, cnf_only_minpermutation1( 4, 3, CNF2), C)).
% % 41,668,798 inferences, 3.439 CPU in 3.439 seconds (100% CPU, 12116207 Lips)
% C = 3176.
% 
% (cmd)?- time( aggregate_all( count, cnf_only_minpermutation1( 3, 4, CNF2), C)).
% % 236,705,911 inferences, 19.710 CPU in 19.720 seconds (100% CPU, 12009615 Lips)
% C = 4558.
% 
% (cmd)?- time( aggregate_all( count, cnf_only_minpermutation1( 4, 4, CNF2), C)).
% % 7,300,775,620 inferences, 590.113 CPU in 590.199 seconds (100% CPU, 12371823 Lips)
% C = 76545.
% 
% 
% (ins)?- aggregate_all( count, cnf_minpermutation1( 2, 2, _, CNF2), C).
% C = 36.
% 
% (cmd)?- aggregate_all( count, cnf_only_minpermutation1( 0, 0, CNF2), C).
% C = 0.
% 
% 
% (cmd)?- aggregate_all( count, cnf_only_minpermutation1( 0, 1, CNF2), C).
% C = 0.
% 
% (cmd)?- aggregate_all( count, cnf_only_minpermutation1( 1, 1, CNF2), C).
% C = 3.


*/

:- table cnf_only_minpermutation3/3.

cnf_only_minpermutation3( RULECOUNT, VARCOUNT, CNF_ONLY_MINPERMUTATION) :- true
, cnf_minpermutation3( RULECOUNT, VARCOUNT, _CNF, CNF_MINPERMUTATION)
, CNF_ONLY_MINPERMUTATION = CNF_MINPERMUTATION
.

:- table cnf_only_minpermutation4/3.

cnf_only_minpermutation4( RULECOUNT, VARCOUNT, CNF_ONLY_MINPERMUTATION) :- true
, cnf_minpermutation4( RULECOUNT, VARCOUNT, _CNF, CNF_MINPERMUTATION)
, CNF_ONLY_MINPERMUTATION = CNF_MINPERMUTATION
.

/*

% (ins)?- findall( C, ( member( P, [cnf_minpermutation1, cnf_minpermutation2, cnf_minpermutation3, cnf_minpermutation4]), aggregate_all( count, call( P, 2, 2, _, _), C)), L).
% L = [36, 36, 36, 72].
% 
% (cmd)?- findall( C, ( member( P, [cnf_only_minpermutation1, cnf_only_minpermutation2, cnf_only_minpermutation3, cnf_only_minpermutation4]), aggregate_all( count, call( P, 2, 2, _), C)), L).
% L = [21, 21, 21, 21].

% (ins)?- findall( CNF, cnf_only_minpermutation1( 2, 2, CNF), L1), findall( CNF, cnf_only_minpermutation3( 2, 2, CNF), L2).
% L1 = L2, L2 = [[[1, 2], [2, 2]], [[1, 2], [2, 1]], [[1, 1], [2, 2]], [[1, 1], [1, 2]], [[0, 2], [2, 2]], [[0, 2], [2, 1]], [[0, 2], [2, 0]], [[0, 2], [1, 2]], [[0, 2], [1, 1]], [[0, 1], [2, 2]], [[0, 1], [2, 1]], [[0, 1], [2, 0]], [[0, 1], [1, 2]], [[0, 1], [1, 1]], [[0, 1], [1, 0]], [[0, 1], [0, 2]], [[0, 0], [2, 2]], [[0, 0], [1, 2]], [[0, 0], [1, 1]], [[0, 0], [0, 2]], [[0, 0], [0, 1]]].
% 

% (ins)?- findall( CNF, cnf_only_minpermutation1( 2, 2, CNF), L1), findall( CNF, cnf_only_minpermutation4( 2, 2, CNF), L2), intersection( L1, L2, L3), subtract( L2, L3, L22).
% L1 = L2, L2 = L3, L3 = [[[1, 2], [2, 2]], [[1, 2], [2, 1]], [[1, 1], [2, 2]], [[1, 1], [1, 2]], [[0, 2], [2, 2]], [[0, 2], [2, 1]], [[0, 2], [2, 0]], [[0, 2], [1, 2]], [[0, 2], [1, 1]], [[0, 1], [2, 2]], [[0, 1], [2, 1]], [[0, 1], [2, 0]], [[0, 1], [1, 2]], [[0, 1], [1, 1]], [[0, 1], [1, 0]], [[0, 1], [0, 2]], [[0, 0], [2, 2]], [[0, 0], [1, 2]], [[0, 0], [1, 1]], [[0, 0], [0, 2]], [[0, 0], [0, 1]]],
% L22 = [].


*/


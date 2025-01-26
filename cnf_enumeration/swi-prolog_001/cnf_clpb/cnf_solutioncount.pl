
:- table cnf_solutioncount/5.

cnf_solutioncount( RULECOUNT, VARCOUNT, CNF, SAT_OUT, COUNT) :- true
, cnf_enumeration3( RULECOUNT, VARCOUNT, CNF)
, cnf_sat( CNF, SAT)
, copy_term( SAT, SAT_OUT)
, aggregate_all( count, ( sat(SAT), term_variables( SAT, V), labeling( V) ), COUNT)
.

cnf_solutioncount_max( RULECOUNT, VARCOUNT, SOLUTIONCOUNT) :- true
, aggregate( max(SOLUTIONCOUNT), (CNF, SAT) , cnf_solutioncount( RULECOUNT, VARCOUNT, CNF, SAT, SOLUTIONCOUNT), SOLUTIONCOUNT)
.

/*

% (ins)?- cnf_solutioncount( 3, 3, CNF, SAT, COUNT), COUNT == 0.
% CNF = [[1, 2, 2], [2, 1, 2], [2, 2, 2]],
% SAT = *([+[_], +[_], +[]]),
% COUNT = 0 ;
% CNF = [[1, 1, 2], [2, 2, 1], [2, 2, 2]],
% SAT = *([+[_, _], +[_], +[]]),
% COUNT = 0 ;
% CNF = [[1, 1, 2], [1, 2, 2], [2, 2, 2]],
% SAT = *([+[_A, _], +[_A], +[]]),
% COUNT = 0 ;
% CNF = [[1, 1, 2], [1, 2, 1], [2, 2, 2]],
% SAT = *([+[_A, _], +[_A, _], +[]]),
% COUNT = 0 ...
% 
% (ins)?- aggregate_all( max(COUNT), cnf_solutioncount( 3, 3, CNF, SAT, COUNT), M).
% M = 6.
% 
% (ins)?- cnf_solutioncount( 3, 3, CNF, SAT, COUNT), COUNT == 6.
% CNF = [[0, 1, 1], [1, 1, 1], [2, 1, 1]],
% SAT = *([+[~_A, _B, _C], +[_A, _B, _C], +[_B, _C]]),
% COUNT = 6 ;
% CNF = [[0, 0, 1], [0, 1, 1], [0, 2, 1]],
% SAT = *([+[~_A, ~_B, _C], +[~_A, _B, _C], +[~_A, _C]]),
% COUNT = 6 ;
% CNF = [[0, 0, 0], [0, 0, 1], [0, 0, 2]],
% SAT = *([+[~_A, ~_B, ~_C], +[~_A, ~_B, _C], +[~_A, ~_B]]),
% COUNT = 6.

*/

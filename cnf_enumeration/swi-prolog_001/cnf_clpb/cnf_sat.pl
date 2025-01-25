
cnf_sat( CNF, SAT) :- true
, empty_assoc(E)
, cnf_freevars( CNF, CNF_VARS, E, _)
, maplist( [RULE, SATRULE]>>( SATRULE = '+'(RULE)), CNF_VARS, SATRULES)
, SAT = '*'(SATRULES)
.

/*

% (ins)?- cnf_sat( [[0, 1, 2],[2,0,1]], SAT).
% SAT = *([+[~_, _A], +[~_A, _]]).
% 
% 
% (ins)?- cnf_sat( [[0, 1, 2],[2,0,1]], SAT), sat(SAT).
% SAT = *([+[~_A, _B], +[~_B, _C]]),
% sat(_A=:=_A*_B),
% sat(_B=:=_B*_C).
% 
% (ins)?- cnf_sat( [[0, 1, 2],[2,0,1]], SAT), sat(SAT), term_variables( SAT, V), labeling( V).
% SAT = *([+[~0, 0], +[~0, 0]]),
% V = [0, 0, 0] ;
% SAT = *([+[~0, 0], +[~0, 1]]),
% V = [0, 0, 1] ;
% SAT = *([+[~0, 1], +[~1, 1]]),
% V = [0, 1, 1] ;
% SAT = *([+[~1, 1], +[~1, 1]]),
% V = [1, 1, 1].

*/

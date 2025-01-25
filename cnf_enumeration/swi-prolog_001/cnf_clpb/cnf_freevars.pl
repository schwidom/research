cnf_freevars( CNF, CNF_FREEVARS, ASSOC_IN, ASSOC_OUT) :- true
, CNF = [], CNF_FREEVARS = [], ASSOC_IN = ASSOC_OUT, !.

cnf_freevars( CNF, CNF_FREEVARS, ASSOC_IN, ASSOC_OUT) :- true
, CNF = [ H1 | T1]
, CNF_FREEVARS = [ H2 | T2]
, rule_freevars( 0, H1, H2, ASSOC_IN, ASSOC_NEXT)
, cnf_freevars( T1, T2, ASSOC_NEXT, ASSOC_OUT)
.

/*

% (ins)?- empty_assoc(E), cnf_freevars( [[0, 1, 2],[0, 1, 2]], CNF, E, O).
% E = t,
% CNF = [[~_A, _B], [~_A, _B]],
% O = t(0, _A, >, t, t(1, _B, -, t, t)).
% 
% (ins)?- empty_assoc(E), cnf_freevars( [[0, 1, 2],[2,0,1]], CNF, E, O).
% E = t,
% CNF = [[~_A, _B], [~_B, _C]],
% O = t(1, _B, -, t(0, _A, -, t, t), t(2, _C, -, t, t)).

*/


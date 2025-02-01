:- consult( 'main.pl').

cnf_setup :- true
, cnf_configuration_set_has_false_rules( false)
, cnf_configuration_set_has_lesser_vars( true).


:- cnf_setup.

cnf_enumeration( RULECOUNT, VARCOUNT, CNF) :- true
% , cnf_setup
, cnf_enumeration3( RULECOUNT, VARCOUNT, CNF)
.

/*

% (ins)?- cnf_enumeration( 2, 2, CNF).
% CNF = [[1, 2], [2, 1]] ;
% CNF = [[1, 1], [1, 2]] ;
% CNF = [[0, 2], [2, 1]] ;
% CNF = [[0, 2], [2, 0]] ;
% CNF = [[0, 2], [1, 2]] ;
% CNF = [[0, 2], [1, 1]] ;
% CNF = [[0, 1], [2, 1]] ;
% CNF = [[0, 1], [2, 0]] ;
% CNF = [[0, 1], [1, 2]] ;
% CNF = [[0, 1], [1, 1]] ;
% CNF = [[0, 1], [1, 0]] ;
% CNF = [[0, 1], [0, 2]] ;
% CNF = [[0, 0], [1, 2]] ;
% CNF = [[0, 0], [1, 1]] ;
% CNF = [[0, 0], [0, 2]] ;
% CNF = [[0, 0], [0, 1]].

*/


:- table cnf_solutioncount_count / 4.

cnf_solutioncount_count( RULECOUNT, VARCOUNT, SOLUTIONCOUNT, COUNT) :- true
, aggregate( count, (CNF, SAT) , cnf_solutioncount( RULECOUNT, VARCOUNT, CNF, SAT, SOLUTIONCOUNT), COUNT)
.

/*

% (cmd)?- cnf_solutioncount_count( 2, 2, C1, C2).
% C1 = 0,
% C2 = 6 ;
% C1 = 1,
% C2 = 7 ;
% C1 = 2,
% C2 = 8.
% 
% (cmd)?- cnf_solutioncount_count( 2, 3, C1, C2).
% C1 = 0,
% C2 = 10 ;
% C1 = 1,
% C2 = 7 ;
% C1 = 2,
% C2 = 8 ;
% C1 = 3,
% C2 = 12 ;
% C1 = 4,
% C2 = 10 ;
% C1 = 5,
% C2 = 20 ;
% C1 = 6,
% C2 = 15.

% (cmd)?- cnf_solutioncount_count( 3, 2, C1, C2).
% C1 = 0,
% C2 = 27 ;
% C1 = 1,
% C2 = 18 ;
% C1 = C2, C2 = 2.

% (ins)?- cnf_solutioncount_count( 3, 3, C1, C2).
% C1 = 0,
% C2 = 93 ;
% C1 = 1,
% C2 = 58 ;
% C1 = 2,
% C2 = 100 ;
% C1 = 3,
% C2 = 130 ;
% C1 = 4,
% C2 = 131 ;
% C1 = 5,
% C2 = 58 ;
% C1 = 6,
% C2 = 3.


% (cmd)?- cnf_solutioncount_count( 4, 4, C1, C2).
% C1 = 0,
% C2 = 5232 ;
% C1 = 1,
% C2 = 975 ;
% C1 = 2,
% C2 = 2657 ;
% C1 = 3,
% C2 = 4112 ;
% C1 = 4,
% C2 = 6362 ;
% C1 = 5,
% C2 = 6744 ;
% C1 = 6,
% C2 = 9595 ;
% C1 = 7,
% C2 = 9696 ;
% C1 = 8,
% C2 = 10750 ;
% C1 = 9,
% C2 = 9285 ;
% C1 = 10,
% C2 = 6734 ;
% C1 = 11,
% C2 = 3383 ;
% C1 = 12,
% C2 = 967 ;
% C1 = 13,
% C2 = 53.


*/

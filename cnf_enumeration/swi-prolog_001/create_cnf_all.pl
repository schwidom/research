create_cnf_all( RULECOUNT, VARCOUNT, CNF) :- true
, length( CNF, RULECOUNT)
, maplist( create_rule( VARCOUNT), CNF)
, create_cnf_has_lesser_vars_filter( VARCOUNT, CNF)
.

/*

% (ins)?- aggregate_all( count, create_cnf_all( 2, 2, _), C).
% C = 81.
% 

% (ins)?- aggregate_all( count, ( create_cnf_all( 2, 2, CNF), is_set(CNF)), C).
% C = 72.

% (cmd)?- aggregate_all( count, create_cnf( 2, 2, _), C).
% C = 36.

% (ins)> 72 / 36
% [1] 2 # 2!


% (cmd)?- aggregate_all( count, ( create_cnf( 2, 2, CNF), is_set( CNF)), C).
% C = 36.

% (cmd)?- aggregate_all( count, ( create_cnf_all( 3, 3, CNF), is_set(CNF)), C).
% C = 17550.

% (cmd)?- aggregate_all( count, ( create_cnf( 3, 3, CNF), is_set(CNF)), C).
% C = 2925.

% (ins)> 17550 / 2925
% [1] 6 # 3!

% (cmd)?- aggregate_all( count, ( create_cnf_all( 2, 3, CNF), is_set(CNF)), C).
% C = 702.
% 
% (cmd)?- aggregate_all( count, ( create_cnf( 2, 3, CNF)), C).
% C = 351.
% 
% ^ 2!

% (cmd)?- aggregate_all( count, ( create_cnf_all( 3, 2, CNF), is_set(CNF)), C).
% C = 504.
% 
% (cmd)?- aggregate_all( count, ( create_cnf( 3, 2, CNF), is_set(CNF)), C).
% C = 84.
% 
% (ins)> 504 / 84
% [1] 6 # 3!


*/


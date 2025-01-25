create_rule( VARCOUNT, RULE) :- combine_012_fast( VARCOUNT, RULE) .

create_cnf( _RULE_LESSER, RULECOUNT, _VARCOUNT, CNF) :- RULECOUNT = 0, CNF = [].

create_cnf( RULE_LESSER, RULECOUNT, VARCOUNT, CNF) :- RULECOUNT \== 0
, create_rule( VARCOUNT, RULE) 
, RULE_LESSER @< RULE
, CNF = [ RULE | RULES ]
, RULECOUNT_NEXT is RULECOUNT - 1
, create_cnf( RULE, RULECOUNT_NEXT, VARCOUNT, RULES)
.

create_cnf( RULECOUNT, VARCOUNT, CNF) :- create_cnf( 0, RULECOUNT, VARCOUNT, CNF). % 0 @< [] (true)


/*

% (ins)?- aggregate_all( count, create_cnf( 2, 2, CNF), C).
% C = 81.

% nach Reduktion
% (ins)?- aggregate_all( count, create_cnf( 2, 2, CNF), C).
% C = 36.

% (cmd)?- aggregate_all( count, create_cnf( 3, 3, CNF), C).
% C = 2925.
% 
% (cmd)?- aggregate_all( count, create_cnf( 3, 4, CNF), C).
% C = 85320.
% 
% (cmd)?- aggregate_all( count, create_cnf( 4, 3, CNF), C).
% C = 17550.
% 
% (cmd)?- aggregate_all( count, create_cnf( 4, 4, CNF), C).
% C = 1663740.

% (cmd)?- create_cnf( 0, 0, CNF).
% CNF = [] ;
% false.
% 
% (cmd)?- create_cnf( 1, 0, CNF).
% CNF = [[]] ;
% false.
% 
% (cmd)?- create_cnf( 2, 0, CNF).
% false.
% 
% (cmd)?- create_cnf( 2, 1, CNF).
% CNF = [[0], [1]] ;
% CNF = [[0], [2]] ;
% CNF = [[1], [2]] ;
% false.
% 
% (cmd)?- create_cnf( 3, 1, CNF).
% CNF = [[0], [1], [2]] ;
% false.
% 
% (cmd)?- create_cnf( 4, 1, CNF).
% false.
% 
% (cmd)?- create_cnf( 4, 2, CNF).
% CNF = [[0, 0], [0, 1], [0, 2], [1, 0]] ;
% CNF = [[0, 0], [0, 1], [0, 2], [1, 1]] ;

% (cmd)?- create_cnf( 9, 2, CNF), writeln(CNF), false.
% [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
% false.

% (cmd)?- create_cnf( 27, 3, CNF), writeln(CNF), false.
% [[0,0,0],[0,0,1],[0,0,2],[0,1,0],[0,1,1],[0,1,2],[0,2,0],[0,2,1],[0,2,2],[1,0,0],[1,0,1],[1,0,2],[1,1,0],[1,1,1],[1,1,2],[1,2,0],[1,2,1],[1,2,2],[2,0,0],[2,0,1],[2,0,2],[2,1,0],[2,1,1],[2,1,2],[2,2,0],[2,2,1],[2,2,2]]
% ^C

% (ins)?- create_cnf( 81, 4, CNF), writeln(CNF), false.
% [[0,0,0,0],[0,0,0,1],[0,0,0,2],[0,0,1,0],[0,0,1,1],[0,0,1,2],[0,0,2,0],[0,0,2,1],[0,0,2,2],[0,1,0,0],[0,1,0,1],[0,1,0,2],[0,1,1,0],[0,1,1,1],[0,1,1,2],[0,1,2,0],[0,1,2,1],[0,1,2,2],[0,2,0,0],[0,2,0,1],[0,2,0,2],[0,2,1,0],[0,2,1,1],[0,2,1,2],[0,2,2,0],[0,2,2,1],[0,2,2,2],[1,0,0,0],[1,0,0,1],[1,0,0,2],[1,0,1,0],[1,0,1,1],[1,0,1,2],[1,0,2,0],[1,0,2,1],[1,0,2,2],[1,1,0,0],[1,1,0,1],[1,1,0,2],[1,1,1,0],[1,1,1,1],[1,1,1,2],[1,1,2,0],[1,1,2,1],[1,1,2,2],[1,2,0,0],[1,2,0,1],[1,2,0,2],[1,2,1,0],[1,2,1,1],[1,2,1,2],[1,2,2,0],[1,2,2,1],[1,2,2,2],[2,0,0,0],[2,0,0,1],[2,0,0,2],[2,0,1,0],[2,0,1,1],[2,0,1,2],[2,0,2,0],[2,0,2,1],[2,0,2,2],[2,1,0,0],[2,1,0,1],[2,1,0,2],[2,1,1,0],[2,1,1,1],[2,1,1,2],[2,1,2,0],[2,1,2,1],[2,1,2,2],[2,2,0,0],[2,2,0,1],[2,2,0,2],[2,2,1,0],[2,2,1,1],[2,2,1,2],[2,2,2,0],[2,2,2,1],[2,2,2,2]]
% ^C

*/


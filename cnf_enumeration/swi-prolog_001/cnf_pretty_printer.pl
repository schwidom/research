
cnf_config_pp_ascii :- nb_setval( cnf_config_pp, [ ascii, `~`, ` /\\ `, ` \\/ `]).
cnf_config_pp_markdown :- nb_setval( cnf_config_pp, [ markdown, `$\\neg$`, ` $\\wedge$ `, ` $\\vee$ `]).
cnf_config_pp_utf8 :- nb_setval( cnf_config_pp, [ utf8, `¬`, ` ∧ `, ` ∨ `]).

:- cnf_config_pp_ascii. % default

letters( LCODES) :- [ACODE , ZCODE] = `az` , numlist( ACODE, ZCODE, LCODES) .

num0_variablename_codes( NUM, CODES) :- true
, letters( LCODES)
, length( LCODES, LEN)
, NUM2 is NUM mod LEN
, nth0( NUM2, LCODES, CODE)
, ( NUM2 == NUM 
     -> CODES=[CODE] 
     ;  CODES = [CODE|T], NUM3 is NUM // LEN, num0_variablename_codes( NUM3, T)
  )
.

num0_variablename( NUM, NAME) :- true
, num0_variablename_codes( NUM, CODES)
, string_codes( NAME, CODES)
.

idx0_rule_pretty_printer( IDX, RULE, LIST) :- IDX=_, RULE=[], LIST=[], !.
idx0_rule_pretty_printer( IDX, RULE, LIST) :- true
, nb_getval( cnf_config_pp, [_, NOT, _, _])
, num0_variablename_codes( IDX, NAME)
, IDXNEXT is IDX + 1
, RULE = [ RULENUMBER | TR ] % RULENUMBER : 0 = ~a, 1 = a, 2 = false
, LIST = [ CODES_FORMATTED | TL ]
, (
    0 == RULENUMBER -> append( NOT, NAME, CODES_FORMATTED) ;
    1 == RULENUMBER -> CODES_FORMATTED = NAME ;
    2 == RULENUMBER -> CODES_FORMATTED = [] ; true
  )
, idx0_rule_pretty_printer( IDXNEXT, TR, TL)
.

rule_pretty_printer( RULE, LIST) :- true
% , nb_getval( cnf_config_pp, [_, _, _, OR])
, idx0_rule_pretty_printer( 0, RULE, LIST_CODES)
, foldl( [X, Y, Z]>>( 
    X==[] -> Z=Y; 
    Y==[] -> Z = [X];
    nb_getval( cnf_config_pp, [_, _, _, OR]), Z = [X, OR | Y]
   )
  , LIST_CODES, [], LISTREV)
, ( LISTREV == [] -> LIST = [`false`] ; reverse( LISTREV, LIST) )
.

/*

% (ins)?- rule_pretty_printer( [1,1], LIST).
% LIST = [[97], [32, 92, 47, 32], [98]].

% (ins)?- rule_pretty_printer( [0, 1, 2, 0], L), flatten( L, L2), string_codes( X, L2), writeln(X).
% ~a \/ b \/ ~d
% L = [[126, 97], [32, 92, 47, 32], [98], [32, 92, 47, 32], [126, 100]],
% L2 = [126, 97, 32, 92, 47, 32, 98, 32, 92, 47, 32, 126, 100],
% X = "~a \\/ b \\/ ~d".

% (ins)?- rule_pretty_printer( [], L), flatten( L, L2), string_codes( X, L2), writeln(X).
% false
% L = [[102, 97, 108, 115, 101]],
% L2 = [102, 97, 108, 115, 101],
% X = "false".
% 
% (ins)?- rule_pretty_printer( [2, 2], L), flatten( L, L2), string_codes( X, L2), writeln(X).
% false
% L = [[102, 97, 108, 115, 101]],
% L2 = [102, 97, 108, 115, 101],
% X = "false".


*/


cnf_pretty_printer( CNF, FORMATTED) :- true 
% , nb_getval( cnf_config_pp, [_, _, AND, _]) 
, maplist( rule_pretty_printer, CNF, CNF2)
, maplist( [A, B]>>( length( A, 1) -> A=B ; append( [[`(`], A, [`)`]], B) ), CNF2, CNF3)
, foldl( [X, Y, Z]>>( Y == [] -> Z = [X] ; nb_getval( cnf_config_pp, [_, _, AND, _]), Z = [ X, AND | Y]) , CNF3, [], FORMATTEDREV)
, reverse( FORMATTEDREV, FORMATTED)
.

/*

% (ins)?- cnf_pretty_printer([[1,1],[1,1]], O), flatten( O, OF), string_codes( S, OF).
% O = [[[40], [97], [32, 92, 47, 32], [98], [41]], [32, 47, 92, 32], [[40], [97], [32, 92, 47, 32], [98], [41]]],
% OF = [40, 97, 32, 92, 47, 32, 98, 41, 32, 47, 92, 32, 40, 97, 32, 92, 47, 32, 98, 41],
% S = "(a \\/ b) /\\ (a \\/ b)".
% 
% (ins)?- cnf_pretty_printer([[1,1],[1,1]], O), flatten( O, OF), string_codes( S, OF), writeln( S).
% (a \/ b) /\ (a \/ b)
% O = [[[40], [97], [32, 92, 47, 32], [98], [41]], [32, 47, 92, 32], [[40], [97], [32, 92, 47, 32], [98], [41]]],
% OF = [40, 97, 32, 92, 47, 32, 98, 41, 32, 47, 92, 32, 40, 97, 32, 92, 47, 32, 98, 41],
% S = "(a \\/ b) /\\ (a \\/ b)".
% 
% (ins)?- cnf_pretty_printer([[1,1],[2,2],[1,1]], O), flatten( O, OF), string_codes( S, OF), writeln( S).
% (a \/ b) /\ false /\ (a \/ b)
% O = [[[40], [97], [32, 92, 47, 32], [98], [41]], [32, 47, 92, 32], [[102, 97, 108, 115, 101]], [32, 47, 92, 32], [[40], [97], [32, 92, 47, 32], [98], [41]]],
% OF = [40, 97, 32, 92, 47, 32, 98, 41, 32, 47, 92, 32, 102, 97, 108, 115, 101, 32, 47, 92, 32, 40, 97, 32, 92, 47, 32, 98, 41],
% S = "(a \\/ b) /\\ false /\\ (a \\/ b)".
% 
% (cmd)?- cnf_pretty_printer([[0,1],[2,2],[1,0]], O), flatten( O, OF), string_codes( S, OF), writeln( S).
% (~a \/ b) /\ false /\ (a \/ ~b)
% O = [[[40], [126, 97], [32, 92, 47, 32], [98], [41]], [32, 47, 92, 32], [[102, 97, 108, 115, 101]], [32, 47, 92, 32], [[40], [97], [32, 92, 47, 32], [126, 98], [41]]],
% OF = [40, 126, 97, 32, 92, 47, 32, 98, 41, 32, 47, 92, 32, 102, 97, 108, 115, 101, 32, 47, 92, 32, 40, 97, 32, 92, 47, 32, 126, 98, 41],
% S = "(~a \\/ b) /\\ false /\\ (a \\/ ~b)".

*/

cnf_pretty_printer_string( CNF, STRING) :- true
, cnf_pretty_printer( CNF, LIST)
, flatten( LIST, LIST_F), string_codes( STRING, LIST_F)
.

/*

% (ins)?- cnf_pretty_printer_string([[0,1],[2,2],[1,0]], S), writeln( S).
% (~a \/ b) /\ false /\ (a \/ ~b)
% S = "(~a \\/ b) /\\ false /\\ (a \\/ ~b)".

*/

% depends on which file is loaded cnf_enumeration_A380518.pl / cnf_enumeration_A380610.pl
% public referred
cnf_enumeration_pretty_printer( RULECOUNT, VARCOUNT) :- true
, TERM1 = ( cnf_enumeration( RULECOUNT, VARCOUNT, CNF), cnf_pretty_printer_string(CNF,CNF_S) )
, forall( TERM1, ( write( CNF), write( ' => '), writeln(CNF_S) ))
.

/*


% (ins)?- cnf_enumeration_pretty_printer( 1, 1). % swipl -s cnf_enumeration_A380610.pl
% [[1]] => a
% [[0]] => ~a
% true.
% (ins)?- cnf_enumeration_pretty_printer( 2, 1).
% [[0],[1]] => ~a /\ a
% true.
% (ins)?- cnf_enumeration_pretty_printer( 1, 2).
% [[1,2]] => a
% [[1,1]] => (a \/ b)
% [[0,2]] => ~a
% [[0,1]] => (~a \/ b)
% [[0,0]] => (~a \/ ~b)
% true.
% (ins)?- cnf_enumeration_pretty_printer( 2, 2).
% [[1,2],[2,1]] => a /\ b
% [[1,1],[1,2]] => (a \/ b) /\ a
% [[0,2],[2,1]] => ~a /\ b
% [[0,2],[2,0]] => ~a /\ ~b
% [[0,2],[1,2]] => ~a /\ a
% [[0,2],[1,1]] => ~a /\ (a \/ b)
% [[0,1],[2,1]] => (~a \/ b) /\ b
% [[0,1],[2,0]] => (~a \/ b) /\ ~b
% [[0,1],[1,2]] => (~a \/ b) /\ a
% [[0,1],[1,1]] => (~a \/ b) /\ (a \/ b)
% [[0,1],[1,0]] => (~a \/ b) /\ (a \/ ~b)
% [[0,1],[0,2]] => (~a \/ b) /\ ~a
% [[0,0],[1,2]] => (~a \/ ~b) /\ a
% [[0,0],[1,1]] => (~a \/ ~b) /\ (a \/ b)
% [[0,0],[0,2]] => (~a \/ ~b) /\ ~a
% [[0,0],[0,1]] => (~a \/ ~b) /\ (~a \/ b)
% true.

*/



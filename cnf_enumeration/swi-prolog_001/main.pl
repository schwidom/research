
:- use_module( library(clpb)). % ~, *([]), +([]), sat, labeling
:- use_module( library(clpfd)). % transpose
:- use_module( library(error)). % must_be

:- set_prolog_flag( stack_limit , 10_737_418_240).
% :- set_prolog_flag( table_space, 10_737_418_240).
:- set_prolog_flag( table_space, 20_737_418_240).
:- set_prolog_flag( answer_write_options, [quoted(true), portray(true), max_depth(250), spacing(next_argument)]).

:- consult( 'cnf_configuration.pl').

:- consult( 'tools/combine.pl').
:- consult( 'tools/order.pl').
:- consult( 'tools/permutation.pl').

:- consult( 'cnf_pretty_printer.pl').
:- consult( 'create_cnf.pl').
:- consult( 'create_cnf_all.pl').

:- consult( 'helper.pl').

:- consult( 'cnf_compare.pl').

:- consult( 'cnf_order1.pl').

:- consult( 'cnf_order2.pl').

:- consult( 'cnf_minpermutation.pl').

:- consult( 'cnf_enumeration.pl').

:- consult( 'group_sorted_cnf_table.pl').

:- consult( 'benchmark.pl').

show_raising_rows( VARCOUNT) :- true
, LAMBDA = {VARCOUNT}/[RULECOUNT, COUNT]>>( true
   , aggregate_all( count, cnf_enumeration3( RULECOUNT, VARCOUNT, _CNF), COUNT)
   , write( COUNT)
   , write( ', ')
   , flush_output
   )
, aggregate_all( max(RULECOUNT)
    , ( between( 0, inf, RULECOUNT), call( LAMBDA, RULECOUNT, COUNT), COUNT\==0, !)
    , MR
  )
, MR2 is 1 + MR
, ignore( forall( ( between( MR2, inf, RULECOUNT), call( LAMBDA, RULECOUNT, COUNT)), COUNT\==0))
.

/*

% in case:
% nb_setval( cnf_config_has_false_rules, true).

% (ins)?- show_raising_rows( 0).
% 1, 1, 0, 
% false.

% https://oeis.org/search?q=0%2C+0%2C+3%2C+3%2C+1%2C+0&language=english&go=Search # 0, 0, 3, 3, 1, 0
% 
% (ins)?- show_raising_rows( 1).
% 1, 3, 3, 1, 0
% false.
% 
% 
% (ins)?- show_raising_rows( 2).
% 1, 6, 21, 47, 69, 69, 47, 21, 6, 1, 0
% false.

% (ins)?- show_raising_rows( 3).
% 1, 10, 82, 573, 3176, 14066, 50646, 150508, 
% ERROR: '$tbl_wkl_add_answer'/4: Not enough resources: private_table_space

% (ins)?- show_raising_rows( 4).
% 1, 15, 252, 4558, 76545, ^C

% (ins)?- show_raising_rows( 5). % 70% hauptspeichernutzung (von 32Gig)
% 1, 21, 657, ^C

% (cmd)?- show_raising_rows( 6).
% 1, 28, ^C
% 
% (ins)?- show_raising_rows( 7).
% 1, 36, ^C
%  
% (cmd)?- show_raising_rows( 8).
% 1, 45, ^C
% 
% (cmd)?- show_raising_rows( 9).
% 1, 55, ^C
% 
% (ins)?- show_raising_rows( 10).
% 1, 66, ^C

% in case:
% nb_setval( cnf_config_has_false_rules, false).

% (ins)?- show_raising_rows( 0).
% 1, 0, 
% false.
% 
% (ins)?- show_raising_rows( 1).
% 1, 2, 1, 0, 
% false.
% 
% (ins)?- show_raising_rows( 2).
% 1, 5, 16, 31, 38, 31, 16, 5, 1, 0, 
% false.
% 
% (ins)?- show_raising_rows( 3).
% 1, 9, 73, 573, 2676, 11390, 39256
% 
% (cmd)?- show_raising_rows( 4).
% 1, 14, 238, 4320,

% (cmd)?- show_raising_rows( 5).
% 1, 20, 637, 

% (ins)?- cnf_configuration_set_has_false_rules( false), cnf_configuration_set_has_lesser_vars(false).
% true.
% 

% (ins)?- show_raising_rows( 0).
% 1, 0, 

% (ins)?- show_raising_rows( 1).
% 0, 2, 1, 0, 
% 
% (ins)?- show_raising_rows( 2).
% 0, 3, 15, 31, 38, 31, 16, 5, 1, 0, 

% (ins)?- show_raising_rows( 3).
% 0, 4, 57, 469, 2638, 11359, 39240, ^C % 

% OEIS:
% Constant differences
% The differences of order 2 in the difference table of depth 3 appear to become constant.
% The next few terms would be 105017, 159374, -422877, -5466620.
% 
%    4    57    469   2638  11359  39240  105017  159374  -422877
%   53   412   2169   8721  27881  65777   54357  -582251
%  359  1757   6552  19160  37896  -11420  -636608
% 1398  4795  12608  18736  -49316  -625188
% 3397  7813   6128  -68052  -575872
% 4416  -1685  -74180  -507820
% -6101  -72495  -433640
% -66394  -361145
% -294751


% (ins)?- show_raising_rows( 4).
% 0, 5, 165, 3820, 69549, 

% (ins)?- show_raising_rows( 5).
% 0, 6, 399, 


*/

show_raising_vars( RULECOUNT, MAXVARCOUNT) :- true
, forall( between( 0, MAXVARCOUNT, VARCOUNT), ( true
   , aggregate_all( count, cnf_enumeration3( RULECOUNT, VARCOUNT, _CNF), COUNT)
   , write( COUNT)
   , write( ', ')
   , flush_output
   )
  )
.

/*

% in case:
% nb_setval( cnf_config_has_false_rules, true).

% (ins)?- show_raising_vars( 0, 100).
% 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
% true.

% (cmd)?- show_raising_vars( 1, 13).
% 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78, 91, 105, # A253145 Triangular numbers (A000217) omitting the term 1.
% true.

% (ins)?- show_raising_vars( 2, 10).
% 0, 3, 21, 82, 252, 657, 1533, 3276, ^C

% (ins)?- show_raising_vars( 3, 5).
% 0, 1, 47, 573, 4558, 28643
% true.

% (cmd)?- show_raising_vars( 4, 4).
% 0, 0, 69, 3176, 76545
% true.

% (cmd)?- show_raising_vars( 5, 3).
% 0, 0, 69, 14066, 
% true.

% (ins)?- show_raising_vars( 6, 3).
% 0, 0, 47, 50646, 
% true.

% (cmd)?- show_raising_vars( 7, 3).
% 0, 0, 21, , 150508, 
% true.

% in case:
% nb_setval( cnf_config_has_false_rules, false).

% (ins)?- show_raising_vars( 0, 100).
% 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
% true.
% 
% (ins)?- show_raising_vars( 1, 100).
% 0, 2, 6, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 
% 
% (ins)?- show_raising_vars( 2, 100).
% 0, 1, 16, 73, 238, 637, 1506, 
% 
% (ins)?- show_raising_vars( 3, 100).
% 0, 0, 31, 500, 4320, 
% 
% (ins)?- show_raising_vars( 4, 100).
% 0, 0, 38, 2676, 
% 
% (ins)?- show_raising_vars( 5, 100).
% 0, 0, 31, 11390, 


*/

/*

% interesting oeis entries
% 
% https://oeis.org/search?q=cnf&language=english&go=Search
% 
% https://oeis.org/A112650 # A112650 Number of truth tables generated by (n-1)-CNF Boolean expressions of n variables.
% 
% 
% https://oeis.org/A112535 # A112535 Number of truth tables generated by 3CNF expressions of n variables.
% 
% ...

*/

:- consult( 'cnf_clpb/rule_freevars.pl').
:- consult( 'cnf_clpb/cnf_freevars.pl').
:- consult( 'cnf_clpb/cnf_sat.pl').
:- consult( 'cnf_clpb/cnf_solutioncount.pl').
:- consult( 'cnf_clpb/cnf_solutioncount_count.pl').
:- consult( 'cnf_clpb/cnf_solutioncount_count_sequence.pl').


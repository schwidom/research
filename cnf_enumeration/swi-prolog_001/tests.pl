
% run_tests, make

:- use_module( library( plunit)).

:- consult( 'main.pl').

:- abolish_all_tables.

:- set_test_options(format(log)).

:- set_prolog_flag( answer_write_options, [quoted(true), portray(true), max_depth(50), spacing(next_argument)]).

:- begin_tests( cnf).

test( cnf_001) :- true.

test( order0) :- true
, order0( [], [])
, order0_transposed( [], [])
, index0( [], [], [])
, index0_transposed( [], [], [])
.

test( helper_001) :- true
, transposed_msort([[]], [[]])
.

test( order) :- true
, L = [ f, g, h, b, a, c, z, w, x]
, order0( L, LO)
, LO = [4,3,5,0,1,2,7,8,6]
, order0_transposed( L, LT)
, LT = [3,4,5,1,0,2,8,6,7]
, index0( LO, L, LI1)
, LI1 = [a,b,c,f,g,h,w,x,z]
, index0( LT, L, LI2)
, index0_transposed( LT, L, LI3)
, LI1 == LI3
, LI2 = [b,a,c,g,f,h,x,z,w]
, iota0( 9, I9)
, index0( I9, I9, I9)
, index0( L, LO, I9) % atypical
, index0_transposed( L, LT, I9) % atypical
, index0_transposed( LT, LI2, L)
, index0_transposed( LO, LI1, L)
, index0_transposed( LT, LI2, L)
, index0( LT, LI3, L)
.

test( cnf_002) :- true
, findall( CNF, create_cnf( 3, 3, CNF), L)
, sort( L, L2)
, L == L2
.

test( cnf_vs_all_2_2) :- true
, TERM1 = ( create_cnf_all( 2, 2, CNF1), is_set( CNF1) )
, TERM2 = create_cnf( 2, 2, CNF2)
, findall( CNF2, TERM2, L2)
, CHECK = ( member( CNF2, L2), cnf_compare( CNF1, CNF2))
, forall( TERM1, CHECK)
.

test( cnf_vs_all_2_3) :- true
, TERM1 = ( create_cnf_all( 2, 3, CNF1), is_set( CNF1) )
, TERM2 = create_cnf( 2, 3, CNF2)
, findall( CNF2, TERM2, L2)
, CHECK = ( member( CNF2, L2), cnf_compare( CNF1, CNF2))
, forall( TERM1, CHECK)
.

test( cnf_vs_all_3_2) :- true
, TERM1 = ( create_cnf_all( 3, 2, CNF1), is_set( CNF1) )
, TERM2 = create_cnf( 3, 2, CNF2)
, findall( CNF2, TERM2, L2)
, CHECK = ( member( CNF2, L2), cnf_compare( CNF1, CNF2))
, forall( TERM1, CHECK)
.

% test( cnf_vs_all_3_3) :- true % passed 136.919 sec
% , TERM1 = ( create_cnf_all( 3, 3, CNF1), is_set( CNF1) )
% , TERM2 = create_cnf( 3, 3, CNF2)
% , findall( CNF2, TERM2, L2)
% , CHECK = ( member( CNF2, L2), cnf_compare( CNF1, CNF2))
% , forall( TERM1, CHECK)
% .

% test( cnf_order_001) :- true
% , findall( CNF, cnf_enumeration1( 2, 2, CNF), L1)
% , findall( CNF, cnf_enumeration3( 2, 2, CNF), L2)
% , L1 == L2
% .
% 
% test( cnf_order_002) :- true
% , findall( CNF, cnf_enumeration1( 2, 2, CNF), L1)
% , findall( CNF, cnf_enumeration4( 2, 2, CNF), L2)
% , L1 == L2
% .

test( cnf_order_003) :- true
, aggregate_all( set(CNF), cnf_enumeration1( 3, 3, CNF), L1)
, aggregate_all( set(CNF), cnf_enumeration2( 3, 3, CNF), L2)
, L1 == L2
.

test( cnf_order_004) :- true
, aggregate_all( set(CNF), cnf_enumeration3( 2, 3, CNF), L1)
, aggregate_all( set(CNF), cnf_enumeration4( 2, 3, CNF), L2)
, L1 == L2
.


normalize_001_4_comparison( L_PRE, L) :- true
, maplist( msort, L_PRE, L_PRE2)
, msort( L_PRE2, L)
.


test( cnf_order_005) :- true
, aggregate_all( set(CNF), cnf_enumeration1( 3, 2, CNF), L1_PRE)
, aggregate_all( set(CNF), cnf_enumeration4( 3, 2, CNF), L2_PRE)
, normalize_001_4_comparison( L1_PRE, L1)
, normalize_001_4_comparison( L2_PRE, L2)
, L1 == L2
.

test( cnf_order_005_failing, [fail]) :- true
, aggregate_all( set(CNF), cnf_enumeration1( 3, 2, CNF), L1)
, aggregate_all( set(CNF), cnf_enumeration4( 3, 2, CNF), L2)
, L1 == L2
.

test( cnf_order_006) :- true
, aggregate_all( set(CNF), cnf_enumeration1( 2, 3, CNF), L1)
, aggregate_all( set(CNF), cnf_enumeration4( 2, 3, CNF), L2)
, L1 == L2
.


test( cnf_order_007) :- true
, aggregate_all( set(CNF), cnf_enumeration3( 3, 3, CNF), L1)
, aggregate_all( set(CNF), cnf_enumeration4( 3, 3, CNF), L2)
, L1 == L2
.

% 29.567 sec
% test( cnf_order_007_3_4) :- true
% , aggregate_all( set(CNF), cnf_enumeration3( 3, 4, CNF), L1_PRE)
% , aggregate_all( set(CNF), cnf_enumeration4( 3, 4, CNF), L2_PRE)
% , normalize_001_4_comparison( L1_PRE, L1)
% , normalize_001_4_comparison( L2_PRE, L2)
% , L1 == L2
% .

% 26.135 sec
% test( cnf_order_007_4_3) :- true
% , aggregate_all( set(CNF), cnf_enumeration3( 4, 3, CNF), L1_PRE)
% , aggregate_all( set(CNF), cnf_enumeration4( 4, 3, CNF), L2_PRE)
% , normalize_001_4_comparison( L1_PRE, L1)
% , normalize_001_4_comparison( L2_PRE, L2)
% , L1 == L2
% .

normalize_002_and_compare( L1_PRE, L2_PRE) :- true
, normalize_001_4_comparison( L1_PRE, L1)
, normalize_001_4_comparison( L2_PRE, L2)
, intersection( L1, L2, L3)
, subtract( L1, L3, L11)
, subtract( L2, L3, L22)
% , length( L1, LEN1)
% , length( L2, LEN2)
% , writeln( (LEN1,LEN2))
% , writeln( L11)
% , writeln( L22)
% , L1 == L2
% the remaining cnfs can be represented by each other
, bubble_compare_sets( cnf_compare, L11, L22)
.

test( cnf_order_008) :- true
, aggregate_all( set(CNF), cnf_enumeration1( 3, 3, CNF), L1_PRE)
, aggregate_all( set(CNF), cnf_enumeration4( 3, 3, CNF), L2_PRE)
, normalize_002_and_compare( L1_PRE, L2_PRE)
.

test( cnf_order_008_failing, [fail]) :- true
, aggregate_all( set(CNF), cnf_enumeration1( 3, 3, CNF), L1_PRE)
, aggregate_all( set(CNF), cnf_enumeration4( 3, 3, CNF), L2_PRE)
, normalize_001_4_comparison( L1_PRE, L1)
, normalize_001_4_comparison( L2_PRE, L2)
, L1 == L2
.

% test( cnf_order_009) :- true
% , aggregate_all( set(CNF), cnf_enumeration1( 4, 4, CNF), L1_PRE)
% , aggregate_all( set(CNF), cnf_enumeration4( 4, 4, CNF), L2_PRE)
% , normalize_002_and_compare( L1_PRE, L2_PRE)
% .

/*

% ERROR: /home/ox/dev-git/cnf_enumeration/003_swipl_003/tests.pl:185:
% ERROR:     test cnf:cnf_order_009: received error: '$tbl_wkl_add_answer'/4: Not enough resources: private_table_space
% % End unit cnf: **FAILED (815.919 sec CPU)
% ERROR: 1 test failed

*/

:- end_tests( cnf).

run_my_tests :- true
, cnf_configuration_set_has_false_rules( true)
, cnf_configuration_set_has_lesser_vars( true)
, run_tests
, cnf_configuration_set_has_false_rules( false)
, run_tests
, cnf_configuration_set_has_lesser_vars( false)
, run_tests
, cnf_configuration_set_has_false_rules( true)
, run_tests
.

:- writeln( 'run run_my_tests, avoid make').

:- run_my_tests.

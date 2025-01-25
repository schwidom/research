:- table cnf_minpermutation1/4 .

cnf_minpermutation1( RULECOUNT, VARCOUNT, CNF, CNF_MINPERMUTATION) :- true
, group_sorted_cnf_table( RULECOUNT, VARCOUNT, CNF)
, setof( CNF_ORDERED, cnf_order1( CNF, CNF_ORDERED), CNF_ORDERED_SET)
, CNF_ORDERED_SET = [ CNF_MINPERMUTATION | _ ] 
.

:- table cnf_minpermutation2/4 .

cnf_minpermutation2( RULECOUNT, VARCOUNT, CNF, CNF_MINPERMUTATION) :- true
, create_cnf( RULECOUNT, VARCOUNT, CNF)
, setof( CNF_ORDERED, cnf_order1( CNF, CNF_ORDERED), CNF_ORDERED_SET)
, CNF_ORDERED_SET = [ CNF_MINPERMUTATION | _ ] 
.


/*

% (ins)?- aggregate_all( count, cnf_minpermutation1( 3, 3, CNF, CNF2), C).
% C = 2925.

*/

:- table cnf_minpermutation3/4 .

cnf_minpermutation3( RULECOUNT, VARCOUNT, CNF, CNF_MINPERMUTATION) :- true
, create_cnf( RULECOUNT, VARCOUNT, CNF)
, setof( CNF_ORDERED, cnf_order2( CNF, CNF_ORDERED), CNF_ORDERED_SET)
, CNF_ORDERED_SET = [ CNF_MINPERMUTATION | _ ] 
.

:- table cnf_minpermutation4/4 .
cnf_minpermutation4( RULECOUNT, VARCOUNT, CNF, CNF_MINPERMUTATION) :- true
, create_cnf_all( RULECOUNT, VARCOUNT, CNF)
, is_set( CNF)
, setof( CNF_ORDERED, cnf_order2( CNF, CNF_ORDERED), CNF_ORDERED_SET)
, CNF_ORDERED_SET = [ CNF_MINPERMUTATION | _ ] 
.

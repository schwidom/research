
cnf_order1( [], []) :- !.

cnf_order1( CNF, CNF_ORDERED) :- true
, member( CHOOSED_RULE, CNF)
, order0( CHOOSED_RULE, CHOOSED_RULE_ORDER)
, index0( CHOOSED_RULE_ORDER, CHOOSED_RULE, CHOOSED_RULE_ORDERED)
, sorted_to_permutation_indicator0( CHOOSED_RULE_ORDERED, PERMUTATION_CLASS_IDS)
, interpermutation( PERMUTATION_CLASS_IDS, CHOOSED_RULE_ORDER, CHOOSED_RULE_ORDER_PERMUTED)
, maplist( index0( CHOOSED_RULE_ORDER_PERMUTED), CNF, CNF_ORDERED_PRE)
, msort( CNF_ORDERED_PRE, CNF_ORDERED)
.

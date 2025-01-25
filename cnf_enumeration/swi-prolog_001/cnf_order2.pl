cnf_order2( CNF, CNF_ORDERED) :- true
, cnf_maplist_msort_order_index( CNF, _CNF_GROUP, CNF_GROUP_ORDER, CNF_GROUP_ORDERED)
, sorted_to_permutation_indicator0( CNF_GROUP_ORDERED, PERMUTATION_CLASS_IDS)
, index0( CNF_GROUP_ORDER, CNF, CNF_ORDERED_PRE)
, interpermutation( PERMUTATION_CLASS_IDS, CNF_ORDERED_PRE, CNF2_ORDERED)
, transposed_msort( CNF2_ORDERED, CNF_ORDERED)
.

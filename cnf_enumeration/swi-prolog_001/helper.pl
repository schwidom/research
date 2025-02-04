cnf_maplist_msort_order_index( CNF, CNF_GROUP, CNF_GROUP_ORDER, CNF_GROUP_ORDERED) :- true
, maplist( msort, CNF, CNF_GROUP)
, order0( CNF_GROUP, CNF_GROUP_ORDER)
, index0( CNF_GROUP_ORDER, CNF_GROUP, CNF_GROUP_ORDERED)
.

% transposed_msort( [[],[]], [[],[]]) :- !. % not needed momentarily
transposed_msort( [[]], [[]]) :- !. % structure has to be preserved
transposed_msort( LOL1, LOL2) :- true
, transpose( LOL1, LOL1_TRANSPOSED)
, msort( LOL1_TRANSPOSED, LOL2_TRANSPOSED)
, transpose( LOL2_TRANSPOSED, LOL2)
.

get_or_put_assoc( KEY, A0, VALUE, A1) :- true
, get_assoc( KEY, A0, VALUE) -> A0 = A1
   ; put_assoc( KEY, A0, VALUE, A1)
.


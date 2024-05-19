
:- object( tower(_DATA_)).

:- public( tower/1).
tower(_DATA_).

:- public( discs/1).
discs(DISCS) :- length( _DATA_, DISCS).

:- public( minor_discs_iter/2).
minor_discs_iter( PIVOT, DISC) :- user:between0( 1, PIVOT, IDX), user:nth1( IDX, _DATA_, DISC).

:- public( minor_discs_sat/2).
minor_discs_sat( PIVOT, SAT) :- user:mybagof0( 0 =:= DISC, minor_discs_iter( PIVOT, DISC), L), SAT='*'(L).

:- public( pivot_iter/3).
:- mode( pivot_iter( ?integer, +var, +term), zero_or_more).
pivot_iter( PIVOT_IDX, DISC, SAT) :- true
, discs(LEN)
, user:between( 1, LEN, PIVOT_IDX)
, user:nth1( PIVOT_IDX, _DATA_, DISC)
, minor_discs_sat( PIVOT_IDX, SAT)
.

:- public( pivot_iter_dict/2).
pivot_iter_dict(PIVOT_IDX, DICT) :- DICT = _{discs:LEN,disc:DISC,rest:REST,sat:SAT}
, discs(LEN)
, user:between( 1, LEN, PIVOT_IDX)
, user:nth1( PIVOT_IDX, _DATA_, DISC,REST)
, minor_discs_sat( PIVOT_IDX, SAT)
.

:- end_object.


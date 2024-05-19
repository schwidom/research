:- object( tower_movable( _T1_, _T2_)).

:- public( new/0).
new :- _T1_ = tower(_), _T2_ = tower(_).

:- public(discs/1).
discs(LEN) :- user:maplist( {LEN}/[T]>>(T::discs(LEN)), [_T1_, _T2_]).

:- public( new/1).
new(LEN) :- new, discs(LEN).

:- public( pivot_iter/1).
pivot_iter( SAT) :- true
, _T1_::pivot_iter(IDX, DISC1, SAT1)
, _T2_::pivot_iter(IDX, DISC2, SAT2)
, SAT=( ( DISC1 # DISC2) * SAT1 * SAT2)
.

:- public( pivot_iter/2).
pivot_iter( IDX, SAT) :- true
, _T1_::pivot_iter(IDX, DISC1, SAT1)
, _T2_::pivot_iter(IDX, DISC2, SAT2)
, SAT=( ( DISC1 # DISC2) * SAT1 * SAT2)
.

:- public( pivot_iter_dict/2).
pivot_iter_dict( IDX, DICT) :- DICT = _{d1:D1,d2:D2,sat:SAT}
, _T1_::pivot_iter_dict(IDX, D1)
, _T2_::pivot_iter_dict(IDX, D2)
, SAT=( ( D1.disc # D2.disc) * D1.sat * D2.sat)
.

:- public( vars/1).
:- mode( vars(+list), one).
vars(L) :- _T1_= tower(L1), _T2_= tower(L2), user:append( L1, L2, L).

:- public( pivot_sat/1).
pivot_sat( SAT) :- true
, user:mybagof0( SAT, pivot_iter( SAT), L)
, SAT = '+'(L)
.

:- end_object.


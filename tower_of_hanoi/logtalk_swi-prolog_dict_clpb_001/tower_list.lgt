
:- object( tower_list(_TL_)).

:- public( tower_list/1).
tower_list(_TL_).

:- public( towers/1).
towers( LEN) :- length( _TL_, LEN).

:- public( discs/1).
discs( LEN) :- user:maplist( {LEN}/[T]>>(T=tower(_), T::discs(LEN)), _TL_).

:- public(towers_discs/2).
towers_discs( TOWERS,DISCS ) :- towers(TOWERS), discs(DISCS).

:- public(set_start/0).
set_start :- _TL_ = [T|REST], T::tower(DISCLIST), user:maplist( =(1), DISCLIST )
, user:maplist( [T2]>>( T2::tower(DL2), user:maplist( =(0), DL2)), REST)
.

:- public(set_end/0).
set_end :- user:append( REST, [T], _TL_), T::tower(DISCLIST), user:maplist( =(1), DISCLIST )
, user:maplist( [T2]>>( T2::tower(DL2), user:maplist( =(0), DL2)), REST)
.

:- use_module( library( clpfd)).

:- public(tower_movable_iter_dict/2).
tower_movable_iter_dict(IDXs, DICT) :- DICT = _{tower_movable: tower_movable(T1,T2),tower_list_remainder: tower_list_remainder( REMAINDER)}
, IDXs = (IDX1, IDX2)
, user:append( REM1, [T1|TAIL], _TL_)
, length( REM1, REM1LEN)
, IDX1 #= REM1LEN + 1
, user:nth1( IDX2SUB, TAIL, T2, REM2)
, IDX2 #= IDX1 + IDX2SUB
, user:append( REM1, REM2, REMAINDER)
.

:- end_object.

:- object( tower_list_pair( _TLP1_, _TLP2_)).
:- public( tower_list_pair/2).
tower_list_pair( _TLP1_, _TLP2_).

:- public( tower_movable_iter_dict2/3).
tower_movable_iter_dict2(IDXs, DICT1, DICT2) :- true
, _TLP1_::tower_movable_iter_dict(IDXs, DICT1)
, _TLP2_::tower_movable_iter_dict(IDXs, DICT2)
.

:- public( tower_move_iter_sat/1).
tower_move_iter_sat(SAT) :- true
, tower_movable_iter_dict2( _, DICT1, DICT2)
, tower_list_remainder_pair( DICT1.tower_list_remainder, DICT2.tower_list_remainder)::equal_sat(T1)
, tower_move( DICT1.tower_movable, DICT2.tower_movable)::pivot_sat(T2)
, SAT=T1*T2
.

:- public( tower_move_sat/1).
tower_move_sat(SAT) :- user:mybagof0( SAT, tower_move_iter_sat(SAT), L), SAT = card([1], L).

:- end_object.


:- object( tower_list_remainder(_TLR_)).
:- public( tower_list_remainder/1).
tower_list_remainder(_TLR_).
:- end_object.

:- object( tower_list_remainder_pair( _TLR1_, _TLR2_)).

:- public(new/0).
new :- _TLR1_ = tower_list_remainder(_), _TLR2_ = tower_list_remainder(_).

:- public( equal_sat/1).
equal_sat( SAT) :- true
, _TLR1_::tower_list_remainder(TLR1)
, _TLR2_::tower_list_remainder(TLR2)
, length( TLR1, LEN1)
, length( TLR2, LEN2)
, user:must_be( oneof( [LEN1]), LEN2)
, user:mygroup_by0( (TLR1,TLR2), E1 =:= E2, ( true
   , user:nth1( IDX1, TLR1, T1)
   , user:nth1( IDX1, TLR2, T2)
   , T1::tower(L1)
   , T2::tower(L2)
   , user:nth1( IDX2, L1, E1)
   , user:nth1( IDX2, L2, E2)
   ) , L) 
, SAT= '*'( L )
.

:- end_object.



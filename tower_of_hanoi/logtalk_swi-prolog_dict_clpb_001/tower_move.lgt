:- object( tower_move( _TP1_, _TP2_)).

:- public( tower_move/2).
tower_move( _TP1_, _TP2_).

:- public(new/0).
new :- true , _TP1_ = tower_movable( _, _) , _TP2_ = tower_movable( _, _) , user:maplist( [TP]>>(TP::new), [_TP1_,_TP2_]).

:- public(discs/1).
discs(LEN) :- user:maplist( {LEN}/[TP]>>(TP::discs(LEN)), [_TP1_,_TP2_]).

:- public(new/1).
new(LEN) :- new, discs(LEN).

:- public( pivot_iter_dict/2).
pivot_iter_dict( IDX, DICT) :- DICT = _{d1:D1,d2:D2,sat:SAT}
, _TP1_::pivot_iter_dict(IDX, D1)
, _TP2_::pivot_iter_dict(IDX, D2)
, user:mybagof0( E1 =:= E2, I^(user:nth1( I, D1.d1.rest, E1), user:nth1( I, D2.d1.rest, E2)), L1)
, user:mybagof0( E1 =:= E2, I^(user:nth1( I, D1.d2.rest, E1), user:nth1( I, D2.d2.rest, E2)), L2)
, SAT = D1.sat * (D1.d1.disc # D2.d1.disc) * (D1.d2.disc # D2.d2.disc) * '*'(L1) * '*'(L2)
.

:- public( pivot_sat/1).
pivot_sat( SAT) :- true
, user:mybagof0( SAT , (IDX,DICT)^( pivot_iter_dict( IDX, DICT), user:dict_key_value( DICT, sat, SAT)), L)
% , SAT = '+'(L)
, SAT = card( [1], L) % same result but clearer intention
.

:- public(vars/1).
vars(VARS) :- _TP1_::vars(V1), _TP2_::vars(V2), user:append( V1, V2, VARS).

:- end_object.

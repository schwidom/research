
:- object( tower_list_chain( _TLC_)).

:- public( tower_list_chain/1).
tower_list_chain( _TLC_).

:- public( len/1).
len( LEN) :- length( _TLC_, LEN).

:- public(towers_discs/2).
towers_discs( TOWERS,DISCS ) :- true
, user:maplist( {TOWERS,DISCS}/[TL]>>( TL=tower_list(_), TL::towers_discs( TOWERS,DISCS )), _TLC_)
.

:- public( set_start_end/0).
set_start_end :- _TLC_ = [START|_], START::set_start, user:last( _TLC_, END), END::set_end.

:- public( window2_iter/2).
window2_iter( TL1, TL2) :- user:nth1( IDX, _TLC_, TL1), user:nth0(IDX, _TLC_, TL2).

:- public( window2_sat/1).
window2_sat( SAT) :- true
, user:mygroup_by0( ( _TLC_), SAT, 
   ( window2_iter( TL1, TL2), tower_list_pair( TL1, TL2)::tower_move_sat( SAT)), L)
, SAT = '*'(L)
.

:- end_object.


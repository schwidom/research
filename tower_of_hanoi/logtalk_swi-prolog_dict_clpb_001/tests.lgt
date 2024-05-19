
:- object(tests, extends(lgtunit)).

test( tower__minor_discs_sat, deterministic(true)) :- true
, T=tower(_), T::(discs(3),minor_discs_sat(3, D))
, X = (T,D)
, X =@= (tower([_A, _B, _C]), *([0=:=_A, 0=:=_B])) 
.

test( tower__pivot_iter, deterministic(true)) :- true
, T=tower(_), bagof( (IDX, DISC, SAT), T::(discs(3),pivot_iter( IDX, DISC, SAT)), L)
, X = (T, L)
, X =@= (tower([_A, _B, _C]), [(1, _A, *([])), (2, _B, *([0=:=_A])), (3, _C, *([0=:=_A, 0=:=_B]))])
.

test( tower__pivot_iter_dict, deterministic(true)) :- true
, T=tower(_), bagof( (I,D), T::(discs(3),pivot_iter_dict(I,D)), L)
, X = (T,L)
, X =@= (
    tower([_A, _B, _C]),
    [
     (1, _{disc:_A, discs:3, rest:[_B, _C], sat: *([])}), 
     (2, _{disc:_B, discs:3, rest:[_A, _C], sat: *([0=:=_A])}), 
     (3, _{disc:_C, discs:3, rest:[_A, _B], sat: *([0=:=_A, 0=:=_B])})
    ]
   )
.

test( tower_movable__pivot_iter_dict_001, deterministic(true)) :- true
, TP = tower_movable( _, _) , bagof( (I,D), TP::( new(2), pivot_iter_dict(I,D)), L)
, X = ( TP, L)
, X =@= (
  tower_movable(tower([_A, _B]), tower([_C, _D])), 
  [
   (1, _{
         d1:_{disc:_A, discs:2, rest:[_B], sat: *([])}, 
         d2:_{disc:_C, discs:2, rest:[_D], sat: *([])}, 
         sat: (_A#_C)* *([])* *([])} ), 
   (2, _{
         d1:_{disc:_B, discs:2, rest:[_A], sat: *([0=:=_A])}, 
         d2:_{disc:_D, discs:2, rest:[_C], sat: *([0=:=_C])}, 
         sat: (_B#_D)* *([0=:=_A])* *([0=:=_C])} )
  ]
 )
.

test( tower_movable__pivot_sat) :- true 
, TP = tower_movable( T1, T2)
, T1 = tower([1,1,1])
, T2 = tower([0,0,0])
, TP::(pivot_sat(SAT), vars(VARS))
, user:sat(SAT) , user:labeling(VARS)

, TP =@= TP
, TP =@= tower_movable(tower([1, 1, 1]), tower([0, 0, 0]))
, T1 =@= tower([1, 1, 1])
, T2 =@= tower([0, 0, 0])
, SAT =@= +[(1#0)* *([])* *([]), (1#0)* *([0=:=1])* *([0=:=0]), (1#0)* *([0=:=1, 0=:=1])* *([0=:=0, 0=:=0])]
, VARS =@= [1, 1, 1, 0, 0, 0]
.

test( tower_movable__pivot_iter_dict_002) :- true
, TP = tower_movable( _, _)
, bagof( (IDX, DICT), TP::( new(3), vars(VARS), pivot_iter_dict(IDX, DICT)), L)
, X=(TP,VARS,L)
, X =@= (
   tower_movable(tower([_A, _B, _C]), tower([_D, _E, _F])),
   [_A, _B, _C, _D, _E, _F],
   [
    (1, _{
          d1:_{disc:_A, discs:3, rest:[_B, _C], sat: *([])}, 
          d2:_{disc:_D, discs:3, rest:[_E, _F], sat: *([])}, 
          sat: (_A#_D)* *([])* *([])} ),
    (2, _{
          d1:_{disc:_B, discs:3, rest:[_A, _C], sat: *([0=:=_A])},
          d2:_{disc:_E, discs:3, rest:[_D, _F], sat: *([0=:=_D])}, 
          sat: (_B#_E)* *([0=:=_A])* *([0=:=_D])} ), 
    (3, _{
          d1:_{disc:_C, discs:3, rest:[_A, _B], sat: *([0=:=_A, 0=:=_B])},
          d2:_{disc:_F, discs:3, rest:[_D, _E], sat: *([0=:=_D, 0=:=_E])}, 
          sat: (_C#_F)* *([0=:=_A, 0=:=_B])* *([0=:=_D, 0=:=_E])} )
   ]
  )
.

test( tower_move__pivot_iter_dict) :- true
, TM = tower_move(_,_)
, bagof( (I, D), TM::(new(2), pivot_iter_dict( I, D), vars(V)), L)
, X = ( TM, V, L)
, X =@= (
   tower_move(tower_movable(tower([_A, _B]), tower([_C, _D])), tower_movable(tower([_E, _F]), tower([_G, _H]))),
   [_A, _B, _C, _D, _E, _F, _G, _H],
   [
    (1, _{
     d1:_{
      d1:_{disc:_A, discs:2, rest:[_B], sat: *([])}, 
      d2:_{disc:_C, discs:2, rest:[_D], sat: *([])}, 
      sat: (_A#_C)* *([])* *([])},
     d2:_{
      d1:_{disc:_E, discs:2, rest:[_F], sat: *([])}, 
      d2:_{disc:_G, discs:2, rest:[_H], sat: *([])}, 
      sat: (_E#_G)* *([])* *([])},
     sat: (_A#_C)* *([])* *([])*(_A#_E)*(_C#_G)* *([_B=:=_F])* *([_D=:=_H])}),
    (2, _{
     d1:_{
      d1:_{disc:_B, discs:2, rest:[_A], sat: *([0=:=_A])},
      d2:_{disc:_D, discs:2, rest:[_C], sat: *([0=:=_C])}, 
      sat: (_B#_D)* *([0=:=_A])* *([0=:=_C])},
     d2:_{
      d1:_{disc:_F, discs:2, rest:[_E], sat: *([0=:=_E])}, 
      d2:_{disc:_H, discs:2, rest:[_G], sat: *([0=:=_G])}, 
      sat: (_F#_H)* *([0=:=_E])* *([0=:=_G])}, 
     sat: (_B#_D)* *([0=:=_A])* *([0=:=_C])*(_B#_F)*(_D#_H)* *([_A=:=_E])* *([_C=:=_G])})
   ]
  )
.

test( tower_move__pivot_sat_001) :- true
, TM = tower_move(_,_), TM::(new(1), vars(V), pivot_sat( SAT))
, X=(TM,V,SAT)
, X =@= (
    tower_move(tower_movable(tower([_A]), tower([_B])), tower_movable(tower([_C]), tower([_D]))), 
    [_A, _B, _C, _D], 
    card([1], [(_A#_B)* *([])* *([])*(_A#_C)*(_B#_D)* *([])* *([])])
    )
.

test( tower_move__pivot_sat_002) :- true
, TM = tower_move(_,_), TM::(new(2), vars(V), pivot_sat( SAT))
, X=(TM,V,SAT)
, X =@= (
    tower_move(tower_movable(tower([_A, _B]), tower([_C, _D])), tower_movable(tower([_E, _F]), tower([_G, _H]))),
    [_A, _B, _C, _D, _E, _F, _G, _H],
    % +[(_A#_C)* *([])* *([])*(_A#_E)*(_C#_G)* *([_B=:=_F])* *([_D=:=_H]), (_B#_D)* *([0=:=_A])* *([0=:=_C])*(_B#_F)*(_D#_H)* *([_A=:=_E])* *([_C=:=_G])]
    card([1], [(_A#_C)* *([])* *([])*(_A#_E)*(_C#_G)* *([_B=:=_F])* *([_D=:=_H]), (_B#_D)* *([0=:=_A])* *([0=:=_C])*(_B#_F)*(_D#_H)* *([_A=:=_E])* *([_C=:=_G])]) % same result but clearer
  )
.

test( tower_list__tower_movable_iter_dict_001) :- true
, TL = tower_list([1,2]), TL::tower_movable_iter_dict(I, D)
, TL =@= tower_list([1, 2])
, I =@= (1, 2)
, D =@= _{tower_list_remainder:tower_list_remainder([]), tower_movable:tower_movable(1, 2)}
.

test( tower_list__tower_movable_iter_dict_002, deterministic(true)) :- true
, TL = tower_list([1,2,3,4]), bagof( (I, D), TL::tower_movable_iter_dict(I, D), L)
, L =@= [
   ((1, 2), _{tower_list_remainder:tower_list_remainder([3, 4]), tower_movable:tower_movable(1, 2)}),
   ((1, 3), _{tower_list_remainder:tower_list_remainder([2, 4]), tower_movable:tower_movable(1, 3)}),
   ((1, 4), _{tower_list_remainder:tower_list_remainder([2, 3]), tower_movable:tower_movable(1, 4)}),
   ((2, 3), _{tower_list_remainder:tower_list_remainder([1, 4]), tower_movable:tower_movable(2, 3)}),
   ((2, 4), _{tower_list_remainder:tower_list_remainder([1, 3]), tower_movable:tower_movable(2, 4)}),
   ((3, 4), _{tower_list_remainder:tower_list_remainder([1, 2]), tower_movable:tower_movable(3, 4)})
  ]
.

test( tower_list_pair__tower_movable_iter_dict2, deterministic(true)) :- true
, TLP = tower_list_pair( tower_list([a,b,c]), tower_list([d,e,f])), bagof( (I, D1, D2), TLP::tower_movable_iter_dict2(I, D1, D2), L)
, L =@= [
     ((1, 2), _{tower_list_remainder:tower_list_remainder([c]), tower_movable:tower_movable(a, b)}, 
              _{tower_list_remainder:tower_list_remainder([f]), tower_movable:tower_movable(d, e)}),
     ((1, 3), _{tower_list_remainder:tower_list_remainder([b]), tower_movable:tower_movable(a, c)}, 
              _{tower_list_remainder:tower_list_remainder([e]), tower_movable:tower_movable(d, f)}),
     ((2, 3), _{tower_list_remainder:tower_list_remainder([a]), tower_movable:tower_movable(b, c)}, 
              _{tower_list_remainder:tower_list_remainder([d]), tower_movable:tower_movable(e, f)})
  ]
.

test( tower_list_pair__tower_move_iter_sat) :- true
, TL1=tower_list(_), TL1::(towers_discs( 3, 3),set_start), TL2=tower_list(_), TL2::(towers_discs( 3, 3)), TLP = tower_list_pair( TL1, TL2), bagof( (SAT), TLP::tower_move_iter_sat(SAT), L), X = (TLP, L)
, X =@= (
    tower_list_pair(tower_list([tower([1, 1, 1]), tower([0, 0, 0]), tower([0, 0, 0])]), tower_list([tower([_A, _B, _C]), tower([_D, _E, _F]), tower([_G, _H, _I])])),

    [*([0=:=_G, 0=:=_H, 0=:=_I])*card([1], [(1#0)* *([])* *([])*(1#_A)*(0#_D)* *([1=:=_B, 1=:=_C])* *([0=:=_E, 0=:=_F]), (1#0)* *([0=:=1])* *([0=:=0])*(1#_B)*(0#_E)* *([1=:=_A, 1=:=_C])* *([0=:=_D, 0=:=_F]), (1#0)* *([0=:=1, 0=:=1])* *([0=:=0, 0=:=0])*(1#_C)*(0#_F)* *([1=:=_A, 1=:=_B])* *([0=:=_D, 0=:=_E])]), *([0=:=_D, 0=:=_E, 0=:=_F])*card([1], [(1#0)* *([])* *([])*(1#_A)*(0#_G)* *([1=:=_B, 1=:=_C])* *([0=:=_H, 0=:=_I]), (1#0)* *([0=:=1])* *([0=:=0])*(1#_B)*(0#_H)* *([1=:=_A, 1=:=_C])* *([0=:=_G, 0=:=_I]), (1#0)* *([0=:=1, 0=:=1])* *([0=:=0, 0=:=0])*(1#_C)*(0#_I)* *([1=:=_A, 1=:=_B])* *([0=:=_G, 0=:=_H])]), *([1=:=_A, 1=:=_B, 1=:=_C])*card([1], [(0#0)* *([])* *([])*(0#_D)*(0#_G)* *([0=:=_E, 0=:=_F])* *([0=:=_H, 0=:=_I]), (0#0)* *([0=:=0])* *([0=:=0])*(0#_E)*(0#_H)* *([0=:=_D, 0=:=_F])* *([0=:=_G, 0=:=_I]), (0#0)* *([0=:=0, 0=:=0])* *([0=:=0, 0=:=0])*(0#_F)*(0#_I)* *([0=:=_D, 0=:=_E])* *([0=:=_G, 0=:=_H])])]

)
.

test( tower_list_pair__tower_move_sat_001) :- true
, TL1=tower_list(_), TL1::(towers_discs( 2, 1)),TL2=tower_list(_), TL2::(towers_discs( 2, 1)),TLP = tower_list_pair( TL1, TL2), TLP::tower_move_sat(SAT), X=(TLP,SAT)
, X =@= (
     tower_list_pair(tower_list([tower([_A]), tower([_B])]), tower_list([tower([_C]), tower([_D])])),
     card([1], [*([])*card([1], [(_A#_B)* *([])* *([])*(_A#_C)*(_B#_D)* *([])* *([])])])
    )
.

test( tower_list_pair__tower_move_sat_002) :- true
, TL1=tower_list(_), TL1::(towers_discs( 3, 3),set_start), TL2=tower_list(_), TL2::(towers_discs( 3, 3)), TLP = tower_list_pair( TL1, TL2), TLP::tower_move_sat(SAT), X = (TLP, SAT)
, X =@= (
    tower_list_pair(tower_list([tower([1, 1, 1]), tower([0, 0, 0]), tower([0, 0, 0])]), tower_list([tower([_A, _B, _C]), tower([_D, _E, _F]), tower([_G, _H, _I])])),

    card([1], [*([0=:=_G, 0=:=_H, 0=:=_I])*card([1], [(1#0)* *([])* *([])*(1#_A)*(0#_D)* *([1=:=_B, 1=:=_C])* *([0=:=_E, 0=:=_F]), (1#0)* *([0=:=1])* *([0=:=0])*(1#_B)*(0#_E)* *([1=:=_A, 1=:=_C])* *([0=:=_D, 0=:=_F]), (1#0)* *([0=:=1, 0=:=1])* *([0=:=0, 0=:=0])*(1#_C)*(0#_F)* *([1=:=_A, 1=:=_B])* *([0=:=_D, 0=:=_E])]), *([0=:=_D, 0=:=_E, 0=:=_F])*card([1], [(1#0)* *([])* *([])*(1#_A)*(0#_G)* *([1=:=_B, 1=:=_C])* *([0=:=_H, 0=:=_I]), (1#0)* *([0=:=1])* *([0=:=0])*(1#_B)*(0#_H)* *([1=:=_A, 1=:=_C])* *([0=:=_G, 0=:=_I]), (1#0)* *([0=:=1, 0=:=1])* *([0=:=0, 0=:=0])*(1#_C)*(0#_I)* *([1=:=_A, 1=:=_B])* *([0=:=_G, 0=:=_H])]), *([1=:=_A, 1=:=_B, 1=:=_C])*card([1], [(0#0)* *([])* *([])*(0#_D)*(0#_G)* *([0=:=_E, 0=:=_F])* *([0=:=_H, 0=:=_I]), (0#0)* *([0=:=0])* *([0=:=0])*(0#_E)*(0#_H)* *([0=:=_D, 0=:=_F])* *([0=:=_G, 0=:=_I]), (0#0)* *([0=:=0, 0=:=0])* *([0=:=0, 0=:=0])*(0#_F)*(0#_I)* *([0=:=_D, 0=:=_E])* *([0=:=_G, 0=:=_H])])])

  )
.

test( tower_list_remainder_pair__equal_sat, deterministic(true)) :- true
, tower_list_remainder_pair( tower_list_remainder([tower([A,B]),tower([C,D])]), tower_list_remainder([tower([E,F]),tower([G,H])]))::equal_sat(SAT)
, SAT =@= *([A=:=E, B=:=F, C=:=G, D=:=H])
.

test( tower_list_chain__towers_discs, deterministic(true)) :- true
, TLC=tower_list_chain(_), TLC::(len(3),towers_discs(4,5))
, TLC =@= tower_list_chain([
   tower_list([tower([_, _, _, _, _]), tower([_, _, _, _, _]), tower([_, _, _, _, _]), tower([_, _, _, _, _])]),
   tower_list([tower([_, _, _, _, _]), tower([_, _, _, _, _]), tower([_, _, _, _, _]), tower([_, _, _, _, _])]),
   tower_list([tower([_, _, _, _, _]), tower([_, _, _, _, _]), tower([_, _, _, _, _]), tower([_, _, _, _, _])])])
.

test( tower_list_chain__set_start_end) :- true
, TLC=tower_list_chain(_), TLC::(len(3),towers_discs(4,5),set_start_end)
, TLC =@= tower_list_chain([
   tower_list([tower([1, 1, 1, 1, 1]), tower([0, 0, 0, 0, 0]), tower([0, 0, 0, 0, 0]), tower([0, 0, 0, 0, 0])]),
   tower_list([tower([_, _, _, _, _]), tower([_, _, _, _, _]), tower([_, _, _, _, _]), tower([_, _, _, _, _])]),
   tower_list([tower([0, 0, 0, 0, 0]), tower([0, 0, 0, 0, 0]), tower([0, 0, 0, 0, 0]), tower([1, 1, 1, 1, 1])])])
.

test( tower_list_chain__window2_iter, deterministic(true)) :- true
, TLC = tower_list_chain([1,2,3,4]), bagof( (TL1, TL2), TLC::window2_iter(TL1, TL2), L)
, L =@= [(1, 2), (2, 3), (3, 4)]
.

test( tower_list_chain__window2_sat) :- true
, TLC=tower_list_chain(_), TLC::(len(4),towers_discs( 3, 2),set_start_end,window2_sat(SAT)), user:sat(SAT), X=(TLC, SAT)
, X =@= (
    tower_list_chain([
     tower_list([tower([1, 1]), tower([0, 0]), tower([0, 0])]),
     tower_list([tower([0, 1]), tower([1, 0]), tower([0, 0])]),
     tower_list([tower([0, 0]), tower([1, 0]), tower([0, 1])]),
     tower_list([tower([0, 0]), tower([0, 0]), tower([1, 1])])
    ]),
    *([card([1], [*([0=:=0, 0=:=0])*card([1], [(1#0)* *([])* *([])*(1#0)*(0#1)* *([1=:=1])* *([0=:=0]), (1#0)* *([0=:=1])* *([0=:=0])*(1#1)*(0#0)* *([1=:=0])* *([0=:=1])]), *([0=:=1, 0=:=0])*card([1], [(1#0)* *([])* *([])*(1#0)*(0#0)* *([1=:=1])* *([0=:=0]), (1#0)* *([0=:=1])* *([0=:=0])*(1#1)*(0#0)* *([1=:=0])* *([0=:=0])]), *([1=:=0, 1=:=1])*card([1], [(0#0)* *([])* *([])*(0#1)*(0#0)* *([0=:=0])* *([0=:=0]), (0#0)* *([0=:=0])* *([0=:=0])*(0#0)*(0#0)* *([0=:=1])* *([0=:=0])])]), card([1], [*([0=:=0, 0=:=1])*card([1], [(0#1)* *([])* *([])*(0#0)*(1#1)* *([1=:=0])* *([0=:=0]), (1#0)* *([0=:=0])* *([0=:=1])*(1#0)*(0#0)* *([0=:=0])* *([1=:=1])]), *([1=:=1, 0=:=0])*card([1], [(0#0)* *([])* *([])*(0#0)*(0#0)* *([1=:=0])* *([0=:=1]), (1#0)* *([0=:=0])* *([0=:=0])*(1#0)*(0#1)* *([0=:=0])* *([0=:=0])]), *([0=:=0, 1=:=0])*card([1], [(1#0)* *([])* *([])*(1#1)*(0#0)* *([0=:=0])* *([0=:=1]), (0#0)* *([0=:=1])* *([0=:=0])*(0#0)*(0#1)* *([1=:=1])* *([0=:=0])])]), card([1], [*([0=:=1, 1=:=1])*card([1], [(0#1)* *([])* *([])*(0#0)*(1#0)* *([0=:=0])* *([0=:=0]), (0#0)* *([0=:=0])* *([0=:=1])*(0#0)*(0#0)* *([0=:=0])* *([1=:=0])]), *([1=:=0, 0=:=0])*card([1], [(0#0)* *([])* *([])*(0#0)*(0#1)* *([0=:=0])* *([1=:=1]), (0#1)* *([0=:=0])* *([0=:=0])*(0#0)*(1#1)* *([0=:=0])* *([0=:=1])]), *([0=:=0, 0=:=0])*card([1], [(1#0)* *([])* *([])*(1#0)*(0#1)* *([0=:=0])* *([1=:=1]), (0#1)* *([0=:=1])* *([0=:=0])*(0#0)*(1#1)* *([1=:=0])* *([0=:=1])])])])
  )
.

:- end_object.

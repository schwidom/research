
rule_freevars( VARIDX, RULE, RULE_FREEVARS, ASSOC_IN, ASSOC_OUT) :- true
, VARIDX = _, RULE = [], RULE_FREEVARS = [], ASSOC_IN = ASSOC_OUT, !.

rule_freevars( VARIDX, RULE, RULE_FREEVARS, ASSOC_IN, ASSOC_OUT) :- true
, VARIDX_NEXT is 1 + VARIDX
, RULE = [ H1 | T1 ]
, ( H1 == 0 -> RULE_FREEVARS = [ H2| T2 ], H2 = ~NEW_VAR, get_or_put_assoc( VARIDX, ASSOC_IN, NEW_VAR, ASSOC_NEXT) 
   ; H1 == 1 -> RULE_FREEVARS = [ H2| T2 ], H2 = NEW_VAR, get_or_put_assoc( VARIDX, ASSOC_IN, NEW_VAR, ASSOC_NEXT)
   ; H1 == 2 -> RULE_FREEVARS = T2, ASSOC_IN = ASSOC_NEXT
   ; must_be( boolean, 'H1 contains wrong value'(H1))
  )
, rule_freevars( VARIDX_NEXT, T1, T2, ASSOC_NEXT, ASSOC_OUT)
.

/*

% (ins)?- empty_assoc(E), rule_freevars( 0, [0, 1, 2], RULE, E, O).
% E = t,
% RULE = [~_A, _B],
% O = t(0, _A, >, t, t(1, _B, -, t, t)).

*/


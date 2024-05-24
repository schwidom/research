
:- set_prolog_flag(table_space, 10737418240).

toh_create( NTOWERS, OBJECT) :- length( OBJECT, NTOWERS).
toh_create3( OBJECT) :- toh_create( 3, OBJECT).

toh_move( X, Y2, OBJ1, OBJ2) :- true
, nth0( X, OBJ1, LVON1, OBJREST1)
, when( nonvar(Y), ( Y >= X -> plus(1,Y,Y2) ; Y = Y2) )
, nth0( Y, OBJREST1, LBIS1, OBJREST) 
, LVON1 = [ E | LVON2]
, LBIS2 = [ E | LBIS1]
, nth0( X, OBJ2, LVON2, OBJREST2)
, nth0( Y, OBJREST2, LBIS2, OBJREST) 
.

toh_search( OBJ1, OBJ2, MOVES) :- OBJ1 = OBJ2, MOVES=[].

toh_search( OBJ1, OBJ2, MOVES) :- true
, toh_move( X, Y, OBJ1, OBJM)
, MOVE= X-Y
, MOVES=[MOVE|RESTMOVES]
, toh_search(OBJM,OBJ2, RESTMOVES)
.

:- table toh_search2/3.

toh_search2( OBJ1, OBJ2, MOVES) :- OBJ1 = OBJ2, MOVES=[].

toh_search2( OBJ1, OBJ2, MOVES) :- true
, toh_move( X, Y, OBJ1, OBJM)
, nth0(X,OBJ1,[XVALUE|_])
, nth0(Y,OBJ1,YVALUES)
, ( ( YVALUES = [YVALUE|_], XVALUE < YVALUE) ; YVALUES = [])

, MOVE= X-Y
, MOVES=[MOVE|RESTMOVES]
, toh_search2(OBJM,OBJ2, RESTMOVES)
.


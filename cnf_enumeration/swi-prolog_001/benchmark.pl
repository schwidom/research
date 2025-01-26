:- discontiguous benchmarks/1.

benchmarks( TERM) :- TERM = forall( cnf_minpermutation1( 3, 3, _, _), true).
benchmarks( TERM) :- TERM = forall( cnf_minpermutation2( 3, 3, _, _), true).
benchmarks( TERM) :- TERM = forall( cnf_minpermutation3( 3, 3, _, _), true).
benchmarks( TERM) :- TERM = forall( cnf_minpermutation4( 3, 3, _, _), true).

benchmarks( TERM) :- TERM = forall( cnf_enumeration1( 3, 3, _), true).
benchmarks( TERM) :- TERM = forall( cnf_enumeration2( 3, 3, _), true).
benchmarks( TERM) :- TERM = forall( cnf_enumeration3( 3, 3, _), true).
benchmarks( TERM) :- TERM = forall( cnf_enumeration4( 3, 3, _), true).

benchmarks( TERM) :- TERM = abolish_all_tables.

benchmarks( TERM) :- TERM = forall( cnf_enumeration1( 3, 3, _), true).
benchmarks( TERM) :- TERM = forall( cnf_enumeration2( 3, 3, _), true).
benchmarks( TERM) :- TERM = forall( cnf_enumeration3( 3, 3, _), true).
benchmarks( TERM) :- TERM = forall( cnf_enumeration4( 3, 3, _), true).

%%%%%%%%%%%%%%%%%%%

writeln_numbervars( X) :- copy_term( X, Y), numbervars( Y), writeln( Y).
write_numbervars( X) :- copy_term( X, Y), numbervars( Y), write( Y).

bench_001 :- true
, abolish_all_tables 
, PART1 = ( benchmarks( BENCHMARK), write_numbervars( BENCHMARK), write( '   '))
, PART2 = ( call_time( BENCHMARK, TIMES) -> writeln( TIMES) ; writeln( fail))
, forall( ( PART1, PART2), true)
.

/*

% (ins)?- bench_001.
% forall(cnf_minpermutation1(3,3,A,B),true)   time{cpu:0.3751129199999994,inferences:4387594,wall:0.382249116897583}
% forall(cnf_minpermutation2(3,3,A,B),true)   time{cpu:0.35440467999999825,inferences:4197439,wall:0.35439515113830566}
% forall(cnf_minpermutation3(3,3,A,B),true)   time{cpu:0.13007011499999876,inferences:1315472,wall:0.13008856773376465}
% forall(cnf_minpermutation4(3,3,A,B),true)   time{cpu:0.7728215489999997,inferences:7789238,wall:0.7728040218353271}
% forall(cnf_enumeration1(3,3,A),true)   time{cpu:0.004529810000001078,inferences:7029,wall:0.004529714584350586}
% forall(cnf_enumeration2(3,3,A),true)   time{cpu:0.005023569000002226,inferences:7029,wall:0.005022287368774414}
% forall(cnf_enumeration3(3,3,A),true)   time{cpu:0.004572424999999214,inferences:7029,wall:0.004571676254272461}
% forall(cnf_enumeration4(3,3,A),true)   time{cpu:0.02398665899999841,inferences:36279,wall:0.02398371696472168}
% abolish_all_tables   time{cpu:0.06170968500000029,inferences:1,wall:0.06170535087585449}
% forall(cnf_enumeration1(3,3,A),true)   time{cpu:0.3742150930000001,inferences:4388770,wall:0.38828015327453613}
% forall(cnf_enumeration2(3,3,A),true)   time{cpu:0.35712125899999947,inferences:4198615,wall:0.35711216926574707}
% forall(cnf_enumeration3(3,3,A),true)   time{cpu:0.13320626800000213,inferences:1316648,wall:0.13320088386535645}
% forall(cnf_enumeration4(3,3,A),true)   time{cpu:0.7792940610000016,inferences:7790414,wall:0.7792985439300537}
% true.

*/



% similar to an combn in R
% combn(x, m, FUN = NULL, simplify = TRUE, ...)

combn( _, 0, []). 

combn( Individuals, N, L) :- true
 , N > 0
 , NNext is N - 1
 , append( _, [M|IRT], Individuals)
 , L=[M|LT]
 , combn( IRT, NNext, LT)
 .
 

combn_rest( Individuals, 0, [], Rest) :- Individuals = Rest. 

combn_rest( Individuals, N, L, Rest) :- true
 , N > 0
 , NNext is N - 1
 , append( RestHere, [M|IRT], Individuals)
 , L=[M|LT]
 , combn_rest( IRT, NNext, LT, RestNext)
 , append( RestHere, RestNext, Rest)
 .
 


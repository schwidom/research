


cnf_solutioncount_count_sequence( RULECOUNT, VARCOUNT, SC_LIST, COUNT_LIST) :- true
, cnf_solutioncount_max( RULECOUNT, VARCOUNT, SC_MAX)
, findall( [ SC, COUNT], ( true
   , between( 0, SC_MAX, SC)
   , cnf_solutioncount_count( RULECOUNT, VARCOUNT, SC, COUNT)
   )
  , SC_COUNT_LIST
)
, transpose( SC_COUNT_LIST, [ SC_LIST, COUNT_LIST])
.

/*

% (ins)?- cnf_solutioncount_count_sequence( 2, 2, L1, L2).
% L1 = [0, 1, 2],
% L2 = [6, 7, 8].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 2, 3, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5, 6],
% L2 = [10, 7, 8, 12, 10, 20, 15].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 3, 2, L1, L2).
% L1 = [0, 1, 2],
% L2 = [27, 18, 2].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 3, 3, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5, 6],
% L2 = [93, 58, 100, 130, 131, 58, 3].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 4, 2, L1, L2).
% L1 = [0, 1],
% L2 = [58, 11].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 5, 2, L1, L2).
% L1 = [0, 1],
% L2 = [66, 3].
% 
% (ins)?- cnf_solutioncount_count_sequence( 6, 2, L1, L2).
% L1 = [0],
% L2 = [47].
% 
% (ins)?- cnf_solutioncount_count_sequence( 7, 2, L1, L2).
% L1 = [0],
% L2 = [21].
% 
% (ins)?- cnf_solutioncount_count_sequence( 8, 2, L1, L2).
% L1 = [0],
% L2 = [6].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 9, 2, L1, L2).
% L1 = [0],
% L2 = [1].
% 
% (ins)?- cnf_solutioncount_count_sequence( 10, 2, L1, L2).
% false.
% 
% (cmd)?- cnf_solutioncount_count_sequence( 4, 3, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5],
% L2 = [788, 555, 851, 650, 304, 28].
% 
% (ins)?- cnf_solutioncount_count_sequence( 5, 3, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5],
% L2 = [5196, 3625, 3492, 1476, 271, 6].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 6, 3, L1, L2).
% L1 = [0, 1, 2, 3, 4],
% L2 = [25897, 14484, 8325, 1794, 146].
% 
% (ins)?- cnf_solutioncount_count_sequence( 7, 3, L1, L2).
% L1 = [0, 1, 2, 3, 4],
% L2 = [97953, 38262, 12857, 1386, 50].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 2, 4, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
% L2 = [15, 7, 8, 12, 10, 20, 15, 16, 8, 6, 12, 33, 24, 41, 25].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 1, 4, L1, L2).
% L1 = [0, 1, 3, 7, 15],
% L2 = [1, 2, 3, 4, 5].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 3, 4, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
% L2 = [270, 58, 100, 208, 256, 220, 341, 385, 428, 585, 622, 550, 394, 137, 4].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 4, 4, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
% L2 = [5232, 975, 2657, 4112, 6362, 6744, 9595, 9696, 10750, 9285, 6734, 3383, 967, 53].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 1, 5, L1, L2).
% L1 = [0, 1, 3, 7, 15, 31],
% L2 = [1, 2, 3, 4, 5, 6].
% 
% (cmd)?- cnf_solutioncount_count_sequence( 2, 5, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
% L2 = [21, 7, 8, 12, 10, 20, 15, 16, 8, 6, 12, 33, 24, 41, 25, 20, 10, 12, 16, 44, 21, 12, 42, 66, 46, 72, 38].
% 
% (ins)?- cnf_solutioncount_count_sequence( 3, 5, L1, L2).
% L1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
% L2 = [684, 58, 100, 208, 256, 220, 341, 489, 552, 627, 718, 814, 846, 477, 748, 758, 612, 322, 855, 1272, 1640, 1864, 2301, 1978, 2283, 2618, 2094, 1646, 975, 282, 5].

*/


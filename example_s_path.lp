#include "reachable.lp".

% grid:
% [ 
%     (0, 0), (0, 1), (0, 2),
%     (1, 0), (1, 1), (1, 2),
%     (2, 0), (2, 1), (2, 2)
% ]

% island(1, 0, 0). island(2, 0, 1). island(3, 0, 2). 
% island(4, 1, 0). island(5, 1, 1). island(6, 1, 2). 
% island(7, 2, 0). island(8, 2, 1). island(9, 2, 2). 

% S path 1 -> 2 -> 3 -> 6 -> 5 -> 4 -> 7 -> 8 -> 9

bridge(2, 1).
bridge(3, 2).
bridge(6, 3).
bridge(6, 5).
bridge(5, 4).
bridge(7, 4).
bridge(8, 7).
bridge(9, 8).

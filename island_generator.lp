#const island_num = 20.

% Example 3x3 grid and island numbering:

% grid:
% [ 
%     (0, 0), (0, 1), (0, 2),
%     (1, 0), (1, 1), (1, 2),
%     (2, 0), (2, 1), (2, 2)
% ]

% island(1, 0, 0). island(2, 0, 1). island(3, 0, 2). 
% island(4, 1, 0). island(5, 1, 1). island(6, 1, 2). 
% island(7, 2, 0). island(8, 2, 1). island(9, 2, 2). 

% Set up points for the coordinate grid (0, 0) through (island_num, island_num).
point(0..island_num, 0..island_num).

% instantiate the first island.
island(1, 0, 0).

% Moving in X column increases the N by the length of the row
island(N + island_num + 1, X + 1, Y) :- island(N, X, Y), point(X + 1, Y).

% Moving in the Y row increases the N by 1
island(N + 1, X, Y + 1) :- island(N, X, Y), point(X, Y + 1).

% Bidirectional edges
edge(X,Y) :- bridge(X,Y).
edge(Y,X) :- bridge(X,Y).

% Base distance
starting_distance(1,0).

% Recursive BFS distance
starting_distance(Y, D+1) :- edge(X, Y), starting_distance(X, D), D <= island_num.

% inspect islands that have no distance?
distance(X, M) :- reachable(X), M = #min{D : starting_distance(X, D)}, #count{D : starting_distance(X, D)} >= 1.

#show distance/2.

#include "reachable.lp".

% Let us assume that bridges can only be connected between adjacent islands (non-diagonal).

% choose to add a bridge between islands to the left and right:
{bridge(N, M) : island(N, X1, Y1), island(M, X2, Y2), X1 = X2, Y1 = Y2 + 1}.

% choose to add a bridge between islands above and below:
{bridge(N, M) : island(N, X1, Y1), island(M, X2, Y2), Y1 = Y2, X1 = X2 + 1}.

% we must be able to reach the end
:-not reachable(9).

#show bridge/2.
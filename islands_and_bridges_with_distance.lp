#const island_num = 2.

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

% =================================== Generate Islands ===================================

% Set up points for the coordinate grid (0, 0) through (island_num, island_num).
point(0..island_num, 0..island_num).

% instantiate the first island.
island(1, 0, 0).

% Moving in X column increases the N by the length of the row
island(N + island_num + 1, X + 1, Y) :- island(N, X, Y), point(X + 1, Y).

% Moving in the Y row increases the N by 1
island(N + 1, X, Y + 1) :- island(N, X, Y), point(X, Y + 1).

% Instantiate 1 variable island for ease of reading
island(N) :- island(N, _, _).

#show island/3.

% =================================== Generate Bridges ===================================

% Let us assume that bridges can only be connected between adjacent islands (non-diagonal).

% choose to add a bridge between islands to the left and right:
{bridge(N, M) : island(N, X1, Y1), island(M, X2, Y2), X1 = X2, Y1 = Y2 + 1}.

% choose to add a bridge between islands above and below:
{bridge(N, M) : island(N, X1, Y1), island(M, X2, Y2), Y1 = Y2, X1 = X2 + 1}.

% the first island is always reachable
reachable(1).
% X is reachable if there is a bridge entering a reachable island Y from X
reachable(X) :- bridge(X, Y), reachable(Y).

% X is reachable if there is a bridge entering X from a reachable island Y
reachable(X) :- bridge(Y, X), reachable(Y).

#show reachable/1.

% we must be able to reach the end
:-not reachable((island_num + 1) * (island_num + 1)).

#show bridge/2.

% =================================== Calculate Distance ===================================

% Bidirectional edges
edge(X,Y) :- bridge(X,Y).
edge(Y,X) :- bridge(X,Y).

% Base distance
all_distances(1,0).

% Find all possible distances for a particular island Y
all_distances(Y, D+1) :- edge(X, Y), all_distances(X, D), D <= (island_num + 1) * (island_num + 1).

% inspect islands that have no distance?
% Find minimal distance
distance(X, M) :- reachable(X), M = #min{D : all_distances(X, D)}.

#show distance/2.
% grid:
% [ 
%     (0, 0), (0, 1), (0, 2),
%     (1, 0), (1, 1), (1, 2),
%     (2, 0), (2, 1), (2, 2)
% ]

% island(1, 0, 0). island(2, 0, 1). island(3, 0, 2). 
% island(4, 1, 0). island(5, 1, 1). island(6, 1, 2). 
% island(7, 2, 0). island(8, 2, 1). island(9, 2, 2). 

% back path 1 -> 4 -> 6 -> 9 -> 8

bridge(2, 1).
bridge(3, 2).
bridge(6, 3).
bridge(9, 6).
bridge(9, 8).

% the first island is always reachable
reachable(1).
% X is reachable if there is a bridge entering a reachable island Y from X
reachable(X) :- bridge(X, Y), reachable(Y).

% X is reachable if there is a bridge entering X from a reachable island Y
reachable(X) :- bridge(Y, X), reachable(Y).

% Bidirectional edges
edge(X,Y) :- bridge(X,Y).
edge(Y,X) :- bridge(X,Y).

% Base distance
all_distances(1,0).

% Find all possible distances for a particular island Y
all_distances(Y, D+1) :- edge(X, Y), all_distances(X, D), D <= 9.

% inspect islands that have no distance?
% Find minimal distance
distance(X, M) :- reachable(X), M = #min{D : all_distances(X, D)}, #count{D : all_distances(X, D)} >= 1.

#show distance/2.
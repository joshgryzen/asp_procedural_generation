% Bidirectional edges
edge(X,Y) :- bridge(X,Y).
edge(Y,X) :- bridge(X,Y).

% Base distance
distance(1,0).

% Recursive BFS distance
distance(Y, D+1) :- edge(X, Y), distance(X, D), D <= 9.

min_distance(X, M) :- reachable(X), M = #min{D : distance(X, D)}.
#show min_distance/2.
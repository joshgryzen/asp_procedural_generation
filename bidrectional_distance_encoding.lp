% Bidirectional edges
edge(X,Y) :- bridge(X,Y).
edge(Y,X) :- bridge(X,Y).

% Base distance
starting_distance(1,0).

% Recursive BFS distance
starting_distance(Y, D+1) :- edge(X, Y), starting_distance(X, D), D <= 9.

distance(X, M) :- reachable(X), M = #min{D : starting_distance(X, D)}.

#show distance/2.
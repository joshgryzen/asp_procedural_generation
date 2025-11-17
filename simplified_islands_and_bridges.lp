island(1..9).

bridge(2, 1).
bridge(3, 2).
bridge(6, 3).
bridge(9, 6).
bridge(9, 8).

dist(X, X, 0) :- island(X).

% To go from island 1 to island 8, we must take 1, 2, 3, 6, 9, 8
dist(X,Y, M+1) :- island(X), island(Y), M = #min{N: dist(X,Z, N), bridge(Z,Y)}.
dist(Y,X, M+1) :- island(X), island(Y), M = #min{N: dist(X,Z, N), bridge(Z,Y)}.
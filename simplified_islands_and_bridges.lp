island(1..9).

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

% the distance to the first island is always 0
forward_distance(1, 0).

% forward_distance(1) := 0.

% calculate the minimum distance from the start assuming a straight line
forward_distance(X, M+1) :- bridge(X,Y), M = #min{D : forward_distance(Y, D)}.










% calculate the minimum distance from the start allowing backtracking
% this will catch the islands such that N > M where N never occurs in forward distsance
reverse_distance(X, M+1) :- bridge(Y, X), M = #min{D : forward_distance(Y, D)}.






% if there is only one forward or reverse distance, it is optimal
distance(X, D1) :- forward_distance(X, D1), not reverse_distance(X, _).
distance(X, D2) :- not forward_distance(X, _), reverse_distance(X, D2).

% otherwise, find the smaller distance (forward or backward)
distance(X, D1) :- forward_distance(X, D1), reverse_distance(X, D2), D1 <= D2.
distance(X, D2) :- forward_distance(X, D1), reverse_distance(X, D2), D1 > D2.
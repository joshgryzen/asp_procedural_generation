% the first island is always reachable
reachable(1).
% X is reachable if there is a bridge entering a reachable island Y from X
reachable(X) :- bridge(X, Y), reachable(Y).

% X is reachable if there is a bridge entering X from a reachable island Y
reachable(X) :- bridge(Y, X), reachable(Y).

#show reachable/1.
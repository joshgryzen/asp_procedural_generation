island(1, 0, 0). island(2, 0, 1). island(3, 0, 2). 
island(4, 1, 0). island(5, 1, 1). island(6, 1, 2). 
island(7, 2, 0). island(8, 2, 1). island(9, 2, 2). 

% bridge(N, M): bridges will always be such that N > M.
bridge(2, 1).
bridge(3, 2).
bridge(6, 3).
bridge(9, 6).

% bridge(4, 1).
% bridge(7, 4).
% bridge(8, 7).
bridge(9, 8).
% bridge(8, 9).

% distance(M, D+1) :- bridge(N, M), distance(N, D).

% distance(N, D + 1) :- bridge(N, M), D = #min{D1: distance(M, D1)}.

% X is reachable if there is a bridge entering a reachable island Y from X
reachable(X) :- bridge(X, Y), reachable(Y).

% X is reachable if there is a bridge entering X from a reachable island Y
reachable(X) :- bridge(Y, X), reachable(Y).

% The distance(N, D) = distance to island N is equal to D. 
% Let us set the distance from the first island to 0.
distance(1, 0).

% bridges will always be such that N > M.
% check if there are multiple distances?
% distance(N, D+1) :- reachable(N), bridge(N, M), distance(M, D).

% distance(N, D+1) :- reachable(N), bridge(M, N), distance(M, D).

% the start is always reachable
reachable(1).

#show distance/2.
#show reachable/1.
% grid:
% [ 
%     (0, 0), (0, 1), (0, 2),
%     (1, 0), (1, 1), (1, 2),
%     (2, 0), (2, 1), (2, 2)
% ]

% Consider a 3x3 grid. 
#const n = 3.

% For now, lets assume there is an island at each point
% island(N, X, Y) is island number N at point X, Y.
island(1, 0, 0). island(2, 0, 1). island(3, 0, 2). 
island(4, 1, 0). island(5, 1, 1). island(6, 1, 2). 
island(7, 2, 0). island(8, 2, 1). island(9, 2, 2). 

% Let us additionally assume that bridges can only be connected between adjacent islands (non-diagonal).

% bridges between islands to the left and right:
bridge(N, M) :- island(N, X1, Y1), island(M, X2, Y2), X1 = X2, Y1 = Y2 + 1.

% bridges between islands above and below:
bridge(N, M) :- island(N, X1, Y1), island(M, X2, Y2), Y1 = Y2, X1 = X2 + 1.

#show bridge/2.

% Let (0, 0) be the starting point and (2, 2) be the end point.

reachable(X) :- bridge(X, Y), reachable(Y).
reachable(1).

#show reachable/1.
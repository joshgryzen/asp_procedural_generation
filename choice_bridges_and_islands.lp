% grid:
% [ 
%     (0, 0), (0, 1), (0, 2),
%     (1, 0), (1, 1), (1, 2),
%     (2, 0), (2, 1), (2, 2)
% ]

point(1, 0, 0). point(2, 0, 1). point(3, 0, 2). 
point(4, 1, 0). point(5, 1, 1). point(6, 1, 2). 
point(7, 2, 0). point(8, 2, 1). point(9, 2, 2). 

#const p = 5.

% Let us now randomly pick p points to have an island
% island(N, X, Y) is island number N at point X, Y.
{island(N, X, Y) : point(N, X, Y)} = p.
% Let island (0, 0) be the starting point and island (2,2) be the end point.
% ensure we have our start and end islands:
:- not island(1, 0, 0).
:- not island(9, 2, 2).

#show island/3.
% {island((N), 0..(n-1), 0..(n-1))} = 1 :- N = 1..p.
% % a point X, Y cannot have more than one island.
% :- island(N1, X, Y), island(N2, X, Y), N1 != N2.

% Let us additionally assume that bridges can only be connected between adjacent islands (non-diagonal).

% choose to add a bridge between islands to the left and right:
{bridge(N, M) : island(N, X1, Y1), island(M, X2, Y2), X1 = X2, Y1 = Y2 + 1}.

% choose to add a bridge between islands above and below:
{bridge(N, M) : island(N, X1, Y1), island(M, X2, Y2), Y1 = Y2, X1 = X2 + 1}.

#show bridge/2.

reachable(X) :- bridge(X, Y), reachable(Y).
reachable(1).

% % we must be able to reach the end
:-not reachable(9).

#show reachable/1.
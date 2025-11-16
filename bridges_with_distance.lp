% grid:
% [ 
%     (0, 0), (0, 1), (0, 2),
%     (1, 0), (1, 1), (1, 2),
%     (2, 0), (2, 1), (2, 2)
% ]

% For now, lets assume there is an island at each point
% island(N, X, Y) is island number N at point X, Y.
island(1, 0, 0). island(2, 0, 1). island(3, 0, 2). 
island(4, 1, 0). island(5, 1, 1). island(6, 1, 2). 
island(7, 2, 0). island(8, 2, 1). island(9, 2, 2). 

% Let us additionally assume that bridges can only be connected between adjacent islands (non-diagonal).

% choose to add a bridge between islands to the left and right:
{bridge(N, M) : island(N, X1, Y1), island(M, X2, Y2), X1 = X2, Y1 = Y2 + 1}.

% choose to add a bridge between islands above and below:
{bridge(N, M) : island(N, X1, Y1), island(M, X2, Y2), Y1 = Y2, X1 = X2 + 1}.

% #show bridge/2.

% Let (0, 0) be the starting point and (2, 2) be the end point.

% An island X is reachable if there is a bridge between island X and a reachable island Y
reachable(X) :- bridge(X, Y), reachable(Y).
% the start is always reachable
reachable(1).

% The distance(N, D) = distance to island N is equal to D. 
% Let us set the distance from the first island to 0.
distance(1, 0).

% bridges will always be such that N > M.
distance(N, D+1) :- bridge(N, M), distance(M, D).

% #show distance/2.

% we must be able to reach the end
:-not reachable(9).

% we can additionally minimize the number of bridges:
% #minimize{1, (N, M) : bridge(M, N)}.

% Can use --opt-mode=OptN to show all minimal models
% #show reachable/1.
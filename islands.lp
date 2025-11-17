#const island_num = 2.

% Example 3x3 grid and island numbering:

% grid:
% [ 
%     (0, 0), (0, 1), (0, 2),
%     (1, 0), (1, 1), (1, 2),
%     (2, 0), (2, 1), (2, 2)
% ]

% island(1, 0, 0). island(2, 0, 1). island(3, 0, 2). 
% island(4, 1, 0). island(5, 1, 1). island(6, 1, 2). 
% island(7, 2, 0). island(8, 2, 1). island(9, 2, 2). 

% Set up points for the coordinate grid (0, 0) through (island_num, island_num).
point(0..island_num, 0..island_num).

% instantiate the first island.
island(1, 0, 0).

% Moving in X column increases the N by the length of the row
island(N + island_num + 1, X + 1, Y) :- island(N, X, Y), point(X + 1, Y).

% Moving in the Y row increases the N by 1
island(N + 1, X, Y + 1) :- island(N, X, Y), point(X, Y + 1).
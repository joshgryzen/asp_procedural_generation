#const number_of_doors = 2.

% Choose to spawn key X island N
{spawn_key(X, N) : island(N, _, _)} = 1 :- X = 1..number_of_doors.

% Choose to spawn door X on island N
{spawn_door(X, N) : island(N, _, _)} = 1 :- X = 1..number_of_doors.

% ensure the distance to the key is less than the distance to the door
% it cannot be that the distance to the key is greater than or equal to the distance to the door.
:- spawn_key(X, N1), spawn_door(X, N2), distance(N1, D1), distance(N2, D2), D1 >= D2.

% it is impossible for the key island to be unreachable.
:- spawn_key(_, N1), not reachable(N1).

% it is impossible for the door island to be unreachable.
:- spawn_door(_, N2), not reachable(N2).

% ensure only one key per island
:- spawn_key(X1, N), spawn_key(X2, N), X1 != X2.

% ensure only one door per island
:- spawn_door(X1, N), spawn_door(X2, N), X1 != X2.

% ensure that lower number doors appear fist
% for two doors, if the id of X1 is less than X2, it is impossible for X1 to appear after X2.
:- spawn_door(X1, N1), spawn_door(X2, N2), distance(N1, D1), distance(N2, D2), X1 < X2, D1 > D2.

#show spawn_key/2.
#show spawn_door/2.
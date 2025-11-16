% Choose to spawn a key on one island
{spawn_key(N) : island(N, _, _)} = 1.

% Choose to spawn a door on one island
{spawn_door(N) : island(N, _, _)} = 1.

% ensure the distance to the key is less than the distance to the door
% it cannot be that the distance to the key is greater than or equal to the distance to the door.
:- spawn_key(N1), spawn_door(N2), distance(N1, D1), distance(N2, D2), D1 >= D2.

% it is impossible for the key island to be unreachable.
:- spawn_key(N1), not reachable(N1).

% it is impossible for the door island to be unreachable.
:- spawn_door(N2), not reachable(N2).

#show spawn_key/1.
#show spawn_door/1.
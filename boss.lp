#const boss_distance = 2.

% choose 1 island (other than the starting island) to be the boss island.
{boss_island(N) : island(N, _, _), distance(N, D), D > boss_distance} = 1.
#show boss_island\1.
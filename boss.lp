% choose 1 island (other than the starting island) to be the boss island.
{boss_island(N) : island(N, _, _), distance(N, D), D > 0} = 1.
#show boss_island\1.
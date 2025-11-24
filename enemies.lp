% a goblin is 1 difficulty point, mummy is 2 difficulty points, skeleton is 1.5 difficulty
% clingo only works with integers so scaled up by 10

enemy(goblin, 10).
enemy(mummy, 20).
enemy(skeleton, 15).

% Spawn X points worth of enemy E on island N
% Consider the example, distance = 3.  We can have 1 mummy and 1 goblin, 3 goblins, 2 skeletons.
0 {spawn((S * F), E, N) : F = 1..D} 1 :- reachable(N), distance(N, D), enemy(E, S). 

% Ensure that the total score of enemies is equal to the distance
score(N, S) :- distance(N, D), S = #sum{X, E, N : spawn(X, E, N)}, S <= (D*10).
% :- reachable(N), score(N, S), distance(N, D), S != (D*10). % inspect this error: enemies.lp:14:53-54: info: number expected (got #sup)

#show spawn/3.
#show score/2.
% a goblin is 1 difficulty point, mummy is 2 difficulty points, skeleton is 1.5 difficulty
% clingo only works with integers so scaled up by 10

enemy(goblin, 10).
enemy(mummy, 20).
enemy(skeleton, 15).

% Spawn X points worth of enemy E on island N
% Consider the example, distance = 3.  We can have 1 mummy and 1 goblin, 3 goblins, 2 skeletons.
0 {spawn((S * F), E, N) : F = 1..D} 1 :- island(N, _, _), distance(N, D), enemy(E, S). 

% Ensure that the total score of enemies is equal to the distance
score(N, S) :- island(N, _, _), S = #sum{X, E, N : spawn(X, E, N)}.
:- island(N, _, _), score(N, S), distance(N, D), S != (D*10).

#show spawn/3.
% #show score/2.
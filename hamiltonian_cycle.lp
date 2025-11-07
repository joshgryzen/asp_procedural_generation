#const v0 = 1.
#const n = 6.

% #include "edges.lp".

node(1..6).

edge(1, 2). edge(1, 3). edge(1, 4).
edge(2, 4). edge(2, 5). edge(2, 6).
edge(3, 1). edge(3, 4). edge(3, 5).
edge(4, 1). edge(4, 2).
edge(5, 3). edge(5, 4). edge(5, 6).
edge(6, 2). edge(6, 3). edge(6, 5).

{ in(X, Y) : edge(X, Y) }.
% achieved: in/2 is a set consisting of edges of G.

:- vertex(X), in(X, Y), in(X, Y1), Y!=Y1. 
:- vertex(Y), in(X, Y), in(X1, Y), X!=X1. 

reachable(X) :- in(Y, X), reachable(Y).
reachable(v0) :- vertex(v0).
% achieved: reachable(X) iff there exists a path from v0 to X

:- vertex(X), not reachable(X).
% achieved: every vertex is reachable from any other vertex. 

arc(X, Y):- edge(X, Y).
arc(X, Y):- edge(Y, X).
vertex(X):- edge(X, _).
vertex(Y):- edge(Y, _).

#show in/2.
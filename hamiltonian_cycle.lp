#const v0 = 1.
#const n = 6.

#include "edges.lp".

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
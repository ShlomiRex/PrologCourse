parent(terach, bob).
parent(tom, bob).
parent(tom, liz).
parent(liz, roy).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

male(bob).
male(tom).
male(jim).

female(terach).
female(liz).
female(ann).
female(pat).

mother(X,Y):-
    female(X), parent(X,Y).

father(X,Y):-
	male(X), parent(X, Y).

grandfather(X,Y):-
	father(X, Z), parent(Z, Y).

grandmother(X,Y):-
	mother(X, Z), parent(Z, Y).

/* Comments! */

brother(X, Y):-
	male(X), parent(Z, X), parent(Z, Y), X\=Y.

sister(X, Y):-
	female(X), parent(Z, X), parent(Z, Y), X\=Y.

/* TODO: Is this correct? */
uncle(X, Y):-
	brother(X, Z), parent(Z, Y).


cousin(X, Y):-
	parent(P1, X), parent(P2, Y), (brother(P1, P1) ; sister(P1, P2)).

successor(X, Y):-
	parent(Y, X)
	;
	parent(Y, Z), successor(X, Z).


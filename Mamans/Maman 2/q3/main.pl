house(green_house).
house(red_house).
house(white_house).
house(yellow_house).
house(blue_house).

person(english).
person(spanish).
person(ukrain).
person(norwegian).
person(japan).

street(A, B, C, D, E):-
	next_to(A, B),
	next_to(B, C),
	next_to(C, D),
	next_to(D, E).



% 1
live_in_house(english, red_house).
live_in_house(X, green_house):-
	X \= english.

% 2
has_dog(spanish).

% 3
drinks_coffee(X):-
	live_in_house(X, green_house
).

% 4
drinks_tea(ukrain).

% 5
next_to(white_house, green_house).

% 6
smokes_marbalo(X):-
	has_cat(X).

% 7
smokes_time(X):-
	live_in_house(X, yellow_house).

% 8
drinks_milk(X):-
	street(A, B, C, D, E),
	live_in_house(X, C).

% 9
live_in_house(norwegian, HOUSE):-
	street(HOUSE, B, C, D, E).

next_to(X, Y):-
	has_fox(Z),
	live_in_house(Z, X),
	
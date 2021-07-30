% We have:

% A Street is 5 houses

% House is complex of:
% House color: Red, Green, White, Yellow, Blue
% Who lives there: Person
% House is next to another house

% A Person can have:
% Has pet: Dog, Cat, Fox, Horse
% Drinks: Coffee, Tea, Milk, Orange Juice
% Smokes: Marboro, Time, Montena, Lucky Strike, Parlament

% All types of persons (5 people):
% English, Spanish, Ukrain, Norwegian, Japanese

person(english).
person(spanish).
person(ukrain).
person(norwegian).
person(japanese).

pet(dog).
pet(cat).
pet(fox).
pet(horse).

drinkable(coffee).
drinkable(tea).
drinkable(milk).
drinkable(orange_juice).

smokeable(marboro).
smokeable(time).
smokeable(montena).
smokeable(lucky_strike).
smokeable(parlament).

house(red_house).
house(green_house).
house(white_house).
house(yellow_house).
house(blue_house).


street(H1, H2, H3, H4, H5):-
	house(H1), house(H2), house(H3), house(H4), house(H5),
	house_next_to(H1, H2),
	house_next_to(H2, H1),

	house_next_to(H2, H3),
	house_next_to(H3, H2),

	house_next_to(H3, H4),
	house_next_to(H4, H3),

	house_next_to(H4, H5),
	house_next_to(H5, H4).



lives_in(english, red_house).

has_pet(spanish, dog).
has_pet(_, _):-
	has_pet(A, dog),
	has_pet(B, cat),
	has_pet(C, fox),
	has_pet(D, horse),
	A \= B, A \= C, A \= D, B \= C, B \= D, C \= D.

drinks(X, coffee):-
	lives_in(X, green_house).
drinks(ukrain, tea).

house_next_to(white_house, green_house).
house_next_to(green_house, white_house).

smokes(has_pet(_, cat), marboro).
smokes(lives_in(_, yellow_house), time).

drinks(X, milk):-
	street(_, _, H3, _, _),
	lives_in(X, H3).

lives_in(norwegian, Y):-
	street(Y, _, _, _, _).

house_next_to(has_pet(_, fox), smokes(_, montena)).
house_next_to(smokes(_, montena), has_pet(_, fox)).

house_next_to(smokes(_, time), has_pet(_, horse)).
house_next_to(has_pet(_, horse), smokes(_, time)).

drinks(smokes(_, lucky_strike), orange_juice).


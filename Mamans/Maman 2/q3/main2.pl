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
pet(zebra).

drinkable(coffee).
drinkable(tea).
drinkable(milk).
drinkable(orange_juice).
drinkable(water).

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
	house_next_to(H2, H3),
	house_next_to(H3, H4),
	house_next_to(H4, H5).



lives_in(english, red_house).
lives_in(norwegian, Y):-
	street(Y, _, _, _, _).

has_pet(spanish, dog).


drinks(X, coffee):-
    lives_in(X, green_house).
drinks(ukrain, tea).
drinks(X, milk):-
	street(_, _, H3, _, _),
	lives_in(X, H3).
drinks(X, orange_juice):-
    smokes(X, lucky_strike).



smokes(X, marboro):-
    has_pet(X, cat).
smokes(X, time):-
    lives_in(X, yellow_house).
smokes(japanese, parlament).


house_next_to(white_house, green_house).
house_next_to(House, House2):-
    has_pet(X, fox),
    lives_in(X, House),
    smokes(Y, montena),
    lives_in(Y, House2),
    X \= Y.
house_next_to(House, House2):-
    smokes(X, time),
    lives_in(X, House),
    has_pet(Y, horse),
    lives_in(Y, House2),
    X \= Y.
house_mext_to(House, blue_house):-
    lives_in(norwegian, House).




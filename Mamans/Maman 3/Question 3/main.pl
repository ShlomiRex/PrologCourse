point(1,2).
point(1,10).
point(2,3).
point(5,2).
point(4,4). 

% Do not use findall, bagof and setof.

bestcompare(GT, X, Y):-
	Term =.. [GT, X, Y],
	write('Comparing: '), writeln(Term),
	Term.


findbest([X|Rest], GT, BestResult):-
	writeln('findbest called'),
	retract(bestval(Y)), % Get current best value
	assert(bestval(Y)),
	write('current best: '), writeln(Y),
	write('Head of the list is: '), writeln(X),
	bestcompare(GT, X, Y), % If True, then we have a new best. 
	!,
	retract(bestval(Y)),
	assert(bestval(X)),
	write('Setting BestResult to be '), writeln(X),
	findbest(Rest, GT, X).

findbest([X|Rest], GT, BestResult):-
	% X is better than BestResult, set BestResult as X
	write(X), write(' is not better than BestResult: '), writeln(BestResult),
	findbest(Rest, GT, BestResult).
findbest([], _, BestResult):-
	!,
	retract(bestval(X)),
	write('Finished finding best value: '), writeln(X),
	BestResult = X,
	writeln(BestResult).


bestof(Val, GT, Goal):-
	getAllValues(Val, Goal, [Head|Values]), % Collect all values
	write('asserting: '),
	writeln(Head),
	assert(bestval(Head)), % Set BestResult to Head (first element)
	findbest(Values, GT, BestVal), % Find best value
	write('Best value is: '), writeln(BestVal),
	Val is BestVal. % Return result




% Page 163 of the book
getAllValues(X, Goal, Xlist):-
	call(Goal),
	assertz(queue(X)),
	fail;
	assertz(queue(bottom)),
	collect(Xlist).
collect(L):-
	retract(queue(X)), !,
	( X == bottom, !, L = []
	;
	L = [X|Rest], collect(Rest)).

% bestof(Y,>,point(_,Y)). % Y = 10
% bestof(Y,<,point(_,Y)). % Y = 2
% bestof(X,>,point(X,_)). % X = 5
% bestof(X,<,point(X,_)). % X = 1

% findall(Y, point(_, Y), Res). % Res = [2, 10, 3, 2, 4].


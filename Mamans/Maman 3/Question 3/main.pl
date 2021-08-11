point(1,2).
point(1,10).
point(2,3).
point(5,2).
point(4,4). 

% Do not use findall, bagof and setof.


%%%%%%%%%%%%%%%%%%%% NOTE: I used write and writeln for debugging, and I comment them out for final grading %%%%%%%%%%%%%%%%%%%%

bestcompare(GT, X, Y):-
	Term =.. [GT, X, Y],
	%write('Comparing: '), writeln(Term),
	Term.


findbest([X|Rest], GT):-
	%writeln('findbest called'),
	retract(bestval(Y)), % Get current best value
	assert(bestval(Y)),
	%write('current best: '), writeln(Y),
	%write('Head of the list is: '), writeln(X),
	bestcompare(GT, X, Y), % If True, then we have a new best. 
	!, % Red cut - don't run the second 'findbest' because 100% that X is the new best.
	retract(bestval(Y)),
	assert(bestval(X)),
	%write('Setting BestResult to be '), writeln(X),
	findbest(Rest, GT).

findbest([_|Rest], GT):-
	% X is not better than best value so far.
	%write(X), writeln(' is not better than current best value'),
	findbest(Rest, GT).
findbest([], _).


bestof(Val, GT, Goal):-
	getAllValues(Val, Goal, [Head|Values]), % Collect all values
	%write('asserting: '), writeln(Head),
	assert(bestval(Head)), % Set BestResult to Head (first element)
	findbest(Values, GT), % Find best value
	retract(bestval(BestVal)),
	%write('Best value is: '), writeln(BestVal),
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

% Same as above but with one command (to clean memory):

% [main], retractall(bestval(_)), bestof(Y,>,point(_,Y)). % Y = 10.
% [main], retractall(bestval(_)), bestof(Y,<,point(_,Y)). % Y = 2.
% [main], retractall(bestval(_)), bestof(X,>,point(X,_)). % X = 5.
% [main], retractall(bestval(_)), bestof(X,<,point(X,_)). % X = 1





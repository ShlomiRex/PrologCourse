range(SAME, SAME, [SAME]).
range(START, END, [START|Tail]):-
	START =< END,
	NEWSTART is START + 1,
	range(NEWSTART, END, Tail).

% range( 2, 8, List). 
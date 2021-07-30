range(SAME, SAME, [SAME]).
range(START, END, [START|Tail]):-
	START =< END,
	NEWSTART is START + 1,
	range(NEWSTART, END, Tail).

% range( 2, 8, List). % List = [2, 3, 4, 5, 6, 7, 8] .

divide(L, A, B):-
    append(A, B, L),
    length(A, Len1),
    length(B, Len2),
	Len3 is Len1 - 1,
	( Len1 == Len2 ; Len3 == Len2 ).

% divide([1,2,3,4,5,6], List1, List2). % List1 = [1,2,3], List2 = [4,5,6] .
% divide([1, 2, 3], List1, List2). % List1 = [1, 2], List2 = [3] .
% range(1, 9, List), divide(List, A, B). % A = [1, 2, 3, 4, 5], B = [6, 7, 8, 9].

shuffle([X, Y], _, [Y, X]).
shuffle([], _, []).
shuffle(_, 0, _).
shuffle([X], _, [X]).

%mix([X|FirstHalfRest], [Y|SecondHalfRest], [X, Y|Result]):-


shuffle(List, Times, NewList):-
	writeln(Times),
	writeln(List),
	NewTimes is Times - 1,
	divide(List, FirstHalf, SecondHalf),
	shuffle(FirstHalf, NewTimes, NewFirstHalf),
	writeln("shuffling"),
	shuffle(SecondHalf, NewTimes, NewSecondHalf),
	writeln("new first half"),
	writeln(NewFirstHalf),
	writeln("new second half"),
	writeln(NewSecondHalf),
	append(NewFirstHalf, NewSecondHalf, NewList).

% shuffle( [1,2,3,4,5,6,7,8,9,10], 4, List). 
% range(1, 10, List), shuffle(List, 4, Result).
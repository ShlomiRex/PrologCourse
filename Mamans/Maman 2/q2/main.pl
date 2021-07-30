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

merge([], [], []).
merge([X|FirstHalfRest], [Y|SecondHalfRest], [X, Y|Result]):-
	merge(FirstHalfRest, SecondHalfRest, Result).
merge([X|FirstHalfRest], [], [X|Result]):-
	merge(FirstHalfRest, [], Result).

shuffle(X, 0, X).
shuffle(List, Times, NewList):-
	NewTimes is Times - 1,
	divide(List, FirstHalf, SecondHalf),
	merge(FirstHalf, SecondHalf, Result),
	shuffle(Result, NewTimes, NewList).


% shuffle([1,2,3,4,5,6,7,8,9,10], 4, Result). % Result = [1, 5, 9, 4, 8, 3, 7, 2, 6, 10].
% range(1, 10, List), shuffle(List, 4, Result). % Result = [1, 5, 9, 4, 8, 3, 7, 2, 6, 10].

% range(1, 27, List), shuffle(List, 4, Result). % Result = [1,23,18,13,8,3,25,20,15,10,5,27,22,17,12,7,2,24,19,14,9,4,26,21,16,11,6]

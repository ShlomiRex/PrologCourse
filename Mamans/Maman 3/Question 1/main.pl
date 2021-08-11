


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Section A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
merge2([X|Xs], [Y|Ys], [X|Res]):-
    X < Y, !, % Green Cut - Does not affect result because the second recursion function catches X >= Y
    merge2(Xs, [Y|Ys], Res).
merge2([X|Xs], [Y|Ys], [Y|Res]):-
    X >= Y, !, % Green cut - first recursion function catches the opposite of (X >= Y) .
    merge2([X|Xs], Ys, Res).
merge2([], SortedList2, SortedList2):-!. % Green cut - performance
merge2(SortedList1, [], SortedList1).
% merge2([1,2], [], Res). % Res = [1,2].
% merge2([], [1,2], Res). % Res = [1,2].
% merge2([1,5,7], [3,5], MergedList). % MergedList = [1, 3, 5, 5, 7].
% merge2([-2, 0, 2], [-3, -1, 1, 3], Res). % Res = [-3, -2, -1, 0, 1, 2, 3].



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Secion B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
merge3([X|Xs], [Y|Ys], [X|Res]):-
    X < Y, !, % Red cut - if first function wasn't called, then 100% that X >= Y.
    merge3(Xs, [Y|Ys], Res).
merge3([X|Xs], [Y|Ys], [Y|Res]):-
    merge3([X|Xs], Ys, Res), !. % Green cut - performance
merge3([], SortedList2, SortedList2):-!. % Green cut - performance
merge3(SortedList1, [], SortedList1).
% merge3([1,2], [], Res). % Res = [1,2].
% merge3([], [1,2], Res). % Res = [1,2].
% merge3([1,5,7], [3,5], MergedList). % MergedList = [1, 3, 5, 5, 7].
% merge3([-2, 0, 2], [-3, -1, 1, 3], Res). % Res = [-3, -2, -1, 0, 1, 2, 3].
















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Old version - Do not read - Not for grading %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
merge2([], SortedList2, SortedList2):-!.
merge2(SortedList1, [], SortedList1):-!.

merge2(SortedList1, SortedList2, MergedList):-
    merge2SortedLists(SortedList1, SortedList2, [], MergedList).

merge2SortedLists([], [], Res, Res):-!.


merge2SortedLists(SortedList1, [], Acc, Res):-
    append(Acc, SortedList1, Res), !.
merge2SortedLists([], SortedList2, Acc, Res):-
    append(Acc, SortedList2, Res), !.
    

merge2SortedLists([X|Xs], [Y|Ys], Acc, Res):-
    X < Y, !,
    append(Acc, X, Acc2),
    merge2SortedLists(Xs, [Y|Ys], Acc2, Res).
merge2SortedLists([X|Xs], [Y|Ys], Acc, Res):-
    X >= Y, !,
    append(Acc, Y, Acc2),
    merge2SortedLists([X|Xs], Ys, Acc2, Res).
*/



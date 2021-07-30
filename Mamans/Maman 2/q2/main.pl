range(SAME, SAME, [SAME]).
range(START, END, [START|Tail]):-
	START =< END,
	NEWSTART is START + 1,
	range(NEWSTART, END, Tail).

% range( 2, 8, List). % List = [2, 3, 4, 5, 6, 7, 8] .




% First argument is the list to divide.
% Second argument is the first divided list.
% Third argument is the second divided list.
%divide([], [], []). % Extreme case.
%divide([X], [X], []). % Extreme case.
%divide([X, Y], [X], [Y]). % Extreme case.

%%% Code 1 %%%
% divide(L, L1, L2):-
% 	div_head(L, L1, L2).

% div_head([], [], []).
% div_head([X], [X], []).
% div_head([X, Y], [X], [Y]).
% div_head([A|As], [A|L1], L2):-
% 	div_tail(As, L1, L2).

% div_tail([], [], []).
% div_tail([X], [], [X]).
% div_tail([X, Y], [X], [Y]).
% div_tail([Bs|B], L1, [L2|B]):-
% 	div_head(Bs, L1, L2).
%%% Code 1 %%%
%%% Code 2 %%%

% divide([], [], []). % Extreme case.
% divide([X], [X], []). % Extreme case.
% divide([X, Y], [X], [Y]). % Extreme case.
% divide(L, [X|Xs], [Ys|Y]):-
% 	append(Xs, Ys, L).

%%% Code 2 %%%

%divide_first([A|As], [A|Xs], Ys):-
%	divide_last(As, Xs, Ys).
%divide_last([As|A], Xs, [Ys|A]):-
%	divide_first(As, Xs, Ys).
%
%take_first_element([E|Es], List):-

% divide([1, 2, 3, 4], List1, List2). % List1 = [1, 2], List2 = [3, 4].
% divide([1, 2, 3, 4, 5, 6], List1, List2). % List1 = [1, 2, 3], List2 = [4, 5, 6].


%%% Code 3 %%%

% reverse([],Z,Z).

% reverse([H|T],Z,Acc):-
% 	reverse(T,Z,[H|Acc]).

% divide([], [], []).
% divide([X], [X], []).
% divide([X, Y|Rest], [X|List1], [Y|List2]):-
% 	reverse(Rest, ReversedRest, []),
% 	reverse(ReversedRest, Z, []),
% 	divide(Z, List1, List2).
%%% Code 3 %%%




div(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N).

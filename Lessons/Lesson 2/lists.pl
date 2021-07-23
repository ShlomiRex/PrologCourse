%member(X, [X|Tail]).
%member(X, [Head|Tail]):-
%	member(X, Tail).

% member(2, [1, 2, 3]). % true

% Same as above but without singleton.
% Check is X is in list.
member(X, [X|_]). % If X is in the head of the list, then X is in the list.
member(X, [_|Tail]):- % Else, check the rest of the list.
	member(X, Tail).









% Find all permutations of a list. (that contain a, b, c)
% L = [_, _, _], member(a, L), member(b, L), member(c, L).
	% L = [a, b, c] ;
	% L = [a, c, b] ;
	% L = [b, a, c] ;
	% L = [c, a, b] ;
	% L = [b, c, a] ;
	% L = [c, b, a] ;









% Concatinate two lists.

% The third argument save the result of the concatination.
% If first argument is empty, then the second argument and third argument must be the same.
conc([], L, L).
conc([X|Tail], L2, [X|L3]):-  % X must be the head of the first list AND as a result, the head of the third list.
	conc(Tail, L2, L3). % Remove head of the first list untill we left with nothing. Meanwhile, L3 is 'wrapped' with X.

% conc([1, 2], [3,4], Result). % Result = [1, 2, 3, 4].
% conc(["shlomi", "domnenko", "is", ["cool", "and", "handsome"]], ["second list"], Result). % Result = ["shlomi", "domnenko", "is", ["cool", "and", "handsome"], "second list"].
% conc(A, B, [a, b, c]).
	% A = [],
	% B = [a, b, c] ;
	% A = [a],
	% B = [b, c] ;
	% A = [a, b],
	% B = [c] ;
	% A = [a, b, c],
	% B = [] ;
	% false.









% Another way to declare membership:
member2(X, L):-
	conc(_, [X|_], L).











% Add element to the list.
addElement(X, L, [X|L]).
% addElement(1, [5], Result). % Result = [1, 5].









% Delete element from the list.
deleteElement(X, [X|Tail], Tail).
deleteElement(X, [Y|Tail], [Y|OtherTail]):-
	deleteElement(X, Tail, OtherTail).

% deleteElement(a, [a, b, c], Result). % Result = [b, c].
% deleteElement(a, [a, b, a, a], Result). 
	% Result = [b, a, a] ;
	% Result = [a, b, a] ;
	% Result = [a, b, a] ;
	% false.








% Insert element to the list.
% Basically we ask the question: From which list (BiggerList), that after deleting element X, will result the original list?
insertElement(X, List, BiggerList):-
	deleteElement(X, BiggerList, List).
% insertElement(a, [b, c], Result).
	% Result = [a, b, c] ;
	% Result = [b, a, c] ;
	% Result = [b, c, a] ;
	% false.









% Yet another way to declare membership:
member3(X, L):-
	deleteElement(X, L, _).
% member3(a, [b, c, a, c, b]). % true .
% member3(d, [b, c, a, c, b]). % false.











% Check sublist.
% Format: L1 | S | L3
% We want: L =  [L1 | S | L3]
% We also want: L2 = [S | L3]
sublist(S, L):-
	conc(_, L2, L),
	conc(S, _, L2).
% sublist([a, b, c], [a, b, c, d]). % true.
% sublist([a, b, c], [a, b, d]). % false.
% sublist(S, [a, b, c]).
	% S = [] ;
	% S = [a] ;
	% S = [a, b] ;
	% S = [a, b, c] ;
	% S = [] ;
	% S = [b] ;
	% S = [b, c] ;
	% S = [] ;
	% S = [c] ;
	% S = [] ;
	% false.











% Permuatations of a list.
% If list empty, then return empty list.
% Else, the list is not empty, so the list is in the format: [X|L].
% So, permutate L, save the result as L1, and insert X to L1.
permutation([], []).
permutation([X|L], Result):-
	permutation(L, L1),
	insertElement(X, L1, Result).
% permutation([a, b, c], Result).
	% Result = [a, b, c] ;
	% Result = [b, a, c] ;
	% Result = [b, c, a] ;
	% Result = [a, c, b] ;
	% Result = [c, a, b] ;
	% Result = [c, b, a] ;
	% false.
% permutation(L, [a, b, c]). % It finds all of the 6 solutions but then it loops.

% Another way to permutation:
% If RESULT list is empty, then the permutation is empty.
% Else, the result list is not empty, so it's in the format: [X|Result].
% So delete X from L, save result as L1, and permuate L1, AND the result should be 'Result' from [X|Result]. (i.e. the result list without head)
permutation2([], []).
permutation2(L, [X|Result]):-
	deleteElement(X, L, L1),
	permutation2(L1, Result).
% permutation2(L, [a, b, c]). % First result is [a, b, c] and then it loops.




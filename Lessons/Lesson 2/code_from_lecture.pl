count([],0).
count([_|Tail],C):-
	count(Tail,C1),
	C is C1 +1.
% count([a, b, c], Result). % Result = 3




sum([],0).
sum([X|Tail],S):-
	sum(Tail,S1),
	S is S1 +X.
% sum([1, 2, 3], Result). % Result = 6




countPositives([],0).
countPositives([X|Xs],C):-
	X>0,
	countPositives(Xs,C1),
	C is C1 +1.
countPositives([X|Xs],C):-
	X=<0,
	countPositives(Xs,C).

% countPositives([1, 2, 3, -4, -5, 6], Result). % Result = 4




conc([],L,L).
conc([X|Xs],L,[X|Res]):-
	conc(Xs,L,Res).
% conc([a, b], [c, d], Result). % Result = [a, b, c, d]




% Mine - not working - it doesn't concatinate
% Instead of concatinating [X] it concatinates X. So the result is like so: [[[[]|c]|b]|a]
% reverseList([], []).
% reverseList([X|Xs], [Rest|X]):-
% 	reverseList(Xs, Rest).

% Lecturer program - working
reverseList([], []).
reverseList([X|Xs],Zs):- 
	reverseList(Xs,Ys),
	conc(Ys,[X],Zs).

% reverseList([a, b, c], Result). % Result = [c, b, a]




isSortedList([]).
isSortedList([_]).
isSortedList([X,Y|Tail]):-
	X =< Y,
	isSortedList([Y|Tail]).
% isSortedList([1, 2, 3]). % Result = true
% isSortedList([1, 2, 0, 3]). % Result = false




% The lecturer saied that because we have intermidiate argument (S0) the recursion doesn't need to 'return' for each call,
% but instead it immidietly returns the sum. It acts like linear function. (but not really).
% He said it 'saves time by Big-O of O(n)' - because recursion = 2O(n) (1 call 1 exit per recursion).
sumOfList(List,Sum):-   
    sumOfList(List,0,Sum).

sumOfList([],Sum,Sum).

sumOfList([X|Xs],S0,Sum):-
	S1 is X + S0 ,
	sumOfList(Xs,S1,Sum).
% sumOfList([-5], Sum). % Result = -5
% sumOfList([1, 2, -2], Sum). % Result = 1




% So the lecturer also said that we can rewrite reverse function to have intermidiate argument (AccList).
reverseList2(List,Res):-
    reverseList2(List,[],Res).

reverseList2([],Res,Res).
reverseList2([X|Xs],AccList,Res):-
    reverseList2(Xs,[X|AccList],Res).
% reverseList2([1, 2, 3], Res). % Result = [3, 2, 1]




% Exam question worth 25 points:
% Given list L, and atom X, find the depth of X.
% If atom X appears more than once, then for each appearance, return result.
% Example: 
% deep_member(a, [a, [s, c, [d], [a, s], []]], N). 
	% Result: N = 3 
	% Result: N = 1 
deep_member(Element, L, Result):- % Generic function
	deep_member(Element, L, Result, 1). % Start recursion with accumulated depth 1.
deep_member(Element, [Element|_], AccDepth, AccDepth). % The recursion sets Result to AccDepth if the element is found.
deep_member(Element, [Y|_], Result, AccDepth):- % If the head is not the element, then perhaps its a list. Check inside there.
	is_list(Y), % If Y is a list,
	NewAccDepth is AccDepth + 1, % Then we want to add to accumulated depth,
	deep_member(Element, Y, Result, NewAccDepth). % And search inside the Y list.
deep_member(Element, [_|Ys], Result, AccDepth):- % Else, Y is not a list and not the elemennt, check Ys (rest of the list).
	deep_member(Element, Ys, Result, AccDepth).
is_list([]).
is_list([_|_]).
% deep_member(a,[a,[s,c,[d],[a,s],[]]],N). 
	% N = 1 ;
	% N = 3 ;
	% false.
% deep_member(qq,[a,[s,c,[d],[a,s],[]]],N). % false




% Exam question (professor said so)
% Find the middle element of a list.
% We do this linearly with 2 'lists'. One jumps once, the other jumps twice.
findMid(List, Mid):-
    findMid(List, List, Mid).


findMid([Mid|_], [], Mid). % If the second list (that jump twice) encounter empty list, then we at the end of the list, so the first list (that jumps once), is in the middle.

findMid([Mid|_], [_], Mid). % If the second list (that jump twice) encounters only one element, we can't jump twice on it, so we are at the end of the list. So the first list (that jumps once), is in the middle.

findMid([_|Tail1], [_,_|Tail2], Mid):- % Here, we jump once on the first list (first argument) and jump twice on the second list (second argument).
    findMid(Tail1, Tail2, Mid). % We continue recursion untill clousure (the 2 predicates above this one) is reached.

% findMid([a, b, c], Res). % Res = b
% findMid([a, b], Res). % Res = b
% findMid([a, b, c, d], Res). % Res = c
% findMid([a,b,c,s,d,r,1,44,1],Res). % Res = d ;




% Delete once element from list.
% First argument is what element to delete.
% Second argument is the list.
% Third argument is the list with the element deleted. (result)
del(X, [X|Xs], Xs).
del(X, [Y|Xs], [Y|Ys]):-
	del(X, Xs, Ys).
% del(2, [1, 2, 3], Res). % Res = [1, 3]
% del(2, [1, 2, 3, 2, 4], Res).
	% Res = [1, 3, 2, 4] ;
	% Res = [1, 2, 3, 4] ;
	% false.




% Find intersection of two lists.
% i.e. return list of elements that appear in both lists.
% First argument is the first list.
% Second argument is the second list.
% Third argument is the list with the intersection. (result)
conj([], _, []). % Extreme case
conj(_, [], []). % Extreme case
% First we need to check that head of list 1 is member of list 2.
% Then, the result should contain [X|ResultTail].
conj([X|Tail1], Ys, [X|ResultTail]):-
	member(X, Ys), % We can also write: del(X, Ys, Ys1). This removes X from Ys and the next recursion call has to pass n-1 elements. Which is a bit more efficient.
	conj(Tail1, Ys, ResultTail). % We can also write: conj(Tail1, Ys1, ResultTail).
conj([X|Xs], Ys, Zs):-
	nonmember(X, Ys), % In case X is not member of Ys, then the result shouldn't contain X.
	conj(Xs, Ys, Zs).
nonmember(X, [Y|Ys]):- % Non-member checks the oposite of member().
	X \= Y,
	nonmember(X, Ys).
nonmember(_, []).
% conj([a, b, c], [a, b, c, d], Res). % Res = [a, b, c]
% conj([a, b, c], [a, b, d], Res). % Res = [a, b] % Res = [a, b]
% conj([a, b, c], [b, a], Res). % Res = [a, b]



% Permutation of a list.
% First argument is the list.
% Second argument is the list with the permutation. (result)
% The idea is to delete Z from the list, so the result head is Z, and the rest (Zs) is the permutation from recursion.
permutation([], []). % Extreme case
permutation(Xs, [Z|Zs]):-
	del(Z, Xs, Ys),
	permutation(Ys, Zs).
% permutation([a, b, c], Res). 
	% Res = [a, b, c] ; % a in head, rest is permutation (b in the head, rest is permutation (c in head, rest is permutation(empty in head, stop)))).
	% Res = [a, c, b] ; % a in head, rest is permutation...
	% Res = [b, a, c] ; % b in head, rest is permutation...
	% Res = [b, c, a] ; % ...
	% Res = [c, a, b] ; % ...
	% Res = [c, b, a] ; % ...
	% false.




% Sort a list.
% First argument is the list.
% Second argument is the sorted list. (result)

% A dumb solution is: get permutation of the list, and check if the permutation is sorted.
% To get permutation: O(n!)
% To check sorted: O(n)

% Is a list ordered? (sorted from small to large)
ordered([]). % Extreme case, empty list.
ordered([_]). % Extreme case, single element list.
ordered([X, Y|Rest]):-
	X =< Y,
	ordered([Y|Rest]).

sortList(Xs, Ys):-
	permutation(Xs, Ys),
	ordered(Ys).
% sortList([2, 1, 3], Res). % Res = [1, 2, 3]
% sortList([2, 1, 3, 4], Res). % Res = [1, 2, 3, 4]
% sortList([-1, -2, -3], Res). % Res = [-3, -2, -1]




% Insertion sort.
% First argument is the list.
% Second argument is the sorted list. (result)
% First recursivly sort untill stop on empty list.
% Then, we insert the element in the sorted list, in the correct position.
sort2([], []).
sort2([X|Xs], Ys):-
	sort2(Xs, Zs),
	insert(X, Zs, Ys).

insert(X, [], [X]).
insert(X, [Y|Ys], [Y|Zs]):-
	X > Y,
	insert(X, Ys, Zs).
insert(X, [Y|Ys], [X, Y|Ys]):-
	X =< Y.
% sort2([3, 0, 1], Res). % Res = [0, 1, 3]
% sort2([-3, 3, -2, 2], Res). % Res = [-3, -2, -2, 2, 3]


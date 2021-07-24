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
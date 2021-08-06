between(X, _, X).
between(X, Y, Res):-
	X1 is X+1,
	X1 =< Y,
	between(X1,Y,Res).

% between(1, 5, Res). % 1 2 3 4 5






composite(X):-
	X1 is X//2,
	between(2, X1, Z),
	0 is X mod Z.

% composite(10). % true
% composite(11). % false
% composite(7). % false
% composite(6). % true








% Lowest common divisor
lcd(N, Res):-
	N1 is N//2,
	between(2, N1, Res),
	0 is N mod Res,
	!.

% lcd(100, Res). % 2
% lcd(7, Res). % false
% lcd(9, Res). % 3









% Old code:
% makeSet([], []).
% makeSet([X|Xs], Ys):-
% 	member(X, Xs),
% 	makeSet(Xs, Ys).

% makeSet([X|Xs], [X|Ys]):-
% 	nonmember(X, Xs),
% 	makeSet(Xs, Ys).

% New code with cuts:
% This makes a set which is list with unique elements.
makeSet([], []).
makeSet([X|Xs], Ys):-
	member(X, Xs),
	!,
	makeSet(Xs, Ys).

makeSet([X|Xs], [X|Ys]):-
	makeSet(Xs, Ys).

% makeSet([1,2,3, 2, 3, 2, 3, 1], Res). % [2, 3, 1]






conj([], _, []).
conj([X|Xs], L, [X|Res]):-
	member(X, L),
	conj(Xs, L, Res).
conj([X|Xs], L, Res):-
	not(member(X, L)),
	conj(Xs, L, Res).

% Intersection of two lists
conj2([], _, []).
conj2([X|Xs], Ys, [X|Res]):-
	member(X, Ys),
	!,
	conj2(Xs, Ys, Res).

% When I get to here, I know that [X|Xs] X is not member of Ys.
conj2([_|Xs], Ys, Res):-
	conj2(Xs, Ys, Res).

% conj([1,2,3], [5, 6, 1, 3], Res). % [1, 3]








% Concatenation of two lists
conc([], L, L).
conc([X|Xs], L, [X|Ys]):-
	conc(Xs, L, Ys).
% conc([11, 12, 13], [a, a, b, c], Res). % [11, 12, 13, a, a, b, c]
% Built in function: 
	% append([11, 12, 13], [a, a, b, c], Res). % [11, 12, 13, a, a, b, c]










% Sort list
% If already ordered, don't sort. The result is the input.
sortList(Xs, Xs):-
	ordered(Xs).

% Else, sort.
sortList(Xs, Ys):-
	conc(As, [X, Y|BS], Xs), X > Y,
	conc(As, [Y,X|BS], Xs1),
	sortList(Xs1, Ys).

ordered( []      ) .
ordered( [_]     ) .
ordered( [X,Y|Z] ) :- X =< Y , ordered( [Y|Z] ) .

% sortList([5, 7, 1, 8], Res). % [1, 5, 7, 8].


% The above code works, but it returns infinitly same solution:
	% sortList([22, 2, 3, -5], Res). % [-5, 2, 3, 22]
% To fix this, we add '!' (cut): sortList2









sortList2(Xs, Xs):-
	ordered(Xs), !.

% Else, sort.
sortList2(Xs, Ys):-
	conc(As, [X, Y|BS], Xs), X > Y, !,
	conc(As, [Y,X|BS], Xs1),
	sortList2(Xs1, Ys).
% This gives one solution:
% sortList2([22, 2, 3, -5], Res). % [-5, 2, 3, 22]






% Without cuts
max(A, B, A):-
	A >= B.
max(A, B, B):-
	B > A.

% With green cut
max2(A, B, A):-
	A >= B, !.
max2(A, B, B):-
	B > A.

% With red cut
max3(A, B , A):-
	A >= B, !.
max3(_, B, B).

% max(3, 1, Res). % Res = 3; false.
% max(1, 3, Res). % Res = 3.

% max2(3, 1, Res). % Res = 3.
% max2(1, 3, Res). % Res = 3.

% max3(3, 1, Res). % Res = 3.
% max3(1, 3, Res). % Res = 3.

% Red cut by professor:
% קאט אדום הוא כזה שאם אי-הימצאותו משנה את הערכים, את התוצאות מבחינה ערכית. כלומר הערכים של התוצאות השתנו (או כמותית, כמות התוצאות השתנה).

% Green cut by professor:
% קאט ירוק הוא כזה שאולי משפר ביצועים אולי משפר את הריצה אבל אם שחכתי אותו לא קורה שום דבר









% המשמעות של Cut

% P:- A, !, B.
% P:- C.
% P <=> (A AND B) OR (NOT A AND C)

% P:-A, B.
% P:-C.
% P <=> (A AND B) OR C

% P:-C.
% P:-A, !, B.
% P <=> C OR (A AND B)










if_then_else(P ,Q, _):-
	P, !, Q.

if_then_else(_, _, R):-
	R.








% Test question worth 25 points
% ?- summary([a, b, d, d, a, d], S).
% S = [2*a, 1*b, 3*d]

% The entry point
summary(L,S):-
    summary(L,[], S). % [] is the accumulator and S is the result

summary([],S,S). % If list empty, then the result is the accumulator
summary([N|L], S1, S3) :- % Else, the list contains a head.
	update(N, S1, S2),  
    summary(L, S2, S3). % Remove N from L and run the recursion on L, with the new accumulator S2.

update(N,[],[1*N]):-!. % If the accumulator is empty, then the result is just 1 times N.
update(N,[F*N|S],[F1*N|S]):- % Else, accumulator is not empty. It's in the form of [F*N|Tail] where N is currently the head of the list. So the result is new number: F1 times N.
	!, %RED CUT, don't continue to the third update function
    F1 is F + 1. % Increase the count of N.
update(N,[F*M|S],[F*M|S1]) :- %Third update function. N != M because of the red cut in the previous function.
	update(N, S, S1). % So if N != M, continue the recursion untill N = M. Then increase it's count.

% ?- summary([a, b, d, d, a, d], S).
% S = [2*a, 1*b, 3*d]


%summary([a,b,d,d,a,d],S).
%[a,b,d,d,a,d] ==> a, [] == >[1*a]
%[b,d,d,a,d] ==> b, [1*a] == >[1*a,1*b]
%[d,d,a,d] ==> d, [1*a,1*b] == >[1*a,1*b,1*d]
%[d,a,d] ==> d, [1*a,1*b,1*d] == >[1*a,1*b,2*d]
%[a,d] ==> a, [1*a,1*b,2*d] == >[2*a,1*b,2*d]
%[d] ==> d, [2*a,1*b,2*d] == >[2*a,1*b,3*d]
%[]  == >[2*a,1*b,3*d]











% Another implementation of summary:

% This time, we delete one by one ALL of the same elements from the list, and return the count of deleted elements.
% Then in recursion, do the same thing but with the new list (that doesn't contain the deleted element).

delAllAndCount(_,[],[],0):-!. % Cut
delAllAndCount(X,[X|Xs],ResList,ResCount):- % X is the element to delete. [X|Xs] is the current list to delete X from. ResCount is the count of deleted X elements.
	!, % Cut
    delAllAndCount(X,Xs,ResList,ResCount1), % Remove X from the head of the list. ResCount is increased by 1.
    ResCount is ResCount1+1.

delAllAndCount(X,[Y|Xs],[Y|ResList],ResCount):- % Else, X is not the head of the list. (X!=Y because of previous function cut)
    delAllAndCount(X,Xs,ResList,ResCount). % Then don't remove X from the list, remove Y from the list and continue the recursion.


summary2([X|Xs],[C1*X|Ys]):- % First argument is the list. Second argument is the result list.
    delAllAndCount(X,Xs,NewXs,C), % Delete X from the list, count is C. The list without X is NewXs.
	C1 is C +1, % Because the first argument contains X in the head, we first remove it, and then call delAllAndcount. So we also need to increase by 1 because delAllAndCount doesn't count the first X.
    summary2(NewXs,Ys). % Continue with new list, which doesn't contain X anymore.

summary2([],[]).

% delAllAndCount(3, [5, 3, 4, 3, 6, 3, 3], A, B). % A = [5, 4, 6] , B = 4.
% summary2([a, b, d, d, a, d], S). % S = [2*a, 1*b, 3*d].









% Fail and True

diffirent(X, Y):-
	X = Y, !, fail
	;
	true.

diffirent2(X, X):-
	!,
	fail.
diffirent2(_, _).
% diffirent2(1, 1). % false
% diffirent2(1, 2). % true





not2(X):-
	X, !, fail.
not2(_).
% not2(true). % false
% not2(fail). % true




diffirent3(X, Y):-
	not(X=Y).
% diffirent3(1, 1) % false
% diffirent3(1, 2) % true




isSet([]).
isSet([X|Xs]):-
	not(member(X, Xs)),
	isSet(Xs).
% isSet([1, 2, 3]). % true
% isSet([1, 2, 3, 1]). % false











% Test question worth 25 points
exam(logic).
exam(ethics).
exam(epistemology).

passed(sarah, logic).
passed(sarah, ethics).
passed(sarah, epistemology).
passed(yoni, logic).

easy_quality(X):-
	exam(Y),
	passed(X, Y).


% Now we want: qualify
qualify(X):-
	for_all(exam(Y), passed(X ,Y)).

% qualify(X) should return: X = sarah

% Your task is to write forall2 function: for_all(Goal, Condition)

for_all(Goal, Condition):-
	not(Goal, not(Condition)).






% Write infinitly many stars
% ?- repeat, write(*), fail.
% Because it fails it returns to repeat.




wait_r():-
	repeat,
	(read(CH), CH='r', ! ; fail).
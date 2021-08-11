% Check if list contains variable
noVarInList([X|Tail]):-
	nonvar(X), 
	noVarInList(Tail).
noVarInList([]).
% noVarInList([1, 2, 3]). % true
% noVarInList([1, X, 3]). % false



% Check atomic
% atomic(23). % true
% atomic(X). % false





% Check if number is prime
between(X,Y,X):-
	X=<Y.
between(X,Y,Res):-
	X1 is X + 1,
	X1 =< Y,
	between(X1, Y, Res).

prime(Num):-
	not(divisible(Num)).
divisible(Num):-
	NumSqrt is sqrt(Num),
	between(2, NumSqrt, X),
	Y is Num / X,
	integer(Y).
% prime(4). % false
% primte(7). % true




% Count number of occurences of a element
count1(_,[],0). 

count1(A,[B|L],N):-
    atomic(B),A=B,!,      % B is atom A?  % NOTE: If you change this to 'atom' then it will only work for 'a', 'b', etc. But 'atomic' works for 'a', 'b' and numbers: '1', '2', etc.
	count1(A,L,N1),        % count in tail 
	N is N1 + 1.
count1(A,[_|L],N):- 
	count1(A, L, N). % else count tail
% count1(2, [1, 2, 3, 2, 4], Res). % Res = 3.
% count1(2, [1, 2, 3], Res). % Res = 1.
% count1(2, [1, 3], Res). % Res = 0.




% Check if compound (checks if it is יחס)
% כלומר יחס
% compound(a). % false
% compound(23). % false
% compound([23]). % true
% compound(f(a,b)). % true




% Get the argument in index N
% arg(1, f(a,b,c,d,e,ggg,as,34), A). % A = a
% arg(2, f(a,b,c,d,e,ggg,as,34), A). % A = b
% arg(6, f(a,b,c,d,e,ggg,as,34), A). % A = ggg
% arg(8, f(a,b,c,d,e,ggg,as,34), A). % A = 34





% Get the function name (compound name) and number of arguments
% functor(f(a,b,c,d), F, N). % F = f, N = 4.







% Next compound: '=..'
% f(a,b,c) =.. L. % L = [f, a, b, c].
% D =.. [f, a, b, c]. % D = f(a,b,c).







% Flatten term
flat(Term, Result):-
	atomic(Term), !, Result = [Term]
	;
	Term =.. [Head|Tail],
	flat(Head, R1), flat_list(Tail, R2),
	conc(R1, R2, Result), !.
flat_list([], []).
flat_list([H1|T1], [H1|T2]):-
	atomic(H1), !, flat_list(T1, T2).
flat_list([H1|T1], L):-
	flat(H1, H2), !, flat_list(T1, T2), conc(H2, T2, L).

conc([], L, L).
conc([X|Xs], L, [X|Ys]):-
	conc(Xs, L, Ys).

% flat(f(g(j,c),l), Result). % Result = [f, g, j, c, l].
% flat(f(g(j,c),l, k(a)), Result). % Result = [f, g, j, c, l, k, a].







% Subterm
subterm(Term, Term).
subterm(Sub, Term):-
	compound(Term),
	Term =.. [_|Args],
	subterm_list(Sub, Args).
subterm_list(Sub, [Arg|_]):-
	subterm(Sub, Arg).
subterm_list(Sub, [_|Args]):-
	subterm_list(Sub, Args).
% subterm(f(a,s), s(f(a, s), a, d ,f)). % true: f(a,s) is subterm of s(f(a, s)).
% subterm(X, s(f(a, s), a, d ,f)). 
	% X = s(f(a, s), a, d ,f)
	% X = f(a,s)
	% X = a
	% X = s
	% X = a
	% X = d
	% X = f







% Enlarge - multiply a term by a number
enlarge(Fig, F, NewFig):-
	Fig =.. [Type|Params],
	multiplylist(Params, F, NewParams),
	NewFig =.. [Type|NewParams].
multiplylist([], _, []).
multiplylist([H1|T1], F, [H2|T2]):-
	H2 is H1 * F,
	multiplylist(T1, F, T2).
% enlarge(s(2,3,4,1), 3, NewFig). % NewFig = s(6,9,12,3).


% What is we want:
% enlarge(s(2,f(3,4),1),3,NewFig). % NewFig = s(6, f(9, 12), 3)
% i.e. we want also atomic/integer AND compound to be enlarged.
% We need to check if integer. If so just multiply. If not, compound, call multiplylist.
% THIS IS EXAM QUESTION WORTH 25 POINTS. The professor said 


enlarge2(Fig,F,Res):-
    integer(Fig),!,Res is Fig*F.


enlarge2(Fig,F,NewFig) :-
    Fig =.. [Type | Params], 
    multiplylist2(Params, F, NewParams), 
    NewFig =.. [Type|NewParams].

multiplylist2([], _, []). 

multiplylist2([H1 | T1], F, [H2|T2]) :- 
    enlarge2(H1,F,H2),
    multiplylist2(T1, F, T2).
% enlarge(s(2,f(3,4),1),3,NewFig). % NewFig = s(6, f(9, 12), 3).









f(a,1).
f(b,1).
f(c,1).
f(d,1).

f(b,2).
f(a,2).
f(c,2).
f(d,2).

f(a,3).
f(b,3).
f(c,3).
f(d,3).

f(d,3).
f(d,4).
/*
findall(X,f(X,1),ResList). % ResList = [a,b,c,d].
findall(X,f(X,_),ResList). % ResList = [a, b, c, d, b, a, c, d, a, b, c, d, d, d]
bagof(X,f(X,1),ResList). % ResList = [a, b, c, d].
bagof(X,f(X,Y),ResList). 
	% Y=1, ResList=[a,b,c,d]. 
	% Y=2, ResList=[b,a,c,d]. 
	% Y=3, ResList=[a,b,c,d,d]. 
	% Y=4, ResList=[d].
setof(X, f(X,Y), ResList).
	% Y=1, ResList=[a,b,c,d]. 
	% Y=2, ResList=[a,b,c,d]. 
	% Y=3, ResList=[a,b,c,d]. 
	% Y=4, ResList=[d].
*/






makeSet(List, Set):-
	setof(X, member(X, List), Set).
% makeSet([4,1,1,2,2,3,3], Res). % Res = [1,2,3,4].






conj(L1, L2, Res):-
	findall(X, (member(X, L1), member(X, L2)), Res).
% conj([1,2,3,1], [1,3,67], Res). % Res = [1, 3, 1].

conj2(L1, L2, Res):-
	setof(X, (member(X, L1), member(X, L2)), Res).
% conj([1,2,3,1], [1,3,67], Res). % Res = [1, 3].







grade(a, 65).
grade(b, 78).
grade(guy, 80).
grade(guy2, 81).
grade(eli, 95).
grade(roy, 40).
grade(kobi, 71).

findGreater(N, List):-
	findall(X, (grade(X, S), S > N), List).
% findGreater(80, Res). % Res = [guy2, eli].










/*
%?-summary([a,b,d,d,a,d],S).
%S=[2*a,1*b,3*d]
%%%% FIRST TRY
summary(List,Res):-
    findall(C*X,(member(X,List),count(X,List,C)),Res).

%%%%%%%%%%%%

summary(List,Res):-
    setof(C*X,(member(X,List),count(X,List,C)),Res).

%%%%%%%%%%%%%%%%%%%%%%

*/
count(_,[],0).
count(X, [X|List], C):-
	!,
	count(X, List, C2),
	C is C2+1.
count(X, [_|List], C):-
	count(X, List, C).

summary(List,Res):-
    makeSet(List,Set),
    findall(C*X,(member(X,Set),count(X,List,C)),Res).
% summary([a,b,d,d,a,d], Res). % Res = [2*a,1*b,3*d].










%%%%%%%%%%%%%%%%%%%%%% תת המקטע הכי גדול 
sum([],0).
sum([X|Xs],C):-
    sum(Xs,C1),
    C is C1 + X .
 
subSeg(List,Sub):-
    append(_,Temp,List),
    append(Sub,_,Temp).


maxSubSeg(List,Res):-
    findall(X,subSeg(List,X),TempRes),
    findMax(TempRes,Res).

findMax([X],X):-!.
 
findMax([X|Xs],MaxSub):-
    findMax(Xs,Temp),
    sum(X,SX),
    sum(Temp,ST),
    (SX>ST,!,MaxSub = X
    ;   
    MaxSub = Temp).
% maxSubSeg([12, -12, 222, 11, -5, -45, 15], MaxSub). % MaxSub = [222, 11].




%%%%%%%% More efficient
/*
maxSubSeg(List,Res):-
    setof(S-X,(subSeg(List,X),sum(X,S)),TempRes),
    findMax(TempRes,_-Res).

findMax([S-X],S-X):-!.
 
findMax([_|Xs],Sum-MaxSub):-
    findMax(Xs,Sum-MaxSub).
*/


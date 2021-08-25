t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))).

% member check
in(X, t(_,X,_)):-!.
in(X, t(L, _, R)):- in(X, L), !; in(X, R).

% ?- in(8, t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil)))). % true
% ?- in(11, t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil)))). % false



% Count anssestors
% Professor's Answer:
countNodes(t(L,_,R),Count):-
  countNodes(L,Count1), 
  countNodes(R,Count2),
  Count is 1+Count1+Count2.
countNodes(nil,0).


% ?- countNodes(t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), Res). % Res = 5.






% Sum all the nodes of the tree.
sumTree(t(L,X,R),Sum):-
  sumTree(L,Sum1), sumTree(R,Sum2),
  Sum is X+Sum1+Sum2.
sumTree(nil,0).
% ?- sumTree(t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), Res). % Res = 25.



% My answer:
maxHeight(nil, 0).
maxHeight(t(L, _, R), H):-
	maxHeight(L, H1),
	maxHeight(R, H2),
	(H1 > H2 -> H is H1+1 ; H is H2+1).

% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), maxHeight(T, Res). % Res = 3.
% ?- T=t(t(nil,2,nil),4,t(t(t(nil, 1, nil),5,nil),6,t(nil,8,nil))), maxHeight(T, Res). % Res = 4.
% ?- T=t(t(nil,2,t(nil, 2, nil)),4,t(t(t(t(nil, 1, nil), 1, nil),5,nil),6,t(nil,8,nil))), maxHeight(T, Res). % Res = 5.
% ?- T=t(nil, 1, nil), maxHeight(T, Res). % Res = 1.
% ?- T=nil, maxHeight(T, Res). % Res = 0.



% Number of leafs
% My answer:
numOfLeafs(nil, 0).
numOfLeafs(t(nil, _, nil), 1):-!.
numOfLeafs(t(L, _, R), N):-
	numOfLeafs(L, N1),
	numOfLeafs(R, N2),
	N is N1+N2.
% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), numOfLeafs(T, Res). % Res = 3.
% ?- T=t(nil, 1, nil), numOfLeafs(T, Res). % Res = 1.
% ?- T=t(t(nil, 2, nil), 1, t(nil, 2, nil)), numOfLeafs(T, Res). % Res = 2.
% ?- T=t(t(nil, 2, nil), 1, nil), numOfLeafs(T, Res). % Res = 1.




% Get all leafs as a list
% My answer:
getAllLeafs(nil, []).
getAllLeafs(t(nil, X, nil), [X]):-!.
getAllLeafs(t(L, _, R), Leafs):-
	getAllLeafs(L, LeftLeafs),
	getAllLeafs(R, RightLeafs),
	append(LeftLeafs, RightLeafs, Leafs).
% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), getAllLeafs(T, Res). % Res = [2, 5, 8].
% ?- T=t(nil, 1, nil), getAllLeafs(T, Res). % Res = [1].
% ?- T=t(t(nil, 2, nil), 1, t(nil, 2, nil)), getAllLeafs(T, Res). % Res = [2, 2].
% ?- T=t(t(nil, 2, nil), 1, nil), getAllLeafs(T, Res). % Res = [2].





% My answer:
getAllNodesAbove5(nil, []).
getAllNodesAbove5(t(L, X, R), [X|Nodes]):-
	X > 5,
	getAllNodesAbove5(L, Nodes1),
	getAllNodesAbove5(R, Nodes2),
	append(Nodes1, Nodes2, Nodes), !.
getAllNodesAbove5(t(L, _, R), Nodes):-
	getAllNodesAbove5(L, Nodes1),
	getAllNodesAbove5(R, Nodes2),
	append(Nodes1, Nodes2, Nodes).
% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), getAllNodesAbove5(T, Res). % Res = [6, 8].
% ?- T=t(nil, 1, nil), getAllNodesAbove5(T, Res). % Res = [].
% ?- T=t(t(nil, 6, nil), 8, t(nil, 7, nil)), getAllNodesAbove5(T, Res). % Res = [8, 6, 7].
% ?- T=t(t(nil, 2, nil), 1, t(nil, 7, nil)), getAllNodesAbove5(T, Res). % Res = [7].






% Professor's answer:
% NOT WORKING
bl5(nil,0).
bl5(t(L,X,R),Res):-
    bl5(L,ResL),
    bl5(R,ResR),
    append(ResL,ResR,TempList),
    (X>5,!,Res = [X|TempList]
    ;   
    Res = TempList).
% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), bl5(T, Res).
% ?- T=t(nil, 1, nil), bl5(T, Res).
% ?- T=t(t(nil, 6, nil), 8, t(nil, 7, nil)), bl5(T, Res).
% ?- T=t(t(nil, 2, nil), 1, t(nil, 7, nil)), bl5(T, Res).









% Get path (as a list) to a node with value X
path_to_item(X,t(_,X,_),[X]).
path_to_item(X,t(L,Y,R),[Y|Path]):-
	path_to_item(X,L,Path) 
	;
	path_to_item(X,R,Path).
% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), path_to_item(5, T, Res). % Res = [4, 6, 5].






% Exam question worth 25 points
% Find number of nodes, that the value of the node, is equal to number of nodes in the sub-tree.
% But also, the number of access to a node is limited (O(1)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the original code of the question
% Because of countNodes, the leaf will be accessed this many times: height of the leaf.
eq(nil,0).
eq(t(L,X,R),N):-
	eq(L,N1) , eq(R,N2), 
	(countNodes(t(L,X,R),X) , ! ,  N is N1 + N2 + 1 
	;
	 N is N1 + N2 
	).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% So professor proposed O(1) accesses per node like this:
% i.e. save intermediate Size which is the number of nodes in the sub-tree.
% Num is the number of nodes of the subtree which has Num nodes.
 eq(Tree,Res):-
    eq(Tree,_,Res).

eq(nil,0,0).
	 
eq(t(L,X,R),Size,Num):-
      eq(L,Size1,Num1),
	  eq(R,Size2,Num2),
	  Size is Size1+Size2+1,  
	  (X=Size,!,Num is Num1+Num2+1
	   ;
	   Num is Num1+Num2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









% Write a predict that returns the list of nodes, of the height X of the tree.
% For example if X = 2 then return the list of nodes of height 2.

% MY CODE - NOT WORKING
/*
listOfNodesOfHeight(nil,_,[]).
listOfNodesOfHeight(T,H,Nodes):-
	listOfNodesOfHeightHelper(T,0,H,Nodes).
listOfNodesOfHeightHelper(nil,_,_,[]):-!.
listOfNodesOfHeightHelper(t(L,X,R), CurrH, H, Nodes):-
	CurrH \= H,
	!,
	NewCurrH is CurrH + 1,
	listOfNodesOfHeightHelper(L, NewCurrH, H, Nodes1),
	listOfNodesOfHeightHelper(R, NewCurrH, H, Nodes2),
	append(Nodes1, Nodes2, Nodes), !.
listOfNodesOfHeightHelper(t(_,X,_), CurrH, H, [X|_]):-
	CurrH = H,
	writeln(X),
	!.
*/

% MY WORKING CODE
listOfNodesOfHeight(t(L,_,R),H,Nodes):-
	H > 0, 
	!,
	NewHeight is H - 1,
	listOfNodesOfHeight(L,NewHeight,Nodes1),
	listOfNodesOfHeight(R,NewHeight,Nodes2),
	append(Nodes1,Nodes2,Nodes).
listOfNodesOfHeight(t(_,X,_),0,[X]).
listOfNodesOfHeight(nil,_,[]).

% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), listOfNodesOfHeight(T, 0, Res). % Res = [4].
% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), listOfNodesOfHeight(T, 1, Res). % Res = [2, 6].
% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), listOfNodesOfHeight(T, 2, Res). % Res = [5, 8].












% כתוב פרדיקט המקבל עץ ומחזיר את סכום הגבהים של צמתיו כולל של השורש
% גובה של עץ מוגדר להיות כאורך המסלול המקסימלי מאותה צומת לעלה שמתחתיו
sumHeight(t(L,_,R),Sum):-
	maxHeight(t(L,_,R), H),
	sumHeight(L,SumL),
	sumHeight(R,SumR),
	Sum is H + SumL + SumR.
sumHeight(nil,0).
% ?- T=t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil))), sumHeight(T, Res). % Res = 8.

% Professor's Answer (more efficient):
% sumHeight2(t(L,_,R),Sum,H):-
% 	sumHeight2(L,SumL,H1),
% 	sumHeight2(R,SumR,H2),
% 	max(H1,H2,H3),
% 	H is H3 + 1,
% 	Sum is SumL + SumR + H.
% sumHeight2(nil,0,-1).











% Determin if the tree is binary search tree.
ordered_tree(nil).
ordered_tree(t(L,X,R)):-
	bigger_than(X,L),
	smaller_than(X,R),
	ordered_tree(L),
	ordered_tree(R).

bigger_than(_,nil):-!.
bigger_than(X,t(L,Y,R)):-
	X > Y,
	bigger_than(X,L),
	bigger_than(X,R).

smaller_than(_,nil):-!.
smaller_than(X,t(L,Y,R)):-
	X < Y,
	smaller_than(X,L),
	smaller_than(X,R).

% ?- ordered_tree(t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil)))). % true.
% ?- ordered_tree(t(t(nil,2,nil),4,t(t(nil,8,nil),6,t(nil,5,nil)))). % false.
% ?- ordered_tree(t(nil, 5, nil)). % true.
% ?- ordered_tree(t(t(nil, 6, nil), 5, nil)). % false.


% More efficient solution

ordered(Tree):-
	ordered(Tree,-10000, 10000).
% if needed the values of Min and Max can be determined by a pre-scan of the tree
ordered(t(L,X,R), Min, Max):-
	X>Min,
	X<Max,
	ordered(L,Min,X),
	ordered(R,X,Max).
ordered(nil,_,_).
% ?- ordered(t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil)))). % true.
% ?- ordered(t(t(nil,2,nil),4,t(t(nil,8,nil),6,t(nil,5,nil)))). % false.
% ?- ordered(t(nil, 5, nil)). % true.
% ?- ordered(t(t(nil, 6, nil), 5, nil)). % false.







% More efficient answer (Notice we don't provide +10000 and -10000 as Min and Max - Prolog chooses for us)
ordered2(Tree):-
	ordered2(Tree, _, _).
ordered2(t(L,X,R), Min, Max):-
	(var(Min), ! ; X >= Min),
	(var(Max), ! ; X < Max),
	ordered2(L, Min, X),
	ordered2(R, X, Max).
ordered2(nil,_,_).
% What is hapenning here?
% At first, Min is variable. So prolog exits.
% Bug prolog doesn't like when things return False. So it tries again. It SETS MIN AS A NUMBER IT CHOOSES.
% So now Min is not Var. Then it checks if X >= Min. If not, then prolog exits and starts again, setting MIN to be DIFFIRENT number, untill it succeeds.
% And so on, including Max.


% ?- ordered2(t(t(nil,2,nil),4,t(t(nil,5,nil),6,t(nil,8,nil)))). % true.
% ?- ordered2(t(t(nil,2,nil),4,t(t(nil,8,nil),6,t(nil,5,nil)))). % false.
% ?- ordered2(t(nil, 5, nil)). % true.
% ?- ordered2(t(t(nil, 6, nil), 5, nil)). % false.









% Linked list with Tail so we can concatinate lists with O(1).
% L=[1, 2, 3, 4, bob|Tail], Tail= [a,aaa,a,aa]

% Concatinate two lists.
% רשימות הפרש
% Big O (1) - no recursion
conc(L1-T1,L2-T2,Res - Tail):-
    T1 = L2,
    Res = L1,
    Tail = T2.
% ?- conc([1,2,343,bob|T1] - T1 , [a,b,c|T2]-T2 , Res - Tail).
/* 
T1 = [a, b, c|Tail],
T2 = Tail,
Res = [1, 2, 343, bob, a, b, c|Tail].
*/











% פרדיקט המקבל רשימה וממין אותה משתנים לתחילתה ואטומים או מספרים לסוף הרשימה

var_atomic(L,Res):-
		var_atomic(L,L1,L2),
		conc(L1,L2,Res).

var_atomic([],[],[]).

var_atomic([X|Xs],[X|Rest1],L2):-
	var(X),!,var_atomic(Xs,Rest1,L2).

var_atomic([X|Xs],L1,[X|Rest2]):-
	atomic(X),var_atomic(Xs,L1,Rest2).
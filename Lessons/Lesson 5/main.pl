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




/*
Tree in the question:

T = t(t(t(nil, d, t(nil, g, nil)), b, t(nil, e, nil)), a, t(t(nil, f, t(nil, h, nil)), c, nil))

*/






my_inorder(Tree, Res):-
	my_inorder_helper(Tree, Res-[]).

my_inorder_helper(t(L,X,R), List-Tail):-
	my_inorder_helper(L, List-[X|T]), 
	my_inorder_helper(R, T-Tail).

my_inorder_helper(nil, T-T).

%%%%%%% Testing %%%%%%%
% ?- T = t(t(t(nil, d, t(nil, g, nil)), b, t(nil, e, nil)), a, t(t(nil, f, t(nil, h, nil)), c, nil)), my_inorder(T, Res).



inorder_place(Tree, X, Place):-
	my_inorder(Tree, InorderList),
	(
		member(X, InorderList) -> 
			(
				indexOf(InorderList, X, Index),
				Place is Index + 1
			)
			; 
			(Place = -1)
	).
% ?- T = t(t(t(nil, d, t(nil, g, nil)), b, t(nil, e, nil)), a, t(t(nil, f, t(nil, h, nil)), c, nil)), inorder_place(T, c, Place). % Place = 8
% ?- T = t(t(t(nil, d, t(nil, g, nil)), b, t(nil, e, nil)), a, t(t(nil, f, t(nil, h, nil)), c, nil)), inorder_place(T, d, Place). % Place = 1
% ?- T = t(t(t(nil, d, t(nil, g, nil)), b, t(nil, e, nil)), a, t(t(nil, f, t(nil, h, nil)), c, nil)), inorder_place(T, r, Place). % Place = -1


indexOf([Element|_], Element, 0):- !.
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1),
  !,
  Index is Index1+1.
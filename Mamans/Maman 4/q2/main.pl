% Question 2 - Instructions
% MUST BE EFFICIENT
% MUST USE רשימות הפרש


/*
T1 = t(t(nil, 9, nil), 5, t(nil, 10, nil)).

Question tree:
T = 
t(
	t(
		t(
			t(nil, 8, nil),
			4,
			nil
		),
		2,
		t(
			t(nil, 9, nil),
			5,
			t(nil, 10, nil)
		)
	),
	1,
	t(
		t(nil, 6, nil),
		3,
		t(nil, 7, nil)
	)
)


OR:
T = t(t(t(t(nil, 8, nil),4,nil),2,t(t(nil, 9, nil),5,t(nil, 10, nil))),1,t(t(nil, 6, nil),3,t(nil, 7, nil)))
*/


% At first, Tail = []
% Then the new tail becomes T, and we add X to the list.
my_preorder(Tree, Res):-
	my_preorder_helper(Tree, Res-[]).

% We start with X in the list, and then we don't use it, so basically we append X to the list, first thing first.
my_preorder_helper(t(L,X,R),[X|List]-Tail):-
	writeln(X),
	% List now contains X as first element.
	% We then scan left subtree and append T.
	% The new list: 
	% [X, left, T]
	my_preorder_helper(L,List-T), 
	% We now want to change T to be the scan of the right subtree.
	% So we get: 
	% [X, left, right, Tail]
	% Which is preorder.
	my_preorder_helper(R,T-Tail). % The new tail is T. Now, convert it to be the list and add new tail.
my_preorder_helper(nil,T-T). % When we reached the end, the list and the tail are the same.

%%%%%%% Testing %%%%%%%
% ?- T1 = t(t(nil, 9, nil), 5, t(nil, 10, nil)), my_preorder(T1, Res). 
	% Res = [5, 9, 10].
% ?- T = t(t(t(t(nil, 8, nil),4,nil),2,t(t(nil, 9, nil),5,t(nil, 10, nil))),1,t(t(nil, 6, nil),3,t(nil, 7, nil))), my_preorder(T, Res). 
	% Res = [1, 2, 4, 8, 5, 9, 10, 3, 6, 7].








my_inorder(Tree, Res):-
	my_inorder_helper(Tree, Res-[]). % Tail empty.

% We don't add X to the list (yet).
my_inorder_helper(t(L,X,R), List-Tail):-
	% After working on left subtree, we append X, then we append T. T will become the right subtree, which makes for inorder logic.
	% [left, X, right, T]
	my_inorder_helper(L, List-[X|T]), 
	writeln(X),
	% Now we add X to the list. And then search on right subtree.
	% We also want to add the result of the left subtree with the right subtree.
	% So here we use the 'T'.
	% Now we have:
	% [left, X, right, Tail]
	% Which is inorder.
	my_inorder_helper(R, T-Tail).

my_inorder_helper(nil, T-T).

%%%%%%% Testing %%%%%%%
% ?- T1 = t(t(nil, 9, nil), 5, t(nil, 10, nil)), my_inorder(T1, Res). 
	% Res = [9, 5, 10].
% ?- T = t(t(t(t(nil, 8, nil),4,nil),2,t(t(nil, 9, nil),5,t(nil, 10, nil))),1,t(t(nil, 6, nil),3,t(nil, 7, nil))), my_inorder(T, Res). 
	% Res = [8, 4, 2, 9, 5, 10, 1, 6, 3, 7].



my_postorder(Tree, Res):-
	my_postorder_helper(Tree, Res-[]).

% Same as before, we don't add X as first element.
my_postorder_helper(t(L,X,R), List-Tail):-
	% We scan left subtree, then append T.
	% So we get:
	% [left, T]
	my_postorder_helper(L, List-T),
	% Then, scan right subtree, and append (change T) a list: [X|Tail]
	% So we get:
	% [left, right, X, Tail]
	% Which is postorder.
	my_postorder_helper(R, T-[X|Tail]), 
	writeln(X).
my_postorder_helper(nil, T-T).

%%%%%%% Testing %%%%%%%
% ?- T1 = t(t(nil, 9, nil), 5, t(nil, 10, nil)), my_postorder(T1, Res). 
	% Res = [9, 10, 5].
% ?- T = t(t(t(t(nil, 8, nil),4,nil),2,t(t(nil, 9, nil),5,t(nil, 10, nil))),1,t(t(nil, 6, nil),3,t(nil, 7, nil))), my_postorder_helper(T, Res). 
	% Res = [8, 4, 9, 10, 5, 2, 6, 7, 3, 1].










%%%%%%% Not used %%%%%%%
/*
conc(L1-T1,L2-T2,Res - Tail):-
    T1 = L2,
    Res = L1,
    Tail = T2.
% ?- L1=[1,2,3|Tail1]-Tail1, L2=[4,5,6|Tail2]-Tail2, conc(L1, L2, Res). % Res = [1, 2, 3, 4, 5, 6|Tail2]-Tail2.

add2end(Item, InputList-Tail, OutputList-NewTail):-
	Tail = [Item|NewTail],
	OutputList = InputList.
% ?- add2end(4, [1,2,3|Tail]-Tail, List-NewTail). % List = [1, 2, 3, 4|NewTail].
*/
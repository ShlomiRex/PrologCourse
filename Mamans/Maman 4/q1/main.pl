/*
The tree in the question:


t(
	t(
		t(nil, 15, nil)
		10,
		t(
			t(
				nil,
				6,
				nil
			),
			8,
			nil
		)
	),
	20,
	t(
		nil,
		30,
		t(nil, 25, nil)
	)
)

Or:


T1 = t(t(t(nil, 15, nil),10,t(t(nil,6,nil),8,nil)),20,t(nil,30,t(nil, 25, nil))).
*/


/*
Subtree of the question's tree:
t(
	t(nil, 15, nil),
	10,
	t(
		t(nil, 6, nil), 
		8, 
		nil)
)

Or:
T2 = t(t(nil, 15, nil),10,t(t(nil, 6, nil), 8, nil))
*/

is_zigzag_ole(t(L,X,R)):-
	is_zigzag_yored(L),
	is_zigzag_yored(R),
	all_nodes_less_than(L,X),
	all_nodes_greater_than(R,X).
is_zigzag_ole(nil).

is_zigzag_yored(t(L,X,R)):-
	is_zigzag_ole(L),
	is_zigzag_ole(R),
	all_nodes_greater_than(L,X),
	all_nodes_less_than(R,X).
is_zigzag_yored(nil).



%%%%%%% Testing %%%%%%%

% Basic tree, single node
% ?- T = t(nil, 1, nil), is_zigzag_ole(T). % true
% ?- T = t(nil, 1, nil), is_zigzag_yored(T). % true

% Basic tree, 2 levels
% ?- T = t(t(nil, 1, nil), 2, t(nil, 3, nil)), is_zigzag_ole(T). % true
% ?- T = t(t(nil, 1, nil), 2, t(nil, 3, nil)), is_zigzag_yored(T). % false

% Basic tree, 3 levels, like in the question (root of 10)
% ?- T2 = t(t(nil, 15, nil),10,t(t(nil, 6, nil), 8, nil)), is_zigzag_ole(T2). % false
% ?- T2 = t(t(nil, 15, nil),10,t(t(nil, 6, nil), 8, nil)), is_zigzag_yored(T2). % true

% The question's tree (root of 20)
% ?- T1 = t(t(t(nil, 15, nil),10,t(t(nil,6,nil),8,nil)),20,t(nil,30,t(nil, 25, nil))), is_zigzag_ole(T1). % true
% ?- T1 = t(t(t(nil, 15, nil),10,t(t(nil,6,nil),8,nil)),20,t(nil,30,t(nil, 25, nil))), is_zigzag_yored(T1). % false




%%%%%%% Helper functions %%%%%%%



all_nodes_less_than(t(L,X,R),Num):-
	X < Num,
	all_nodes_less_than(L,Num),
	all_nodes_less_than(R,Num).
all_nodes_less_than(nil,_).
% ?- all_nodes_less_than(t(t(nil, 2, nil), 1, t(nil, 2, nil)), 5). % true
% ?- all_nodes_less_than(t(t(nil, 10, nil), 1, t(nil, 2, nil)), 5). % false
% ?- T = t(t(t(nil, 15, nil),10,t(t(nil,6,nil),8,nil)),20,t(nil,30,t(nil, 25, nil))), all_nodes_less_than(T, 100). % true
% ?- T = t(t(t(nil, 15, nil),10,t(t(nil,6,nil),8,nil)),20,t(nil,30,t(nil, 25, nil))), all_nodes_less_than(T, 3). % false

all_nodes_greater_than(t(L,X,R),Num):-
	X > Num,
	all_nodes_greater_than(L,Num),
	all_nodes_greater_than(R,Num).
all_nodes_greater_than(nil,_).
% ?- all_nodes_greater_than(t(t(nil, 2, nil), 1, t(nil, 2, nil)), 5). % false
% ?- all_nodes_greater_than(t(t(nil, 13, nil), 10, t(nil, 10, nil)), 5). % true
% ?- T = t(t(t(nil, 15, nil),10,t(t(nil,6,nil),8,nil)),20,t(nil,30,t(nil, 25, nil))), all_nodes_greater_than(T, 100). % false
% ?- T = t(t(t(nil, 15, nil),10,t(t(nil,6,nil),8,nil)),20,t(nil,30,t(nil, 25, nil))), all_nodes_greater_than(T, 3). % true
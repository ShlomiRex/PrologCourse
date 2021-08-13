% To run:
% [main], retractall(board(_, _, _)), begin().


/*
---------------------
		Board
---------------------
Consists of 3 rows.

Empty cell: 0
X Player: 1
O Player: 2
*/

begin():-
	writeln('Welcome to TicTacToe! Made by Shlomi Domnenko!'),
	assert(board([0,0,0], [0,2,0], [0,1,0])),
	printBoard().


printBoard():-
	retract(board(Row1, Row2, Row3)),
	nl, nl,
	printRow(Row1),
	writeln('|---|---|---|'),
	printRow(Row2),
	writeln('|---|---|---|'),
	printRow(Row3),
	nl, nl,
	assert(board(Row1, Row2, Row3)).
printRow([Head|Tail]):-
	write('|'),
	((Head == 0,write('   ')) ; (Head == 1,write(' X ')) ; (Head == 2,write(' O '))),
	printRow(Tail).
printRow([]):-
	writeln('|').
% To run:
% consult("main.pl"), retractall(board(_,_,_)), begin().


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
	nl,nl,
	writeln('Welcome to TicTacToe! Made by Shlomi Domnenko!'),
	writeln('Starting player is X, second player is O'),
	nl,
	assert(board([0,0,0], [0,0,0], [0,0,0])),
	printBoard(),
	writeln('Please select your cell'),
	inputSelectCell(Row, Col).


/* User Input - Start */
inputSelectCell(Row, Col):-
	writeln('Row number(1-3): '),
	read(Row),
	writeln('Column number(1-3): '),
	read(Col),
	(
	integer(Row), integer(Col),
	Row > 0, Row < 4,
	Col > 0, Col < 4,
	writeln('Success!')
	) ; 
	nl, writeln('Please enter valid numbers!'),
	inputSelectCell(Row, Col).
/* User Input - End */

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
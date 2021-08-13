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

/* Starting the game */
begin():-
	nl,nl,
	writeln('Welcome to TicTacToe! Made by Shlomi Domnenko!'),
	writeln('Starting player is X, second player is O'),
	nl,
	assert(board([0,0,0], [0,0,0], [0,0,0])),
	playerTurn(1).




playerTurn(Player):-
	((Player == 1, writeln('Player X turn')) ; (writeln('Player O turn'))),
	printBoard(),
	writeln('Please select your cell'),
	inputSelectCell(Row, Col).



checkValidMove(Player, RowNumber, ColNumber):-
	getCell(RowNumber, ColNumber, Cell).


getRow(RowNumber, RowResult):-
	retract(board(Row1, Row2, Row3)),
	( (RowNumber == 1, RowResult is Row1) ; (RowNumber == 2, RowResult is Row2) ; (RowNumber == 3, RowResult is Row3) ),
	assert(board(Row1, Row2, Row3)).
getCell(RowNumber, ColNumber, CellResult):-
	getRow(RowNumber, Row).


getElementAtIndex([X|Xs], Index, Res):-
	writeln(Index),
	Index2 is Index - 1,
	getElementAtIndex(Xs, Index2, Res), !.
getElementAtIndex([X|_], 0, X).

/* User Input - Start */
inputSelectCell(Row, Col):-
	writeln('Row number(1-3): '),
	read(Row),
	writeln('Column number(1-3): '),
	read(Col),
	(
	integer(Row), integer(Col),
	Row > 0, Row < 4,
	Col > 0, Col < 4
	) ; 
	nl, writeln('Please enter valid numbers!'),
	inputSelectCell(Row, Col).
/* User Input - End */






/* Print Board - Start */
printBoard():-
	%writeln('Printing board...'),
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
/* Print Board - End */
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
	assert(board([1,0,0], [0,0,0], [0,0,0])),
	playerTurn(1).



% Player makes a move on the board.
playerTurn(Player):-
	((Player == 1, writeln('Player X turn')) ; (writeln('Player O turn'))),
	printBoard(),
	writeln('Please select your cell'),
	inputSelectCell(Row, Col),
	checkValidMove(Player, Row, Col),
	write('[DEBUG] Player made a move'), nl,
	writeCell(Player, Row, Col).
	
	
/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Board read and writes - Start @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */

% Checks if cell is occupied.
checkValidMove(Player, RowNumber, ColNumber):-
	write('[DEBUG] Getting the cell the player chose...'), nl,
	ColIndex is ColNumber - 1,
	getCell(RowNumber, ColIndex, Cell),
	write('[DEBUG] Cell: '), write(Cell), nl,
	(Cell == 0 ; (write('Cell is occupied! Try again.'), nl, fail)).
% Return list of cells given row number.
getRow(RowNumber, RowResult):-
	retract(board(Row1, Row2, Row3)),
	( (RowNumber == 1, RowResult = Row1) ; (RowNumber == 2, RowResult = Row2) ; (RowNumber == 3, RowResult = Row3) ),
	assert(board(Row1, Row2, Row3)).
% Return single cell (integer 0, 1, or 2)
getCell(RowNumber, ColNumber, CellResult):-
	getRow(RowNumber, Row),
	write('[DEBUG] The row selected: '), write(Row), nl,
	getElementAtIndex(Row, ColNumber, CellResult).

% General predicate to get n'th element of a list.
getElementAtIndex([X|Xs], Index, Res):-
	Index2 is Index - 1,
	getElementAtIndex(Xs, Index2, Res), !.
getElementAtIndex([X|_], 0, X).

writeElementAtIndex([X|Xs], Index, [X|RestNewList]):-
	Index > -1, !,
	Index2 is Index - 1,
	writeElementAtIndex(Xs, Index2, NewList).

writeElementAtIndex([], 0, _):- !.
writeElementAtIndex([X|Xs], 0, [X|RestNewList]):-
	writeElementAtIndex(Xs, 0, RestNewList), !.

writeCell(Player, RowNumber, ColNumber):-
	write('[DEBUG] Writing to cell'), nl,
	getRow(RowNumber, Row),
	write('Row to write to: '), write(Row), nl,
	writeElementAtIndex(Row, ColNumber, NewRow),
	write('[DEBUG] New row: '), write(NewRow), nl.


/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Board read and writes - End @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */









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
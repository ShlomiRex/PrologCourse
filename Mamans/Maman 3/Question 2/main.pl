% To run:
% consult("main.pl"), retractall(board(_)), begin().


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
	assert(board([0,0,0, 0,0,0, 0,0,0])), % Start the game with empty board
	begin(1).

begin(Player):-
	playerTurn(Player),
	writeln('Player turn end'),
	(
		not(checkWinner(Player)), 
		%writeln('[DEBUG] Not winner.'),
		((Player == 1, begin(2)) ; begin(1)
	) ;
	(printBoard(), nl, nl, write('We have a winner!!!'), nl, nl)).


% Player makes a move on the board.
playerTurn(Player):-
	((Player == 1, writeln('Player X turn')) ; (writeln('Player O turn'))),
	printBoard(),
	writeln('Please select your cell'),
	inputSelectCell(Row, Col),
	playerMove(Player, Row, Col).
	




checkWinner(Player):-
	%write('[DEBUG] Checking if winner...'), nl,

	retract(board(Cells)), % Look at memory
	assert(board(Cells)), % Don't update it, only read

	% Get rows, cols and diags (all are list of length 3)
	getRows(Cells, Row1, Row2, Row3),
	getCols(Cells, Col1, Col2, Col3),
	getDiags(Cells, Diag1, Diag2),
	(
		member([Player, Player, Player], [Row1, Row2, Row3]) ;
		member([Player, Player, Player], [Col1, Col2, Col3]) ;
		member([Player, Player, Player], [Diag1, Diag2])
	).



/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Board read and writes - Start @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */

% Checks if cell is occupied.
playerMove(Player, RowNumber, ColNumber):-
	%write('[DEBUG] Checking if valid move...'), nl,
	Index is ((RowNumber-1) * 3) + (ColNumber - 1), % RowNumber, ColNumber start from 1, so we do a little math to calculate index in 1D array.
	%write('[DEBUG] Cell index: '), write(Index), nl,

	retract(board(Cells)), % Look at memory

	nth0(Index, Cells, Cell),
	%write('[DEBUG] Cell chosen: '), write(Cell), nl,
	(
		(
			Cell == 0,
			%write('[DEBUG] Player made a valid move'), nl,
			replace(Cells, Index, Player, NewCells), % Player made a valid move. Execute the move.
			assert(board(NewCells)) % Update the memory.
		) ; 
		(write('Cell is occupied! Try again.'), nl, assert(board(Cells)), fail) % Return the memory to what it was before.
	).

% Replace element in list by given index. Returns the new list.
% Signature: List, Index, NewElement, NewList.
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

% Converts single array to 3 arrays.
getRows(Cells, Row1, Row2, Row3):-
	%write('[DEBUG] Get rows...'), nl,
	take(Cells, 3, Row1, NewList1),
	take(NewList1, 3, Row2, NewList2),
	take(NewList2, 3, Row3, _).

getCol(Cells, ColIndexStart, Col):-
	ColIndexStart2 is ColIndexStart + 3,
	ColIndexStart3 is ColIndexStart + 6,

	nth0(ColIndexStart, Cells, Cell1),
	nth0(ColIndexStart2, Cells, Cell2),
	nth0(ColIndexStart3, Cells, Cell3),
	Col = [Cell1, Cell2, Cell3].

getCols(Cells, Col1, Col2, Col3):-
	%write('[DEBUG] Get cols...'), nl,
	getCol(Cells, 0, Col1),
	getCol(Cells, 1, Col2),
	getCol(Cells, 2, Col3).


getDiags(Cells, Diag1, Diag2):-
	%write('[DEBUG] Get diags...'), nl,

	% Main diag
	nth0(0, Cells, MainDiagCell1),
	nth0(4, Cells, MainDiagCell2),
	nth0(8, Cells, MainDiagCell3),

	% Secondary diag
	nth0(2, Cells, SecondaryDiagCell1),
	nth0(4, Cells, SecondaryDiagCell2),
	nth0(6, Cells, SecondaryDiagCell3),

	Diag1 = [MainDiagCell1, MainDiagCell2, MainDiagCell3],
	Diag2 = [SecondaryDiagCell1, SecondaryDiagCell2, SecondaryDiagCell3].

% Helper function. Take first 'N' elements from a list, and return it as 'L1', and return the list without the first 'N' elements as 'Res'.
take(L, N, L1, Res):- 
	length(L1, N), append(L1, Res, L).




/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Board read and writes - End @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */









/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ User Input - Start @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */
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
/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ User Input - End @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */






/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Print Board - Start @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */
printBoard():-
	%writeln('[DEBUG] Printing board...'),
	retract(board(Cells)),
	getRows(Cells, Row1, Row2, Row3),
	nl, nl,
	printRow(Row1),
	writeln('|---|---|---|'),
	printRow(Row2),
	writeln('|---|---|---|'),
	printRow(Row3),
	nl, nl,
	assert(board(Cells)).
printRow([Head|Tail]):-
	write('|'),
	((Head == 0,write('   ')) ; (Head == 1,write(' X ')) ; (Head == 2,write(' O '))),
	printRow(Tail).
printRow([]):-
	writeln('|').
/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Print Board - End @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */
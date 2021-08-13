
% הבחנה
% name(lpa, Res). % Res = [108, 122, 97].
% name('lpa', Res). % Res = [108, 122, 97].

% So we need to compare ascii value of the atoms.
% We need to find list of words, that make a list of ascii, that is match with target.

% Example:
% Target: 'lpa prolog' : [108, 112, 97, 32, 112, 114, 111, 108, 111, 103]
% Possible sequence: [[108, 122], [97], [32, 112, 114], [111], [108], [111, 103] ].










match_words(Atoms, Target, Seq):-
	name(Target, TargetAsciiList),
	%write('Target: '), writeln(TargetAsciiList),

	% Next we need to find permutation of atoms, and convert it also to ascii list.
	permutation(Atoms, Perm),
	list_of_atoms_to_list_of_ascii(Perm, PermAsciiList),
	%write('Permutation: '), writeln(PermAsciiList),
	flatten(PermAsciiList, PermAsciiListFlat),
	%write('Permutation flatten: '), writeln(PermAsciiListFlat),
	%write('Target: `'), write(Target), write('` '), writeln(TargetAsciiList),

	% Next we check if the target is at the start of the permutation
	check_sublist_at_begining(TargetAsciiList, PermAsciiListFlat),
	%write('Success! Permutation sequence: '), writeln(Perm),

	construct_seq(Perm, TargetAsciiList, Seq),
	not(retract(sequence_answer(Seq))),
	assertz(sequence_answer(Seq)).

% match_words([cd,de,da,a,def,bc,abc], abcde, Seq). 
	% Seq = [a,bc,de] ;
	% Seq = [abc,de] 

% match_words([lpa, lp, pro, 'a p',' ', win, rol, og, log], 'lpa prolog', Seq).
	% Seq = [lpa,' ',pro,log] ;
	% Seq = [lp,'a p',rol,og]



list_of_atoms_to_list_of_ascii([], []).
list_of_atoms_to_list_of_ascii([Atom|Atoms], [Ascii|List]):-
	name(Atom, Ascii),
	list_of_atoms_to_list_of_ascii(Atoms, List).
% list_of_atoms_to_list_of_ascii([cd, de], Res). % Res = [[99, 100], [100, 101]].

check_sublist_at_begining([], _).
check_sublist_at_begining([Head|Sublist], [Head|List]):-
	check_sublist_at_begining(Sublist, List).
% check_sublist_at_begining([97, 98], [97, 98, 99]). % true
% check_sublist_at_begining([97, 98], [98, 97, 99]). % false


% We know that the beginning of the permutation is the target. Now, return Seq.
construct_seq([X|Perm], TargetAsciiList, [X|Seq]):-
	name(X, XAsciiList),

	%write('Target: '), writeln(TargetAsciiList),
	%write('Head ascii: '), writeln(XAsciiList),
	%write('Seq: '), writeln([X|Seq]),

	append([XAsciiList, Rest], TargetAsciiList),
	%write('Rest: '), writeln(Rest),

	construct_seq(Perm, Rest, Seq).
construct_seq(_, [], []).












% list_of_atoms_to_list_of_ascii([lpa, lp, pro, 'a p',' ', win, rol, og, log], Res).
% Res = [[108, 112, 97], [108, 112], [112, 114, 111], [97, 32, 112], [32], [119, 105, 110], [114, 111, 108], [111, 103], [108, 111, 103]].

% name('lpa prolog', Res).
% Res = [108, 112, 97, 32, 112, 114, 111, 108, 111, 103].





% Delete once element from list.
% First argument is what element to delete.
% Second argument is the list.
% Third argument is the list with the element deleted. (result)
del(X, [X|Xs], Xs).
del(X, [Y|Xs], [Y|Ys]):-
	del(X, Xs, Ys).

% Permutation of a list.
% First argument is the list.
% Second argument is the list with the permutation. (result)
% The idea is to delete Z from the list, so the result head is Z, and the rest (Zs) is the permutation from recursion.
permutation([], []). % Extreme case
permutation(Xs, [Z|Zs]):-
	del(Z, Xs, Ys),
	permutation(Ys, Zs).
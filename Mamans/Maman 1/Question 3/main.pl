count(0, 0).
count(s(X), Z):-
	count(X, Z1), % Transform s(X) to X
	Z is Z1+1.

% num_to_recursive_s(0).
% num_to_recursive_s(Z):-
% 	num_to_recursive_s(Z):

dec(0, 0).
dec(s(X), s(Z)):-
	dec(X, Z).

plus(0, Z, Z).
plus(X, 0, X).
plus(s(X), s(Y), s(Z)):-
	plus(X, s(Y), Z). % Option 1: decrement X


% plus(s(s(0)), s(s(s(0))), Z). % Z = s(s(s(s(s(0))))) 
% plus(s(s(0)), Y, s(s(s(s(s(0)))))). % Y = s(s(s(0))) 
% plus(X, s(s(s(0))), s(s(s(s(s(0)))))). % X = s(s(0)) 



times(X, s(0), X).
times(s(0), Y, Y).
times(s(0), s(0), s(0)).
times(_, 0, 0).
times(0, _, 0).
% Z = X*(Y+1)
times(X, s(Y), Z):-
	writeln("times"),
	times(X, Y, XY), % Dec Y, result is X*((Y+1)-1) = X*Y
	plus(XY, X, Z). 



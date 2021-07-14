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


plus(s(X), s(Y), s(Z)):-
	plus(X, s(Y), Z); % Option 1: decrement X
	plus(s(X), Y, Z). % Option 2: decrement Y
plus(0, 0, 0).
plus(0, Z, Z).
plus(Z, 0, Z).
	


% plus(s(s(0)), s(s(s(0))), Z). % Z = s(s(s(s(s(0))))) 
% plus(s(s(0)), Y, s(s(s(s(s(0)))))). % Y = s(s(s(0))) 
% plus(X, s(s(s(0))), s(s(s(s(s(0)))))). % X = s(s(0)) 


% s(0) % 1
% s(s(0)) % 2
% s(s(s(0))) % 3


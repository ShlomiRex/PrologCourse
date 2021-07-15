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
	times(X, Y, XY), % Dec Y, result is X*((Y+1)-1) = X*Y
	plus(XY, X, Z). 

% times(s(s(0)), s(s(s(0))), Z). % Z = s(s(s(s(s(s(0)))))) 
% times(s(s(0)), Y, s(s(s(s(s(s(0))))))). % Y = s(s(s(0)))
% times(X, s(s(s(0))), s(s(s(s(s(s(0))))))). % X = s(s(0))




not_greater(0, s(_)).
not_greater(0, 0).
not_greater(s(X), s(Y)):-
	not_greater(X, Y).

% not_greater(s(s(0)), s(s(s(0)))). % true
% not_greater(X, s(s(s(0)))). 	% X = 0 ;
								% X = s(0) ;
								% X = s(s(0)) ;
								% X = s(s(s(0))) 


% Plus and times predict are from Maman 11.

plus(0, 0, 0).
plus(0, A, A).
plus(A, 0, A).
plus(s(X), s(Y), s(Z)):-
	plus(s(X), Y, Z), % Dec Y only
	plus(X, s(Y), Z). % Dec X only
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





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

translate(0, 0).
translate(s(X), Num):-
	translate(X, Num2),
	Num is Num2 + 1.

% translate(s(s(s(s(s(s(0)))))), Num). % Num = 6
% translate(X, 4). % s(s(s(s(0))))
% translate(X,2), translate(Y,3), times(X,Y,Z), translate(Z,Num). 	% Num = 6,
																	% X = s(s(0)),
																	% Y = s(s(s(0))),
																	% Z = s(s(s(s(s(s(0))))))
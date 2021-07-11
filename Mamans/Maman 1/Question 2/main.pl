live_direct_above(frid, stein).
live_direct_above(asher, frid).
live_direct_above(goren, asher).
live_direct_above(yarden, fogel).
live_direct_above(cohen, yarden).
live_direct_above(zamir, cohen).
live_direct_above(levi, adar).
live_direct_above(adar, segal).
live_direct_above(segal, avraham).

% goren
% asher
% frid
% stein

% zamir
% cohen
% yarden
% fogel

% levi
% adar
% segal
% avraham


live_above(Family1, Family2) :-
	live_direct_above(Family1, Family2);
	(live_direct_above(Family1, X), live_above(X, Family2)).

% live_above(cohen, fogel). % true
% live_above(goren, stein). % true
% live_above(frid, stein). % true

% live_above(fogel, cohen). % false
% live_above(stein, goren). % false
% live_above(stein, frid). % false

% live_above(goren, avraham). % false
% live_above(levi, avraham). % true

live_below(Family1, Family2) :-
	live_above(Family2, Family1).

% live_below(stein, goren). % true
% live_below(cohen, fogel). % false
% live_below(goren, stein). % false
% live_below(goren, avraham). % false

live_in_first_floor(stein).
live_in_first_floor(fogel).
live_in_first_floor(avraham).

% Recursive helper function. No need to count level of family. 
% In each recursion (1 inner recursion stack frame = 1 level) check if in current level, family 1, family 2 inhabit X1,X2.
% Note: CurrFamily1 and CurrFamily2 are given as 2 diffirent buildings (if same building, then non-helper function checks it) to make it easier.
live_in_same_floor_helper(CurrFamily1, CurrFamily2, Family1, Family2):-
	(live_direct_above(X1, CurrFamily1), 
	live_direct_above(X2, CurrFamily2), 
	X1=Family1, X2=Family2);
	(live_direct_above(X1, CurrFamily1), 
	live_direct_above(X2, CurrFamily2), 
	live_in_same_floor_helper(X1, X2, Family1, Family2)).

% First 2 lines are obvious (extreme cases)
% Third line calls recursive function
live_in_same_floor(Family1, Family2) :-
	(Family1=Family2);
	(live_in_first_floor(Family1), live_in_first_floor(Family2));
	(live_in_first_floor(X1), live_in_first_floor(X2),  X1\=X2, live_in_same_floor_helper(X1, X2, Family1, Family2)).

% live_in_same_floor(cohen, adar). % true
% live_in_same_floor(goren, cohen). % false
% live_in_same_floor(frid, yarden). % true
% live_in_same_floor(frid, frid). % true
% live_in_same_floor(asher, asher). % true
% live_in_same_floor(stein, stein). % true
% live_in_same_floor(avraham, goren). % false


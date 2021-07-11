live_direct_above(frid, stein).
live_direct_above(asher, frid).
live_direct_above(goren, asher).
live_direct_above(yarden, fogel).
live_direct_above(cohen, yarden).
live_direct_above(zamir, cohen).
live_direct_above(levi, adar).
live_direct_above(adar, segal).
live_direct_above(segal, avraham).

% Building 1:
% -------------
% goren         % Floor 4
% asher
% frid
% stein         % Floor 1

% Building 2:
% -------------
% zamir
% cohen
% yarden
% fogel

% Building 3:
% -------------
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

% Recursive helper function. No need to count level of family (like we did in class).
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






% If Family1 is above Family2 (in diffirent buildings), return true.
% We only have 1 pointer for one of the buildings that Family1 exists in.
% We then must ask: if pointer is same floor as Family2. If so, then we also want that pointer is BELOW Family1.
% If something is not met, then it should return false.
% We then increment the pointer of building 1.
above_helper(CurrFamily1, Family1, Family2):-
	(live_in_same_floor(CurrFamily1, Family2),
	live_below(CurrFamily1, Family1));
	(live_direct_above(NewCurr, CurrFamily1), above_helper(NewCurr, Family1, Family2)).


% Case 1: Same building: Check if live_above. Done.
% Case 2: Diffirent building: Get building 1 level 1 family (X1), building 2 level 1 family(X2) and check if Family1 above Family2
% If Family1, Family2 are both the same level, then return false.
above(Family1, Family2):-
	live_above(Family1, Family2);
	(live_in_first_floor(X1), live_in_first_floor(X2), X1\=X2, 
	above_helper(X1, Family1, Family2)).


% above(goren, yarden). % true
% above(stein, zamir). % false
% above(stein, cohen). % false
% above(stein, yarden). % false
% above(stein, stein). % false
% above(goren, cohen). % true

% above(segal, avraham). % true
% above(levi, avraham). % true
% above(yarden, avraham). % true    
% above(avraham, yarden). % false
% above(frid, fogel). % true

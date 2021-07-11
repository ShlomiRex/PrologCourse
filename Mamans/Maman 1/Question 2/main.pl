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
% ========================================================================================================================================================================================================
% ארבע מטיילים צריכים לעבור מנהרה צרה וחשוכה.
% אפשר לעבור את המנהרה לבד או בזוג ובעזרת פנס דולק.
% ברשות המטיילים פנס אחד ובו סוללה המספיקה ל 12 שעות בלבד.
% קצב ההליכה של המטיילים שונה, וכאשר הולכים בזוג, המהיר צריך להתאים את עצמו לקצב של האיטי.
% מטייל א עובר את המנהרה בשעה
% מטייל ב עובר את המנהרה בשעתיים
% מטייל ג עובר את המנהרה בארבע שעות
% מטייל ד עובר את המנהרה ב 5 שעות
% ========================================================================================================================================================================================================
% If list is sorted.
orderd([_]):-!.
orderd([X,Y|Res]):-
    name(X, [Z1]),
    name(Y, [Z2]),
    Z1 =< Z2,
    orderd([Y|Rest]).

% ?- orderd([3, 2, 1]). % false
% ?- orderd([1, 2, 3]). % true
% ========================================================================================================================================================================================================
% Delete element X from list.
del(X, [X|Tail], Tail).
del(X, [Y|Tail1], [Y|Tail2]):-
    del(X, Tail1, Tail2).
% ?- del(1, [1, 2, 3], L). ? L = [2, 3].
% ========================================================================================================================================================================================================
% Insert element X to List1, result is List2.
insert(X, List1, List2):-
    del(X, List2, List1).
% ?- insert(4, [1, 2, 3], L). ? L = [4, 1, 2, 3]. L = [1, 4, 2, 3]. L = [1, 2, 4, 3]. L = [1, 2, 3, 4]. 
% ========================================================================================================================================================================================================

% The cave and light problem. Video at: 00:42:25

solve(List, Solution):-
    depthfirst(s(before, List, [], 12), Solution, []), !.

goal(s(_, [], [a, b, c, d], [_])).

% ?- solve([a,b,c,d], Solution). % 
% ========================================================================================================================================================================================================
% we can move on the tree in four ways as mention in the question.
% in my move there is three parameters, the third is the cost of doing %this move
max(A,B,A):-
    A > B.
max(A,B,B):-
    B >= A.

man_time(a, 1).
man_time(b, 2).
man_time(c, 4).
man_time(d, 5).

move(s(before, List, List_Before1, List_After1, Time_Before_Move), s(after, List_Before2, ListAfter2, Time_AfterMove)):-
    del(X, List_Before1, Temp_List),
    del(Y, Temp_List1, List_Before2),
    insert(Y, List_After1, Temp_List1),
    insert(X, Temp_List2, List_After2),
    man_time(X, Move_Time1),
    man_time(Y, Move_Time2),
    max(Move_Time1, Move_Time2, Move_Time),
    Time_After_Move is Time_Before_Move - Move_Time,
    Time_After_Move >= 0.

move(s(after, List_Before1, List_After1, Time_Before_Move), s(before, List_Before2, List_After2, Time_After_Move)):-
    del(X, List_After1, List_After2),
    insert(X, List_Before1, List_Before2),
    man_time(X, Move_Time),
    Time_After_Move is Time_Before_Move - Move_Time,
    Time_After_Move >= 0.
% ========================================================================================================================================================================================================
% DFS - Depth First Search
% Without circles, we update the time and visited list
depthfirst(Node, [Node], _):-
    goal(Node).

depthfirst(Node, [Node|Sol], Visit):-
    move(Node, Node1),
    not( member(Node1, Visit) ),
    depthfirst(Node1, Sol, [Node1|Visit]).
% ========================================================================================================================================================================================================

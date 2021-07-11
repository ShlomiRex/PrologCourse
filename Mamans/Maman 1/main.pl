directed_edge(edge1, node1, node2).
directed_edge(edge2, node3, node2).
directed_edge(edge3, node4, node3).
directed_edge(edge4, node1, node4).

directed_edge(edge5, node5, node6).
directed_edge(edge6, node6, node7).
directed_edge(edge7, node8, node7).
directed_edge(edge8, node8, node5).

/* Return true if edge X = {NodeI, NodeJ} (unordered) */
edge(X, NodeI, NodeJ) :- 
	directed_edge(X, NodeI, NodeJ) ; directed_edge(X, NodeJ, NodeI).

% edge(edge1, node1, node2). % true
% edge(edge1, node2, node1). % true
% edge(edge1, node3, node4). % false
% edge(edge1, node1, node3). % false

% edge(edge1, X, Y) % (X,Y) = [(node1, node2), (node2, node1)]

vertical(EdgeI, EdgeJ) :-
	edge(EdgeI, X, Y), edge(EdgeJ, X, Z), X\=Y, X\=Z.

% vertical(edge1, edge2). % true
% vertical(edge2, edge1). % true
% vertical(edge1, edge3). % false
% vertical(edge2, edge4). % false
% vertical(edge3, edge4). % true

parallel(EdgeI, EdgeJ) :-
	vertical(EdgeI, EdgeK), vertical(EdgeJ, EdgeK), EdgeK\=EdgeI, EdgeK\=EdgeJ.

% parallel(edge1, edge2). % false
% parallel(edge2, edge1). % false
% parallel(edge1, edge4). % false
% parallel(edge1, edge3). % true
% parallel(edge2, edge4). % true
% parallel(edge4, edge2). % true


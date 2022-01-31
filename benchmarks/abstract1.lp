pos(X,Y):-init(object(node,_),value(at,(X,Y))).

edg(X1,Y1,X1+1,Y1,0):-pos(X1,Y1), pos(X1+1,Y1).
edg(X1,Y1,X1,Y1+1,0):-pos(X1,Y1), pos(X1,Y1+1).
edg(X1,Y1,X1-1,Y1,0):-pos(X1,Y1), pos(X1-1,Y1).
edg(X1,Y1,X1,Y1-1,0):-pos(X1,Y1), pos(X1,Y1-1).
edg(X1,Y1,X1+1,Y1+1,0):-pos(X1,Y1), pos(X1+1,Y1+1), pos(X1,Y1+1), pos(X1+1,Y1).
edg(X1,Y1,X1-1,Y1-1,0):-pos(X1,Y1), pos(X1-1,Y1-1), pos(X1,Y1-1), pos(X1-1,Y1).
edg(X1,Y1,X1+1,Y1-1,0):-pos(X1,Y1), pos(X1+1,Y1-1), pos(X1,Y1-1), pos(X1+1,Y1).
edg(X1,Y1,X1-1,Y1+1,0):-pos(X1,Y1), pos(X1-1,Y1+1), pos(X1,Y1+1), pos(X1-1,Y1).

cluster2(X1,Y1,X2,Y2,L):-edg(X1,Y1,X2,Y2,L), not cluster2(X2,Y2,_,_,L), not cluster2(_,_,X1,Y1,L).






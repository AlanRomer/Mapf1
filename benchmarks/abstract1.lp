pos(X,Y):-init(object(node,_),value(at,(X,Y))).
maxx(X,0):-pos(X,_), not pos(X+1,_).
maxy(Y*X,0):-pos(_,Y), not pos(_,Y+1), maxx(X,0).
points(X1+(Y1-1)*X2,0):-pos(X1,Y1), maxx(X2,0).

edg(X1+(Y1-1)*X2,X1+1+(Y1-1)*X2,0):-pos(X1,Y1), pos(X1+1,Y1), maxx(X2,0).
edg(X1+(Y1-1)*X2,X1+Y1*X2,0):-pos(X1,Y1), pos(X1,Y1+1), maxx(X2,0).
edg(X1+(Y1-1)*X2,X1-1+(Y1-1)*X2,0):-pos(X1,Y1), pos(X1-1,Y1), maxx(X2,0).
edg(X1+(Y1-1)*X2,X1+(Y1-2)*X2,0):-pos(X1,Y1), pos(X1,Y1-1), maxx(X2,0).
edg(X1+(Y1-1)*X2,X1+1+Y1*X2,0):-pos(X1,Y1), pos(X1+1,Y1+1), pos(X1,Y1+1), pos(X1+1,Y1), maxx(X2,0).
edg(X1+(Y1-1)*X2,X1-1+(Y1-2)*X2,0):-pos(X1,Y1), pos(X1-1,Y1-1), pos(X1,Y1-1), pos(X1-1,Y1), maxx(X2,0).
edg(X1+(Y1-1)*X2,X1+1+(Y1-2)*X2,0):-pos(X1,Y1), pos(X1+1,Y1-1), pos(X1,Y1-1), pos(X1+1,Y1), maxx(X2,0).
edg(X1+(Y1-1)*X2,X1-1+Y1*X2,0):-pos(X1,Y1), pos(X1-1,Y1+1), pos(X1,Y1+1), pos(X1-1,Y1), maxx(X2,0).

%square(Z1,Z2,Z3,Z4,0):-edg(Z1,Z2,0), edg(Z1,Z3,0), edg(Z1,Z4,0), edg(Z2,Z3,0), edg(Z2,Z4,0), edg(Z3,Z4,0), Z1<Z2, Z2<Z3, Z3<Z4.
%selsquare(Z1,Z2,Z3,Z4,0):-square(Z1,Z2,Z3,Z4,0), square(Z1,Z5,_,_,0), Z5<Z2.
%selsquare(Z1,Z2,Z3,Z4,0):-square(Z1,Z2,Z3,Z4,0), square(Z1,Z2,Z5,_,0), Z5<Z3.
%selsquare(Z1,Z2,Z3,Z4,0):-square(Z1,Z2,Z3,Z4,0), square(Z1,Z2,Z3,Z5,0), Z5<Z4.
%drei(Z1,0):-points(Z1,0), not square(Z1,_,_,_,0), not square(_,Z1,_,_,0), not square(_,_,Z1,_,0), not square(_,_,_,Z1,0).
%triang(Z1,Z2,Z3,0):-edg(Z1,Z2,0), edg(Z1,Z3,0), edg(Z2,Z3,0), Z1<Z2, Z2<Z3, drei(Z1,0), drei(Z2,0), drei(Z3,0).
%bi(Z1,0):-drei(Z1,0), not triang(Z1,_,_,0), not triang(_,Z1,_,0), not triang(_,_,Z1,0).
%line(Z1,Z2,0):-edg(Z1,Z2,0), Z1<Z2, bi(Z1,0), bi(Z2,0).
%sing(Z1,0):-bi(Z1,0), not line(Z1,_,0), not line(_,Z1,0).
%conn(Z3,Z1,0):-edg(Z3,Z1,0), C=1, C=#count{ Z2 : edg(Z2,Z1,0)}, sing(Z1,0).
%point(Z1,0):-C>1, C=#count{ Z2 : edg(Z2,Z1,0)}, sing(Z1,0).

square(Z1,Z2,Z3,Z4,0):-edg(Z1,Z2,0), edg(Z1,Z3,0), edg(Z1,Z4,0), edg(Z2,Z3,0), edg(Z2,Z4,0), edg(Z3,Z4,0), Z1<Z2, Z2<Z3, Z3<Z4, not square(_,Z1,_,_,0), not square(_,_,Z1,_,0), not square(_,_,_,Z1,0), not square(Z2,_,_,_,0), not square(_,_,Z2,_,0), not square(_,_,_,Z2,0), not square(Z3,_,_,_,0), not square(_,Z3,_,_,0), not square(_,_,_,Z3,0), not square(Z4,_,_,_,0), not square(_,Z4,_,_,0), not square(_,_,Z4,_,0).
drei(Z1,0):-points(Z1,0), not square(Z1,_,_,_,0), not square(_,Z1,_,_,0), not square(_,_,Z1,_,0), not square(_,_,_,Z1,0).
triang(Z1,Z2,Z3,0):-edg(Z1,Z2,0), edg(Z1,Z3,0), edg(Z2,Z3,0), Z1<Z2, Z2<Z3, drei(Z1,0), drei(Z2,0), drei(Z3,0), not triang(_,Z1,_,0), not triang(_,_,Z1,0), not triang(Z2,_,_,0), not triang(_,_,Z2,0), not triang(_,Z3,_,0), not triang(Z3,_,_,0).
bi(Z1,0):-drei(Z1,0), not triang(Z1,_,_,0), not triang(_,Z1,_,0), not triang(_,_,Z1,0).
line(Z1,Z2,0):-edg(Z1,Z2,0), Z1<Z2, bi(Z1,0), bi(Z2,0), not line(_,Z1,0), not line(Z2,_,0).
sing(Z1,0):-bi(Z1,0), not line(Z1,_,0), not line(_,Z1,0).
conn(Z3,Z1,0):-edg(Z3,Z1,0), C=1, C=#count{ Z2 : edg(Z2,Z1,0)}, sing(Z1,0).
point(Z1,0):-C>1, C=#count{ Z2 : edg(Z2,Z1,0)}, sing(Z1,0).





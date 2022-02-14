maxlevel(N):-N=10.
pos(X,Y):-init(object(node,_),value(at,(X,Y))).
maxx(X):-pos(X,_), not pos(X+1,_).
maxy(Y*X):-pos(_,Y), not pos(_,Y+1), maxx(X).
points(X1+(Y1-1)*X2,0):-pos(X1,Y1), maxx(X2).

edg(X1+(Y1-1)*X2,X1+1+(Y1-1)*X2,0):-pos(X1,Y1), pos(X1+1,Y1), maxx(X2).
edg(X1+(Y1-1)*X2,X1+Y1*X2,0):-pos(X1,Y1), pos(X1,Y1+1), maxx(X2).
edg(X1+(Y1-1)*X2,X1+1+Y1*X2,0):-pos(X1,Y1), pos(X1+1,Y1+1), pos(X1,Y1+1), pos(X1+1,Y1), maxx(X2).
edg(X1+(Y1-1)*X2,X1-1+Y1*X2,0):-pos(X1,Y1), pos(X1-1,Y1+1), pos(X1,Y1+1), pos(X1-1,Y1), maxx(X2).

walk(1,0).
walk(Z1+1,I):-walk(Z1,I), square(Z1,_,_,_,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), square(_,Z1,_,_,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), square(_,_,Z1,_,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), square(_,_,_,Z1,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), triang(Z1,_,_,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), triang(_,Z1,_,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), triang(_,_,Z1,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), line(Z1,_,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), line(_,Z1,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), sing(Z1,I), Z1<Z2, maxy(Z2).
walk(Z1+1,I):-walk(Z1,I), not points(Z1,I), Z1<Z2, maxy(Z2).

aktive(Z1,I):-walk(Z1,I), points(Z1,I), not square(_,Z1,_,_,I), not square(_,_,Z1,_,I), not square(_,_,_,Z1,I), not triang(_,Z1,_,I), not triang(_,_,Z1,I), not line(_,Z1,I).
sqr(Z1,Z2,Z3,Z4,I):-aktive(Z1,I), edg(Z1,Z2,I), edg(Z1,Z3,I), edg(Z1,Z4,I), edg(Z2,Z3,I), edg(Z2,Z4,I), edg(Z3,Z4,I), Z1<Z2, Z2<Z3, Z3<Z4, I<N, maxlevel(N).
ansqr(Z1,Z2,Z3,Z4,I):-sqr(Z1,Z2,Z3,Z4,I), anedg(Z5,Z2,I), Z5<Z1. 
ansqr(Z1,Z2,Z3,Z4,I):-sqr(Z1,Z2,Z3,Z4,I), anedg(Z5,Z3,I), Z5<Z1. 
ansqr(Z1,Z2,Z3,Z4,I):-sqr(Z1,Z2,Z3,Z4,I), anedg(Z5,Z4,I), Z5<Z1. 
square(Z1,Z2,Z3,Z4,I):-sqr(Z1,Z2,Z3,Z4,I), not ansqr(Z1,Z2,Z3,Z4,I).
anedg(Z1,Z2,I):-square(Z1,Z2,Z3,Z4,I).
anedg(Z1,Z3,I):-square(Z1,Z2,Z3,Z4,I).
anedg(Z1,Z4,I):-square(Z1,Z2,Z3,Z4,I).
anedg(Z2,Z3,I):-square(Z1,Z2,Z3,Z4,I).
anedg(Z2,Z4,I):-square(Z1,Z2,Z3,Z4,I).
anedg(Z3,Z4,I):-square(Z1,Z2,Z3,Z4,I).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), square(Z1,Z3,Z4,Z5,I), Z2!=Z3, Z2!=Z4, Z2!=Z5, I<N, maxlevel(N).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), square(Z3,Z1,Z4,Z5,I), Z2!=Z3, Z2!=Z4, Z2!=Z5, I<N, maxlevel(N).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), square(Z4,Z3,Z1,Z5,I), Z2!=Z3, Z2!=Z4, Z2!=Z5, I<N, maxlevel(N).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), square(Z5,Z3,Z4,Z1,I), Z2!=Z3, Z2!=Z4, Z2!=Z5, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), square(Z1,Z3,Z4,Z5,I), Z2!=Z3, Z2!=Z4, Z2!=Z5, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), square(Z3,Z1,Z4,Z5,I), Z2!=Z3, Z2!=Z4, Z2!=Z5, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), square(Z4,Z3,Z1,Z5,I), Z2!=Z3, Z2!=Z4, Z2!=Z5, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), square(Z5,Z3,Z4,Z1,I), Z2!=Z3, Z2!=Z4, Z2!=Z5, I<N, maxlevel(N).
drei(Z1,I):-aktive(Z1,I), not square(Z1,_,_,_,I), I<N, maxlevel(N).
tri(Z1,Z2,Z3,I):-edg(Z1,Z2,I), edg(Z1,Z3,I), edg(Z2,Z3,I), Z1<Z2, Z2<Z3, drei(Z1,I), I<N, maxlevel(N).
antri(Z1,Z2,Z3,I):-tri(Z1,Z2,Z3,I), anedg(Z5,Z2,I), Z5<Z1. 
antri(Z1,Z2,Z3,I):-tri(Z1,Z2,Z3,I), anedg(Z5,Z3,I), Z5<Z1. 
triang(Z1,Z2,Z3,I):-tri(Z1,Z2,Z3,I), not antri(Z1,Z2,Z3,I).
anedg(Z1,Z2,I):-triang(Z1,Z2,Z3,I).
anedg(Z1,Z3,I):-triang(Z1,Z2,Z3,I).
anedg(Z2,Z3,I):-triang(Z1,Z2,Z3,I).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), triang(Z1,Z3,Z4,I), Z2!=Z3, Z2!=Z4, I<N, maxlevel(N).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), triang(Z3,Z1,Z4,I), Z2!=Z3, Z2!=Z4, I<N, maxlevel(N).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), triang(Z4,Z3,Z1,I), Z2!=Z3, Z2!=Z4, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), triang(Z1,Z3,Z4,I), Z2!=Z3, Z2!=Z4, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), triang(Z3,Z1,Z4,I), Z2!=Z3, Z2!=Z4, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), triang(Z4,Z3,Z1,I), Z2!=Z3, Z2!=Z4, I<N, maxlevel(N).
bi(Z1,I):-drei(Z1,I), not triang(Z1,_,_,I), I<N, maxlevel(N).
li(Z1,Z2,I):-edg(Z1,Z2,I), Z1<Z2, bi(Z1,I), I<N, maxlevel(N).
anli(Z1,Z2,I):-li(Z1,Z2,I), anedg(Z5,Z2,I), Z5<Z1. 
anli(Z1,Z2,I):-li(Z1,Z2,I), anedg(Z5,Z3,I), Z5<Z1. 
line(Z1,Z2,I):-li(Z1,Z2,I), not anli(Z1,Z2,I).
anedg(Z1,Z2,I):-line(Z1,Z2,I).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), line(Z3,Z1,I), Z2!=Z3, I<N, maxlevel(N).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), line(Z1,Z3,I), Z2!=Z3, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), line(Z3,Z1,I), Z2!=Z3, I<N, maxlevel(N).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), line(Z1,Z3,I), Z2!=Z3, I<N, maxlevel(N).
sing(Z1,I):-bi(Z1,I), not line(Z1,_,I), I<N, maxlevel(N).
conn(Z1,I):-C=1, C=#count{ Z2 : edg(Z2,Z1,I); Z2 : edg(Z1,Z2,I)}, sing(Z1,I), I<N, maxlevel(N).
point(Z1,I):-C>1, C=#count{ Z2 : edg(Z2,Z1,I); Z2 : edg(Z1,Z2,I)}, sing(Z1,I), I<N, maxlevel(N).
naedg(Z1,Z2,I):-edg(Z1,Z2,I), point(Z1,I).
naedg(Z2,Z1,I):-edg(Z2,Z1,I), point(Z1,I).

tranedg(Z1,Z2,I):-naedg(Z1,Z2,I), square(Z1,_,_,_,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z3,Z2,I), square(Z1,Z3,_,_,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z3,Z2,I), square(Z1,_,Z3,_,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z3,Z2,I), square(Z1,_,_,Z3,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z1,Z2,I), triang(Z1,_,_,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z3,Z2,I), triang(Z1,Z3,_,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z3,Z2,I), triang(Z1,_,Z3,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z1,Z2,I), line(Z1,_,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z3,Z2,I), line(Z1,Z3,I), I<N, maxlevel(N).
tranedg(Z1,Z2,I):-naedg(Z1,Z2,I), point(Z1,I), I<N, maxlevel(N).

edg(Z1,Z2,I+1):-tranedg(Z1,Z2,I), square(Z2,_,_,_,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z3,I), square(Z2,Z3,_,_,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z3,I), square(Z2,_,Z3,_,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z3,I), square(Z2,_,_,Z3,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z2,I), triang(Z2,_,_,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z3,I), triang(Z2,Z3,_,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z3,I), triang(Z2,_,Z3,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z2,I), line(Z2,_,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z3,I), line(Z2,Z3,I), I<N, maxlevel(N).
edg(Z1,Z2,I+1):-tranedg(Z1,Z2,I), point(Z2,I), I<N, maxlevel(N).

points(Z1,I+1):-square(Z1,_,_,_,I), I<N, maxlevel(N).
points(Z1,I+1):-triang(Z1,_,_,I), I<N, maxlevel(N).
points(Z1,I+1):-line(Z1,_,I), I<N, maxlevel(N).
points(Z1,I+1):-point(Z1,I), I<N, maxlevel(N).
walk(0,I+1):-square(_,_,_,_,I), I<N, maxlevel(N).
walk(0,I+1):-triang(_,_,_,I), I<N, maxlevel(N).
walk(0,I+1):-line(_,_,I), I<N, maxlevel(N).
#show edg/3.
#show square/5.
#show triang/4.
#show line/3.
#show sing/2.

%edg(Z1,Z5,1):-edg(Z1,Z5,0), square(Z1,_,_,_,0), square(Z5,_,_,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z1,Z6,0), square(Z1,_,_,_,0), square(Z5,Z6,_,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z1,Z7,0), square(Z1,_,_,_,0), square(Z5,_,Z7,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z1,Z8,0), square(Z1,_,_,_,0), square(Z5,_,_,Z8,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z2,Z5,0), square(Z1,Z2,_,_,0), square(Z5,_,_,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z2,Z6,0), square(Z1,Z2,_,_,0), square(Z5,Z6,_,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z2,Z7,0), square(Z1,Z2,_,_,0), square(Z5,_,Z7,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z2,Z8,0), square(Z1,Z2,_,_,0), square(Z5,_,_,Z8,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z3,Z5,0), square(Z1,_,Z3,_,0), square(Z5,_,_,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z3,Z6,0), square(Z1,_,Z3,_,0), square(Z5,Z6,_,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z3,Z7,0), square(Z1,_,Z3,_,0), square(Z5,_,Z7,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z3,Z8,0), square(Z1,_,Z3,_,0), square(Z5,_,_,Z8,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z4,Z5,0), square(Z1,_,_,Z4,0), square(Z5,_,_,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z4,Z6,0), square(Z1,_,_,Z4,0), square(Z5,Z6,_,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z4,Z7,0), square(Z1,_,_,Z4,0), square(Z5,_,Z7,_,0), Z1!=Z5.
%edg(Z1,Z5,1):-edg(Z4,Z8,0), square(Z1,_,_,Z4,0), square(Z5,_,_,Z8,0), Z1!=Z5.

%edg(Z1,Z5,1):-edg(Z1,Z5,0), square(Z1,_,_,_,0), triang(Z5,_,_,0).
%edg(Z1,Z5,1):-edg(Z1,Z6,0), square(Z1,_,_,_,0), triang(Z5,Z6,_,0).
%edg(Z1,Z5,1):-edg(Z1,Z7,0), square(Z1,_,_,_,0), triang(Z5,_,Z7,0).

%edg(Z1,Z5,1):-edg(Z2,Z5,0), square(Z1,Z2,_,_,0), triang(Z5,_,_,0).
%edg(Z1,Z5,1):-edg(Z2,Z6,0), square(Z1,Z2,_,_,0), triang(Z5,Z6,_,0).
%edg(Z1,Z5,1):-edg(Z2,Z7,0), square(Z1,Z2,_,_,0), triang(Z5,_,Z7,0).

%edg(Z1,Z5,1):-edg(Z3,Z5,0), square(Z1,_,Z3,_,0), triang(Z5,_,_,0).
%edg(Z1,Z5,1):-edg(Z3,Z6,0), square(Z1,_,Z3,_,0), triang(Z5,Z6,_,0).
%edg(Z1,Z5,1):-edg(Z3,Z7,0), square(Z1,_,Z3,_,0), triang(Z5,_,Z7,0).

%edg(Z1,Z5,1):-edg(Z4,Z5,0), square(Z1,_,_,Z4,0), triang(Z5,_,_,0).
%edg(Z1,Z5,1):-edg(Z4,Z6,0), square(Z1,_,_,Z4,0), triang(Z5,Z6,_,0).
%edg(Z1,Z5,1):-edg(Z4,Z7,0), square(Z1,_,_,Z4,0), triang(Z5,_,Z7,0).


%edg(Z1,Z5,1):-edg(Z1,Z5,0), square(Z1,_,_,_,0), line(Z5,_,0).
%edg(Z1,Z5,1):-edg(Z1,Z6,0), square(Z1,_,_,_,0), line(Z5,Z6,0).

%edg(Z1,Z5,1):-edg(Z2,Z5,0), square(Z1,Z2,_,_,0), line(Z5,_,0).
%edg(Z1,Z5,1):-edg(Z2,Z6,0), square(Z1,Z2,_,_,0), line(Z5,Z6,0).

%edg(Z1,Z5,1):-edg(Z3,Z5,0), square(Z1,_,Z3,_,0), line(Z5,_,0).
%edg(Z1,Z5,1):-edg(Z3,Z6,0), square(Z1,_,Z3,_,0), line(Z5,Z6,0).

%edg(Z1,Z5,1):-edg(Z4,Z5,0), square(Z1,_,_,Z4,0), line(Z5,_,0).
%edg(Z1,Z5,1):-edg(Z4,Z6,0), square(Z1,_,_,Z4,0), line(Z5,Z6,0).


%edg(Z1,Z5,1):-edg(Z1,Z5,0), square(Z1,_,_,_,0), point(Z5,0).
%edg(Z1,Z5,1):-edg(Z2,Z5,0), square(Z1,Z2,_,_,0), point(Z5,0).
%edg(Z1,Z5,1):-edg(Z3,Z5,0), square(Z1,_,Z3,_,0), point(Z5,0).
%edg(Z1,Z5,1):-edg(Z4,Z5,0), square(Z1,_,_,Z4,0), point(Z5,0).





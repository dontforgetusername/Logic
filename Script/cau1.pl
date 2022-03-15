male(princePhillip).
male(princeCharles).
male(captainMarkPhillips).
male(timothyLaurence).
male(princeAndrew).
male(princeEdward).
male(princeWilliam).
male(princeHarry).
male(peterPhillips).
male(mikeTindall).
male(jamesViscountSevern).
male(princeGeorge).

female(queenElizabethII).
female(princessDiana).
female(camillaParkerBowles).
female(princessAnne).
female(sarahFerguson).
female(sophieRhys-jones).
female(kateMiddleton).
female(autumnKelly).
female(zaraPhillips).
female(princessBeatrice).
female(princessEugenie).
female(ladyLouiseMountbattenWindsor).
female(princessCharlotte).
female(savannahPhillips).
female(islaPhillips).
female(miaGraceTindall).

married(queenElizabethII, princePhillip).
married(camillaParkerBowles, princeCharles).
married(princessAnne, timothyLaurence).
married(sophieRhys-jones, princeEdward).
married(kateMiddleton, princeWilliam).
married(zaraPhillips, mikeTindall).
married(autumnKelly, peterPhillips).

divorced(princessDiana, princeCharles).
divorced(princessAnne, captainMarkPhillips).
divorced(sarahFerguson, princeAndrew).

parent(queenElizabethII, princeCharles).
parent(queenElizabethII, princessAnne).
parent(queenElizabethII, princeAndrew).
parent(queenElizabethII, princeEdward).
parent(princePhillip, princeCharles).
parent(princePhillip, princessAnne).
parent(princePhillip, princeAndrew).
parent(princePhillip, princeEdward).

parent(princessDiana, princeWilliam).
parent(princessDiana, princeMarry).
parent(princeCharles, princeWilliam).
parent(princeCharles, princeHarry).

parent(captainMarkPhillips, peterPhillips).
parent(captainMarkPhillips, zaraPhillips).
parent(princessAnne, peterPhillips).
parent(princessAnne, zaraPhillips).

parent(sarahFeguson, princessBeatrice).
parent(sarahFeguson, princessEugenie).
parent(princeAndrew, princessBeatrice).
parent(princeAndrew, princessEugenie).

parent(sophieRhys-jones, jamesViscountSevern).
parent(sophieRhys-jones, ladyLouiseMountbattenWindsor).
parent(princeEdward, jamesViscountSevern).
parent(princeEdward, ladyLouiseMountbattenWindsor).

parent(princeWilliam, princeGeorge).
parent(princeWilliam, princessCharlotte).
parent(kateMiddleton, princeGeorge).
parent(kateMiddleton, princessCharlotte).

parent(autumnKelly, savannahPhillips).
parent(autumnKelly, islaPhillips).
parent(peterPhillips, savannahPhillips).
parent(peterPhillips, islaPhillips).

parent(zaraPhillips, miaGraceTindall).
parent(mikeTindall, miaGraceTindall).

husband(X, Wife) :- married(Wife, X).
wife(X, Husband) :- married(X, Husband).

father(X, Child) :- parent(X, Child),male(X).
mother(X, Child) :- parent(X, Child),female(X).
child(Child, Parent) :- parent(Parent, Child).
son(Child, Parent) :- parent(Parent, Child),male(Child).
daughter(Child, Parent) :- parent(Parent, Child),female(Child).

grandparent(GP, GC) :- parent(GP, X),parent(X, GC).
grandmother(GM, GC) :- parent(GM, X),parent(X, GC),female(GM).
grandfather(GF, GC) :- parent(GF, X),parent(X,GC),male(GF).
grandchild(GC, GP) :- parent(GP, X),parent(X, GC).
grandson(GS, GP) :- parent(GP, X),parent(X, GS),male(GS).
granddaughter(GD, GP) :- parent(GP, X),parent(X, GD),female(GD).

sibling(X, Y) :- father(W, X),father(W, Y),dif(X, Y).
brother(X, Sibling) :- male(X),sibling(X, Sibling),dif(X, Sibling).
sister(X, Sibling) :- female(X),sibling(X, Sibling),dif(X, Sibling).

aunt(X, NieceNephew) :- sibling(Z, X),parent(Z, NieceNephew), female(X),dif(Z, X).
uncle(X, NieceNephew) :- sibling(Z, X),parent(Z, NieceNephew), male(X),dif(Z, X).
niece(X, AuntUncle) :- daughter(X, Z),sibling(Z, AuntUncle), dif(Z, AuntUncle).
nephew(X, AuntUncle) :- son(X, Z), sibling(Z, AuntUncle), dif(Z, AuntUncle).
































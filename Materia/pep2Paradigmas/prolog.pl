isIn(X, [X|_]):-!.
isIn(X, [_|Tails]):-
	isIn(X, Tails).

insert(0, X, Lista, [X|Lista]).
insert(Pos, X, [H|T], [H|Resultado]):-
	PosSig is Pos - 1,
	insert(PosSig, X, T, Resultado).

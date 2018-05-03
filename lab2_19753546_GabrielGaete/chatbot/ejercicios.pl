size(0, []).
size(NUM, [_|COLA]):- size(N1, COLA), NUM is N1+1.

factorial(0, 1).
factorial(NUMERO, RESULTADO):- NUMERO > 0, N1 is NUMERO-1, factorial(N1, RESULTADO2), RESULTADO is RESULTADO2 * NUMERO.

resto([_|COLA], COLA).

cons(X, [CABEZA|COLA], [X | [CABEZA|COLA]]).

pertenece(ELEMENTO, [ELEMENTO |_]).
pertenece(ELEMENTO, [_|COLA]):- pertenece(ELEMENTO, COLA).

conc([], LISTA, LISTA).
conc([_|L1], L2, [_|L3]):- conc(L1, L2, L3).

inversaAux([], L2, L2).
inversaAux([CABEZA|COLA], LISTA, LISTAaux):- inversaAux(COLA, LISTA, [CABEZA|LISTAaux]).

inversa(L1, L2):- inversaAux(L1, L2, []).

palindromo(L1):- reverse(L1, L1).

penultimo(ELEMENTO, [ELEMENTO, _]).
penultimo(X, [_|COLA]):- penultimo(X, COLA).



%% COMIENZO LABORATORIO.
compareList([CABEZA|COLA], [CABEZA|COLA]).
crearMensajeAux(FECHA, AUTOR, MENSAJE, LISTA):- compareList(LISTA, [FECHA, AUTOR, MENSAJE]).
crearMensaje(AUTOR, MENSAJE, RESULTADO):- 
						get_date_time_value(hour, FECHA),
						crearMensajeAux(FECHA, AUTOR, MENSAJE, RESULTADO).

%% Obtener la hora del sistema.
%% Ejemplos de uso:
%% ?- get_date_time_value(day, X).
%% X = 29.

%% ?- get_date_time_value(year, X).
%% X = 2014.

%% ?- get_date_time_value(date, X).
%% X = date(2014, 3, 29).

get_date_time_value(Key, Value) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(Key, DateTime, Value).
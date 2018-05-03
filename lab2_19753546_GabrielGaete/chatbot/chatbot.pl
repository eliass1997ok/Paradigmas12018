capitalRegional(arica).
capitalRegional(iquique).
capitalRegional(antofagasta).
capitalRegional(copiapo).
capitalRegional(la_serena).
capitalRegional(valparaiso).
capitalRegional(rancagua).
capitalRegional(talca).
capitalRegional(concepcion).
capitalRegional(arica).
capitalRegional(arica).
capitalRegional(arica).
capitalRegional(arica).
capitalRegional(arica).

compareList([Head|Tails], [Head|Tails]).

%% CONSTRUCTOR TDA MENSAJE
crearMensajeAux(FECHA, AUTOR, MENSAJE, LISTA):- compareList(LISTA, [FECHA, AUTOR, MENSAJE]).

crearMensaje(AUTOR, MENSAJE, RESULTADO):- 
	get_date_time_value(day, DAY),
	get_date_time_value(month, MONTH),
	get_date_time_value(year, YEAR),
	string_concat(DAY,"/", AUX1),
	string_concat(MONTH, "/", AUX2),
	string_concat(AUX1, AUX2, AUX3),
	string_concat(AUX3,YEAR, FECHA),

	crearMensajeAux(FECHA, AUTOR, MENSAJE, RESULTADO).

%PERTENENCIA TDA MENSAJE
isMessage([First, Second, Third]):- string(First), string(Second), string(Third).

%SELECTORES TDA MENSAJE
getDateMessage(Message, Date):- isMessage(Message), nth0(0, Message, Date).
getAutorMessage(Message, Autor):- isMessage(Message), nth0(1, Message, Autor).
getContentMessage(Message, Content):- isMessage(Message), nth0(2, Message, Content).

%MODIFICADORES TDA MENSAJE
setDateMessage(Message, Day, Month, Year, NewMessage):- 
	isMessage(Message),
	string_concat(Day,"/", AUX1),
	string_concat(Month, "/", AUX2),
	string_concat(AUX1, AUX2, AUX3),
	string_concat(AUX3,Year, FECHA),

	nth0(1, Message, Autor),
	nth0(2, Message, Content),

	crearMensajeAux(FECHA, Autor, Content, NewMessage).

setAutorMessage(Message, Autor, NewMessage):- 
	isMessage(Message),
	nth0(0, Message, Date),
	nth0(2, Message, Content),

	crearMensajeAux(Date, Autor, Content, NewMessage).

setContentMessage(Message, Content, NewMessage):- 
	isMessage(Message),
	nth0(0, Message, Date),
	nth0(1, Message, Autor),

	crearMensajeAux(Date, Autor, Content, NewMessage).

%%FUNCIONES QUE OPERAN SOBRE EL TDA
messageToLog(CurrentLog, Message, UpdatedLog):-
	isMessage(Message),
	reverse([CurrentLog], ReversedCurrentLog),
	append([], [Message], EncapsulatedMessage),
	append(EncapsulatedMessage, [ReversedCurrentLog], ReversedUpdatedLog),
	reverse(ReversedUpdatedLog, UpdatedLog).



%% COMIENZO LABORATORIO.

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
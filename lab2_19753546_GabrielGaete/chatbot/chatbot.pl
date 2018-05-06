capitalRegional("Arica", "$32.200 pesos").
capitalRegional("Iquique", "$30.100 pesos").
capitalRegional("Antofagasta", "$21.600 pesos").
capitalRegional("Copiapo", "$15.000 pesos").
capitalRegional("La Serena", "$9.100 pesos").
capitalRegional("Valparaiso", "$6.500 pesos").
capitalRegional("Rancagua", "$3.000 pesos").
capitalRegional("Talca", "$6.500 pesos").
capitalRegional("Concepcion", "$13.900 pesos").
capitalRegional("Temuco", "$14.900 pesos").
capitalRegional("Puerto Montt", "$19.900 pesos").
capitalRegional("Coyhaique", "$33.000 pesos").
capitalRegional("Punta Arenas", "$15.000 pesos").
capitalRegional("Valdivia", "$17.900 pesos").

listadoCapitales(["Arica", "Iquique", "Antofagasta", "Copiapo", "La Serena", "Valparaiso", "Rancagua", "Talca", "Concepcion", "Temuco", "Puerto Montt", "Coyhaique", "Punta Arenas", "Valdivia"]).

afirmacion("Sí").
afirmacion("sí").
afirmacion("Si").
afirmacion("si").
afirmacion("Sí.").
afirmacion("sí.").
afirmacion("Si.").
afirmacion("si.").

negacion("No").
negacion("no").
negacion("No.").
negacion("no.").

test(Wea):-
	string(Wea), !;
	number(Wea).

compareList([Head|Tails], [Head|Tails]).
createDate(Date):-
	get_date_time_value(day, DAY),
	get_date_time_value(month, MONTH),
	get_date_time_value(year, YEAR),
	string_concat(DAY,"/", AUX1),
	string_concat(MONTH, "/", AUX2),
	string_concat(AUX1, AUX2, AUX3),
	string_concat(AUX3,YEAR, Date).
	
chatbot( [
		 ["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], 
		 [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", "¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", "y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."],
		 [[0, 0]],
		 ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"],
		 ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"],
		 [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "]
		 ]
		).

%% CONSTRUCTOR TDA MENSAJE
crearMensajeAux(FECHA, AUTOR, MENSAJE, LISTA):- compareList(LISTA, [FECHA, AUTOR, MENSAJE]).

crearMensaje(AUTOR, MENSAJE, RESULTADO):- 
	createDate(FECHA),
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
	append(CurrentLog, [Message], UpdatedLog), !.
	%% write(UpdatedLog).
	%% reverse(CurrentLog, ReversedCurrentLog),
	%% append([], [Message], EncapsulatedMessage),
	%% append(EncapsulatedMessage, [ReversedCurrentLog], ReversedUpdatedLog),
	%% reverse(ReversedUpdatedLog, UpdatedLog).

createAnswer(String, Precio, RandomNumber, Chatbot, Answer):-
	nth0(5, Chatbot, ListAnswersBeforePrice),
	length(ListAnswersBeforePrice, ListAnswersBeforePriceLength),
	ListAnswersBeforePricePosition is RandomNumber mod ListAnswersBeforePriceLength,
	nth0(ListAnswersBeforePricePosition, ListAnswersBeforePrice, BeforePrice),
	string_concat(String, BeforePrice, ConcatenedWithoutPrice),
	string_concat(ConcatenedWithoutPrice, Precio, FinalString),
	crearMensaje("Bot", FinalString, Answer).
	%% nth0(6, Chatbot, ListAnswersAfterPrice),
	%% nth0(RandomNumber, ListAnswersAfterPrice, AfterPrice),
	%% string_concat(ConcatenedUntilPrice, AfterPrice, Answer).

%% http://obvcode.blogspot.cl/2008/11/working-with-strings-in-prolog.html
sublist(S, L) :-
  append(_, L2, L),
  append(S, _, L2).
contains(A, B) :-
  string(A),
  string(B),
  name(A, AA),
  name(B, BB),
  contains(AA, BB).
contains(A, B) :-
  atom(A),
  name(A, AA),
  contains(AA, B).
contains(A, B) :-
  sublist(B, A),
  B \= [].

isCityOnMessage(String, City):-
	%% ( contains(String, Head) -> City = Head ; isCityOnMessage(String, Tails, _) ).
	capitalRegional(City, _),
	contains(String, City).
	%% nth0(0, Tails, Ciudad),
	%% isCityOnMessage(String, Tails, Ciudad).

determineAnswer(String, Chatbot, NumberRandom, Answer):-
	%% listadoCapitales(ListaCapitales),
	isCityOnMessage(String, Ciudad),
	%% write("acá voy"),
	%% split_string(String, " ", "", SplitedMessage2),
	%% intersection(SplitedMessage2, ListaCapitales, [First|_]),
	%% write(Ciudad), 
	capitalRegional(Ciudad, Precio),
	createAnswer(Ciudad, Precio, NumberRandom, Chatbot, Answer),
	!;
	%% write("Hola"),
	negacion(String),
	nth0(3, Chatbot, Negations),
	length(Negations, NegationsLength),
	NegationsPosition is NumberRandom mod NegationsLength,
	nth0(NegationsPosition, Negations, Response1),
	crearMensaje("Bot", Response1, Answer), !;
	afirmacion(String),
	nth0(4, Chatbot, Affirmations),
	length(Affirmations, AffirmationsLength),
	AffirmationsPosition is NumberRandom mod AffirmationsLength,
	nth0(AffirmationsPosition, Affirmations, Response2),
	crearMensaje("Bot", Response2, Answer), !.

beginDialog(Chatbot, InputLog, Seed, OutputLog):-
	chatbot(Chatbot),
	nth0(0, Chatbot, Greetings),
	set_random(seed(Seed)),
	NumberRandom is random(Seed),
	length(Greetings, GreetingsLength),
	Position is  NumberRandom mod GreetingsLength,
	nth0(Position, Greetings, Content),
	%% IDRatePosition -> SOLO PARA ESTE CASO ES 2!!! FIJARSE EN ESTRUCTURA CHATBOT.
	nth0(2, Chatbot, ListIDRates),
	reverse(ListIDRates, ReversedListIDRates),
	nth0(0, ReversedListIDRates, PairIDRate),
	createDate(Date),
	append(InputLog, [[Date, "BeginDialog", "ID-Rate:", PairIDRate]], BeginDialogLog),
	crearMensaje("Bot", Content, Result),

	messageToLog(BeginDialogLog, Result, OutputLog), !.

%% try(R):-
%% 	crearMensaje("hola", "sadasd", S),
%% 	isMessage(S).

sendMessage(Msg, Chatbot, InputLog, Seed, OutputLog):-
	%% split_string(Msg, " ", "", SplitedMessage),
	%% length(SplitedMessage, ListSize),
	%% ListSize = 1,
	%% string(Msg),
	%% write("hola mundo"),
	%% chatbot(Chatbot),
	%% set_random(seed(Seed)),
	%% NumberRandom is random(Seed),
	%% nth0(0, SplitedMessage, String),
	%% crearMensaje("Usuario", Msg, Result),
	%% messageToLog(InputLog, Result, ModifiedLog),
	%% determineAnswer(SplitedMessage, Chatbot, NumberRandom, Answer),
	%% messageToLog(ModifiedLog, Answer, OutputLog), !;
	
	%% length(SplitedMessage2, ListSize2),
	%% ListSize2 > 1,
	%% string(Msg),
	%% write(Msg),
	chatbot(Chatbot),
	set_random(seed(Seed)),
	NumberRandom is random(Seed),
	%% nth0(0, Capital, String2),
	crearMensaje("Usuario", Msg, Result2),
	%% isMessage(Result2),
	%% write(Result2),
	messageToLog(InputLog, Result2, ModifiedLog2), 
	determineAnswer(Msg, Chatbot, NumberRandom, Answer2),
	%% write(Answer2),
	messageToLog(ModifiedLog2, Answer2, OutputLog).

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
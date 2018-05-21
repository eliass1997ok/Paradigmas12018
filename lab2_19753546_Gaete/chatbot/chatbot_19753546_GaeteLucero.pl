:-[hechos].

%%==============================+
%% DOMINIOS
%%==============================+
%% palabra 		= string
%% palabras 	= lista de strings
%% estructura   = lista de palabras
%% seed         = integer
%% 
%%==============================+
%% PREDICADOS
%%==============================+
%% 
%%  createDate(palabra).
%%  listToString(palabras, palabra, palabra).
%%  logToStrAux(estructura, palabra, palabra).
%%  recursiveTest(palabras, estructura, estructura, seed, estructura).
%%  crearMensaje(palabra, palabra, palabra, palabras).
%%  crearMensaje(palabra, palabra, palabras).
%%  isMessage(palabras).
%%  getDateMessage(palabras, palabra).
%%  getAutorMessage(palabras, palabra).
%%  getContentMessage(palabras, palabra).
%%  setDateMessage(palabras, palabra, palabras).
%%  setAutorMessage(palabras, palabra, palabras).
%%  setContentMessage(palabras, palabra, palabras).
%%  messageToLog(estructura, palabras, estructura).
%%  createAnswer(palabra, palabra, seed, estructura, palabras).
%%  sublist(palabras, palabras).
%%  contains(palabra, palabras).
%%  isCityOnMessage(palabra, palabra).
%%  answerToName(palabra, estructura, seed, palabras).
%%  didntUnderstood(estructura, seed, palabras).
%%  determineAnswer(palabra, estructura, seed, estructura, palabras).
%%  beginDialog(estructura, estructura, seed, estructura)
%%  sendMessage(palabra, estructura, estructura, seed, estructura).
%%  endDialog(estructura, estructura, seed, estructura).
%%  logToStr(estructura, palabra).
%%  test(palabras, estructura, estructura, seed, estructura).
%%  writeLog(estructura).
%%  get_date_time_value(palabra, seed).
%%  
%%==============================+
%% OBJETIVOS (principal)
%%==============================+
%%      beginDialog(estructura, estructura, seed, estructura)
%%     	"El chatbot presenta un mensaje de bienvenida en el OutputLog, dado cierto InputLog de entrada y un número de semilla"
%% 
%% 		sendMessage(palabra, estructura, estructura, seed, estructura)
%%     	"La frase ingresada como msg gatilla una respuesta del chatbot, en base a un InputLog, generando un OutputLog"
%% 
%% 		endDialog(estructura, estructura, seed, estructura)
%% 		"El chatbot presenta un mensaje de despedida en el OutputLog, dado cierto InputLog de entrada y un número de semilla"
%% 
%% 		logToStr(estructura, palabra)
%% 		"El Log se puede representar por un string"
%%
%% 		test(palabras, estructura, estructura, seed, estructura)
%% 		"Dadas ciertas palabras, el Chatbot produce un flujo conversacional en el OutputLog, a partir de un InputLog y una semilla"
%% 
%%==============================+
%% Clausulas de Horn: RF
%%==============================+
%% 
%% HECHOS:
%% (en archivo "hechos.pl")
%% 
%% listToString([], FinalString, FinalString):-!.
%% logToStrAux([], StrRep, StrRep):-!.
%% documents([], []).
%% 
%% REGLAS:
%% 

%%
%% Permite determinar la hora del sistema
%%
%% Date: Corresponde a un string con la fecha y hora del sistema
%%
%% Ejemplo:
%% 		createDate(Date).
%%
%% 		Date = "[19/5/2018, 0:2]"     %%Indicando que son las 00:02
%%
createDate(Date):-
	get_date_time_value(day, DAY),
	get_date_time_value(month, MONTH),
	get_date_time_value(year, YEAR),
	get_date_time_value(hour, HOUR),
	get_date_time_value(minute, MINUTE),
	string_concat("[", DAY, DAYTOCONCAT),
	string_concat(DAYTOCONCAT,"/", AUX1),
	string_concat(MONTH, "/", AUX2),
	string_concat(AUX1, AUX2, AUX3),
	string_concat(AUX3,YEAR, AUX4),
	string_concat(AUX4, ", ", AUX5),
	string_concat(AUX5, HOUR, AUX6),
	string_concat(AUX6, ":", AUX7),
	string_concat(AUX7, MINUTE, AUX8),
	string_concat(AUX8, "]", Date).

%%
%% Permite transformar una lista de strings a un solo string.
%%
%% Head: Corresponde a la cabeza de la lista de strings.
%% Tails: Corresponde a la cola de la lista de strings.
%% InitialString: Corresponde al string en el que se irán concatenando las palabras. Incialmente está vacío.
%% FinalString: Corresponde al string final, el cual representa a toda la lista.
%%
%% Ejemplo:
%% 		listToString(["Hola", "Mundo"], "", FinalString).
%%
%% 		FinalString = " Hola Mundo"
%%
listToString([], FinalString, FinalString):-!.
listToString([Head|Tails], InitialString, FinalString):-
	string_concat(InitialString, " ", StringAux),
	string_concat(StringAux, Head, String),
	listToString(Tails, String, FinalString).

%%
%% Permite transformar una estructura Log a un string.
%%
%% Log: Corresponde a la estructura Log a transformar a string.
%% InitialString: Corresponde al string en el que se irán concatenando las palabras. Incialmente está vacío.
%% StrRep: Corresponde al string final, el cual representa a toda la lista.
%%
%% Ejemplo:
%% 		logToStrAux([["hola"], ["mundo"]], "", StrRep).
%%
%% 		StrRep = "\n hola\n mundo".        %%Los saltos de línea permitirán separar cada mensaje del log.
%%										   %%El formato "limpio", sin saltos de línea, puede verse al usar el predicado write(S).
%%
logToStrAux([], StrRep, StrRep):-!.
logToStrAux(Log, InitialString, StrRep):-
	head(Log, Head),
	tails(Log, Tails),
	listToString(Head, "", ElementString),
	string_concat(InitialString, "\n", ConcatenedString1),
	string_concat(ConcatenedString1, ElementString, ConcatenedString2),
	logToStrAux(Tails, ConcatenedString2, StrRep).	

%%
%% Permite determinar el flujo de conversación a partir de una lista de strings
%%
%% Head: Corresponde a la cabeza de la lista de strings.
%% Tails: Corresponde a la cola de la lista de strings.
%% Chatbot: Corresponde a una estructura Chatbot.
%% CurrentLog: Corresponde a una estructura Log "actual", la cual se actualiza por cada mensaje.
%% Seed: Corresponde a un número entero, el cual permite generar respuestas aleatorias.
%% FinalLog: Corresponde al Log final, el cual contiene todo el flujo de la conversación.
%%
%% Ejemplo:
%% 		recursiveTest(["Quiero viajar a Valparaíso", "sí"], Chatbot, CurrentLog, 20, FinalLog).
%%
%%      Chatbot = [["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], [["0", "0"]], ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"], ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "], ["Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?", "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?"], ["Hasta luego, espero haber sido de ayuda en esta oportunidad.", "Hasta la próxima, espero haberte ayudado."]]
%%      CurrentLog = []
%%      FinalLog = [["[19/5/2018, 1:0]", "Usuario:", "Quiero viajar a Valparaíso"], ["[19/5/2018, 1:0]", "Bot:", "Valparaíso es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta $6.500 pesos ¿Desea confirmar su destino?"], ["[19/5/2018, 1:0]", "Usuario:", "sí"], ["[19/5/2018, 1:0]", "Bot:", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], ["[19/5/2018, 1:0]", "Bot:", "Hasta la próxima, espero haberte ayudado."], ["[19/5/2018, 1:0]", "EndDialog", "ID"|...]]
%%
recursiveTest([], Chatbot, InputLog, Seed, FinalLog):-
	endDialog(Chatbot, InputLog, Seed, FinalLog),!.

recursiveTest([Head|Tails], Chatbot, CurrentLog, Seed, FinalLog):-
	sendMessage(Head, Chatbot, CurrentLog, Seed, LogToAppend),
	recursiveTest(Tails, Chatbot, LogToAppend, Seed, FinalLog).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%                        %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% TIPO DE DATO ABSTRACTO %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%                        %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% Implementación TDA Mensaje
%%

%%%
%% 1) Representación:
%% Para la representación de mensajes, se ocupará una lista de 3 elementos, en la cual se utilizará una fecha, un
%% remitente, y un 'mensaje' propiamente tal.
%% Ejemplo: 
%%         TDA Mensaje -> ["Fecha", "Autor", "Contenido"]
%%
%%
%% 2) Constructores:
%% crearMensaje: Constructor del TDA Mensaje.
%% Autor: Corresponde a un string que representa al autor del mensaje.
%% Mensaje: Corresponde a un string que representa el contenido del mensaje.
%% Resultado: Corresponde a la representación del TDA.
%%
crearMensaje(AUTOR, MENSAJE, RESULTADO):- 
	createDate(FECHA),
	compareList([FECHA, AUTOR, MENSAJE], RESULTADO).

%%%
%% crearMensaje: Constructor del TDA Mensaje. Variación que permite ingresar una fecha mediante variable universalmente cuantificada.
%% Fecha: Corresponde a un string que representa la fecha del mensaje.
%% Autor: Corresponde a un string que representa al autor del mensaje.
%% Mensaje: Corresponde a un string que representa el contenido del mensaje.
%% Resultado: Corresponde a la representación del TDA.
%%
crearMensaje(FECHA, AUTOR, MENSAJE, RESULTADO):- 
	compareList([FECHA, AUTOR, MENSAJE], RESULTADO).

%%%
%% 3) Pertenencia:
%% isMessage: predicado de pertenencia 
%% First: Corresponde al primer valor de una lista de tres elementos, a verificar si es string.
%% Second: Corresponde al segundo valor de una lista de tres elementos, a verificar si es string.
%% Third: Corresponde al tercer valor de una lista de tres elementos, a verificar si es string.
%%
isMessage([First, Second, Third]):- string(First), string(Second), string(Third).

%%%
%% 4) Selectores:
%% getDate: permite obtener la fecha de un mensaje.
%%
%% Message: Corresponde al TDA Mensaje.
%% Date: Corresponde a un string que representa la fecha del mensaje.
%% 
%% getAutorMessage: permite obtener el autor de un mensaje.
%%
%% Message: Corresponde al TDA Mensaje.
%% Autor: Corresponde a un string que representa al autor de un mensaje.
%%
%% getContentMessage: permite obtener el contenido de un mensaje.
%%
%% Message: Corresponde al TDA Mensaje.
%% Content: Corresponde al contenido del mensaje.
%%
getDateMessage(Message, Date):- isMessage(Message), nth0(0, Message, Date).
getAutorMessage(Message, Autor):- isMessage(Message), nth0(1, Message, Autor).
getContentMessage(Message, Content):- isMessage(Message), nth0(2, Message, Content).

%%%
%% 5) Modificadores:
%% setDateMessage: permite establecer la fecha de un mensaje.
%%
%% Message: Corresponde al TDA Mensaje.
%% Date: Corresponde a un string que representa la fecha del mensaje.
%% NewMessage: Corresponde al "nuevo" mensaje, con la nueva fecha establecida.
%% 
%% setAutorMessage: permite establecer el autor de un mensaje.
%%
%% Message: Corresponde al TDA Mensaje.
%% Autor: Corresponde a un string que representa al autor de un mensaje.
%% NewMessage: Corresponde al "nuevo" mensaje, con el nuevo autor establecido.
%%
%% setContentMessage: permite establecer el contenido de un mensaje.
%%
%% Message: Corresponde al TDA Mensaje.
%% Content: Corresponde al contenido del mensaje.
%% NewMessage: Corresponde al "nuevo" mensaje, con el nuevo contenido establecido.
%%
setDateMessage(Message, Date, NewMessage):- 
	isMessage(Message),

	nth0(1, Message, Autor),
	nth0(2, Message, Content),

	crearMensaje(Date, Autor, Content, NewMessage).

setAutorMessage(Message, Autor, NewMessage):- 
	isMessage(Message),
	nth0(0, Message, Date),
	nth0(2, Message, Content),

	crearMensaje(Date, Autor, Content, NewMessage).

setContentMessage(Message, Content, NewMessage):- 
	isMessage(Message),
	nth0(0, Message, Date),
	nth0(1, Message, Autor),

	crearMensaje(Date, Autor, Content, NewMessage).

%%%
%% 6) "Funciones" que operan sobre el TDA:
%%
%% messageToLog permite añadir un TDA mensaje a la estructura de LOG.
%% 
%% CurrentLog: Log sin el mensaje añadido.
%% Message: Mensaje a añadir.
%% UpdatedLog: Log con el mensaje añadido.
%%
messageToLog(CurrentLog, Message, UpdatedLog):-
	isMessage(Message),
	append(CurrentLog, [Message], UpdatedLog), !.

%%%
%% Permite crear una respuesta por parte del chatbot, en la cual se le entrega el valor del viaje al usuario.
%%
%% String: Palabra que representa la ciudad a la que el usuario desea viajar.
%% Precio: String que representa el valor del pasaje a la ciudad a la que el usuario desea viajar.
%% RandomNumber: Corresponde a un número que permite seleccionar respuestas al azar del chatbot.
%% Chatbot: Corresponde a la estructura Chatbot.
%% Answer: Es la respuesta generada por el Chatbot.
%%
createAnswer(String, Precio, RandomNumber, Chatbot, Answer):-
	nth0(5, Chatbot, ListAnswersBeforePrice),
	length(ListAnswersBeforePrice, ListAnswersBeforePriceLength),
	ListAnswersBeforePricePosition is RandomNumber mod ListAnswersBeforePriceLength,
	nth0(ListAnswersBeforePricePosition, ListAnswersBeforePrice, BeforePrice),
	string_concat(String, BeforePrice, ConcatenedWithoutPrice),
	string_concat(ConcatenedWithoutPrice, Precio, FinalString),
	string_concat(FinalString, " ¿Desea confirmar su destino?", FinalContent),
	crearMensaje("Bot:", FinalContent, Answer).

%%% http://obvcode.blogspot.cl/2008/11/working-with-strings-in-prolog.html
%%%
%% Permite saber si un string está contenido dentro de otro string.
%%
%% S: Corresponde a una lista a saber si es sublista.
%% L: Corresponde a una listas a saber si S está contenida en ella
%%
sublist(S, L) :-
  append(_, L2, L),
  append(S, _, L2).

%%%
%% Permite saber si un string está contenido dentro de otro string.
%%
%% A: Corresponde a un string a saber si es substring de B.
%% B: Corresponde a un string a saber si contiene al string A.
%%
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

%%%
%% Permite saber si un string contiene a una "ciudad"
%%
%% String: Corresponde a string a saber si Ciudad está contenida en él.
%% City: Corresponde a la ciudad que está contenida en el string.
%%
isCityOnMessage(String, City):-
	capitalRegional(City, _),
	contains(String, City).

%%%
%% Permite generar una respuesta por parte del chatbot, a partir de un string con el nombre del usuario.
%%
%% String: Corresponde a un string que contiene el nombre del usuario.
%% Chatbot: Corresponde a una estructura Chatbot.
%% NumberRandom: Corresponde a un número entero, que permite generar una respuesta aleatoria por parte del Chatbot.
%% Answer: Corresponde al mensaje generado por el Chatobot.
%%
answerToName(String, Chatbot, NumberRandom, Answer):-
	nth0(1, Chatbot, ListOfAnswersWithoutName),
	length(ListOfAnswersWithoutName, LengthListOfAnswersWithoutName),
	Position is NumberRandom mod LengthListOfAnswersWithoutName,
	nth0(Position, ListOfAnswersWithoutName, MessageSelected),
	string_concat(String, MessageSelected, ContentOfMessage),
	crearMensaje("Bot:", ContentOfMessage, Answer).

%%%
%% Permite generar una respuesta por parte del chatbot, a partir de un mensaje que no haya sido entendido.
%%
%% Chatbot: Corresponde a una estructura Chatbot.
%% NumberRandom: Corresponde a un número entero, que permite generar una respuesta aleatoria por parte del Chatbot.
%% Answer: Corresponde al mensaje generado por el Chatobot.
%%
didntUnderstood(Chatbot, NumberRandom, Answer):-
	nth0(6, Chatbot, ListOfDontUnderstanding),
	length(ListOfDontUnderstanding, LengthOfDontUnderstandings),
	Position is NumberRandom mod LengthOfDontUnderstandings,
	nth0(Position, ListOfDontUnderstanding, Answer).

%%%
%% Permite determinar qué fue lo expresado por el usuario, con el fin de determinar una respuesta válida.
%%
%% String: Corresponde al string con el contenido del mensaje ingresado por el usuario.
%% Chatbot: Corresponde a una estructura Chatbot.
%% NumberRandom: Corresponde a un número entero, que permite generar una respuesta aleatoria por parte del Chatbot.
%% CurrentLog: Corresponde al log actual. Este log es utilizado para determinar una respuesta.
%% Answer: Corresponde al mensaje generado por el Chatobot.
%%
determineAnswer(String, Chatbot, NumberRandom, CurrentLog, Answer):-
	isCityOnMessage(String, Ciudad),
	capitalRegional(Ciudad, Precio),
	createAnswer(Ciudad, Precio, NumberRandom, Chatbot, Answer), !;

	negacion(String),
	nth0(3, Chatbot, Negations),
	length(Negations, NegationsLength),
	NegationsPosition is NumberRandom mod NegationsLength,
	nth0(NegationsPosition, Negations, Response1),
	crearMensaje("Bot:", Response1, Answer), !;

	afirmacion(String),
	nth0(4, Chatbot, Affirmations),
	length(Affirmations, AffirmationsLength),
	AffirmationsPosition is NumberRandom mod AffirmationsLength,
	nth0(AffirmationsPosition, Affirmations, Response2),
	crearMensaje("Bot:", Response2, Answer), !;

	reverse(CurrentLog, ReversedCurrentLog),
	nth0(2, ReversedCurrentLog, VerifyIfIsTag),
	intersection(VerifyIfIsTag, ["BeginDialog"], ListWithIntersection),
	length(ListWithIntersection, LengthOfListWithIntersection),
	LengthOfListWithIntersection = 1,
	answerToName(String, Chatbot, NumberRandom, Answer),!;

	didntUnderstood(Chatbot, NumberRandom, Answer), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%                              %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% FUNCIONALIDADES OBLIGATORIAS %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%                              %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%
%% Permite iniciar una conversación con el usuario, estableciendo una bienvenida al chat. Además, agrega un indicador
%% de inicio de conversación.
%%
%% Chatbot: Corresponde a una estructura Chatbot.
%% InputLog: Corresponde a una estructura log inicial.
%% Seed: Corresponde a un número entero que permite la generación de respuestas aletorias por parte del Chatbot.
%% OutputLog: Corresponde a una estructura de log final.
%%
%% Ejemplo:
%% 		beginDialog(Chatbot, InputLog, 20, OutputLog).
%%
%%      Chatbot = [["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], [["0", "0"]], ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"], ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "], ["Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?", "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?"], ["Hasta luego, espero haber sido de ayuda en esta oportunidad.", "Hasta la próxima, espero haberte ayudado."]]
%%      InputLog = []
%%      OutputLog = [["[19/5/2018, 16:47]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 16:47]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"]]
%%
beginDialog(Chatbot, InputLog, Seed, OutputLog):-
	chatbot(Chatbot),
	nth0(0, Chatbot, Greetings),
	set_random(seed(Seed)),
	NumberRandom is random(Seed),
	length(Greetings, GreetingsLength),
	Position is  NumberRandom mod GreetingsLength,
	nth0(Position, Greetings, Content),
	nth0(2, Chatbot, ListIDRates),
	reverse(ListIDRates, ReversedListIDRates),
	nth0(0, ReversedListIDRates, PairIDRate),
	nth0(0, PairIDRate, ID),
	createDate(Date),
	append(InputLog, [[Date, "BeginDialog", "ID:", ID]], BeginDialogLog),
	crearMensaje("Bot:", Content, Result),
	messageToLog(BeginDialogLog, Result, OutputLog), !.

%%%
%% Permite intercambiar mensajes entre el usuario y el Chatbot.
%%
%% Msg: Corresponde a un string, el cual representa el mensaje ingresado por el usuario.
%% Chatbot: Corresponde a una estructura Chatbot.
%% InputLog: Corresponde a una estructura log inicial.
%% Seed: Corresponde a un número entero que permite la generación de respuestas aletorias por parte del Chatbot.
%% OutputLog: Corresponde a una estructura de log final.
%%
%% Ejemplo:
%% 		sendMessage("Gabriel", Chatbot, [["[19/5/2018, 16:47]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 16:47]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"]], 20, OutputLog).
%%
%%      Chatbot = [["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], [["0", "0"]], ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"], ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "], ["Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?", "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?"], ["Hasta luego, espero haber sido de ayuda en esta oportunidad.", "Hasta la próxima, espero haberte ayudado."]]
%%      OutputLog = [["[19/5/2018, 16:47]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 16:47]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], ["[19/5/2018, 16:51]", "Usuario:", "Gabriel"], ["[19/5/2018, 16:51]", "Bot:", "Gabriel ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."]].
%%
sendMessage(Msg, Chatbot, InputLog, Seed, OutputLog):-
	chatbot(Chatbot),
	set_random(seed(Seed)),
	NumberRandom is random(Seed),
	crearMensaje("Usuario:", Msg, Result2),
	messageToLog(InputLog, Result2, ModifiedLog2), 
	determineAnswer(Msg, Chatbot, NumberRandom, ModifiedLog2, Answer2),
	messageToLog(ModifiedLog2, Answer2, OutputLog).

%%%
%% Permite finalizar la conversación entre el usuario y el Chatbot.
%%
%% Chatbot: Corresponde a una estructura Chatbot.
%% InputLog: Corresponde a una estructura log inicial.
%% Seed: Corresponde a un número entero que permite la generación de respuestas aletorias por parte del Chatbot.
%% OutputLog: Corresponde a una estructura de log final.
%%
%% Ejemplo:
%% 		endDialog(Chatbot, [["[19/5/2018, 16:47]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 16:47]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], ["[19/5/2018, 16:51]", "Usuario:", "Gabriel"], ["[19/5/2018, 16:51]", "Bot:", "Gabriel ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."]], 20, OutputLog).
%%
%%      Chatbot = [["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], [["0", "0"]], ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"], ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "], ["Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?", "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?"], ["Hasta luego, espero haber sido de ayuda en esta oportunidad.", "Hasta la próxima, espero haberte ayudado."]]
%%      OutputLog = [["[19/5/2018, 16:47]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 16:47]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], ["[19/5/2018, 16:51]", "Usuario:", "Gabriel"], ["[19/5/2018, 16:51]", "Bot:", "Gabriel ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."], ["[19/5/2018, 17:8]", "Bot:", "Hasta la próxima, espero haberte ayudado."], ["[19/5/2018, 17:8]", "EndDialog", "ID", "0"]]
%%
endDialog(Chatbot, InputLog, Seed, OutputLog):-
	chatbot(Chatbot),
	nth0(7, Chatbot, GoodbyeList),
	set_random(seed(Seed)),
	NumberRandom is random(Seed),
	length(GoodbyeList, LengthGoodbyeList),
	Position is NumberRandom mod LengthGoodbyeList,
	nth0(Position, GoodbyeList, GoodbyeText),
	crearMensaje("Bot:", GoodbyeText, GoodbyeMessage),
	messageToLog(InputLog, GoodbyeMessage, ModifiedLog),
	nth0(2, Chatbot, ListIDRates),
	reverse(ListIDRates, ReversedListIDRates),
	nth0(0, ReversedListIDRates, PairIDRate),
	nth0(0, PairIDRate, ID),
	createDate(Date),
	append(ModifiedLog, [[Date, "EndDialog", "ID", ID]], OutputLog).

%%%
%% Permite transformar la estructura de log a un string que el usuario pueda entender.
%%
%% Log: Corresponde a una estructura log.
%% StrRep: Corresponde a la representación del log en forma de string.
%%
%% Ejemplo:
%% 		logToStr([["[19/5/2018, 16:47]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 16:47]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], ["[19/5/2018, 16:51]", "Usuario:", "Gabriel"], ["[19/5/2018, 16:51]", "Bot:", "Gabriel ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."], ["[19/5/2018, 17:8]", "Bot:", "Hasta la próxima, espero haberte ayudado."], ["[19/5/2018, 17:8]", "EndDialog", "ID", "0"]], StrRep).
%%
%%      StrRep = "\n [19/5/2018, 16:47] BeginDialog ID: 0\n [19/5/2018, 16:47] Bot: Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?\n [19/5/2018, 16:51] Usuario: Gabriel\n [19/5/2018, 16:51] Bot: Gabriel ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.\n [19/5/2018, 17:8] Bot: Hasta la próxima, espero haberte ayudado.\n [19/5/2018, 17:8] EndDialog ID 0"
%%
logToStr(Log, StrRep):-
	logToStrAux(Log, "", StrRep).

%%%
%% Permite simular rápidamente una conversación a partir de una lista con mensajes de entrada.
%%
%% User: Corresponde a una lista de strings, siendo estos, los mensajes de entrada del usuario.
%% Chatbot: Corresponde a una estructura Chatbot.
%% InputLog: Corresponde a una estructura log de inicio.
%% Seed: Corresponde a un número entero, el que permite generar respuestas aleatorias por parte del Chatbot.
%% OutputLog: Corresponde a una estructura log de salida.
%%
%% NOTA IMPORTANTE: Si no se especifica entrada de User, prolog evaluará 3 distintas conversaciones, definidas en 
%% hechos.pl. Luego de la 3 conversación evaluada, Prolog evaluará a un usuario "vacío", es decir, un usuario que no 
%% ingresa texto. Por otra parte, a pesar de tener estas definiciones, el usuario final es libre de crear su propio
%% user, ingresando éste como "parámetro" del predicado.
%%
%% Ejemplo:
%% 		test(User, Chatbot, InputLog, 70, OutputLog).
%%
%%      User = ["Gabriel", "Me gustaría tomar un viaje hacia La Serena", "No, mejor no, prefiero viajar a Valparaíso", "Sí"]
%%      Chatbot = [["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], [["0", "0"]], ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"], ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "], ["Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?", "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?"], ["Hasta luego, espero haber sido de ayuda en esta oportunidad.", "Hasta la próxima, espero haberte ayudado."]]
%%      InputLog = []
%%      OutputLog = [["[19/5/2018, 17:26]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 17:26]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], ["[19/5/2018, 17:26]", "Usuario:", "Gabriel"], ["[19/5/2018, 17:26]", "Bot:", "Gabriel y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], ["[19/5/2018, 17:26]", "Usuario:", "Me gustaría tomar un viaje hacia La Serena"], ["[19/5/2018, 17:26]", "Bot:", "La Serena es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta $9.100 pesos ¿Desea confirmar su destino?"], ["[19/5/2018, 17:26]", "Usuario:", "No, mejor no, prefiero viajar a Valparaíso"], ["[19/5/2018, 17:26]", "Bot:", "Valparaíso es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta $6.500 pesos ¿Desea confirmar su destino?"], ["[19/5/2018, 17:26]", "Usuario:", "Sí"], ["[19/5/2018, 17:26]", "Bot:", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], ["[19/5/2018, 17:26]", "Bot:", "Hasta la próxima, espero haberte ayudado."], ["[19/5/2018, 17:26]", "EndDialog", "ID", "0"]]
%%
%%      ;
%%
%%      User = ["Diego", "Me gustaría viajar hacia Punta Arenas", "Sí"]
%%      Chatbot = [["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], [["0", "0"]], ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"], ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "], ["Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?", "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?"], ["Hasta luego, espero haber sido de ayuda en esta oportunidad.", "Hasta la próxima, espero haberte ayudado."]]
%%      InputLog = []
%%      OutputLog = [["[19/5/2018, 17:29]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 17:29]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], ["[19/5/2018, 17:29]", "Usuario:", "Diego"], ["[19/5/2018, 17:29]", "Bot:", "Diego y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], ["[19/5/2018, 17:29]", "Usuario:", "Me gustaría viajar hacia Punta Arenas"], ["[19/5/2018, 17:29]", "Bot:", "Punta Arenas es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta $15.000 pesos ¿Desea confirmar su destino?"], ["[19/5/2018, 17:29]", "Usuario:", "Sí"], ["[19/5/2018, 17:29]", "Bot:", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], ["[19/5/2018, 17:29]", "Bot:", "Hasta la próxima, espero haberte ayudado."], ["[19/5/2018, 17:29]", "EndDialog", "ID", "0"]]
%%
%%      ;
%%
%%      User = ["Paloma", "Tengo unas ganas de visitar a mi familia en Arica", "Mejor en otra oportunidad, prefiero viajar a Valdivia primero", "Sí"],
%%      Chatbot = [["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], [["0", "0"]], ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"], ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "], ["Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?", "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?"], ["Hasta luego, espero haber sido de ayuda en esta oportunidad.", "Hasta la próxima, espero haberte ayudado."]]
%%      InputLog = []
%%      OutputLog = [["[19/5/2018, 17:30]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 17:30]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], ["[19/5/2018, 17:30]", "Usuario:", "Paloma"], ["[19/5/2018, 17:30]", "Bot:", "Paloma y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."], ["[19/5/2018, 17:30]", "Usuario:", "Tengo unas ganas de visitar a mi familia en Arica"], ["[19/5/2018, 17:30]", "Bot:", "Arica es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta $32.200 pesos ¿Desea confirmar su destino?"], ["[19/5/2018, 17:30]", "Usuario:", "Mejor en otra oportunidad, prefiero viajar a Valdivia primero"], ["[19/5/2018, 17:30]", "Bot:", "Valdivia es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta $17.900 pesos ¿Desea confirmar su destino?"], ["[19/5/2018, 17:30]", "Usuario:", "Sí"], ["[19/5/2018, 17:30]", "Bot:", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"], ["[19/5/2018, 17:30]", "Bot:", "Hasta la próxima, espero haberte ayudado."], ["[19/5/2018, 17:30]", "EndDialog", "ID", "0"]]
%%
%%
test(User, Chatbot, InputLog, Seed, OutputLog):-
	chatbot(Chatbot),
	user1(User),
	beginDialog(Chatbot, InputLog, Seed, BeginLog),
	recursiveTest(User, Chatbot, BeginLog, Seed, OutputLog);

	chatbot(Chatbot),
	user2(User),
	beginDialog(Chatbot, InputLog, Seed, BeginLog),
	recursiveTest(User, Chatbot, BeginLog, Seed, OutputLog);

	chatbot(Chatbot),
	user3(User),
	beginDialog(Chatbot, InputLog, Seed, BeginLog),
	recursiveTest(User, Chatbot, BeginLog, Seed, OutputLog); 

	chatbot(Chatbot),
	beginDialog(Chatbot, InputLog, Seed, BeginLog),
	recursiveTest(User, Chatbot, BeginLog, Seed, OutputLog).

%%%
%% Permite visualizar el log de manera completamente entendible para el usuario, incluyendo saltos de línea.
%%
%% Log: Corresponde a una estructura log.
%%
%% Ejemplo:
%% 		writeLog([["[19/5/2018, 16:47]", "BeginDialog", "ID:", "0"], ["[19/5/2018, 16:47]", "Bot:", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], ["[19/5/2018, 16:51]", "Usuario:", "Gabriel"], ["[19/5/2018, 16:51]", "Bot:", "Gabriel ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."], ["[19/5/2018, 17:8]", "Bot:", "Hasta la próxima, espero haberte ayudado."], ["[19/5/2018, 17:8]", "EndDialog", "ID", "0"]]).
%%
%%      [19/5/2018, 16:47] BeginDialog ID: 0
%%      [19/5/2018, 16:47] Bot: Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?
%%      [19/5/2018, 16:51] Usuario: Gabriel
%%      [19/5/2018, 16:51] Bot: Gabriel ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.
%%      [19/5/2018, 17:8] Bot: Hasta la próxima, espero haberte ayudado.
%%      [19/5/2018, 17:8] EndDialog ID 0
%%
writeLog(Log):-
	logToStr(Log, S),
	write(S).

%%%
%% Permite obtener ciertos elementos de la fecha y hora del sistema, tales como día, mes, año, hora, minutos, etc.
%%
%% Key: Símbolo que permite señalar el elemento que se desea obtener.
%% Value: Valor obtenido en base a la Key ingresada.
%%
get_date_time_value(Key, Value) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(Key, DateTime, Value).
#lang scheme

;Importación de librería para acceder a la hora del sistema
(require racket/date)

;Constantes utilizadas para la generación de un número pseudo-aleatorio
(define a 1103515245)
(define c 12345)
(define m 2147483648)

(define user1 (list "Gabriel" "¿Cuándo habrán pasajes para Brasil?" "Me gustaría viajar al sur" "Respóndeme lo que te pregunté" "Quiero viajar a Coyhaique" "Sí"))
(define user2 (list "Diego" "Me gustaría viajar a La Serena" "No" "Prefiero viajar a Coyhaique" "Sí"))
(define user3 (list "Paloma" "¿Cuándo habrán viajes hacia China?" "Me gustaría viajar a Iquique" "No" "¿Podrías responderme lo que te pregunté de China?" "Quiero viajar a Concepción" "Sí"))


;;
;Definición de una estructura de tipo chatbot. En ella, se encuentran los distintos tipos de
;mensajes a los que el chatbot pueda acceder, dependiendo del flujo que tenga la conversación.

(define-struct chatbot
  (
   saludosMañana     ;Lista en la que se tendrán los distintos tipos de saludos que puede generar el bot en la mañana
   saludosTarde      ;Lista en la que se tendrán los distintos tipos de saludos que puede generar el bot en la tarde
   saludosNoche      ;Lista en la que se tendrán los distintos tipos de saludos que puede generar el bot en la noche
   ofrecerNombre     ;Lista en la que se tendrán los primeros diálogos para respuestas tras el nombre
   noEntender        ;Lista en la que se tendrán las respuestas en caso de que el bot no entienda el flujo de conversación
   respuestaViaje1   ;Lista en la que se tendrán los inicios a una respuesta tras identificar el viaje
   respuestaViaje2   ;Continuación de respuesta, la que permite saber el precio
   viajes            ;Lista de pares en los que se tienen los distintos destinos y sus respectivos valores
   confirmacion      ;Lista que contiene respuestas para confirmación de pasajes
   nuevaBusqueda     ;Lista en la que se tendrán las posibilidades de realizar una nueva búsqueda.
   promise           ;Lista de promesas
   lazyAnswer        ;Lista de respuestas a promesas
   despedida         ;Lista en la que se contendrán los distintos tipos de despedidas que puede generar el bot.
   pairID/Rate       ;Lista de listas en las que se tendrá el id y su respectivo rate del bot
   )
  )

;;
; Definición de chatbot1, el cual servirá para utilizar las funciones sin necesidad de crear un chatbot cada vez.
;;
(define chatbot1 (make-chatbot
  '("Buenos días, mi nombre es Bot y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?"
    "Hola, mi nombre es Bot, espero ser de ayuda para buscar un viaje que le acomode. ¿Cuál es su nombre?")
  '("Buenas tardes, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"
    "Buenas tardes, mi nombre es Bot, y estoy aquí para ayudarte con tu próximo viaje. ¿Cuál es tu nombre?")
  '("Buenas noches, mi nombre es Bot, y estoy aquí para ayudarte a elegir tu próximo destino. ¿Cómo debería llamarte?"
    "Buenas noches, mi nombre es Bot, y estoy aquí para que conversemos sobre tu viaje, pero antes, ¿Cuál es tu nombre?")
  '(" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país."
    " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."
    " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año.")
  '("Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?"
    "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?")
  '("¡Es la mejor elección que pudiste elegir! "
    "¡Excelente elección! ")
  '(" es un lugar precioso! Los pasajes hacia allá cuestan "
    " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta ")
  (list (list "Arica" "$32.200 pesos") (list "Iquique" "$30.100 pesos") (list "Antofagasta" "$21.600 pesos") (list "Copiapó" "$15.000 pesos")
        (list "La Serena" "$9.100 pesos") (list "Valparaíso" "$6.500 pesos") (list "Rancagua" "$3.000 pesos") (list "Talca" "$6.500 pesos")
        (list "Concepción" "$13.900 pesos") (list "Temuco" "$14.900 pesos") (list "Puerto Montt" "$19.900 pesos")
        (list "Coyhaique" "$33.000 pesos") (list "Punta Arenas" "$15.000 pesos") (list "Valdivia" "$17.900 pesos"))
  '("¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web."
    "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web")
  '("¿A qué ciudad entonces te gustaría ir?"
    "No hay problema, puedes elegir un nuevo destino")
  '("Consultaré con mis superiores, te responderé en unos minutos."
    "Voy a averigüarlo. Te respondo en un momento.")
  '("A la pregunta que me habías hecho, el servicio comenzará en un tiempo estimado de 6 meses."
    "A la pregunta que me habías hecho, el servicio se encontrará disponible desde el próximo verano.")
  '("Hasta luego, espero haber sido de ayuda en esta oportunidad."
    "Hasta la próxima, espero haberte ayudado.")
  (list (list 0 0))
  )
  )

;;
;##################################################################################################################
;############################################# FUNCIONES OBLIGATORIAS #############################################
;##################################################################################################################
;;

;;
; beginDialog: Función que permite iniciar una conversación con un chatbot.
;
; Entrada:
;     chatbot -> corresponde al chatbot con el que se tendrá la conversación.
;     log -> corresponde a una lista de strings, siendo esta la representación del log histórico de conversaciones.
;     seed -> corresponde a un número entero (o semilla), con el cual se generarán número pseudo-aleatorios.
;
; Salida:
;     Lista de strings, representando a un log actualizado en el que se mantienen las conversaciones del usuario y un chatbot.
;
; Signature:
;     chatbot X lista X Integer -> lista
;
(define (beginDialog chatbot log seed)    
  (append log
          ((lambda (date chatbot)
             (list (string-append
              "["
              (number->string (date-day date)) "-"
              (number->string (date-month date)) "-"
              (number->string (date-year date)) "] "
              (number->string (date-hour date)) ":"
              (number->string (date-minute date)) ":"
              (number->string (date-second date)) " ID:"
              (number->string (first (last (chatbot-pairID/Rate chatbot)))) 
              " BeginDialog"))
    ) (current-date) chatbot)
          ((lambda (message)
             (list (string-append
                    "["
                    (number->string (date-day (getDate message))) "-"
                    (number->string (date-month (getDate message))) "-"
                    (number->string (date-year (getDate message))) "] "
                    (number->string (date-hour (getDate message))) ":"
                    (number->string (date-minute (getDate message))) ":"
                    (number->string (date-second (getDate message))) " " (getAutor message) " "
                    (getText message)
                    )
                   )
    )
           (message (current-date) "Bot:"
              (randomElement (((lambda (chatbot)
                                 (let ((hour (date-hour (current-date))))
                                   (cond
                                     [(< hour 12) chatbot-saludosMañana]
                                     [(and (>= hour 12) (< hour 20)) chatbot-saludosTarde]
                                     [else chatbot-saludosNoche]
                                     )
                                   )
                                 )
                               chatbot)
                              chatbot)
                             seed)
              )
           )
          )
  )

;;
; sendMessage: Función que permite enviar un mensaje a un chatbot.
; Entrada:
;     msg -> String ingresado por el usuario. Corresponde a su mensaje hacia el chatbot.
;     chatbot -> corresponde al chatbot con el que se mantiene una conversación.
;     log -> corresponde a una lista de strings, siendo esta la representación del log histórico de conversaciones.
;     seed -> corresponde a un número entero (o semilla), con el cual se generarán número pseudo-aleatorios.
;
; Salida:
;     Lista de strings, representando a un log actualizado en el que se mantienen las conversaciones del usuario y un chatbot.
;
; Signature:
;     string X chatbot X lista X Integer  -> lista
;
(define (sendMessage msg chatbot log seed)
  ;;
  ; elementInCommon?: Función que permite determinar si hay elementos en común entre dos listas.
  ; Entrada:
  ;     list1 -> Lista
  ;     list2 -> Lista
  ;
  ; Salida:
  ;     Booleano, que determina si existe un elemento en común entre las dos listas.
  ;
  ; Signature:
  ;     lista X lista -> Booleano
  ;
  ; Recursividad:
  ;     Se utiliza recursividad de COLA, ya que no es necesario dejar estados en espera.
  ;
  (define (elementInCommon? list1 list2)
  (cond
    [(or (empty? list1) (empty? list2)) #f]
    [(member (car list1) list2) #t]
    [else (elementInCommon? (cdr list1) list2)]
    )
  )
  ; answerPromises: Función que permite responder promesas pendientes dentro del log.
  ; Entrada:
  ;     log -> Lista
  ;
  ; Salida:
  ;     Log actualizado con la promesa respondida
  ;
  ; Signature:
  ;     lista X lista -> lista
  ;
  ; Recursividad:
  ;     Se utiliza recursividad de COLA, ya que no es necesario dejar estados en espera.
  ;
  (define (answerPromises log)
    (if (empty? log)
        '()
        (if (and (promise? (car log)) (not (promise-forced? (car log))))
            (force (car log))
            (answerPromises (cdr log))
            )
        )
    )
  ; getCityList: Función que permite obtener la lista con la ciudad y el precio que el usuario pide.
  ; Entrada:
  ;     list1 -> Lista
  ;     listOfList -> Lista
  ;
  ; Salida:
  ;     lista con la ciudad y el precio de los pasajes.
  ;
  ; Signature:
  ;     lista X lista -> lista
  ;
  ; Recursividad:
  ;     Se utiliza recursividad de COLA, ya que no es necesario dejar estados en espera.
  ;
  (define (getCityList list1 listOfList)
    (if (empty? ((lambda (list1 list2) (letrec ((I (lambda (set)(cond ((null? set)(quote ()))((member (car set) list2)(cons (car set)(I (cdr set))))(else (I (cdr set)))))))(I list1))) list1 (string-split (caar listOfList))))
        (getCityList list1 (cdr listOfList))
        (car listOfList)
        )
    )
  
  (let ((wordsInMessage (string-split msg)))
      (cond
        [(searchWordInList "BeginDialog" (string-split (list-ref (messageToLog log (message (current-date) "Usuario" msg)) (- (myLength (messageToLog log (message (current-date) "Usuario" msg))) 3)))) ((lambda (nombre log)(messageToLog log (message (current-date) "Bot" (string-append nombre (randomElement (chatbot-ofrecerNombre chatbot) seed))))) msg (messageToLog log (message (current-date) "Usuario" msg)))]
        [(elementInCommon? wordsInMessage (flatten (map (lambda (x) (string-split (car x))) (chatbot-viajes chatbot)))) ((lambda (pair chatbot seed log) (messageToLog log (message (current-date) "Bot" (string-append (randomElement (chatbot-respuestaViaje1 chatbot) seed) (car pair) (randomElement (chatbot-respuestaViaje2 chatbot) seed) (cadr pair) " ¿Desea confirmar esa ciudad?")))) (getCityList wordsInMessage (chatbot-viajes chatbot)) chatbot seed (messageToLog log (message (current-date) "Usuario" msg)))]
        [(searchWordInList "¿Cuándo" wordsInMessage) ((lambda (msg chatbot seed log)(let ((preLog (messageToLog log (message (current-date) "Usuario" msg))))(append (messageToLog preLog (message (current-date) "Bot" (randomElement (chatbot-promise chatbot) seed))) (list (lazy (message (current-date) "Bot" (randomElement (chatbot-lazyAnswer chatbot) seed))))))) msg chatbot seed log)]
        [(or (searchWordInList "Sí" wordsInMessage) (searchWordInList "sí" wordsInMessage)) ((lambda (chatbot seed log)(messageToLog log (message (current-date) "Bot" (randomElement (chatbot-confirmacion chatbot) seed)))) chatbot seed (messageToLog log (message (current-date) "Usuario" msg)))]
        [(or (searchWordInList "No" wordsInMessage) (searchWordInList "no" wordsInMessage)) ((lambda (chatbot seed log)(messageToLog log (message (current-date) "Bot" (randomElement (chatbot-nuevaBusqueda chatbot) seed)))) chatbot seed (messageToLog log (message (current-date) "Usuario" msg)))]
        [(or (searchWordInList "Respóndeme" wordsInMessage) (searchWordInList "responderme" wordsInMessage)) (filter (lambda (x) (not (promise? x))) (messageToLog (messageToLog log (message (current-date) "Usuario" msg)) (answerPromises log)))]
        [else ((lambda (chatbot seed log) (messageToLog log (message (current-date) "Bot" (randomElement (chatbot-noEntender chatbot) seed)))) chatbot seed (messageToLog log (message (current-date) "Usuario" msg)))]
        )
    )
  )

;;
; endDialog: Función que permite finalizar una conversación con un chatbot.
;
; Entrada:
;     chatbot -> corresponde al chatbot con el que se terminará la conversación.
;     log -> corresponde a una lista de strings, siendo esta la representación del log histórico de conversaciones.
;     seed -> corresponde a un número entero (o semilla), con el cual se generarán número pseudo-aleatorios.
;
; Salida:
;     Lista de strings, representando a un log actualizado en el que se mantienen las conversaciones del usuario y un chatbot.
;
; Signature:
;     chatbot X lista X Integer -> lista
;
(define (endDialog chatbot log seed)
  (append log
          ((lambda (message)
             (list (string-append
                    "["
                    (number->string (date-day (getDate message))) "-"
                    (number->string (date-month (getDate message))) "-"
                    (number->string (date-year (getDate message))) "] "
                    (number->string (date-hour (getDate message))) ":"
                    (number->string (date-minute (getDate message))) ":"
                    (number->string (date-second (getDate message))) " " (getAutor message) " "
                    (getText message)
                    )
                   )
             )
           (message (current-date) "Bot:"
                    (randomElement (chatbot-despedida chatbot) seed)))
          ((lambda (date chatbot)
             (list (string-append
                    "["
                    (number->string (date-day date)) "-"
                    (number->string (date-month date)) "-"
                    (number->string (date-year date)) "] "
                    (number->string (date-hour date)) ":"
                    (number->string (date-minute date)) ":"
                    (number->string (date-second date)) " ID:"
                    (number->string (first (last (chatbot-pairID/Rate chatbot)))) 
                    " EndDialog"))
             )
           (current-date) chatbot)
          )
  )

;;
; rate: Función que permite evaluar a un chatbot en base a su conversación y a una nota dada por el usuario.
;
; Entrada:
;     chatbot -> corresponde al chatbot a evaluar.
;     score -> evaluación por parte del usuario hacia el bot.
;     f -> función que permite realizar una autoevaluación del bot.
;     log -> corresponde a una lista de strings, siendo esta la representación del log histórico de conversaciones.
;
; Salida:
;     Estructura de tipo chatbot. En caso de que la conversación no haya terminado, esta función entrega al mismo chatbot, sin
; aplicar una evaluación. En caso contrario, el chatbot se evalúa, y se entrega uno actualizado.
;
; Signature:
;     chatbot X Integer X function X lista  -> chatbot
;
(define (rate chatbot score f log)
  (if (searchWordInList "EndDialog" (string-split (last log)))
      (make-chatbot
       '("Buenos días, mi nombre es Bot y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?"
         "Hola, mi nombre es Bot, espero ser de ayuda para buscar un viaje que le acomode. ¿Cuál es su nombre?")
       '("Buenas tardes, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"
         "Buenas tardes, mi nombre es Bot, y estoy aquí para ayudarte con tu próximo viaje. ¿Cuál es tu nombre?")
       '("Buenas noches, mi nombre es Bot, y estoy aquí para ayudarte a elegir tu próximo destino. ¿Cómo debería llamarte?"
         "Buenas noches, mi nombre es Bot, y estoy aquí para que conversemos sobre tu viaje, pero antes, ¿Cuál es tu nombre?")
       '(" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país."
         " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte."
         " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año.")
       '("Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?"
         "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?")
       '("¡Es la mejor elección que pudiste elegir! "
         "¡Excelente elección! ")
       '(" es un lugar precioso! Los pasajes hacia allá cuestan "
         " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta ")
       (list (list "Arica" "$32.200 pesos") (list "Iquique" "$30.100 pesos") (list "Antofagasta" "$21.600 pesos") (list "Copiapó" "$15.000 pesos")
             (list "La Serena" "$9.100 pesos") (list "Valparaíso" "$6.500 pesos") (list "Rancagua" "$3.000 pesos") (list "Talca" "$6.500 pesos")
             (list "Concepción" "$13.900 pesos") (list "Temuco" "$14.900 pesos") (list "Puerto Montt" "$19.900 pesos")
             (list "Coyhaique" "$33.000 pesos") (list "Punta Arenas" "$15.000 pesos") (list "Valdivia" "$17.900 pesos"))
       '("¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web."
         "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web")
       '("¿A qué ciudad entonces te gustaría ir?"
         "No hay problema, puedes elegir un nuevo destino")
       '("Consultaré con mis superiores, te responderé en unos minutos."
         "Voy a averigüarlo. Te respondo en un momento.")
       '("A la pregunta que me habías hecho, el servicio comenzará en un tiempo estimado de 6 meses."
         "A la pregunta que me habías hecho, el servicio se encontrará disponible desde el próximo verano.")
       '("Hasta luego, espero haber sido de ayuda en esta oportunidad."
         "Hasta la próxima, espero haberte ayudado.")
       (append
        (chatbot-pairID/Rate chatbot)
        (list
         (list
          (+ 1
             (first
              (last
               (chatbot-pairID/Rate chatbot)
               )
              )
             )
          (inexact->exact
           (round
            ((lambda (userScore autoScore)
               (+ (* userScore 0.7) (* autoScore 0.3))
               )
             score (f log)
             )
            )
           )
          )
         )
        )
       )
      chatbot
      )
  )

;;
; test: Función que permite simular una conversación a partir de una lista de strings.
; 
; Entrada:
;     user -> Lista de strings que representan los mensajes del usuario.
;     chatbot -> corresponde al chatbot con el cual se simulará la conversación.
;     log -> corresponde a una lista de strings, siendo esta la representación del log histórico de conversaciones.
;     seed -> corresponde a un número entero (o semilla), con el cual se generarán número pseudo-aleatorios.
;
; Salida:
;     Lista de strings, que representa a un log modificado con el resultado de la conversación simulada.
;
; Signature:
;    lista X chatbot X lista X Integer -> lista
;
; Recursividad:
;     En esta implementación, se ha utilizado recursión de COLA. Se ha decidido utilizar esta recursión para
; obtener un cálculo en el que no queden estados en espera, con el fin de reducir el tiempo necesario para
; simular la conversación.
;
(define (test user chatbot log seed)
  (define (recursiveLog user chatbot log seed)
    (if (empty? user)
        (endDialog chatbot log seed)
        (recursiveLog (cdr user) chatbot (sendMessage (car user) chatbot log seed) seed)
        )
    )
  (recursiveLog user chatbot (beginDialog chatbot log seed) seed)
  )

;;
;##################################################################################################################
;############################################# FUNCIONALIDADES EXTRAS #############################################
;##################################################################################################################
;;

;;
; displayLog: Función que permite mostrar el log por pantalla.
; 
; Entrada:
;     chatbot -> corresponde al chatbot con el cual se simulará la conversación.
;     log -> corresponde a una lista de strings, siendo esta la representación del log histórico de conversaciones.
;
; Salida:
;     Display del log recibido.
;
; Signature:
;     chatbot X lista -> display
;
; Recursividad:
;     En esta implementación, se ha utilizado una función auxiliar que recurre a el concepto de recursión de COLA.
; Esta función helper recibe un parámetro más, el cual es un string, por lo que su signature es: chatbot X lista X string -> string
; Utiliza recursión de COLA con el fin de no generar estados en espera, con tal de reducir el tiempo necesario para imprimir por pantalla.


(define (displayLog chatbot log)
  (define (displayLog chatbot log string)
    (if (empty? log)
        string
        (displayLog chatbot (cdr log) (string-append string (car log) "\n"))
        )
    )
  (display (displayLog chatbot log ""))
  )

;;
;##################################################################################################################
;############################################# TIPO DE DATO ABSTRACTO #############################################
;##################################################################################################################
;;

;;
; IMPLEMENTACIÓN DE TDA MENSAJE.
;;

;;
; 1) Representación:
; Para la representación de mensajes, se ocupará una lista de 3 elementos, en la cual se utilizará una fecha, un
; remitente, y un 'mensaje' propiamente tal.
; Ej:
;   TDA Mensaje -> '(estructuraFecha "Remitente" "Mensaje")
;
; 2) Constructor:
; Message: Constructor
; Entrada:
;     date -> Estructura de tipo date.
;     autor -> string que representa al autor del mensaje.
;     text -> string que representa el contenido del mensaje.
;
; Salida:
;     Lista de tres elementos. El primero de estos corresponde a una fecha, el segundo al autor, y el tercero
; al contenido del mensaje. En caso de que los argumentos de la función no sirvan para crear un TDA mensaje, se
; retorna una lista vacía (o element nulo).
;
; Signature:
;     date X string X string -> lista
;
(define (message date autor text)
  (if (and (date*? date) (string? autor) (string? text))
      (list date autor text)
      '()
      )
  )

; 3) Pertenencia:
; message?: Pertenencia
; Entrada:
;     m -> Argumento a verificar si corresponde a un mensaje.
;
; Salida:
;     Booleano que determina si el argumento entregado corresponde a un TDA mensaje.
;
; Signature:
;     lista -> booleano
;
(define (message? m)
  (if (list? m)
      (if (empty? m)
          #f
          (if (= (myLength m) 3)
              (if (and (date*? (car m))
                       (string? (cadr m))
                       (string? (caddr m))
                       )
                  #t
                  #f
                  )
              #f
              )
          )
      #f
      )
  )

; 4) Selectores:
;
; getDate permite obtener la estructura DATE dentro de un TDA mensaje. En caso que el argumento no sea un TDA mensaje,
; se retorna un string vacío.
;
; Entrada:
;     m -> Mensaje
;
; Salida:
;     Se obtiene la estructura DATE que está dentro de un TDA mensaje. En caso que argumento entregado no sea un mensaje,
; se retorna un string vacío.
;
; Signature:
;     lista -> string
;

(define (getDate m)
  (if (message? m)
      (car m)
      ""
      )
  )

;
; getAutor permite obtener al autor dentro de un TDA mensaje. En caso que el argumento no sea un TDA mensaje,
; se retorna un string vacío.
;
; Entrada:
;     m -> Mensaje
;
; Salida:
;     Se obtiene el string que representa al autor que está dentro de un TDA mensaje. En caso que argumento entregado no sea un mensaje,
; se retorna un string vacío.
;
; Signature:
;     lista -> string
;
(define (getAutor m)
  (if (message? m)
      (cadr m)
      ""
      )
  )

;
; getText permite obtener al contenido dentro de un TDA mensaje. En caso que el argumento no sea un TDA mensaje,
; se retorna un string vacío.
;
; Entrada:
;     m -> Mensaje
;
; Salida:
;     Se obtiene el string que representa al contenido que está dentro de un TDA mensaje. En caso que argumento entregado no sea un mensaje,
; se retorna un string vacío.
;
; Signature:
;     lista -> string
;
(define (getText m)
  (if (message? m)
      (caddr m)
      ""
      )
  )

; 5) Modificadores:
;
; setDate permite modificar la estructura DATE dentro de un TDA mensaje.
;
; Entrada:
;     m -> Mensaje.
;     date -> Estructura con la fecha del sistema.
;
; Salida:
;     Se obtiene el TDA mensaje con la información actualizada. En caso que argumento entregado no sea un mensaje,
; o que la nueva fecha no sea una estructura DATE, se retorna el argumento ingresado como TDA.
;
; Signature:
;     lista X date -> lista
;
(define (setDate m date)
  (if (and (message? m) (date*? date))
      (message date (getAutor m) (getText m))
      m
      )
  )

;
; setAutor permite modificar el string que representa al autor del mensaje dentro de un TDA mensaje.
;
; Entrada:
;     m -> Mensaje.
;     autor -> string con el nuevo remitente del mensaje.
;
; Salida:
;     Se obtiene el TDA mensaje con la información actualizada. En caso que argumento entregado no sea un mensaje,
; o que el nuevo autor no sea un string, se retorna el argumento ingresado como TDA.
;
; Signature:
;     lista X string -> lista
;
(define (setAutor m autor)
  (if (and (message? m) (string? autor))
      (message (getDate m) autor (getText m))
      m
      )
  )

;
; setText permite modificar el string que representa al contenido del mensaje dentro de un TDA mensaje.
;
; Entrada:
;     m -> Mensaje.
;     text -> string con el contenido nuevo que tendrá el mensaje.
;
; Salida:
;     Se obtiene el TDA mensaje con la información actualizada. En caso que argumento entregado no sea un mensaje,
; o que el nuevo contenido no sea un string, se retorna el argumento ingresado como TDA.
;
; Signature:
;     lista X string -> lista
;
(define (setText m text)
  (if (and (message? m) (string? text))
      (message (getDate m) (getAutor m) text)
      m
      )
  )

;;
; 6)Funciones que operan sobre el TDA:
;
; messageToLog: La función permite, a través de un TDA mensaje, hacer una transcripción con un buen formato, hacia el log, el cual es una lista
; de strings.
;
; Entrada:
;     log -> lista de strings, representa al log.
;     message -> TDA mensaje.
;
; Salida:
;     Log modificado con el mensaje agregado. Este último mensaje es añadido siguiendo cierto formato, lo que permite mejor
; legibilidad a la hora de utilizar al Log.
;
; Signature:
;     lista X lista -> lista
;
(define (messageToLog log message)
  (if (message? message)
      (append log (list (string-append
                         "["
                         (number->string (date-day (getDate message))) "-"
                         (number->string (date-month (getDate message))) "-"
                         (number->string (date-year (getDate message))) "] "
                         (number->string (date-hour (getDate message))) ":"
                         (number->string (date-minute (getDate message))) ":"
                         (number->string (date-second (getDate message))) " " (getAutor message) ": "
                         (getText message)
                         )
                        )
              )
      log
      )
  )

;;
; myLength: Función que permite obtener el largo de una lista.
; 
; Entrada:
;     list -> Lista
;
; Salida:
;     Número entero que representa el largo de la lista.
;
; Signature:
;     lista -> Integer
;
; Recursividad:
;     En esta implementación, se ha utilizado recursión NATURAL. Se ha decidido utilizar esta recursión para
; obtener un cálculo directo, sin tener que recurrir a argumentos auxiliares dentro de la función, ni tampoco
; a encapsular funciones.
;
(define (myLength list)
  (if (empty? list)
       0
       (+ 1 (myLength (cdr list)))
     )
   )

;;
; lengthToRate: Función que permite obtener el largo de la última conversación dentro de un log.
; 
; Entrada:
;     reverseList -> Lista que representa al log. Este viene invertido.
;
; Salida:
;     Número entero que representa el largo de la última conversación dentro del log.
;
; Signature:
;     lista -> Integer
;
; Recursividad:
;     En esta implementación, se ha utilizado recursión NATURAL. Se ha decidido utilizar esta recursión para
; obtener un cálculo directo, sin tener que recurrir a argumentos auxiliares dentro de la función, ni tampoco
; a encapsular funciones.
;
(define (lengthToRate reverseList)
  (if (searchWordInList "BeginDialog" (string-split (car reverseList)))
      0
      (+ 1 (lengthToRate (cdr reverseList)))
      )
  )
;;
; autoRate: Función que permite determinar una nota para la última conversación a partir del largo de ésta.
; 
; Entrada:
;     log -> Lista que representa al log.
;
; Salida:
;     Número entero que representa la calificación de la última conversación en base a su largo.
;
; Signature:
;     lista -> Integer
;
(define (autoRate log)
  (let ((largo (lengthToRate (reverse log))))
    (cond
      ((< largo 5) 0)
      ((and (< largo 10) (> largo 4) ) 1)
      ((and (< largo 15) (>= largo 10)) 5)
      ((and (< largo 17) (>= largo 15)) 4)
      ((and (< largo 20) (>= largo 17)) 3)
      ((and (< largo 23) (>= largo 20)) 2)
      (else 1)
      )
    )
  )

;;
; searchWordInList: Función que permite determinar si un string está dentro de una lista.
; 
; Entrada:
;     word -> String a buscar.
;     list -> Lista.
;
; Salida:
;    booleano que determina si el string se encuentra dentro de la lista o no.
;
; Signature:
;     string X lista -> booleano
;
; Recursividad:
;     En esta implementación, se ha utilizado recursión de COLA. Se ha decidido utilizar esta recursión dado
; que para la búsqueda de elementos dentro de una lista, es innecesario dejar estados en espera.
;
(define (searchWordInList word list)
  (if (empty? list)
      #f
      (if (string=? (car list) word)
          #t
          (searchWordInList word (cdr list))
          )
      )
  )
                          

;;
; myRandom: Función que permite generar un número pseudo-aleatorio a partir de una semilla.
; 
; Entrada:
;     seed -> Número entero.
;     list -> Lista.
;
; Salida:
;    número entero pseudo aleatorio a partir de la semilla entregada.
;
; Signature:
;     Integer -> Integer
;
(define (myRandom seed)
  (define myRandom
    (lambda
        (xn)
      (remainder (+ (* a xn) c) m)
      )
    )
  (myRandom seed)
  )

;;
; randomElement: Función que permite obtener un elemento pseudo-aleatorio de una lista a partir de una semilla.
; 
; Entrada:
;     ls -> Lista.
;     seed -> Número entero.
;
; Salida:
;    elemento pseudo-aleatorio de una lista.
;
; Signature:
;     lista X Integer -> elemento de lista
;
(define randomElement
  (lambda (ls seed)
      (list-ref ls (remainder (myRandom seed) (myLength ls)))
      )
    )

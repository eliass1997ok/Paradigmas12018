#lang scheme

;Importación de librería para acceder a la hora del sistema
(require racket/date)

;Se guarda la hora y fecha del sistema dentro de la constante "time"
(define time (current-date))

;Se establece una constante que almacena una lista con la hora exacta en que el chat comienza.
(define beginTime (list (date-hour time) (date-minute time) (date-second time)))

;Estas constantes fueron sacadas de https://en.wikipedia.org/wiki/Linear_congruential_generator
(define a 1103515245)
(define c 12345)
(define m 2147483648)

;INTENTO DE HACER UNA ESTRUCTURA CHATBOT

(define-struct chatbot
  (
   saludosMañana ;Lista en la que se tendrán los distintos tipos de saludos que puede generar el bot en la mañana
   saludosTarde  ;Lista en la que se tendrán los distintos tipos de saludos que puede generar el bot en la mañana
   saludosNoche  ;Lista en la que se tendrán los distintos tipos de saludos que puede generar el bot en la mañana
   ofrecerNombre ;Lista en la que se tendrán los primeros diálogos para respuestas tras el nombre
   noEntender    ;Lista en la que se tendrán las respuestas en caso de que el bot no entienda el flujo de conversación
   respuestaViaje1 ;Lista en la que se tendrán  los inicios a una respuesta tras identificar el viaje
   respuestaViaje2 ;Continuación de respuesta, la que permite saber el precio
   viajes ;Lista de pares en los que se tienen los distintos destinos y sus respectivos valores
   despedida     ;Lista en la que se contendrán los distintos tipos de despedidas que puede generar el bot.
   rate   ;Nota o evaluación del bot
   ID     ;Identificador del bot
   )
  )

;Recursión de Cola

(define (selectGreetings chatbot)
  (let ((hour (date-hour (current-date))))
  (cond
    [(< hour 12) chatbot-saludosMañana]
    [(and (>= hour 12) (< hour 20)) chatbot-saludosTarde]
    [else chatbot-saludosNoche]
    )
  )
  )

(define test-chatbot (make-chatbot
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
  (list (list "Valparaíso" "2000") (list "Punta Arenas" "3000"))
  '("Hasta luego, espero haber sido de ayuda en esta oportunidad."
    "Hasta la próxima, espero haberte ayudado.")
  5
  0
  )
  )

(define (messageToLog log message)
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
  )


(define (endDialog chatbot log seed)
  (define (endDialogTag date chatbot)
    (list (string-append
              "["
              (number->string (date-day date)) "-"
              (number->string (date-month date)) "-"
              (number->string (date-year date)) "] "
              (number->string (date-hour date)) ":"
              (number->string (date-minute date)) ":"
              (number->string (date-second date)) " ID:"
              (number->string (chatbot-ID chatbot)) 
              " EndDialog"))
    )
  (define (lastMessage message)
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
  (append log (lastMessage (message (current-date) "Bot:" (randomElement (chatbot-despedida chatbot) seed))) (endDialogTag (current-date) chatbot))
  )
  

(define (beginDialog chatbot log seed)
  (define (beginDialogTag date chatbot )
    (list (string-append
              "["
              (number->string (date-day date)) "-"
              (number->string (date-month date)) "-"
              (number->string (date-year date)) "] "
              (number->string (date-hour date)) ":"
              (number->string (date-minute date)) ":"
              (number->string (date-second date)) " ID:"
              (number->string (chatbot-ID chatbot)) 
              " BeginDialog"))
    )
  (define (firstMessage message)
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
    
  (append log (beginDialogTag (current-date) chatbot) (firstMessage (message (current-date) "Bot:" (randomElement ((selectGreetings chatbot) chatbot) seed))))
  )

;Recursión de cola
(define (searchWordInList word list)
  (if (empty? list)
      #f
      (if (string=? (car list) word)
          #t
          (searchWordInList word (cdr list))
          )
      )
  )

(define (sendMessage msg chatbot log seed)
  (define (elementInCommon? list1 list2)
  (cond
    [(or (empty? list1) (empty? list2)) #f]
    [(member (car list1) list2) #t]
    [else (elementInCommon? (cdr list1) list2)]
    )
  )
  (define (answerToName nombre log)
    ;(display (string-append nombre (randomElement (chatbot-ofrecerNombre chatbot) seed)))
    (messageToLog log (message (current-date) "Bot" (string-append nombre (randomElement (chatbot-ofrecerNombre chatbot) seed))))
    )
  (define (noEntender chatbot seed log)
    ;(display (randomElement (chatbot-noEntender chatbot) seed))
    (messageToLog (message (current-date) "Bot" (randomElement (chatbot-noEntender chatbot) seed)))
    )
  (define (answerToCity pair chatbot seed log)
    ;(display (string-append (randomElement (chatbot-respuestaViaje1 chatbot) seed) (car pair) (randomElement (chatbot-respuestaViaje2 chatbot) seed) (cadr pair)))
    (messageToLog log (message (current-date) "Bot" (string-append (randomElement (chatbot-respuestaViaje1 chatbot) seed) (car pair) (randomElement (chatbot-respuestaViaje2 chatbot) seed) (cadr pair))))
    )
  
  (define (getCityList list1 listOfList)
    (define intersect
    (lambda (set1 set2)
            (letrec
              ((I (lambda (set)
                      (cond
                           ((null? set) (quote ()))
                           ((member (car set) set2)
                            (cons (car set)
                                  (I (cdr set))))
                           (else (I (cdr set)))))))
            (I set1))
      )
      )
    (if (empty? (intersect list1 (car listOfList)))
        (getCityList list1 (cdr listOfList))
        (car listOfList)
        )
    )
  
  

  (let ((wordsInMessage (string-split msg)))
  
  (cond
    [(searchWordInList "nombre?" (string-split (list-ref (messageToLog log (message (current-date) "Usuario" msg)) (- (length (messageToLog log (message (current-date) "Usuario" msg))) 2)))) (answerToName msg (messageToLog log (message (current-date) "Usuario" msg)))]
    [(searchWordInList "llamarte?" (string-split (list-ref (messageToLog log (message (current-date) "Usuario" msg)) (- (length (messageToLog log (message (current-date) "Usuario" msg))) 2)))) (answerToName msg (messageToLog log (message (current-date) "Usuario" msg)))]
    [(elementInCommon? wordsInMessage (flatten (chatbot-viajes chatbot))) (answerToCity (getCityList wordsInMessage (chatbot-viajes chatbot)) chatbot seed (messageToLog log (message (current-date) "Usuario" msg)))]
    [else (noEntender chatbot seed)]
  )
    )
  )



                          
;CONSTRUCTOR
(define (message date autor text)
  (if (and (date*? date) (string? autor) (string? text))
      (list date autor text)
      '()
      )
  )

;PERTENENCIA
(define (message? m)
  (if (list? m)
      (if (empty? m)
          #f
          (if (= (length m) 3)
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

;SELECTORES

(define (getDate m)
  (if (message? m)
      (car m)
      ""
      )
  )

(define (getAutor m)
  (if (message? m)
      (cadr m)
      ""
      )
  )

(define (getText m)
  (if (message? m)
      (caddr m)
      ""
      )
  )

;MODIFICADORES

(define (setDate m date)
  (if (and (message? m) (date*? date))
      (message date (getAutor m) (getText m))
      m
      )
  )

(define (setAutor m autor)
  (if (and (message? m) (string? autor))
      (message (getDate m) autor (getText m))
      m
      )
  )

(define (setText m text)
  (if (and (message? m) (string? text))
      (message (getDate m) (getAutor m) text)
      m
      )
  )

;FUNCIONES QUE OPERAN SOBRE EL TDA    
  
  
;Esta función random tuma un xn y obtiene el xn+1 de la secuencia de números aleatorios.
(define (myRandom seed)
  (define myRandom
    (lambda
        (xn)
      (remainder (+ (* a xn) c) m)
      )
    )
  (myRandom seed)
  )

(define randomElement
  (lambda (ls seed)
      (list-ref ls (remainder (myRandom seed) (length ls)))
      )
    )


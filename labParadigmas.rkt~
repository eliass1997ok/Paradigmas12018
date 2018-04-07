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

;INTENTO DE HACER UN TDA log

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
(define myRandom
  (lambda
    (xn)
    (remainder (+ (* a xn) c) m)
  )
)


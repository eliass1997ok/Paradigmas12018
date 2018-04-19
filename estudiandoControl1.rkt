#lang racket

(define l (list (list 2 (cons 2 3) (cons 3 7)) (list 3 (cons 1 2) (cons 2 8)) (list 4 (cons 4 9))))


(define (casilla valor columna)
  (if (and (number? valor) (number? columna) (>= columna 0))
      (list valor columna)
      '()
      )
  )

(define (casilla? c)
  (not (null? (casilla (car c) (cadr c))))
  )
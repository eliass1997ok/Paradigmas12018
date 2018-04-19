#lang racket

(define (myReverse lista)
  (define (myReverse lista listaAux)
    (if (null? lista)
        listaAux
        (myReverse (cdr lista) (cons (car lista) listaAux))
        )
    )
  (myReverse lista '())
  )


(define (removeDuplicates list)
  (define (elementIsIn? element list)
    (if (null? list)
        #f
        (if (equal? element (car list))
            #t
            (elementIsIn? element (cdr list))
            )
        )
    )
  (define (removeDuplicates list listAux)
    (if (null? list)
        listAux
        (if (not (elementIsIn? (car list) listAux))
            (removeDuplicates (cdr list) (cons (car list) listAux))
            (removeDuplicates (cdr list) listAux)
            )
        )
    )
  (removeDuplicates list '())
  )
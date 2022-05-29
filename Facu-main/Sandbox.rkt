;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define MAX 5)
(define LISTA1 (list (make-posn 3 5) (make-posn 1 2) (make-posn 0 1) (make-posn 5 6)))

(define (dist-puntos p1 p2) (sqrt (+ (sqr (- (posn-x p1) (posn-x p2))) (sqr (- (posn-y p1) (posn-y p2))))))

(define (dist-origen l a) (cond [(empty? l) a]
                                [(cons? l) (if (<= (dist-puntos (first l) (make-posn 0 0)) MAX)
                                               (dist-origen (rest l) (cons (first l) a))
                                               (dist-origen (rest l) a))]))

(check-expect (dist-origen LISTA1 empty) (list (make-posn 0 1) (make-posn 1 2)))

;==========================================================

(define LISTA2 (list 2 6 5 5 2))
(define LISTA3 (list 2 1 4 8))

(define (eliminar l n a) (cond [(empty? l) a]
                             [(cons? l) (if (= (first l) n)
                                            (eliminar (rest l) n a)
                                            (eliminar (rest l) n (cons (first l) a)))]))

(check-expect (eliminar LISTA2 5 '()) (list 2 6 2))
(check-expect (eliminar LISTA2 2 '()) (list 5 5 6))
(check-expect (eliminar LISTA3 0 '()) (list 8 4 1 2))

;==========================================================

; Ejercicio 22. Diseñe la función cuadrados, que dada una lista de números, devuelva la
; lista que resulta de elevar al cuadrado cada uno de los elementos de la lista original.

(define LISTA4 (list 1 2 3 4 5))

(define (cuadrados l a) (cond [(empty? l) a]
                              [(cons? l) (cuadrados (rest l) (cons (sqr (first l)) a))]))

(check-expect (cuadrados LISTA4 '()) (list 25 16 9 4 1))

;==========================================================

; Ejercicio 25. Diseñe la función prod, que multiplica los elementos de una lista de
; números entre sí. Para la lista vacía, devuelve 1.

(define LISTA5 (list 1 2 3))
(define LISTA6 (list 2 2 2))

(define (prod l) (cond [(empty? l) 1]
                       [(cons? l) (* (first l) (prod (rest l)))]))

(check-expect (prod LISTA5) 6)
(check-expect (prod LISTA6) 8)
(check-expect (prod (list 2 5 6 4 5 8 0)) 0)

;==========================================================

; Ejercicio 27. Diseñe la función maximo que devuelve el máximo de una lista de
; números naturales. Para la lista vacía, devuelve 0.

(define LISTA7 (list 2 5 25 4))
(define LISTA8 (list 500 501 502 1))

(define (maximo l) (cond [(empty? l) 0]
                         [(cons? l) (max (first l) (maximo (rest l)))]))

(check-expect (maximo LISTA7) 25)
(check-expect (maximo LISTA8) 502)

;==========================================================

(define LISTA9 (list 2 1 1 2))
(define LISTA10 (list 0 0 1))

(define (sumcuad l) (cond [(empty? l) 0]
                          [(cons? l) (+ (sqr (first l)) (sumcuad (rest l)))]))

(check-expect (sumcuad LISTA9) 10)
(check-expect (sumcuad LISTA10) 1)

;==========================================================

(define LARGO 500)
(define ALTO 500)
(define CIRCULO (circle 30 "solid" "red"))
(define ESCENARIO (empty-scene LARGO ALTO "black"))
(define POS (list (make-posn (/ LARGO 4) (/ ALTO 4))
                  (make-posn (/ LARGO 2) (/ ALTO 2))
                  (make-posn (/ (* 3 LARGO) 4) (/ (* 3 ALTO) 4))
                  (make-posn (/ LARGO 4) (/ (* 3 ALTO) 4))))

(define (render estado) (place-image CIRCULO (posn-x estado) (posn-y estado) ESCENARIO))
(define (changePosition estado k) (cond [(key=? k "1") (newPos POS 1 1)]
                                        [(key=? k "2") (newPos POS 2 1)]
                                        [(key=? k "3") (newPos POS 3 1)]
                                        [(key=? k "4") (newPos POS 4 1)]
                                        [else estado]))

; NumI = Numero de iteraciones (comienza en 1 siempre)
; Num = Numero que fue presionado
; l = Lista de posiciones (POS)
(define (newPos l num numI) (cond [(empty? l) (make-posn 0 0)] ; La linea nunca se evalua
                                  [(cons? l) (if (= num numI)
                                                 (first l)
                                                 (newPos (rest l) num (+ numI 1)))]))

(define estadoInicial (make-posn (/ LARGO 2) (/ ALTO 2)))

(big-bang estadoInicial
  [to-draw render]
  [on-key changePosition]
  )







;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; (define (funcion <predicado> <lista>) (<patron> <predicado> <lista>))

; (filter <predicado> <lista>) = Se usa para filtar los elementos que se desean de
; una lista. Puede devolver menos cantidad de elementos de una lista, pero nunca mas.

; (map <predicado> <lista>) = Se usa para aplicar una transformacion a los elementos
; de una lista. Siempre devuelve la misma cantidad de elementos que la lista posee.

; (foldr <predicado> <caso base> <lista>) = Se usa para operar todos los elementos de una lista.
; Devuelve siempre un tipo de dato diferente a una lista, como un Number o String.

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; Ejercicio 6. Diseñe la función raices, que dada una lista de números,
; devuelve una lista con las raíces cuadradas de sus elementos.

(define (raices0 l) (cond [(empty? l) '()]
                          [(cons? l) (cons (sqrt (first l)) (raices0 (rest l)))]))

(check-expect (raices0 (list 0 1 4 16)) (list 0 1 2 4))

(define LISTA5 (list 0 1 4 16))

(define (raiz x) (sqrt x))
(define (raices pred l)(map pred l))

(check-expect (raices raiz LISTA5) (list 0 1 2 4))

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; Ejercicio 7. Diseñe una función distancias que tome una lista de
; puntos del plano y devuelva una lista con la distancia al origen de cada
; uno.

(define LISTA6 (list (make-posn 3 4) (make-posn 0 4) (make-posn 12 5))) ; 5 4 13

(define (dist-origen a) (sqrt (+ (sqr (+ (posn-x a) 0)) (sqr (+ (posn-y a) 0)))))

(define (distancias pred l) (map pred l))

(check-expect (distancias dist-origen LISTA6) (list 5 4 13))

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; Ejercicio 8. Diseñe una función anchos que tome una lista de imágenes
; y devuelva una lista con el ancho de cada una

(define LISTA7 (list (circle 5 "solid" "red") (rectangle 10 20 "solid" "blue") (rectangle 20 5 "solid" "grey"))) ; 10 20 5

(define (ancho-img x) (image-height x))

(define (anchos pred l) (map pred l))

(check-expect (anchos ancho-img LISTA7) (list 10 20 5))

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; Ejercicio 13. Diseñe una función prod que multiplica los elementos de
; una lista de números. Para la lista vacía, devuelve 1.

(define LISTA8 (list 1 2 3 4 5)) ; 120

;(foldr * 1 LISTA8)

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; Ejercicio 14. Diseñe una función pegar que dada una lista de strings,
; devuelve el string que se obtiene de concatenar todos los elementos de
; la lista.

(define LISTA9 (list "Mr." "Robot" " es" " una" " serie" " muy" " buena."))

(define (pegar l) (foldr string-append "" l))

;(pegar LISTA9)

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

(define LISTA10 (list 20 21 25 50 1))
(define LISTA11 (list 1 2 5 9 100))

(define (smax l) (foldr max 0 l))

;(smax LISTA10)
;(smax LISTA11)

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

(check-expect (sumcuad empty) 0)
(check-expect (sumcuad (list 1 2 3)) 14)
(check-expect (sumcuad (list -1 -2)) 5)

(define (sumcuad l)
  (foldr + 0 (map sqr l)))

; Ejercicio 11. Diseñe una función longitudes que tome una lista de
; cadenas y devuelva una lista de números que corresponda con la
; longitud de cada cadena de la lista original.

(define (longitudes0 l) (cond [(empty? l) empty]
                              [(cons? l) (cons (string-length (first l)) (longitudes0 (rest l)))]))

(check-expect (longitudes0 (list "hola" "si")) (list 4 2))

(define (predicade x) (string-length x))

(define (longitudes l) (map predicade l))

(check-expect (longitudes (list "hola" "como" "estas?")) (list 4 4 6))
















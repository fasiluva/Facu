;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Sandbox:

;Constantes del escenario:
  (define LARGO 600)
  (define ALTO 400)
  (define COLOR "black")
  (define FONDO (empty-scene LARGO ALTO COLOR))
;Constantes de las estrellas (E-)
  (define E-COLOR "white")
  (define E-LARGO 20)
  (define (estrella x y) (star (/ (* x E-LARGO) LARGO) "solid" E-COLOR))

;Funcion que evalua si se puede graficar la estrella
(define (validacion x y) (cond
                           [(and
                             (and (>= x (+ 0 E-LARGO)) (<= x (- LARGO E-LARGO))) ;Si cumple que este entre esos valores de x y de y, grafica
                             (and (>= y (+ 0 E-LARGO)) (<= y (- ALTO E-LARGO)))
                             ) #true]
                           [else #false] ;Si no esta entre los valores, devuelve false para que en (estrellar) pase al else y no devuelva nada
                           )
  )

;Funcion INTERPRETAR (principal)
(define (interpretar FONDO) FONDO)

;Funcion ESTRELLAR (on-key)
(define (estrellar FONDO x y event) (cond [(and (string=? event "button-down") (validacion x y)) (place-image (estrella x y) x y FONDO)]
                                          [else FONDO]))

(big-bang FONDO
  [to-draw interpretar]
  [on-mouse estrellar]
    )







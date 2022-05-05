;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define LARGO 150)
(define ALTO 500)
(define ESCENARIO (empty-scene LARGO ALTO "cyan"))
(define FIG-LARGO 20)

(define LIMITE-INFERIOR (- ALTO FIG-LARGO)) ; si ALTO = 500 => LIMITE-INFERIOR = 480
(define LIMITE-SUPERIOR FIG-LARGO) ; (+ 0 FIG-LARGO)

(define CUADRADO (square FIG-LARGO "solid" "black"))
(define CIRCULO (circle FIG-LARGO "solid" "black"))

(define EstadoInicial (string-append "s" (number->string LIMITE-INFERIOR)))

(define (interpretar s) (place-image (figura s) (/ LARGO 2) (coordenadaY s) ESCENARIO)) ; Estado -> Image

(define (clasificaFigura s) (string-ith s 0)) ;String -> String
(define (figura s) (cond [(string=? (clasificaFigura s) "s") CUADRADO]
                         [(string=? (clasificaFigura s) "b") CIRCULO]))

(define (coordenadaY s) (string->number (substring s 1 (string-length s)))) ; Estado -> Number
(define (cambiaSentido s) (cond [(string=? (clasificaFigura s) "s") (string-append "b" (substring s 1 (string-length s)))]
                                [(string=? (clasificaFigura s) "b") (string-append "s" (substring s 1 (string-length s)))]))

(define (mover s) (if (string=? (clasificaFigura s) "s") ; S
                      (cond [(> (coordenadaY s) LIMITE-SUPERIOR) (string-append "s" (number->string(- (coordenadaY s) 1)))] ;Estado -> Estado (string)
                            [(<= (coordenadaY s) LIMITE-SUPERIOR) (cambiaSentido s)])
                      (cond [(< (coordenadaY s) LIMITE-INFERIOR) (string-append "b" (number->string (+ (coordenadaY s) 1)))]
                            [else (cambiaSentido s)])
                      )
  )

(big-bang EstadoInicial ; Estado = String
  [to-draw interpretar]
  [on-tick mover 0.005]
  )

; make-posn: Number Number -> posn
; (make-posn a b)
; posn-x: posn -> Number
; (posn-x (make-posn a b)) == a
; posn-y: posn -> Number
; (posn-y (make-posn a b)) == b
; posn?

; (ley 1) == posn-x de un make-posn
; (ley 2) == posn-y de un make-posn
; (definicion de q) == expandir variable make-posn

#|
(define (dist-origen puntos) ; Recibe una variable que en la ejecucion se indica que valores tienen los puntos con el make-posn
  (sqrt (+ (sqr (posn-x puntos)) (sqr (posn-y puntos)))))
(check-expect (dist-origen (make-posn 3 4)) 5)

(check-expect (simetria (make-posn 2 5)) (make-posn -2 -5))
(define (simetria puntos) (make-posn (- 0 (posn-x puntos)) (- 0 (posn-y puntos))))


(define (distancia puntos1 puntos2)
  (if (and (posn? puntos1) (posn? puntos2))
      (sqrt
        (+ (sqr (- (posn-x puntos2) (posn-x puntos1)))
           (sqr (- (posn-y puntos2) (posn-y puntos1)))))
      "Tipos incorrectos para la funcion"))
(check-expect (distancia (make-posn 0 0) (make-posn 3 4)) 5)
(check-expect (distancia (make-posn 0 0) "hola") "Tipos incorrectos para la funcion") 

(define ALTURA 800)
(define LARGO 800)
(define ESTADO-INICIAL (make-posn (/ LARGO 2) (/ ALTURA 2)))
(define ESCENARIO (empty-scene LARGO ALTURA))
(define RADIO 50)
(define COLOR "lightgreen")
(define DELTA 60)

(define (interpretar s)
  (place-image (circle RADIO "solid" COLOR)
               (posn-x s) (posn-y s)
               ESCENARIO
               )
  )

(define (modificador-posición s k)      
      (cond [(string=? k "up") (if (> (- (posn-y s) DELTA) RADIO)
                                    (make-posn (posn-x s) (- (posn-y s) DELTA))
                                    s)]
            [(string=? k "down") (if (< (+ (posn-y s) DELTA) (- ALTURA RADIO))
                                     (make-posn (posn-x s) (+ (posn-y s) DELTA))
                                     s)]
            [(string=? k " ") ESTADO-INICIAL]
            [else s]
        )
  )

(define (controlador-mouse s x y event)
  (cond [(string=? event "button-down")
         (if (and (>= y RADIO)(<= y (- ALTURA RADIO)))
             (make-posn x y)
             s)]
        [else s]
    )
)

(big-bang ESTADO-INICIAL
  [to-draw interpretar]
  [on-key modificador-posición]
  [on-mouse controlador-mouse]
  )|#


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


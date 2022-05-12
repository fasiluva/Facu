;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; make-posn: Number Number -> posn
; (make-posn a b)
; posn-x: posn -> Number
; (posn-x (make-posn a b)) == a
; posn-y: posn -> Number
; (posn-y (make-posn a b)) == b
; posn?

; Estado = (make-posn x y)
; Interpretar: Estado -> Image

(define ALTO 500)
(define LARGO 500)
(define ESCENARIO (empty-scene LARGO ALTO "black"))
(define DELTA 30)
(define RADIO 20)
(define estadoInicial (make-posn (/ LARGO 2) (/ ALTO 2)))

(define (interpretar n) (place-image (circle RADIO "solid" "grey") (posn-x n) (posn-y n) ESCENARIO))

(define (evaluate-new-position-x n) (if (and
                                         (< (posn-x n) (- LARGO DELTA))
                                         (> (posn-x n) DELTA)) ; ambas no pueden ser falsas
                                            (+ (posn-x n) (- (random DELTA) (random DELTA)))
                                            (if (< (posn-x n) (- LARGO DELTA)) ; si x<480 => x<=delta
                                                (+ (posn-x n) 1)
                                                (- (posn-x n) 1) ;sino, x>=480 => x>delta
                                                )))

(define (evaluate-new-position-y n) (if (and
                                         (< (posn-y n) (- ALTO DELTA))
                                         (> (posn-y n) DELTA)) ; ambas no pueden ser falsas
                                            (+ (posn-y n) (- (random DELTA) (random DELTA)))
                                            (if (< (posn-y n) (- ALTO DELTA)) ; si x<480 => x<=delta
                                                (+ (posn-y n) 1)
                                                (- (posn-y n) 1) ;sino, x>=480 => x>delta
                                                )))

(define (mover n) (make-posn
                   (evaluate-new-position-x n)
                   (evaluate-new-position-y n)
                   )
  )

(big-bang estadoInicial
  [to-draw interpretar]
  [on-tick mover 0.05]) ; Estado -> Estado


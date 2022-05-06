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
  )


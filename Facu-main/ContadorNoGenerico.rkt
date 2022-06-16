;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ContadorNoGenerico) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))

(define LARGO 200)
(define ALTO 100)
(define ESCENARIO (empty-scene LARGO ALTO))

(define estadoInicial (make-posn 0 0))

; ---------------------------------------------------------------------------

(define (interpretar estado) (place-image (text "Textos:" 20 "black") (/ LARGO 4) (/ ALTO 4)
                                          (place-image (text (number->string (posn-x estado)) 20 "grey") (/ LARGO 4) (/ ALTO 2)
                                                       (place-image (text "Teoremas:" 20 "black") (/ (* 3 LARGO) 4) (/ ALTO 4)
                                                                    (place-image (text (number->string (posn-y estado)) 20 "grey") (/ (* 3 LARGO) 4) (/ ALTO 2)
                                                                                 ESCENARIO)))))
                                          
(define (sumar x estado) (if (<= x (/ LARGO 2))
                             (make-posn (+ (posn-x estado) 1) (posn-y estado))
                             (make-posn (posn-x estado) (+ (posn-y estado) 1))))

(define (sum estado x y event) (cond [(string=? event "button-down") (sumar x estado)]
                                     [else estado]))

(define (reiniciar estado tecla) (cond [(key=? " " tecla) (make-posn 0 0)]
                                       [else estado]))

; ---------------------------------------------------------------------------

(big-bang estadoInicial
  [to-draw interpretar]
  [on-mouse sum]
  [on-key reiniciar]
  )
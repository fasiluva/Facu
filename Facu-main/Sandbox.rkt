;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Sandbox:
; Ejercicio 4:
#|
(define LARGO 300) ; Definicion del largo del empty-scene
(define ANCHO 300) ; Defiinicion del ancho del empty-scene
(define escenario (empty-scene LARGO ANCHO)) ; Definicion del empty-scene

; Definicion de funcion del color del circulo segun su tamaño:
(define (color-segun-n n) (cond
                            [(<= n 50) "yellow"]
                            [(<= n 100) "red"]
                            [else "green"])) ; n > 100

; Definicion de funcion del circulo:
(define (circulo n) (place-image
                     (circle n "solid" (color-segun-n n)) 150 150
                     escenario))

; Definicion de funcion on-tick:
(define (incrementar n) (cond
                          [(and (< n (/ LARGO 2)) (< n (/ ANCHO 2))) (+ n 1)]
                          [else (- n (/ (min LARGO ANCHO) 2))])) ; Se usa la funcion (min x y) ya que determina el valor mas chico de ambos, y hace que no exceda su tamaño.[1.1]

; Definicion de funcion on-key:
(define (modificar-radio n k) (cond
                                [(not (string-numeric? k)) n] ; Lo que se introduce en los on-key son solo strings, por eso se debe hacer el pasaje para ser evaluado como un numero en el else.
                                [else (* (string->number k) 10)]))

; Definicion de funcion big-bang: 
(big-bang 1
  [to-draw circulo]
  [on-tick incrementar]
  [on-key modificar-radio]
)|#

; Definicion de constantes:
(define ALTO 300) ; Alto del empty-scene
(define LARGO 300) ; Largo del empty-scene
(define ESCENARIO (empty-scene LARGO ALTO))
(define DELTA 10) ; Movimiento del circulo por tecla presionada
(define RADIO 10)

; Definicion de funcion principal:
(define (circulo n) (place-image (circle RADIO "solid" "red") (/ ALTO 2) n
                                 ESCENARIO))
; Definicion de funcion on-key
(define (mover n k) (cond [(key=? k " ") (/ ALTO 2)] ; Primero se pone el reinicio de posicion, sino se bloquearia por la proposicion de abajo.
                          [(or (< (- n DELTA) RADIO) (> (+ n DELTA) (- ALTO RADIO))) n]
                          [(key=? k "up") (- n DELTA)]
                          [(key=? k "down") (+ n DELTA)]
                          [else n]))

; Definicion de funcion on-mouse
(define (mouse-handler n x y event) (cond [(string=? event "button-down") y]
                                          [else n]))

; Defincion de funcion big-bang:
(big-bang (/ ALTO 2)
  [to-draw circulo]
  [on-key mover]
  [on-mouse mouse-handler]
)

(define LARGO 500)
(define ANCHO 500)
(define LADO 50)
(define ESCENARIO (empty-scene LARGO ANCHO))

(define (cuadrado n) (place-image (square LADO "solid" "black") (- LARGO n) (+ 0 n)
                                  (place-image (square LADO "solid" "yellow") (- LARGO n) (- ANCHO n)
                                               (place-image (square LADO "solid" "green") n n
                                                            (place-image (square LADO "solid" "blue") (/ LARGO 2) n
                                                                         (place-image (square LADO "solid" "red") n (/ ANCHO 2)
                                                                                      ESCENARIO
                                                                                      )
                                                                         )
                                                            )
                                               )
                                  )
  )

(define (mover n) (cond [(> n (+ LARGO (/ LADO 2))) (- n (+ LARGO (/ LADO 2)))]
                        [else (+ n 10)]
                  )
)

(big-bang (/ LARGO 2)
  [to-draw cuadrado]
  [on-tick mover]
  )







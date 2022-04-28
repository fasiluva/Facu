;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Sandbox:


#|
(define COLOR "yellow")
(define ALTO 300)
(define LARGO 300)
(define RADIO 50)
(define ESCENARIO (empty-scene LARGO ALTO))

(define (interpretar n) (place-image (circle RADIO "solid" n) (/ LARGO 2) (/ ALTO 2)
                                     ESCENARIO))

(define (cambiar n) (cond [(string=? "yellow" n) "red"]
                          [(string=? "red" n) "green"]
                          [(string=? "green" n) "blue"]
                          [else "yellow"]))

(big-bang COLOR
  [to-draw interpretar]
  [on-tick cambiar 0.5] ; CANTIDAD DE SEGUNDOS 
  )



; (text <string> <font-size> <color>)
; (place-image/align <image> <x> <y> <x-place> <y-place> <scene>)
;                      |(figura-geometrica <largo,ancho> <solid> <color>)
; <x> <y>: coordenadas en basa al escenario sobre el que se posiciona
; <x-place> <y-place>: que punto de la <image> toma como referencia. Ejemplo: "center" toma el centro de la figura

(define LARGO 800)
(define ANCHO 60)
(define ESCENARIO (empty-scene 800 60))
(define CADENA "")
;(define last-char-position (string-ith CADENA (- (string-length CADENA) 1)))

(define (interpretar CADENA) (place-image/align (text CADENA 20 "indigo")
                                                0 0
                                                "left" "top"
                                                ESCENARIO))
(define (escribir CADENA k) (cond [(key=? k "\b")
                                   (if (> (string-length CADENA) 0)
                                       (substring CADENA 0 (- (string-length CADENA) 1))
                                       CADENA)]
                                  [(string? k) (string-append CADENA k)]
                                  [else CADENA]))

(big-bang CADENA
  [to-draw interpretar]
  [on-key escribir])
|#

(define AUTO .)
(define LARGO 800)
(define ALTO 150)
(define ESCENARIO (empty-scene LARGO ALTO))
(define estadoInicial 0)
(define estadoCambiante 0)

(define (interpretar movimiento) (place-image/align
                                  AUTO
                                  movimiento (/ ALTO 2)
                                  "right" "center"
                                  ESCENARIO)
  )

(define (mover n) (cond [(<= n LARGO) (+ n 3)]
                        [else n]
                        )
  )

(define (reiniciar estadoCambiante k)(cond [(key=? k " ") estadoInicial]
                                   [else estadoCambiante]))

(define (posicionar estadoCambiante x y evento) (cond [(string=? evento "button-down") x]
                                                      [else estadoCambiante]))

(big-bang estadoCambiante
  [to-draw interpretar]
  [on-tick mover]
  [on-key reiniciar]
  [on-mouse posicionar])






;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Sandbox:

; las figuras geometrias se representan con un string
; los colores se representaran con un string
; String String -> image
; Estado -> Image

; Definicion de constantes de escenario:
  (define LARGO 500)
  (define ALTO 500)
  (define ESCENARIO (empty-scene LARGO ALTO))
; Definicion de constantes de propiedades de las figuras (F-):
  (define F-COLOR-GREEN "green")
  (define F-COLOR-BLUE "blue")
  (define F-LARGO 100)
; Definicion de constantes de figuras:
  (define TV (triangle F-LARGO "solid" F-COLOR-GREEN)); Estado inicial
  (define TA (triangle F-LARGO "solid" F-COLOR-BLUE))
  (define CV (circle F-LARGO "solid" F-COLOR-GREEN))
  (define CA (circle F-LARGO "solid" F-COLOR-BLUE))

; Definicion de funcion cambioVerde:
(define (cambioVerde TV) (cond [(image=? TV TA) TV]
                               [(image=? TV CA) CV]
                               [else TV]))

; Definicion de funcion cambioAzul:
(define (cambioAzul TV) (cond [(image=? TV TV) TA]
                               [(image=? TV CV) CA]
                               [else TV]))

; Definicion de funcion to-draw:
(define (interpretar e) (place-image
                         e (/ LARGO 2) (/ ALTO 2)
                         ESCENARIO))

; Definicion de funcion on-key:
(define (figura TV k) (cond [(key=? k "v") (cambioVerde TV)]
                            [(key=? k "a") (cambioAzul TV)]
                            [else TV]
                            )
  )

; Definicion de funcion on-tick:
(define (coloreado E) (cond [(image=? E (triangle F-LARGO "solid" F-COLOR-GREEN)) TA]
                            [(image=? E (triangle F-LARGO "solid" F-COLOR-GREEN)) TV]
                            [(image=? E (circle F-LARGO "solid" F-COLOR-GREEN)) CA]
                            [(image=? E (circle F-LARGO "solid" F-COLOR-BLUE)) CV]
                            [else E]
                             )
  )

; Definicion de funcion big-bang:
(big-bang TV
  [to-draw interpretar]
  [on-key figura]
  [on-tick coloreado 1]
)






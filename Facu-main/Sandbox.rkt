;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; Sandbox:

; Ejercicio3.  Diseñe la función vol-cubo que recibe la longitud
; de la arista de un cubo y calcula su volumen
; area de cubo: b^3

(define (vol-cubo l) (if (> l 0) (* l l l)
                         "No es posible porque: la medida debe ser positiva"))

(check-expect (vol-cubo 2) 8)
(check-expect (vol-cubo -2) "No es posible porque: la medida debe ser positiva")

;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; Practica 1.2: Ejercicio 4:

; una imagen es "muy ancha" si su ancho es mas que el doble de su altura
; una imagen es "muy angosta" si su altura es mas que el doble de su ancho
; una imagen es "angosta" si su altura es mayor que su ancho, sino es "ancha"
; hacer un programa que clasifique las imagenes en "muy ancha", "ancha", "cuadrada", "angosta", "muy angosta".

#|
; Se definen los ejemplos en cuestion: 
(define IMAGEN_MUY_ANGOSTA (rectangle 10 30 "solid" "red"))
(define IMAGEN_ANGOSTA (rectangle 10 15 "solid" "red"))
(define IMAGEN_CUADRADA (rectangle 10 10 "solid" "red"))
(define IMAGEN_ANCHA (rectangle 10 5 "solid" "red"))
(define IMAGEN_MUY_ANCHA (rectangle 10 2 "solid" "red"))
(define NO_IMAGEN "hola")

; Se define la funcion:

(define (ImageAnalizer1 x)
  (cond
    [(not (image? x)) "Lo introducido no era una imagen"] ; Para corroborar que se haya introducido una imagen
    [(and
      (> (image-width x) (image-height x)) (> (image-width x) (* 2 (image-height x)))
      ) "La imagen es muy ancha"]
    [(> (image-width x) (image-height x)) "La imagen es ancha"]
    [(= (image-width x) (image-height x)) "La imagen es cuadrada"]
    [(and
      (< (image-width x) (image-height x)) (< (* 2 (image-width x)) (image-height x))
      ) "La imagen es muy angosta"]
    [else "La imagen es angosta"]
    )
  )
(ImageAnalizer1 NO_IMAGEN)
(ImageAnalizer1 IMAGEN_MUY_ANGOSTA)
(ImageAnalizer1 IMAGEN_ANGOSTA)
(ImageAnalizer1 IMAGEN_CUADRADA)
(ImageAnalizer1 IMAGEN_ANCHA)
(ImageAnalizer1 IMAGEN_MUY_ANCHA)


(define (ImageAnalizer1.1 x)
  (cond
    [(not (image? x)) "Lo introducido no era una imagen"] ; Para corroborar que se haya introducido una imagen
    [(> (image-width x) (image-height x)) (if
                                           (> (image-width x) (* 2 (image-height x))) "La imagen es muy ancha"
                                           "La imagen es ancha")]
    [(< (image-width x) (image-height x)) (if
                                           (< (* 2 (image-width x)) (image-height x)) "La imagen es muy angosta"
                                           "La imagen es angosta")]
    [else "La imagen es cuadrada"]
    )
  )

(ImageAnalizer1.1 NO_IMAGEN)
(ImageAnalizer1.1 IMAGEN_MUY_ANGOSTA)
(ImageAnalizer1.1 IMAGEN_ANGOSTA)
(ImageAnalizer1.1 IMAGEN_CUADRADA)
(ImageAnalizer1.1 IMAGEN_ANCHA)
(ImageAnalizer1.1 IMAGEN_MUY_ANCHA)


(define CHILE (place-image (star 10 "solid" "white") 15 15
                             (place-image (square 30 "solid" "blue") 15 15
                                           (place-image (rectangle 90 30 "solid" "red") 45 45
                                                        (empty-scene 90 60)))))         
                 
                                                       
|#

; Ejercicio1.  Diseñe una función distancia-origen, que recibe dos números x e y, de-volviendo
; como resultado la distancia al origen del punto (x,y).

;(define (distancia-origen x y) (sqrt (+ (sqr x) (sqr y))))
;(distancia-origen 2 2)

; Ejercicio2. Diseñe una funcióndistancia-puntos, que recibe cuatro números x1, y1, x2 e y2
; y devuelve la distancia entre los puntos (x1, y1) y (x2, y2).

;(define (distancia-puntos x1 y1 x2 y2) (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2)))))
;(distancia-puntos 0 0 3 4)

; Ejercicio3.  Diseñe la función vol-cubo que recibe la longitud
; de la arista de un cubo y calcula su volumen
; area de cubo b2*h
(define (vol-cubo x) ()) 
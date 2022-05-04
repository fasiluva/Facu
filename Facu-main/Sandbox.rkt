;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Sandbox:
; Escribir un programa que muestre una pelota que pica
; continuamente modificando su forma a una elipse
; al llegar a un extremo.
(define ALTO 600)
(define ANCHO 100)
(define RADIO 40)         ;este es el radio del círculo
(define POSY-MIN RADIO)   ;coordenada mínima admitida sobre
; el eje y para q el centro de la elipse no se salga
; de la escena
(define POSY-MAX (- ALTO RADIO)) ; coordenada máxima admitida
; sobre el eje y para el centro de la elipse para que no
; salga de la escena
(define DELTA 15)

; marco donde picará la pelota
(define MARCO
  (empty-scene ANCHO ALTO))

; Estado : (coordenada y , sentido del movimiento)

; Representaremos el estado con una cadena, donde el primer
; caracter será "b" o "s" y el resto el número correspondiente
; a la coordenada Y.

; Estado inicial
(define INICIAL (string-append "s" (number->string POSY-MAX)))

; coordY : Estado -> Number
; La función obtiene la coordenada Y a partir del estado

(define (coordY s)
        (string->number (substring s 1 (string-length s))) )

; interpretar : Estado -> Imagen
; Obtiene la coordenada Y del estado y muestra una imagen
; rectangular con la pelota, ubicada en la coordenada x e y.

(define (interpretar s)
     (place-image
         (ellipse 50 (+ 50 (/ (coordY s) 9)) "solid" "blue")
         (/ ANCHO 2) ; coordenada x (es fija)
         (coordY s) ; coordenada y 
         MARCO))

; Funciones auxiliares
; cambiarPos : Estado String -> Estado
; Dado un estado y la nuevo posición, cambia el estado
; con la posición dada.
(define (cambiarPos s p)
    (string-append p (substring s 1 (string-length s))))

; armaEstado : Number String -> String
; Dado un número que representa la coordenada Y,
; y una cadena que representa el sentido en que
; se mueve la pelota ("s" o "b") arma un estado
; con ellos.

(define (armaEstado sentido y)
   (string-append sentido (number->string y)))

; avanza-reloj : Estado -> Estado
; Dado el estado del reloj modifica el estado dependiendo
; de si la pelota está subiendo o bajando.

(define (avanza-reloj s)
     (if (string=? (string-ith s 0) "b")
        ; está bajando
        (cond [(>= (+ (coordY s) DELTA) POSY-MAX)
                   (cambiarPos s "s")]
              [else (armaEstado  "b" (+ (coordY s) DELTA))])
        ; está subiendo
        (cond [(<= (- (coordY s) DELTA) POSY-MIN) 
                   (cambiarPos s "b")]
              [else (armaEstado "s" (- (coordY s) DELTA))])))  

(big-bang INICIAL
          [to-draw interpretar]
          [on-tick avanza-reloj] )


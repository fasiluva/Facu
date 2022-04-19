;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; Sandbox:

; Ejercicio3.  Diseñe la función vol-cubo que recibe la longitud
; de la arista de un cubo y calcula su volumen
; area de cubo: b^3

;(define (vol-cubo l) (if (> l 0) (* l l l)
                         ;"No es posible porque: la medida debe ser positiva"))

;(check-expect (vol-cubo 2) 8)
;(check-expect (vol-cubo -2) "No es posible porque: la medida debe ser positiva")

; Ejercicio 1. Diseñe una función distancia-origen, que recibe dos
; números x e y, devolviendo como resultado la distancia al origen del
; punto (x,y).

#|

Dominio: Puntos en el plano (numeros)
Imagen: Distancia de los puntos al origen (numeros)

Signatura: El programa recibe dos numeros (X e Y), lo evalua como un punto en
el plano y devuelve su distancia al origen de coordenadas. En caso de que se
le suministre tipos de datos que NO sean number, devuelve un string indicando
que debe suministrar datos de tipo Number.

f: Number Number -> Number | String

Para calcular la distancia, usamos la propiedad Pitagorica: c^2 = a^2 + b^2

dist(5,6) = 7.81 (aprox)
dist(1,1) = 1.4142 (aprox)


(check-within (distancia-origen 5 6) 7.81 0.01)
(check-within (distancia-origen 1 1) 1.4142 0.1)
(check-expect (distancia-origen "hola" 6) "No se ingresaron valores validos")
(check-expect (distancia-origen 5 "mundo") "No se ingresaron valores validos")

(define (distancia-origen x y)
  (cond [(or (string? x) (string? y)) "No se ingresaron valores validos"]
        [else (sqrt (+ (sqr x) (sqr y)))]
        )
  )
|#

; -------------------------------------------------------------------------------------------------------------------------------

#|
Ejercicio 9. Un Instituto de Portugués decide lanzar las siguientes
promociones buscando aumentar la cantidad de alumnos:

• Si se anotan 2 amigos, cada uno obtiene un 10% de descuento sobre
el valor de la cuota; mientras que si se anotan 3 o más el descuento
alcanza el 20%
• Si al momento de pagar se decide abonar 2 meses juntos se recibe
un descuento del 15%; en caso de abonar 3 o más meses a la vez la
reducción es del 25%

Las promociones son combinables, pero nunca pueden superar el 35%
de descuento. El valor original de la cuota mensual es de $650.

La administración del Instituto nos solicitó diseñar la función monto-persona,
la cual recibe la cantidad de personas que se están anotando
y la cantidad de meses que abonan (para que se aplique la promoción
deben pagar la misma cantidad de meses), y devuelve el monto que el
Instituto debe cobrarle a cada uno. Para desarrollar monto-persona es
conveniente definir ciertas constantes, ya que los precios pueden variar
con el tiempo.

(define CUOTA 650) ; Valor de la cuota total
(define DIEZ-PORCIENTO (ceiling (/ CUOTA 10))) ; Valor del 10%
(define QUINCE-PORCIENTO (ceiling (/ (* CUOTA 15) 100))) ; Valor del 15%
(define VEINTE-PORCIENTO (ceiling (/ (* CUOTA  20) 100))) ; Valor del 20%
(define VEINTICINCO-PORCIENTO (ceiling (/ (* CUOTA 25) 100))) ; Valor del 25%
(define PORCIENTO-LIMITE (ceiling (/ (* CUOTA 35) 100))) ; Valor del porcentaje limite de las promociones (Valor actual: 35%)

(define PERSONAS-2 2) ; Cantidad de personas que se inscriben. Separa entre los valores de las promociones, basta modificarlos para cambiar las promos.
(define ABONO-2 2) ; Cantidad de meses de abono. Separa entre los valores de las promociones, basta modificarlos para cambiar las promos.

; Ejemplos:

(define (Personas P) ; Para valores naturales, obviamente.
  (cond [(< P PERSONAS-2) 0]
        [(= P PERSONAS-2) DIEZ-PORCIENTO]
        [else VEINTE-PORCIENTO]
  )
) 

(define (Abono A) ; Para valores naturales, obviamente.
  (cond [(< A ABONO-2) 0]
        [(= A ABONO-2) QUINCE-PORCIENTO]
        [else VEINTICINCO-PORCIENTO]
  )
)

(define (Promocion-total P A) (+ (Personas P) (Abono A))) ; Suma los valores de la promocion segun las personas y los meses de abono

(define (monto-persona P A)
  (cond [(<= (Promocion-total P A) PORCIENTO-LIMITE) (string-append "Monto: $" (number->string (- CUOTA (Promocion-total P A))))]
        [else (string-append "Monto: $" (number->string (- CUOTA PORCIENTO-LIMITE)))]
  )
)

(check-expect (monto-persona 2 1) "Monto: $585")
(check-expect (monto-persona 2 2) "Monto: $487")
(check-expect (monto-persona 5 3) "Monto: $422")

-------------------------------------------------------------------------------------------------------------------------------
|#
; Determinacion de los meses 
(define E-1MES 1)
(define E-6MESES 6)
(define E-12MESES 12)
(define E-60MESES 60)
(define E-120MESES 120)

; Determinacion de las cotas de los niveles de hemoglobina segun la edad
(define H-1MES 13)
(define H-6MESES 10)
(define H-12MESES 11)
(define H-60MESES 11.5)
(define H-120MESES 12.6)
(define H+120MESES H-1MES) ; H+120MESES = 13

; Determinacion de las constante anemia/no anemia.
(define ANEMIA #true)
(define NO-ANEMIA #false)

; Funcion que determina las cotas de hemoglobina segun la edad dada.
(define (Edad E)
  (cond
    [(<= E E-1MES) H-1MES]
    [(<= E E-6MESES) H-6MESES]
    [(<= E E-12MESES) H-12MESES]
    [(<= E E-60MESES) H-60MESES]
    [(<= E E-120MESES) H-120MESES]
    [else H+120MESES]
    )
  )

; Funcion que determina si se trata de una anemia o no.
(define (anemia E H)
  (cond
    [(<= H (Edad E)) ANEMIA]
    [else NO-ANEMIA]
    )
  )

; Ejemplos corroborados
(check-expect (anemia 64 13) #false)
(check-expect (anemia 1 12) #true)
(check-expect (anemia 200 13) #true)



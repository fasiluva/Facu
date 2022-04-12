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


|#
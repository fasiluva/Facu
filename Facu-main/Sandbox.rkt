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

; Estado = (make-posn x y)
; Interpretar: Estado -> Image

(define ALTO 500)
(define LARGO 500)
(define ESCENARIO (empty-scene LARGO ALTO "black"))
(define DELTA 30)
(define RADIO 20)
(define estadoInicial (make-posn (/ LARGO 2) (/ ALTO 2)))

(define (interpretar n) (place-image (circle RADIO "solid" "grey") (posn-x n) (posn-y n) ESCENARIO))

(define (evaluate-new-position-x n) (if (and
                                         (< (posn-x n) (- LARGO DELTA))
                                         (> (posn-x n) DELTA)) ; ambas no pueden ser falsas
                                            (+ (posn-x n) (- (random DELTA) (random DELTA)))
                                            (if (< (posn-x n) (- LARGO DELTA)) ; si x<480 => x<=delta
                                                (+ (posn-x n) 1)
                                                (- (posn-x n) 1) ;sino, x>=480 => x>delta
                                                )))

(define (evaluate-new-position-y n) (if (and
                                         (< (posn-y n) (- ALTO DELTA))
                                         (> (posn-y n) DELTA)) ; ambas no pueden ser falsas
                                            (+ (posn-y n) (- (random DELTA) (random DELTA)))
                                            (if (< (posn-y n) (- ALTO DELTA)) ; si x<480 => x<=delta
                                                (+ (posn-y n) 1)
                                                (- (posn-y n) 1) ;sino, x>=480 => x>delta
                                                )))

(define (mover n) (make-posn
                   (evaluate-new-position-x n)
                   (evaluate-new-position-y n)
                   )
  )

(big-bang estadoInicial
  [to-draw interpretar]
  [on-tick mover 0.05]) ; Estado -> Estado

(define-struct AutoS [model year oil autonomy]) ; Estructura a utilizar

; Costo-viaje: Struct String -> Number
; La funcion recibe los datos de la estructura y devuelve el coste del viaje. El coste seria la cantidad de km a recorrer
; dividido la autonomia del auto por el precio del combustible, mas el peaje.
(define (costo-viaje Auto km) (+
                               (* (/ km (autonomia (AutoS-year Auto) (AutoS-autonomy Auto))) (priceOil (AutoS-oil Auto)))
                               (peaje km)))

; usage: Number -> Number. Obtiene la cantidad de anios que pasaron desde el dia que se fabrico el auto (2017).
(define (usage year) (- 2017 year))

; <x>percent, x = {two,six,ten,fifty}. Number -> Number. Devuelve el porcentaje de la autonomia segun el numero en cuestion.
(define (twopercent autonomy) (/ (* 2 autonomy) 100))
(define (sixpercent autonomy) (/ (* 6 autonomy) 100))
(define (tenpercent autonomy) (/ (* 10 autonomy) 100))
(define (fiftypercent autonomy) (/ (* 15 autonomy) 100))

; autonomia: Number Number -> Number. Recibe el anio en el que se fabrico el auto, determina cuantos anios pasaron desde ese dia,
; y devuelve cuanto se disminuyo la autonomia segun los anios que pasaron.
(define (autonomia year autonomy) (cond [(<= (usage year) 5) (- autonomy (twopercent autonomy))]
                                        [(<= (usage year) 10) (- autonomy (sixpercent autonomy))]
                                        [(<= (usage year) 15) (- autonomy (tenpercent autonomy))]
                                        [(> (usage year) 15) (- autonomy (fiftypercent autonomy))]
                                        [else "que"]
                                        ))

; priceOil: String -> Number. Segun el combustible, el precio por litro del mismo.
(define (priceOil oil) (if (string=? oil "diesel") 17 19))

;peaje: Number -> Number. Segun la cantidad de km a recorrer, devuelve el monto de los peajes que pasaran.
(define (peaje km) (* (floor (/ km 100)) 50))

(check-within (costo-viaje (make-AutoS "gol" 2013 "nafta" 13) 450) 871.11 0.1)

(define-struct EstudianteS [name average percent]) ; Estructura a utilizar
(define L "Libre")
(define P "Promovido")
(define R "Regular")
(define ERROR "Tipo de dato incorrecto")

; condicion: Struct -> String. Obtiene la estructura, analiza el average de notas y el
; percent de notas. Segun eso, devuelve si el alumno esta promovido, regular o libre.
(define (condicion Estudiante) (evaluate (EstudianteS-name Estudiante)
                                         (EstudianteS-average Estudiante)
                                         (EstudianteS-percent Estudiante)))

; evaluate: String Number Number -> String. Evalua que los datos introducidos sean validos, es decir, que el nombre sea string,
; que el average y percent sean numeros, que average este entre 0 y 10 y que percent este entre 0 y 100. Sino devuelve un mensaje
; de error predefinido. Si esta todo bien, pasa a la siguiente funcion.
(define (evaluate name average percent) (cond [(and (string? name)
                                                    (and (number? average) (and (<= average 10) (>= average 0)))
                                                    (and (number? percent) (and (>= percent 0) (<= percent 100))))
                                               (asistencia percent average)]
                                              [else ERROR]))

; asistencia: Number -> String | Number. Recibe el percent y el average y analiza que condiciones cumple.
; si el percent es menor a 60, o es mayor a 60 y el average menor a 6 entonces esta libre. Si percent es mayor a 60 y el average
; menor a 8 y mayor a 6, entonces esta regular. Si el average es mayor a 8, esta promovido.
(define (asistencia percent average) (if (< percent 60)
                                         L
                                         (cond [(< average 6) L]
                                               [(< average 8) R]
                                               [(>= average 8) P])))

(check-expect (condicion (make-EstudianteS "scioli" 8 45)) L)
(check-expect (condicion (make-EstudianteS "pepe" 10 80)) P)
(check-expect (condicion (make-EstudianteS "celina" 7 80)) R)
(check-expect (condicion (make-EstudianteS 56 12 "si")) ERROR)

(define-struct CasaS [owner adress area zone])
(define INVALID-STRUCT "Algun/os de los datos de la casa fueron incorrectos. Por favor, reintentar.")
(define INVALID-ZONE "La zona no se definio correctament. Por favor, reintentar.")
; venta: Struct -> String. 
(define (venta C) (if (boolean=? (validStruct C) #t)
                      (string-append "el senior/a "
                                     (CasaS-owner C)
                                     " recibira "
                                     (if (number? (payment (CasaS-area C) (CasaS-zone C)))
                                         (number->string (payment (CasaS-area C) (CasaS-zone C)))
                                         INVALID-ZONE)
                                     " pesos por la venta de su propiedad ubicada en la calle "
                                     (CasaS-adress C))
                      INVALID-STRUCT))
(define (validStruct C) (if (CasaS? C)
                            (and
                             (string? (CasaS-owner C))
                             (string? (CasaS-adress C))
                             (number? (CasaS-area C))
                             (string? (CasaS-zone C)))
                            #false))

(define (payment a z) (cond [(= (zonePrices a z) -1) INVALID-ZONE]
                            [(> (zonePrices a z) 1000000) (- (zonePrices a z) (fivePercent (zonePrices a z)))]
                            [else (- (zonePrices a z) (threePercent (zonePrices a z)))]))
(define (fivePercent x) (/ (* 5 x) 100))
(define (threePercent x) (/ (* 3 x) 100))
(define (zonePrices a z) (cond [(string=? z "A") (* a 20000)]
                               [(string=? z "B") (* a 15000)]
                               [(string=? z "C") (* a 10000)]
                               [(string=? z "D") (* a 5000)]
                               [else -1]))

(check-expect (venta (make-CasaS "Jose Romero" "Rueda 3456" 120 "C")) "el senior/a Jose Romero recibira 1140000 pesos por la venta de su propiedad ubicada en la calle Rueda 3456")

(define LARGO 500)
(define ALTO 500)
(define ESCENARIO (empty-scene LARGO ALTO "black"))

; El estado es un string. La primera letra indica el sentido, la segunda el color.
(define estadoInicial "Dred")

(define (interpretar estado) (place-image (figura estado) (/ LARGO 2) (/ ALTO 2) ESCENARIO))

(define (cambioColor estado) (cond [(string=? (kolor? estado) "red") (string-append (sentido? estado) "yellow")] ;Dyellow
                                   [(string=? (kolor? estado) "green") (string-append (sentido? estado) "yellow")] ;Iyellow
                                   [(string=? (kolor? estado) "yellow")
                                    (cond [(string=? (sentido? estado) "Q") "Qyellow"]
                                          [(string=? (sentido? estado) "I") "Dred"]
                                          [(string=? (sentido? estado) "D") "Igreen"])
                                    ]
                                   [else estado]))

(define (detener estado tecla) (cond [(key=? tecla "p") "Qyellow"]
                                     [(key=? tecla "a") estadoInicial]
                                     [else estado]))
(define (clickear estado x y event) (cond [(string=? event "button-down") "Terminar"]
                                          [else estado]))

(define (terminar estado) (cond [(string=? estado "Terminar") #t]
                                [else #f]))
; Funciones auxiliares:
(define (sentido? estado) (string-ith estado 0))
(define (kolor? estado) (substring estado 1 (string-length estado)))
; figura: Estado -> image.
(define (figura estado) (circle 50 "solid" (kolor? estado)))

(big-bang estadoInicial
  [to-draw interpretar]
  [on-tick cambioColor 1]
  [on-key detener]
  [on-mouse clickear]
  [stop-when terminar]
  )

; con la tecla p se detiene en amarillo. con la a reinicia el ciclo desde rojo
; si se hace click en al imagen se termina el programa





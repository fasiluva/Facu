;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Sandbox) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; Pedido [String Number Number]
; menu = 1,2,3
; desert = 1,2
(define-struct Pedido[name menu desert])
; La lista gran-pedido-final representa cantidad de menues y postres.
(define-struct Pedido-final[m1 m2 m3 d1 d2])
; mi = cant de menues i= 1,2,3
; di = cant de desert i= 1,2

; ---------------------------------------------------------------------------

;(check-expect (armar-pedido-final (list (make-Pedido "g" 1 2) (make-Pedido "f" 2 2))) (make-Pedido-final 1 1 0 0 2))
; armar-pedido-final: List(Pedido) -> Struct[Pedido-final]
(define (armar-pedido-final l)(make-Pedido-final (cantmenu1 l)
                                                 ;(cantmenu2 l)
                                                 ;(cantmenu3 l)
                                                 ;(cantdesert1 l)
                                                 ;(cantdesert2 l)
                                                 )
  )

(define (cantmenu1 l) (cond [(empty? l) 0]
                            [(cons? l) (if (= (Pedido-menu (first l)) 1); // esta funcion debe repetirse de igual manera con los otros cantmenu(i)
                                           (+ 1 (cantmenu1 (rest l)));   // y cantdesert(i). 
                                           (cantmenu1 (rest l)))])) ; 

(check-expect (cantmenu1 (list (make-Pedido "g" 1 2) (make-Pedido "f" 2 2))) 1)
 
; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; peso / (altura^2) = IMC
; IMC /2 = Promedio

(define-struct Pers[peso altura])
; Pers[Number Number]

(define (IMC s) (/ (Pers-peso s) (sqr (Pers-altura s))))

(define (prom-imc l) (promedio (sum-IMC l) (cant-elementos l)))

(define (cant-elementos l) (cond [(empty? l) 0]
                                 [(cons? l) (+ 1 (cant-elementos (rest l)))]))

(define (sum-IMC l) (cond [(empty? l) 0]
                          [(cons? l) (+ (IMC (first l)) (sum-IMC (rest l)) )]))

(define (promedio x n) (/ x n))

(check-within (prom-imc (list (make-Pers 44 1.55) (make-Pers 50 1.56))) 19.43 0.01)

;/////////////////////////////////////////////////////////////////////////////////////

(define (clasif l) (cond [(empty? l) empty]
                         [(cons? l) (cons (clasif-IMC (IMC (first l))) (clasif (rest l)))]))

(define (clasif-IMC IMC) (cond [(< IMC 19.5) "Bajo peso"]
                               [(< IMC 25) "Peso normal"]
                               [(< IMC 30) "Sobrepeso"]
                               [(>= IMC 30) "Obesidad"]))

(check-expect (clasif (list (make-Pers 44 1.55) (make-Pers 50 1.56))) (list "Bajo peso" "Peso normal"))

;/////////////////////////////////////////////////////////////////////////////////////

(define (poblacionSaludable? l) (if (>= (saludables (clasif l) (cant-elementos l)) 0.8) #t #f))

(define (saludables l n) (/ (cant-saludables l) n))

(define (cant-saludables l) (cond [(empty? l) 0]
                                  [(cons? l) (+ (saludable? (first l)) (cant-saludables (rest l)))]))

(define (saludable? p) (if (string=? p "Peso normal") 1 0))

(check-expect (poblacionSaludable? (list (make-Pers 44 1.55) (make-Pers 50 1.56))) #f)

;/////////////////////////////////////////////////////////////////////////////////////

(define-struct cuad[color angle rotation])
; cuad[String Number Boolean]

(define LARGO 400)
(define ALTO 400)
(define ESCENARIO (empty-scene LARGO ALTO "black"))
(define LADO 50)
(define estadoInicial (make-cuad "red" 0 #t))
; ---------------------------------------------------------------------------
#|
(define (render estado) (place-image
                         (rotate (cuad-angle estado) (square LADO "solid" (cuad-color estado)))
                         (/ LARGO 2) (/ ALTO 2)
                         ESCENARIO))

(define (changeColor estado k) (cond [(key=? k " ") (make-cuad (cuad-color estado) (cuad-angle estado) (rotation? (cuad-rotation estado)))]
                                     [(key=? k "b") (make-cuad "blue" (cuad-angle estado) (cuad-rotation estado))]
                                     [(key=? k "r") (make-cuad "red" (cuad-angle estado) (cuad-rotation estado))]
                                     [else estado]))

(define (rotation? b) (if (boolean=? b #t) #f #t))

(define (rotation estado) (if (boolean=? (cuad-rotation estado) #f)
                              (make-cuad (cuad-color estado) (cuad-angle estado) #f)
                              (if (>= (+ (cuad-angle estado) 5) 360)
                                  (make-cuad (cuad-color estado) (- (+ 5 (cuad-angle estado)) 360) #t)
                                  (make-cuad (cuad-color estado) (+ (cuad-angle estado) 5) #t))))

(big-bang estadoInicial
  [to-draw render]
  [on-tick rotation]
  [on-key changeColor]
  )
|#

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

(define-struct Book[isbn name writer rate])
; Book[Any String String Number(1-10)]

(define user1 (list (make-Book 02 "Sex" "Valentin Sosa" 10) (make-Book 69 "Anal 2" "Valentin Sosa" 9)))
(define user2 (list (make-Book 02 "Sex" "Valentin Sosa" 1) (make-Book 69 "Anal 2" "Valentin Sosa" 1)))
(define user3 (list (make-Book 02 "Sex" "Valentin Sosa" 8) (make-Book 69 "Anal 2" "Valentin Sosa" 8)))

(define (coincide? b1 b2) (if (< (diferencia (Book-rate b1) (Book-rate b2)) 2) "La lectura es coincidente" "La lectura no es coincidente"))

(define (diferencia r1 r2) (abs (- r1 r2)))

(check-expect (coincide? (make-Book 0 "s" "s" 10) (make-Book 0 "s" "s" 9)) "La lectura es coincidente")
(check-expect (coincide? (make-Book 0 "s" "s" 10) (make-Book 0 "s" "s" 5)) "La lectura no es coincidente")

; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

(define (suma-positivos-es-mayor? l) (>=
                                      (abs (foldr + 0 (filter positive? (filter number? l))))
                                      (abs (foldr + 0 (filter positive? (filter number? l))))
                                      )
  )

(check-expect (suma-positivos-es-mayor? (list 5 "abc" 2 #t -3 "def")) #t)
(check-expect (suma-positivos-es-mayor? (list (circle 10 "solid" "red") 12 1 -2 -45)) #t)


















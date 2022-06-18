;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname GuitarRacket) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct Interface [tbajo
                          nv1 nr1 na1 nz1
                          nv2 nr2 na2 nz2
                          NV NR NA NZ])
; Interface[Number
;           Number Number Number Number
;           Number Number Number Number
;           Boolean Boolean Boolean Boolean]

(define LARGO 200)
(define ALTO 400)
(define TAM-NOTAS 20)
(define ESCENARIO (empty-scene LARGO ALTO "black"))
(define estadoInicial (make-Interface 0
                                      300 200 100 0
                                      150 220 300 0
                                      #f #f #f #f))
;-------------------------------------------------------------------------
; Tamanio de las notas (normales):
; c = circulo, v = verde(ej) 
(define cv (circle TAM-NOTAS "solid" "green"))
(define cr (circle TAM-NOTAS "solid" "red"))
(define ca (circle TAM-NOTAS "solid" "yellow"))
(define cz (circle TAM-NOTAS "solid" "blue"))

; Tamanio de las notas (al apretar)
(define PRESSED-KEY (circle TAM-NOTAS "solid" "white"))

;-------------------------------------------------------------------------
; Divisiones de pantalla horizontal:
; z = zona, v = azul(ej)
(define zv (* LARGO (/ 1 8)))
(define zr (* LARGO (/ 3 8)))
(define za (* LARGO (/ 5 8)))
(define zz (* LARGO (/ 7 8)))

; Division de pantalla vertical:
(define teclas (/ (* ALTO 92) 100))

; Punto de aciertos:
(define sucessLine (/ (* ALTO 80) 100))

;-------------------------------------------------------------------------
(define (render estado) (if (or 
                             (boolean=? (Interface-NV estado) #t)
                             (boolean=? (Interface-NR estado) #t)
                             (boolean=? (Interface-NA estado) #t)
                             (boolean=? (Interface-NZ estado) #t))
                            (place-image PRESSED-KEY zv teclas
                                         (place-image cv zv (Interface-nv1 estado)
                                                      (place-image cv zv (Interface-nv2 estado)
                                                                   (place-image PRESSED-KEY zr teclas
                                                                                (place-image cr zr (Interface-nr1 estado)
                                                                                             (place-image cr zr (Interface-nr2 estado)
                                                                                                          (place-image PRESSED-KEY za teclas
                                                                                                                       (place-image ca za (Interface-na1 estado)
                                                                                                                                    (place-image ca za (Interface-na2 estado)
                                                                                                                                                 (place-image PRESSED-KEY zz teclas
                                                                                                                                                              (place-image cz zz (Interface-nz1 estado)
                                                                                                                                                                           (place-image cz zz (Interface-nz2 estado)
                                                                                                                                                                                        ESCENARIO))))))))))))
                            (place-image cv zv teclas
                                         (place-image cv zv (Interface-nv1 estado)
                                                      (place-image cv zv (Interface-nv2 estado)
                                                                   (place-image cr zr teclas
                                                                                (place-image cr zr (Interface-nr1 estado)
                                                                                             (place-image cr zr (Interface-nr2 estado)
                                                                                                          (place-image ca za teclas
                                                                                                                       (place-image ca za (Interface-na1 estado)
                                                                                                                                    (place-image ca za (Interface-na2 estado)
                                                                                                                                                 (place-image cz zz teclas
                                                                                                                                                              (place-image cz zz (Interface-nz1 estado)
                                                                                                                                                                           (place-image cz zz (Interface-nz2 estado)
                                                                                                                                                                                        ESCENARIO))))))))))))))

(define (presionarTeclas estado tecla) (cond [(key=? tecla "a") (aciertoVerde estado)]
                                             [(key=? tecla "s") (aciertoRojo estado)]
                                             [(key=? tecla "k") (aciertoAmarillo estado)]
                                             [(key=? tecla "l") (aciertoAzul estado)]
                                             [else estado]))

(define (aciertoVerde estado)(cond [(>= (Interface-nv1 estado) sucessLine)
                                    (make-Interface (newTbajo estado)
                                                  (- (random 50) ALTO) (Interface-nr1 estado) (Interface-na1 estado) (Interface-nz1 estado)
                                                  (Interface-nv2 estado) (Interface-nr2 estado) (Interface-na2 estado) (Interface-nz2 estado)
                                                  #t #f #f #f)]
                                   [(>= (Interface-nv2 estado) sucessLine)
                                    (make-Interface (newTbajo estado)
                                                  (Interface-nv1 estado) (Interface-nr1 estado) (Interface-na1 estado) (Interface-nz1 estado)
                                                  (- (random 10) ALTO) (Interface-nr2 estado) (Interface-na2 estado) (Interface-nz2 estado)
                                                  #t #f #f #f)]
                                   [else estado]))

(define (aciertoRojo estado)(cond [(>= (Interface-nr1 estado) sucessLine)
                                   (make-Interface (newTbajo estado)
                                                  (Interface-nv1 estado) (- (random 60) ALTO) (Interface-na1 estado) (Interface-nz1 estado)
                                                  (Interface-nv2 estado) (Interface-nr2 estado) (Interface-na2 estado) (Interface-nz2 estado)
                                                  #f #t #f #f)]
                                   [(>= (Interface-nr2 estado) sucessLine)
                                    (make-Interface (newTbajo estado)
                                                    (Interface-nv1 estado) (Interface-nr1 estado) (Interface-na1 estado) (Interface-nz1 estado)
                                                    (Interface-nv2 estado) (- (random 50) ALTO) (Interface-na2 estado) (Interface-nz2 estado)
                                                    #t #f #f #f)]
                                   [else estado]))

(define (aciertoAmarillo estado)(cond [(>= (Interface-na1 estado) sucessLine)
                                       (make-Interface (newTbajo estado)
                                                       (Interface-nv1 estado) (Interface-nr1 estado) (- (random 50) ALTO) (Interface-nz1 estado)
                                                       (Interface-nv2 estado) (Interface-nr2 estado) (Interface-na2 estado) (Interface-nz2 estado)
                                                       #f #f #t #f)]
                                   [(>= (Interface-na2 estado) sucessLine)
                                    (make-Interface (newTbajo estado)
                                                  (Interface-nv1 estado) (Interface-nr1 estado) (Interface-na1 estado) (Interface-nz1 estado)
                                                  (Interface-nv2 estado) (Interface-nr2 estado) (- (random 20) ALTO) (Interface-nz2 estado)
                                                  #f #f #t #f)]
                                   [else estado]))

(define (aciertoAzul estado)(cond [(>= (Interface-nz1 estado) sucessLine)
                                    (make-Interface (newTbajo estado)
                                                  (Interface-nv1 estado) (Interface-nr1 estado) (Interface-na1 estado) (- (random 100) ALTO)
                                                  (Interface-nv2 estado) (Interface-nr2 estado) (Interface-na2 estado) (Interface-nz2 estado)
                                                  #f #f #f #t)]
                                   [(>= (Interface-nz2 estado) sucessLine)
                                    (make-Interface (newTbajo estado)
                                                  (Interface-nv1 estado) (Interface-nr1 estado) (Interface-na1 estado) (Interface-nz1 estado)
                                                  (Interface-nv2 estado) (Interface-nr2 estado) (Interface-na2 estado) (- (random 30) ALTO)
                                                  #f #f #f #t)]
                                   [else estado]))

(define (newTbajo estado) (+ 1 (max (Interface-nv1 estado)
                                    (Interface-nr1 estado)
                                    (Interface-na1 estado)
                                    (Interface-nz1 estado)
                                    (Interface-nv2 estado)
                                    (Interface-nr2 estado)
                                    (Interface-na2 estado)
                                    (Interface-nz2 estado))))

(define (deleteNote estado) (cond [(>= (Interface-nv1 estado) teclas)
                                   (make-Interface (newTbajo estado)
                                                   (random 20)
                                                   (Interface-nr1 estado)
                                                   (Interface-na1 estado)
                                                   (Interface-nz1 estado)
                                                   (Interface-nv2 estado)
                                                   (Interface-nr2 estado)
                                                   (Interface-na2 estado)
                                                   (Interface-nz2 estado)
                                                   #f #f #f #f)]
                                  [(>= (Interface-nr1 estado) teclas)
                                   (make-Interface (newTbajo estado)
                                                   (Interface-nv1 estado)
                                                   (random 10)
                                                   (Interface-na1 estado)
                                                   (Interface-nz1 estado)
                                                   (Interface-nv2 estado)
                                                   (Interface-nr2 estado)
                                                   (Interface-na2 estado)
                                                   (Interface-nz2 estado)
                                                   #f #f #f #f)]
                                  [(>= (Interface-na1 estado) teclas)
                                   (make-Interface (newTbajo estado)
                                                   (Interface-nv1 estado)
                                                   (Interface-nr1 estado)
                                                   (random 30)
                                                   (Interface-nz1 estado)
                                                   (Interface-nv2 estado)
                                                   (Interface-nr2 estado)
                                                   (Interface-na2 estado)
                                                   (Interface-nz2 estado)
                                                   #f #f #f #f)]
                                  [(>= (Interface-nz1 estado) teclas)
                                   (make-Interface (newTbajo estado)
                                                   (Interface-nv1 estado)
                                                   (Interface-nr1 estado)
                                                   (Interface-na1 estado)
                                                   (random 50)
                                                   (Interface-nv2 estado)
                                                   (Interface-nr2 estado)
                                                   (Interface-na2 estado)
                                                   (Interface-nz2 estado)
                                                   #f #f #f #f)]
                                  [(>= (Interface-nv2 estado) teclas)
                                   (make-Interface (newTbajo estado)
                                                   (Interface-nv1 estado)
                                                   (Interface-nr1 estado)
                                                   (Interface-na1 estado)
                                                   (Interface-nz1 estado)
                                                   (random 25)
                                                   (Interface-nr2 estado)
                                                   (Interface-na2 estado)
                                                   (Interface-nz2 estado)
                                                   #f #f #f #f)]
                                  [(>= (Interface-nr2 estado) teclas)
                                   (make-Interface (newTbajo estado)
                                                   (Interface-nv1 estado)
                                                   (Interface-nr1 estado)
                                                   (Interface-na1 estado)
                                                   (Interface-nz1 estado)
                                                   (Interface-nv2 estado)
                                                   (random 10)
                                                   (Interface-na2 estado)
                                                   (Interface-nz2 estado)
                                                   #f #f #f #f)]
                                  [(>= (Interface-na2 estado) teclas)
                                   (make-Interface (newTbajo estado)
                                                   (Interface-nv1 estado)
                                                   (Interface-nr1 estado)
                                                   (Interface-na1 estado)
                                                   (Interface-nz1 estado)
                                                   (Interface-nv2 estado)
                                                   (Interface-nr2 estado)
                                                   0
                                                   (Interface-nz2 estado)
                                                   #f #f #f #f)]
                                  [(>= (Interface-nz2 estado) teclas)
                                   (make-Interface (newTbajo estado)
                                                   (Interface-nv1 estado)
                                                   (Interface-nr1 estado)
                                                   (Interface-na1 estado)
                                                   (Interface-nz1 estado)
                                                   (Interface-nv2 estado)
                                                   (Interface-nr2 estado)
                                                   (Interface-na2 estado)
                                                   (random 15)
                                                   #f #f #f #f)]
                                  [else (make-Interface 0
                                                        (Interface-nv1 estado)
                                                        (Interface-nr1 estado)
                                                        (Interface-na1 estado)
                                                        (Interface-nz1 estado)
                                                        (Interface-nv2 estado)
                                                        (Interface-nr2 estado)
                                                        (Interface-na2 estado)
                                                        (Interface-nz2 estado)
                                                        #f #f #f #f)]))

(define (notes estado) (cond [(< (Interface-tbajo estado) teclas)
                              (make-Interface (newTbajo estado)
                                              (+ 1 (Interface-nv1 estado))
                                              (+ 1 (Interface-nr1 estado))
                                              (+ 1 (Interface-na1 estado))
                                              (+ 1 (Interface-nz1 estado))
                                              (+ 1 (Interface-nv2 estado))
                                              (+ 1 (Interface-nr2 estado))
                                              (+ 1 (Interface-na2 estado))
                                              (+ 1 (Interface-nz2 estado))
                                              #f #f #f #f)]
                             [(>= (Interface-tbajo estado) teclas) (deleteNote estado)]
                             [else estado]))

(big-bang estadoInicial
  [to-draw render]
  [on-tick notes 0.002]
  [on-key presionarTeclas]
  )
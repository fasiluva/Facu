# C:\Users\USUARIO\Documents\GitHub\Facu\Facu-main\Python => Notebook
# D:\Facu\Facu-main\Python => PC

# Hacer un programa que reciba una lista introducida por el usuario con 3 campos, que representan los componentes de
# un vector. Devolver el modulo, distancia del origen a la recta y las ecuaciones.

import math

def vector_direccion(w1, w2, v1, v2):
	global u1, u2 
	u1 = w1 - v1
	u2 = w2 - v2
	vectorDireccion = list((u1, u2))
	print("\nEl vector direccion es: " , vectorDireccion)

def recta_parametrica(w1, w2):
	x = "x = {0} + ({1}.t)" 
	y = "y = {0} + ({1}.t)"
	print("\nRecta parametrica:")
	print(x.format(w1, u1))
	print(y.format(w2, u2))

def recta_cartesiana(w1, w2):
	global a, b, c
	a = -u2
	b = u1
	c = -((a * w1) + (b * w2))
	r = "({0}x) + ({1}y) + ({2}) = 0" 
	print("\nRecta cartesiana:")
	print(r.format(a, b, c))

def recta_segmentaria():
	corteX = -(c/a)
	corteY = -(c/b)
	r = "x/({0}) + y/({1}) = 1"
	print("\nRecta segmentaria:")
	print(r.format(corteX, corteY))

def recta_explicita():
	m = -(a/b)
	h = -(c/b)
	r = "({0})x + ({1})"
	print("\nRecta explicita:")
	print(r.format(m, h))

def dist_origen():
	origen = abs(c) / (math.sqrt(pow(a, 2) + pow(b, 2)))
	print("\nDistancia del origen a la recta: ", origen)

separador = "-----------------------------------------------------------------"

def modulo(x, y, z, vector):
	longitud = math.sqrt(math.pow(x, 2) + math.pow(y, 2) + math.pow(z, 2))
	print("\nEl modulo  del vector " , vector , " es: "  , longitud)

w1 = int(input("Introduzca la primer componente: "))
w2 = int(input("Introduzca la segunda componente: "))
w3 = int(input("Introduzca la tercera componente: "))
print("El vector w es " , list((w1, w2, w3)))

v1 = int(input("\nIntroduzca la primer componente: "))
v2 = int(input("Introduzca la segunda componente: "))
v3 = int(input("Introduzca la tercera componente: "))
print("El vector v es " , list((v1, v2, v3)))

if w3 == 0 and v3 == 0:
	print(separador)
	modulo(w1, w2, w3, "w")
	modulo(v1, v2, v3, "v")
	print(separador)	
	vector_direccion(w1, w2, v1, v2)
	recta_parametrica(w1, w2)
	print(separador)
	recta_cartesiana(w1, w2)
	print(separador)
	if b != 0:
		recta_explicita()
		print(separador)
		if a != 0 and b != 0:
			recta_segmentaria()	
			print(separador)
			dist_origen()			
else:
	print(separador)
	modulo(w1, w2, w3, "w")
	modulo(v1, v2, v3, "v")	
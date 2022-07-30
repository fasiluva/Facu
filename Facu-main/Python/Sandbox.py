# cd C:\Users\USUARIO\Documents\GitHub\Facu\Facu-main\Python

import SandboxModule as sm
import tkinter as tk
from tkinter import ttk

# ---------------------------------------------------------------------------

root = tk.Tk() # Crea la ventana principal. El contenido de la misma es asignado mediante root.<propiedad>

def convertir_temp():
    temp_celsius = float(caja_temp_celsius.get()) #Toma el valor que posee la variable con el atributo .get()
    
    temp_kelvin = temp_celsius + 273.15 #Realiza la conversion a kelvin
    temp_fahrenheit = temp_celsius*1.8 + 32 #Realiza la conversion a fahrenheit
    
    etiqueta_temp_kelvin.config(text=f"Temperatura en K: {temp_kelvin}") 
    #Modifica el valor que tiene la variable, con el atributo .config()
    # Dato: f"string" se usa como .format(). Implementar.
    etiqueta_temp_fahrenheit.config(text=f"Temperatura en ºF: {temp_fahrenheit}")

# ---------------------------------------------------------------------------

root.title("Conversor de temperatura: ") #Le da un titulo a la ventana
root.geometry("400x300") # Cambia el tamaño de la ventana principal.

# ---------------------------------------------------------------------------

etiqueta_temp_celsius = ttk.Label(text="Temperatura en ºC:") # Crea un widget que pone un texto.
etiqueta_temp_celsius.place(x=20, y=20) # El .place lo posiciona en la ventana de manera ABSOLUTA.

caja_temp_celsius = ttk.Entry() #Crea un widget para el input del usuario
caja_temp_celsius.place(x=140, y=20, width=60) # Lo posiciona en la ventana y le da un tamaño

boton_convertir = ttk.Button(text="Convertir", command=convertir_temp) 
#Crea un widget boton, con el texto indicado
#Command le asigna una funcion que se ejecuta cuando el boton es presionado
boton_convertir.place(x=20, y=60) 

# ---------------------------------------------------------------------------

etiqueta_temp_kelvin = ttk.Label(text="Temperatura en K: n/a")
etiqueta_temp_kelvin.place(x=20, y=120)

etiqueta_temp_fahrenheit = ttk.Label(text="Temperatura en ºF: n/a")
etiqueta_temp_fahrenheit.place(x=20, y=160)

# ---------------------------------------------------------------------------

root.mainloop() # Muestra la ventana al usuario. Siempre va al final.
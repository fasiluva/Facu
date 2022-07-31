# cd C:\Users\USUARIO\Documents\GitHub\Facu\Facu-main\Python

from turtle import bgcolor
import SandboxModule as sm
import tkinter as tk
from tkinter import ttk

# ---------------------------------------------------------------------------

root = tk.Tk() # Crea la ventana principal. El contenido de la misma es asignado mediante root.<propiedad>

# ---------------------------------------------------------------------------

root.title("Conversor de temperatura: ") #Le da un titulo a la ventana
root.geometry("400x300") # Cambia el tamaño de la ventana principal.
root.config(background="black")

# ---------------------------------------------------------------------------

texto1 = ttk.Label(root, text="Hola")
texto1.config(foreground="red", background="red")
texto1.pack()

texto2 = ttk.Label(root, text="Chau")
texto2.pack() 

""" 
Si .pack(), el objeto no se presenta en la imagen 
Para hacer un "ejecutable" de un GUI poner .pyw en la extension del archivo
"""

# ---------------------------------------------------------------------------

root.mainloop() # Muestra la ventana al usuario. Siempre va al final.
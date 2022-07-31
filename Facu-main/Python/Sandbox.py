# cd C:\Users\USUARIO\Documents\GitHub\Facu\Facu-main\Python

import pandas as pd
import matplotlib.pyplot as plt

diccionarioDeDatos = {
    'Product': ["Fideos", "Lavandina", "Arroz"],
    'Price': [100, 150, 80],
    'ID': [100, 101, 102],
    'Stock': [10, 12, 30]
}

indexado = ["P1", "P2", "P3"]

dataFrame = pd.DataFrame(diccionarioDeDatos, index=indexado) 

print(dataFrame.to_string()) 
print(dataFrame.loc['P1']['Price']) #Obtiene un valor de un index 
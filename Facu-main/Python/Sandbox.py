# cd C:\Users\USUARIO\Documents\GitHub\Facu\Facu-main\Python

import SandboxModule as sm
import re
import json

materials_list = open("SandboxFile.txt", "rt")

for line in materials_list:
	mat = re.split(",", line)
	sm.makeMaterialDict(mat)

print(sm.materials_dict['Tierra']['Presencia'])

materials_list.close()

""" 
Para acceder a un key dentro de un dict dentro de otro dict:
dict1['dict1.1']['key']
En el ejemplo de abajo: Materials_dict["madera"]["presencia"] ==> 'Presencia alta'

Materials_dict: {
	"tierra": {
		Estado: solido
		explosivo: False
		presencia: alta
	}
	"madera": {
		Estado: solido
		explosivo: False
		presencia: media
	}
	"aire": aire,
	"metal": metal
}

aire = {
	"name" = "aire"
	"estado" = "solido"
	"explosivo" = False
	"presencia" = "alta"
}
 """


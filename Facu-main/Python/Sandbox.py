# cd C:\Users\USUARIO\Documents\GitHub\Facu\Facu-main\Python

import SandboxModule as sm
import re
import json

materials_list = open("SandboxFile.txt", "rt")

for line in materials_list:
	mat = re.split(",", line)
	sm.makeMaterialDict(mat)

print(sm.materials_dict)

materials_list.close()

json_dumped = json.dumps(sm.materials_dict)
print(json_dumped)

""" 
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
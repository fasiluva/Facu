materials_dict = {}

def makeMaterialDict(mat):
	material1 = {
		"Nombre": mat[0],
		"Estado": mat[1],
		"Explosivo": mat[2],
		"Presencia": mat[3]
	}
	materials_dict[mat[0]] = material1


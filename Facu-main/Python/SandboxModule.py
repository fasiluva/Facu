materials_dict = {}

def makeMaterialDict(mat):
	material_propertys = {
		"Nombre": mat[0].rstrip(),
		"Estado": mat[1].rstrip(),
		"Explosivo": mat[2].rstrip(),
		"Presencia": mat[3].rstrip()
	}
	materials_dict[mat[0]] = material_propertys


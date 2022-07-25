Dom, Img = [], []

def makeArray(): 
	try:
		array_Elementx = int(input("Add a point to the Domain: "))
	except:
		pass
	else: 
		array_Elementy = int(input("Add a point to the Image: "))
		Dom.append(array_Elementx)
		Img.append(array_Elementy)
		del array_Elementy
		del array_Elementx
		makeArray()	



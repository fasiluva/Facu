numberList = list(("aaaaaa", "so", "sdsadasd", "sa"))
oddList = []

for x in numberList:
  if len(x) < 5:
    oddList.append(x)

print(oddList)
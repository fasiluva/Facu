# C:\Users\USUARIO\Documents\GitHub\Facu\Facu-main\Python

f = open("SandboxFile.txt", "wt")

text_input = str(input("Escribe algo para el archivo: "))
f.write(text_input)
f.close()

f = open("SandboxFile.txt", "rt")
print(f.read(5))
f.close()



from ast import If
from cmath import sqrt
from socket import IPV6_DONTFRAG


# ---------------------------------------------------------------------------
# Definicion de las variables a usar:

a1, a2, a3 = 1, 2, -3

def resolvente(a, b, c): 
    x1 = ( (-b + sqrt((pow (b, 2)) - (4 * a * c))) / (2 * a))
    x2 = ( (-b - sqrt((pow (b, 2)) - (4 * a * c))) / (2 * a))
    return x1, x2

print(resolvente(a1, a2, a3))
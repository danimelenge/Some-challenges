import os
import time

# Definimos el tamaño del laberinto
TAMANO_LABERINTO = 6

# Definimos los diferentes símbolos para representar el laberinto
VACIO = "⬜️"
OBSTACULO = "⬛️"
MICKEY = "🐭"
SALIDA = "🚪"

# Creamos la matriz del laberinto
laberinto = [
    [VACIO, VACIO, OBSTACULO, VACIO, VACIO, VACIO],
    [VACIO, OBSTACULO, VACIO, OBSTACULO, VACIO, VACIO],
    [VACIO, VACIO, VACIO, VACIO, OBSTACULO, VACIO],
    [OBSTACULO, VACIO, OBSTACULO, VACIO, VACIO, VACIO],
    [VACIO, VACIO, VACIO, OBSTACULO, VACIO, OBSTACULO],
    [MICKEY, VACIO, VACIO, VACIO, VACIO, SALIDA]
]

# Posición inicial de Mickey
posicion_mickey = (5, 0)

# Función para imprimir el laberinto
def imprimir_laberinto():
    os.system('cls' if os.name == 'nt' else 'clear')
    for fila in laberinto:
        print(" ".join(fila))
    print("\n")

# Función para mover a Mickey
def mover_mickey(direccion):
    global posicion_mickey  # Mueve esta línea al inicio de la función
    fila_actual, columna_actual = posicion_mickey
    nueva_fila, nueva_columna = fila_actual, columna_actual

    # Determinamos la nueva posición según la dirección ingresada
    if direccion == "arriba":
        nueva_fila -= 1
    elif direccion == "abajo":
        nueva_fila += 1
    elif direccion == "izquierda":
        nueva_columna -= 1
    elif direccion == "derecha":
        nueva_columna += 1
    else:
        print("Dirección no válida. Usa 'arriba', 'abajo', 'izquierda' o 'derecha'.")
        return False

    # Validamos que la nueva posición esté dentro de los límites del laberinto
    if nueva_fila < 0 or nueva_fila >= TAMANO_LABERINTO or nueva_columna < 0 or nueva_columna >= TAMANO_LABERINTO:
        print("¡Movimiento no permitido! Has intentado salirte del laberinto.")
        return False

    # Validamos que no haya un obstáculo en la nueva posición
    if laberinto[nueva_fila][nueva_columna] == OBSTACULO:
        print("¡Movimiento bloqueado! Hay un obstáculo en esa dirección.")
        return False

    # Actualizamos la posición de Mickey
    laberinto[fila_actual][columna_actual] = VACIO
    laberinto[nueva_fila][nueva_columna] = MICKEY
    posicion_mickey = (nueva_fila, nueva_columna)

    # Comprobar si Mickey ha llegado a la salida
    if laberinto[nueva_fila][nueva_columna] == SALIDA:
        return True

    return False


# Función principal para ejecutar el juego
def jugar():
    print("¡Bienvenido al laberinto mágico! Ayuda a Mickey a escapar.")
    imprimir_laberinto()

    while True:
        direccion = input("¿Hacia dónde quieres mover a Mickey? (arriba, abajo, izquierda, derecha): ").lower()
        exito = mover_mickey(direccion)
        imprimir_laberinto()

        # Si Mickey llega a la salida, termina el juego
        if exito:
            print("¡Felicidades! Mickey ha encontrado la salida. ¡Has ganado!")
            break

# Inicia el juego
jugar()

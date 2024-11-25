import Foundation

/*
 * EJERCICIO:
 * ¡Disney ha presentado un montón de novedades en su D23!
 * Pero... ¿Dónde está Mickey?
 * Mickey Mouse ha quedado atrapado en un laberinto mágico
 * creado por Maléfica.
 * Desarrolla un programa para ayudarlo a escapar.
 * Requisitos:
 * 1. El laberinto está formado por un cuadrado de 6x6 celdas.
 * 2. Los valores de las celdas serán:
 *    - ⬜️ Vacío
 *    - ⬛️ Obstáculo
 *    - 🐭 Mickey
 *    - 🚪 Salida
 * Acciones:
 * 1. Crea una matriz que represente el laberinto (no hace falta
 * que se genere de manera automática).
 * 2. Interactúa con el usuario por consola para preguntarle hacia
 * donde se tiene que desplazar (arriba, abajo, izquierda o derecha).
 * 3. Muestra la actualización del laberinto tras cada desplazamiento.
 * 4. Valida todos los movimientos, teniendo en cuenta los límites
 * del laberinto y los obtáculos. Notifica al usuario.
 * 5. Finaliza el programa cuando Mickey llegue a la salida.
 */


// Definimos el tamaño del laberinto
let TAMANO_LABERINTO = 6

// Definimos los diferentes símbolos para representar el laberinto
let VACIO = "⬜️"
let OBSTACULO = "⬛️"
let MICKEY = "🐭"
let SALIDA = "🚪"

// Creamos la matriz del laberinto
var laberinto = [
    [VACIO, VACIO, OBSTACULO, VACIO, VACIO, VACIO],
    [VACIO, OBSTACULO, VACIO, OBSTACULO, VACIO, VACIO],
    [VACIO, VACIO, VACIO, VACIO, OBSTACULO, VACIO],
    [OBSTACULO, VACIO, OBSTACULO, VACIO, VACIO, VACIO],
    [VACIO, VACIO, VACIO, OBSTACULO, VACIO, OBSTACULO],
    [MICKEY, VACIO, VACIO, VACIO, VACIO, SALIDA]
]

// Posición inicial de Mickey
var posicionMickey = (fila: 5, columna: 0)

// Función para imprimir el laberinto
func imprimirLaberinto() {
    for fila in laberinto {
        print(fila.joined(separator: " "))
    }
    print("\n")
}

// Función para mover a Mickey
func moverMickey(direccion: String) -> Bool {
    let (filaActual, columnaActual) = posicionMickey
    var nuevaFila = filaActual
    var nuevaColumna = columnaActual
    
    // Determinamos la nueva posición según la dirección ingresada
    switch direccion.lowercased() {
    case "arriba":
        nuevaFila -= 1
    case "abajo":
        nuevaFila += 1
    case "izquierda":
        nuevaColumna -= 1
    case "derecha":
        nuevaColumna += 1
    default:
        print("Dirección no válida. Usa 'arriba', 'abajo', 'izquierda' o 'derecha'.")
        return false
    }
    
    // Validamos que la nueva posición esté dentro de los límites del laberinto
    if nuevaFila < 0 || nuevaFila >= TAMANO_LABERINTO || nuevaColumna < 0 || nuevaColumna >= TAMANO_LABERINTO {
        print("¡Movimiento no permitido! Has intentado salirte del laberinto.")
        return false
    }
    
    // Validamos que no haya un obstáculo en la nueva posición
    if laberinto[nuevaFila][nuevaColumna] == OBSTACULO {
        print("¡Movimiento bloqueado! Hay un obstáculo en esa dirección.")
        return false
    }
    
    // Actualizamos la posición de Mickey
    laberinto[filaActual][columnaActual] = VACIO
    laberinto[nuevaFila][nuevaColumna] = MICKEY
    posicionMickey = (nuevaFila, nuevaColumna)
    
    // Comprobar si Mickey ha llegado a la salida
    if laberinto[nuevaFila][nuevaColumna] == SALIDA {
        return true
    }
    
    return false
}

// Función principal para ejecutar el juego
func jugar() {
    print("¡Bienvenido al laberinto mágico! Ayuda a Mickey a escapar.")
    imprimirLaberinto()
    
    while true {
        print("¿Hacia dónde quieres mover a Mickey? (arriba, abajo, izquierda, derecha):")
        if let direccion = readLine() {
            let exito = moverMickey(direccion: direccion)
            imprimirLaberinto()
            
            // Si Mickey llega a la salida, termina el juego
            if exito {
                print("¡Felicidades! Mickey ha encontrado la salida. ¡Has ganado!")
                break
            }
        }
    }
}

// Inicia el juego
jugar()


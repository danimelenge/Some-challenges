import Foundation

/*
 * EJERCICIO:
 * ¡Cada año celebramos el aDEViento! 24 días, 24 regalos para
 * developers. Del 1 al 24 de diciembre: https://adviento.dev
 *
 * Dibuja un calendario por terminal e implementa una
 * funcionalidad para seleccionar días y mostrar regalos.
 * - El calendario mostrará los días del 1 al 24 repartidos
 *   en 6 columnas a modo de cuadrícula.
 * - Cada cuadrícula correspondiente a un día tendrá un tamaño
 *   de 4x3 caracteres, y sus bordes serán asteríscos.
 * - Las cuadrículas dejarán un espacio entre ellas.
 * - En el medio de cada cuadrícula aparecerá el día entre el
 *   01 y el 24.
 *
 * Ejemplo de cuadrículas:
 * **** **** ****
 * *01* *02* *03* ...
 * **** **** ****
 *
 * - El usuario seleccioná qué día quiere descubrir.
 * - Si está sin descubrir, se le dirá que ha abierto ese día
 *   y se mostrará de nuevo el calendario con esa cuadrícula
 *   cubierta de asteríscos (sin mostrar el día).
 *
 * Ejemplo de selección del día 1
 * **** **** ****
 * **** *02* *03* ...
 * **** **** ****
 *
 * - Si se selecciona un número ya descubierto, se le notifica
 *   al usuario.
 */

// Tamaño del calendario
let filas = 4
let columnas = 6

// Crear un array para almacenar el estado de los días (false = no descubierto, true = descubierto)
var diasDescubiertos = Array(repeating: false, count: 24)

// Función para dibujar el calendario
func dibujarCalendario() {
    for fila in 0..<filas {
        // Dibujar la fila superior de cada cuadrícula
        for _ in 0..<columnas {
            print("**** ", terminator: "")
        }
        print()
        
        // Dibujar el contenido de cada cuadrícula (día o asteriscos si está descubierto)
        for col in 0..<columnas {
            let dia = fila * columnas + col + 1
            if dia <= 24 {
                if diasDescubiertos[dia - 1] {
                    print("**** ", terminator: "")
                } else {
                    print("*\(String(format: "%02d", dia))* ", terminator: "")
                }
            }
        }
        print()
        
        // Dibujar la fila inferior de cada cuadrícula
        for _ in 0..<columnas {
            print("**** ", terminator: "")
        }
        print()
    }
}

// Función para seleccionar un día
func seleccionarDia() {
    print("Selecciona un día (1-24): ", terminator: "")
    if let entrada = readLine(), let dia = Int(entrada), dia >= 1, dia <= 24 {
        if diasDescubiertos[dia - 1] {
            print("El día \(dia) ya está descubierto.")
        } else {
            print("¡Has abierto el día \(dia)! 🎁")
            diasDescubiertos[dia - 1] = true
        }
    } else {
        print("Entrada no válida. Por favor, introduce un número entre 1 y 24.")
    }
}

// Main loop
while true {
    dibujarCalendario()
    seleccionarDia()
    print("\n¿Quieres continuar? (s/n): ", terminator: "")
    if let respuesta = readLine(), respuesta.lowercased() == "n" {
        break
    }
}

print("¡Feliz aDEViento! 🎄")

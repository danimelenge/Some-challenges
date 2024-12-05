import Foundation

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

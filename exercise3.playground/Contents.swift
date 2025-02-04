import Foundation

/*
 * EJERCICIO:
 * ¡La temporada 2 de "Los Anillos de Poder" está a punto de estrenarse!
 * ¿Qué pasaría si tuvieras que encargarte de repartir los anillos
 * entre las razas de la Tierra Media?
 * Desarrolla un programa que se encargue de distribuirlos.
 * Requisitos:
 * 1. Los Elfos recibirán un número impar.
 * 2. Los Enanos un número primo.
 * 3. Los Hombres un número par.
 * 4. Sauron siempre uno.
 * Acciones:
 * 1. Crea un programa que reciba el número total de anillos
 *    y busque una posible combinación para repartirlos.
 * 2. Muestra el reparto final o el error al realizarlo.
 */

func esPrimo(_ numero: Int) -> Bool {
    if numero < 2 { return false }
    for i in 2..<Int(sqrt(Double(numero))) + 1 {
        if numero % i == 0 { return false }
    }
    return true
}

func repartirAnillos(totalAnillos: Int) -> String {
    if totalAnillos < 4 {
        return "Error: No hay suficientes anillos para repartir."
    }

    // Sauron siempre recibe 1 anillo
    let anillosSauron = 1
    var anillosRestantes = totalAnillos - anillosSauron

    // Repartimos un número impar para los Elfos
    var anillosElfos = 1
    while anillosElfos <= anillosRestantes && anillosElfos % 2 == 0 {
        anillosElfos += 2
    }
    if anillosElfos > anillosRestantes {
        return "Error: No es posible repartir los anillos de forma válida."
    }
    anillosRestantes -= anillosElfos

    // Repartimos un número primo para los Enanos
    var anillosEnanos = 2
    while anillosEnanos <= anillosRestantes && !esPrimo(anillosEnanos) {
        anillosEnanos += 1
    }
    if anillosEnanos > anillosRestantes {
        return "Error: No es posible repartir los anillos de forma válida."
    }
    anillosRestantes -= anillosEnanos

    // Lo que quede será para los Hombres (debe ser par)
    if anillosRestantes % 2 == 0 {
        let anillosHombres = anillosRestantes
        return """
        Reparto de anillos:
        - Sauron: \(anillosSauron) anillo(s)
        - Elfos: \(anillosElfos) anillo(s)
        - Enanos: \(anillosEnanos) anillo(s)
        - Hombres: \(anillosHombres) anillo(s)
        """
    } else {
        return "Error: No es posible repartir los anillos de forma válida."
    }
}

// Programa principal
print("¡Distribuidor de anillos de la Tierra Media!")
print("Introduce el número total de anillos: ", terminator: "")

if let input = readLine(), let totalAnillos = Int(input) {
    let resultado = repartirAnillos(totalAnillos: totalAnillos)
    print("\n\(resultado)")
} else {
    print("Por favor, introduce un número válido.")
}

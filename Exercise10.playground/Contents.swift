import Foundation

/*
 * EJERCICIO:
 * ¡Ha comenzado diciembre! Es hora de montar nuestro
 * árbol de Navidad...
 *
 * Desarrolla un programa que cree un árbol de Navidad
 * con una altura dinámica definida por el usuario por terminal.
 *
 * Ejemplo de árbol de altura 5 (el tronco siempre será igual):
 *
 *     *
 *    ***
 *   *****
 *  *******
 * *********
 *    |||
 *    |||
 *
 * El usuario podrá seleccionar las siguientes acciones:
 *
 * - Añadir o eliminar la estrella en la copa del árbol (@)
 * - Añadir o eliminar bolas de dos en dos (o) aleatoriamente
 * - Añadir o eliminar luces de tres en tres (+) aleatoriamente
 * - Apagar (*) o encender (+) las luces (conservando su posición)
 * - Una luz y una bola no pueden estar en el mismo sitio
 *
 * Sólo puedes añadir una estrella, y tantas luces o bolas
 * como tengan cabida en el árbol. El programa debe notificar
 * cada una de las acciones (o por el contrario, cuando no
 * se pueda realizar alguna).
 */

class ChristmasTree {
    var height: Int
    var hasStar: Bool = true
    var decorations: [(type: String, row: Int, col: Int)] = []
    var lightsOn: Bool = true

    init(height: Int) {
        self.height = height
    }

    func render() {
        var tree = [String]()

        // Construcción del árbol
        for i in 0..<height {
            let width = 2 * i + 1
            var level = Array(repeating: " ", count: 2 * height - 1)
            let start = height - 1 - i

            for j in 0..<width {
                level[start + j] = "*"
            }

            // Aplicar decoraciones
            for decoration in decorations where decoration.row == i {
                let index = height - 1 - i + decoration.col
                if level[index] == "*" {
                    if decoration.type == "+" && lightsOn {
                        level[index] = "+"
                    } else if decoration.type == "o" {
                        level[index] = "o"
                    }
                }
            }

            tree.append(level.joined())
        }

        // Añadir la estrella
        if hasStar {
            var starLine = Array(repeating: " ", count: 2 * height - 1)
            starLine[height - 1] = "@"
            tree.insert(starLine.joined(), at: 0)
        }

        // Añadir el tronco
        let trunkWidth = 3
        let trunkStart = height - 1 - trunkWidth / 2
        var trunkLine = Array(repeating: " ", count: 2 * height - 1)

        for _ in 0..<2 {
            for i in 0..<trunkWidth {
                trunkLine[trunkStart + i] = "|"
            }
            tree.append(trunkLine.joined())
        }

        // Renderizar árbol
        print(tree.joined(separator: "\n"))
    }

    func toggleStar() {
        hasStar.toggle()
        let status = hasStar ? "añadida" : "eliminada"
        print("Estrella \(status).")
    }

    func addDecoration(type: String, count: Int) {
        var added = 0

        while added < count {
            let row = Int.random(in: 0..<height)
            let col = Int.random(in: 0...(2 * row))

            if !decorations.contains(where: { $0.row == row && $0.col == col }) {
                decorations.append((type: type, row: row, col: col))
                added += 1
            }
        }

        print("\(added) decoraciones de tipo '\(type)' añadidas.")
    }

    func removeDecoration(type: String, count: Int) {
        let initialCount = decorations.count
        decorations.removeAll(where: { $0.type == type && count > 0 })
        let removed = initialCount - decorations.count
        print("\(removed) decoraciones de tipo '\(type)' eliminadas.")
    }

    func toggleLights() {
        lightsOn.toggle()
        let status = lightsOn ? "encendidas" : "apagadas"
        print("Luces \(status).")
    }
}

func main() {
    print("Introduce la altura del árbol: ", terminator: "")
    guard let input = readLine(), let height = Int(input), height > 0 else {
        print("Altura no válida.")
        return
    }

    let tree = ChristmasTree(height: height)

    while true {
        print("""
        Opciones:
        1. Añadir/eliminar estrella (@)
        2. Añadir bolas (o)
        3. Eliminar bolas (o)
        4. Añadir luces (+)
        5. Eliminar luces (+)
        6. Apagar/encender luces (*)
        7. Mostrar árbol
        8. Salir
        """)
        print("Elige una opción: ", terminator: "")
        guard let option = readLine() else { continue }

        switch option {
        case "1":
            tree.toggleStar()
        case "2":
            tree.addDecoration(type: "o", count: 2)
        case "3":
            tree.removeDecoration(type: "o", count: 2)
        case "4":
            tree.addDecoration(type: "+", count: 3)
        case "5":
            tree.removeDecoration(type: "+", count: 3)
        case "6":
            tree.toggleLights()
        case "7":
            tree.render()
        case "8":
            print("¡Feliz Navidad!")
            return
        default:
            print("Opción no válida.")
        }
    }
}

main()

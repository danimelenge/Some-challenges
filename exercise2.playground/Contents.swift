/*
 * EJERCICIO:
 * ¡La Casa del Dragón ha finalizado y no volverá hasta 2026!
 * ¿Alguien se entera de todas las relaciones de parentesco
 * entre personajes que aparecen en la saga?
 * Desarrolla un árbol genealógico para relacionarlos (o invéntalo).
 * Requisitos:
 * 1. Estará formado por personas con las siguientes propiedades:
 *    - Identificador único (obligatorio)
 *    - Nombre (obligatorio)
 *    - Pareja (opcional)
 *    - Hijos (opcional)
 * 2. Una persona sólo puede tener una pareja (para simplificarlo).
 * 3. Las relaciones deben validarse dentro de lo posible.
 *    Ejemplo: Un hijo no puede tener tres padres.
 * Acciones:
 * 1. Crea un programa que permita crear y modificar el árbol.
 *    - Añadir y eliminar personas
 *    - Modificar pareja e hijos
 * 2. Podrás imprimir el árbol (de la manera que consideres).
 *
 * NOTA: Ten en cuenta que la complejidad puede ser alta si
 * se implementan todas las posibles relaciones. Intenta marcar
 * tus propias reglas y límites para que te resulte asumible.
 */

import Foundation

class Persona {
    let id: String
    let nombre: String
    var pareja: Persona?
    var hijos: [Persona]

    init(id: String, nombre: String) {
        self.id = id
        self.nombre = nombre
        self.hijos = []
    }

    func descripcion() -> String {
        let parejaDesc = pareja?.nombre ?? "Ninguna"
        let hijosDesc = hijos.isEmpty ? "Ninguno" : hijos.map { $0.nombre }.joined(separator: ", ")
        return "\(nombre) (\(id)) - Pareja: \(parejaDesc), Hijos: \(hijosDesc)"
    }
}

class ArbolGenealogico {
    private var personas: [String: Persona] = [:]

    func agregarPersona(id: String, nombre: String) {
        guard personas[id] == nil else {
            print("Error: Ya existe una persona con este ID.")
            return
        }
        personas[id] = Persona(id: id, nombre: nombre)
        print("Persona \(nombre) añadida con éxito.")
    }

    func eliminarPersona(id: String) {
        guard let persona = personas[id] else {
            print("Error: No existe ninguna persona con este ID.")
            return
        }
        // Romper relaciones con pareja e hijos
        if let pareja = persona.pareja {
            pareja.pareja = nil
        }
        for hijo in persona.hijos {
            if let index = hijo.hijos.firstIndex(where: { $0.id == id }) {
                hijo.hijos.remove(at: index)
            }
        }
        personas.removeValue(forKey: id)
        print("Persona \(persona.nombre) eliminada con éxito.")
    }

    func asignarPareja(id1: String, id2: String) {
        guard let persona1 = personas[id1], let persona2 = personas[id2] else {
            print("Error: Uno o ambos IDs no existen.")
            return
        }
        guard id1 != id2 else {
            print("Error: Una persona no puede ser pareja de sí misma.")
            return
        }
        guard persona1.pareja == nil, persona2.pareja == nil else {
            print("Error: Una o ambas personas ya tienen pareja.")
            return
        }
        persona1.pareja = persona2
        persona2.pareja = persona1
        print("\(persona1.nombre) y \(persona2.nombre) ahora son pareja.")
    }

    func eliminarPareja(id: String) {
        guard let persona = personas[id], let pareja = persona.pareja else {
            print("Error: No existe pareja asignada para esta persona.")
            return
        }
        persona.pareja = nil
        pareja.pareja = nil
        print("Pareja eliminada entre \(persona.nombre) y \(pareja.nombre).")
    }

    func asignarHijo(idPadre: String, idHijo: String) {
        guard let padre = personas[idPadre], let hijo = personas[idHijo] else {
            print("Error: Uno o ambos IDs no existen.")
            return
        }
        guard !padre.hijos.contains(where: { $0.id == idHijo }) else {
            print("Error: \(hijo.nombre) ya es hijo de \(padre.nombre).")
            return
        }
        padre.hijos.append(hijo)
        print("\(hijo.nombre) ahora es hijo de \(padre.nombre).")
    }

    func imprimirArbol() {
        print("\n--- Árbol Genealógico ---")
        for persona in personas.values {
            print(persona.descripcion())
        }
        print("\n")
    }
}

// Programa principal
let arbol = ArbolGenealogico()

func mostrarMenu() {
    print("\n--- Menú del Árbol Genealógico ---")
    print("1. Añadir persona")
    print("2. Eliminar persona")
    print("3. Asignar pareja")
    print("4. Eliminar pareja")
    print("5. Asignar hijo")
    print("6. Imprimir árbol")
    print("7. Salir")
}

while true {
    mostrarMenu()
    if let opcion = readLine() {
        switch opcion {
        case "1":
            print("ID de la persona:")
            let id = readLine() ?? ""
            print("Nombre de la persona:")
            let nombre = readLine() ?? ""
            arbol.agregarPersona(id: id, nombre: nombre)
        case "2":
            print("ID de la persona a eliminar:")
            let id = readLine() ?? ""
            arbol.eliminarPersona(id: id)
        case "3":
            print("ID de la primera persona:")
            let id1 = readLine() ?? ""
            print("ID de la segunda persona:")
            let id2 = readLine() ?? ""
            arbol.asignarPareja(id1: id1, id2: id2)
        case "4":
            print("ID de la persona:")
            let id = readLine() ?? ""
            arbol.eliminarPareja(id: id)
        case "5":
            print("ID del padre/madre:")
            let idPadre = readLine() ?? ""
            print("ID del hijo:")
            let idHijo = readLine() ?? ""
            arbol.asignarHijo(idPadre: idPadre, idHijo: idHijo)
        case "6":
            arbol.imprimirArbol()
        case "7":
            print("¡Hasta luego!")
            exit(0)
        default:
            print("Opción no válida.")
        }
    }
}

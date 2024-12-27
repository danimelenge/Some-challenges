/*
 * EJERCICIO:
 * El nuevo año está a punto de comenzar...
 * ¡Voy a ayudarte a planificar tus propósitos de nuevo año!
 *
 * Programa un gestor de objetivos con las siguientes características:
 * - Permite añadir objetivos (máximo 10)
 * - Calcular el plan detallado
 * - Guardar la planificación
 *
 * Cada entrada de un objetivo está formado por (con un ejemplo):
 * - Meta: Leer libros
 * - Cantidad: 12
 * - Unidades: libros
 * - Plazo (en meses): 12 (máximo 12)
 *
 * El cálculo del plan detallado generará la siguiente salida:
 * - Un apartado para cada mes
 * - Un listado de objetivos calculados a cumplir en cada mes
 *   (ejemplo: si quiero leer 12 libros, dará como resultado
 *   uno al mes)
 * - Cada objetivo debe poseer su nombre, la cantidad de
 *   unidades a completar en cada mes y su total. Por ejemplo:
 *
 *   Enero:
 *   [ ] 1. Leer libros (1 libro/mes). Total: 12.
 *   [ ] 2. Estudiar Git (1 curso/mes). Total: 1.
 *   Febrero:
 *   [ ] 1. Leer libros (1 libro/mes). Total: 12.
 *   ...
 *   Diciembre:
 *   [ ] 1. Leer libros (1 libro/mes). Total: 12.
 *
 * - Si la duración es menor a un año, finalizará en el mes
 *   correspondiente.
 *
 * Por último, el cálculo detallado debe poder exportarse a .txt
 * (No subir el fichero)
 */

import Foundation

// Representa un objetivo con meta, cantidad, unidades y plazo.
struct Goal {
    let meta: String
    let cantidad: Int
    let unidades: String
    let plazo: Int

    func monthlyPlan() -> Int {
        return cantidad / plazo
    }
}

// Gestiona los objetivos y permite añadirlos y calcular la planificación mensual.
class GoalManager {
    private var goals: [Goal] = []
    private let monthNames = [
        "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    ]

    func addGoal(meta: String, cantidad: Int, unidades: String, plazo: Int) {
        guard goals.count < 10 else {
            print("⚠️ No puedes añadir más de 10 objetivos.")
            return
        }

        guard plazo <= 12 else {
            print("⚠️ El plazo no puede exceder los 12 meses.")
            return
        }

        let newGoal = Goal(meta: meta, cantidad: cantidad, unidades: unidades, plazo: plazo)
        goals.append(newGoal)
        print("✅ Objetivo añadido: \(meta), \(cantidad) \(unidades), plazo: \(plazo) meses.")
    }

    func calculatePlan() -> [String: [String]] {
        var plan: [String: [String]] = [:]

        for (monthIndex, monthName) in monthNames.enumerated() {
            plan[monthName] = []

            for (goalIndex, goal) in goals.enumerated() {
                if monthIndex < goal.plazo {
                    let monthlyQuantity = goal.monthlyPlan()
                    let task = "[ ] \(goalIndex + 1). \(goal.meta) (\(monthlyQuantity) \(goal.unidades)/mes). Total: \(goal.cantidad)."
                    plan[monthName]?.append(task)
                }
            }
        }

        return plan
    }

    func displayPlan(_ plan: [String: [String]]) {
        for (month, tasks) in plan {
            print("\n\(month):")
            for task in tasks {
                print(task)
            }
        }
    }

    func exportPlan(_ plan: [String: [String]], to filename: String = "plan_detallado.txt") {
        let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)

        var content = ""
        for (month, tasks) in plan {
            content += "\(month):\n"
            for task in tasks {
                content += "\(task)\n"
            }
            content += "\n"
        }

        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            print("✅ Plan exportado a \(fileURL.path)")
        } catch {
            print("❌ Error al exportar el plan: \(error.localizedDescription)")
        }
    }
}

// Menú interactivo
func main() {
    let manager = GoalManager()

    print("🎯 Gestor de objetivos de Año Nuevo 🎯")
    while true {
        print("\nMenú:")
        print("1. Añadir un objetivo")
        print("2. Calcular el plan detallado")
        print("3. Exportar el plan a un archivo")
        print("4. Salir")

        if let choice = readLine() {
            switch choice {
            case "1":
                print("Meta:", terminator: " ")
                let meta = readLine() ?? ""
                print("Cantidad:", terminator: " ")
                let cantidad = Int(readLine() ?? "0") ?? 0
                print("Unidades:", terminator: " ")
                let unidades = readLine() ?? ""
                print("Plazo (en meses, máx. 12):", terminator: " ")
                let plazo = Int(readLine() ?? "0") ?? 0

                manager.addGoal(meta: meta, cantidad: cantidad, unidades: unidades, plazo: plazo)

            case "2":
                let plan = manager.calculatePlan()
                manager.displayPlan(plan)

            case "3":
                let plan = manager.calculatePlan()
                manager.exportPlan(plan)

            case "4":
                print("¡Adiós! 😊")
                return

            default:
                print("❌ Opción inválida, inténtalo de nuevo.")
            }
        }
    }
}

main()

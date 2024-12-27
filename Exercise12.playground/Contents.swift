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

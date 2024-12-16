import Foundation

/*
 * Crea una función que sume 2 números y retorne su resultado pasados
 * unos segundos.
 * - Recibirá por parámetros los 2 números a sumar y los segundos que
 *   debe tardar en finalizar su ejecución.
 * - Si el lenguaje lo soporta, deberá retornar el resultado de forma
 *   asíncrona, es decir, sin detener la ejecución del programa principal.
 *   Se podría ejecutar varias veces al mismo tiempo.
 */

// MARK: - Función asíncrona para sumar dos números después de un retraso
func asyncSum(a: Int, b: Int, delaySeconds: TimeInterval, completion: @escaping (Int) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + delaySeconds) {
        let result = a + b
        print("Resultado de sumar \(a) + \(b) después de \(delaySeconds) segundos: \(result)")
        completion(result)
    }
}

// MARK: - Función principal para demostrar la ejecución
func main() {
    // Crear un grupo de tareas para manejar múltiples ejecuciones simultáneas
    let dispatchGroup = DispatchGroup()
    
    // Ejecutar varias sumas simultáneamente
    dispatchGroup.enter()
    asyncSum(a: 3, b: 5, delaySeconds: 2) { result in
        print("Resultado final de la primera suma: \(result)")
        dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    asyncSum(a: 10, b: 20, delaySeconds: 3) { result in
        print("Resultado final de la segunda suma: \(result)")
        dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    asyncSum(a: 7, b: 8, delaySeconds: 1) { result in
        print("Resultado final de la tercera suma: \(result)")
        dispatchGroup.leave()
    }
    
    // Esperar a que todas las tareas terminen
    dispatchGroup.notify(queue: .main) {
        print("Todas las tareas han finalizado.")
    }
}

// Ejecutar la función principal
main()

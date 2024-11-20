import Foundation

func batallaEpica() {
    print("¡Bienvenido a la batalla épica entre Deadpool y Wolverine!")
    
    // Solicitar vida inicial de los personajes
    print("Introduce la vida inicial de Deadpool:")
    guard let vidaDeadpoolInput = readLine(), let vidaDeadpoolInicial = Int(vidaDeadpoolInput) else {
        print("Entrada inválida para la vida de Deadpool.")
        return
    }
    
    print("Introduce la vida inicial de Wolverine:")
    guard let vidaWolverineInput = readLine(), let vidaWolverineInicial = Int(vidaWolverineInput) else {
        print("Entrada inválida para la vida de Wolverine.")
        return
    }
    
    // Variables de vida
    var vidaDeadpool = vidaDeadpoolInicial
    var vidaWolverine = vidaWolverineInicial
    
    // Probabilidades de evasión
    let probabilidadEvasionDeadpool = 0.25
    let probabilidadEvasionWolverine = 0.20
    
    // Control de turnos
    var turno = 1
    var turnoDeadpoolBloqueado = false
    var turnoWolverineBloqueado = false
    
    // Bucle de batalla
    while vidaDeadpool > 0 && vidaWolverine > 0 {
        print("\n--- Turno \(turno) ---")
        sleep(1) // Pausa de 1 segundo entre turnos
        
        // Deadpool ataca si no está bloqueado
        if !turnoDeadpoolBloqueado {
            if Double.random(in: 0...1) > probabilidadEvasionWolverine {
                let danoDeadpool = Int.random(in: 10...100)
                print("Deadpool ataca e inflige \(danoDeadpool) de daño a Wolverine.")
                if danoDeadpool == 100 {
                    print("¡Golpe máximo de Deadpool! Wolverine pierde el próximo turno.")
                    turnoWolverineBloqueado = true
                }
                vidaWolverine -= danoDeadpool
            } else {
                print("Wolverine esquiva el ataque de Deadpool.")
            }
        } else {
            print("Deadpool se está recuperando y no puede atacar.")
            turnoDeadpoolBloqueado = false
        }
        
        // Verificar si Wolverine sigue en batalla
        if vidaWolverine <= 0 {
            break
        }
        
        // Wolverine ataca si no está bloqueado
        if !turnoWolverineBloqueado {
            if Double.random(in: 0...1) > probabilidadEvasionDeadpool {
                let danoWolverine = Int.random(in: 10...120)
                print("Wolverine ataca e inflige \(danoWolverine) de daño a Deadpool.")
                if danoWolverine == 120 {
                    print("¡Golpe máximo de Wolverine! Deadpool pierde el próximo turno.")
                    turnoDeadpoolBloqueado = true
                }
                vidaDeadpool -= danoWolverine
            } else {
                print("Deadpool esquiva el ataque de Wolverine.")
            }
        } else {
            print("Wolverine se está recuperando y no puede atacar.")
            turnoWolverineBloqueado = false
        }
        
        // Mostrar la vida de los personajes
        print("Vida actual de Deadpool: \(max(0, vidaDeadpool))")
        print("Vida actual de Wolverine: \(max(0, vidaWolverine))")
        
        turno += 1
    }
    
    // Resultado final
    print("\n--- Fin de la Batalla ---")
    if vidaDeadpool > 0 {
        print("¡Deadpool es el ganador!")
    } else {
        print("¡Wolverine es el ganador!")
    }
}

// Ejecutar la función de batalla
batallaEpica()

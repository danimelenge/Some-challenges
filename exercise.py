# ¡Deadpool y Wolverine se enfrentan en una batalla épica!
# Crea un programa que simule la pelea y determine un ganador.
# El programa simula un combate por turnos, donde cada protagonista posee unos
# puntos de vida iniciales, un daño de ataque variable y diferentes cualidades
# de regeneración y evasión de ataques.

import random
import time

def pelea_epica():
    # Configuración inicial
    print("¡Bienvenido a la batalla épica entre Deadpool y Wolverine!")
    
    # Vida inicial de cada protagonista proporcionada por el usuario
    vida_deadpool = int(input("Introduce la vida inicial de Deadpool: "))
    vida_wolverine = int(input("Introduce la vida inicial de Wolverine: "))
    
    # Probabilidades de evasión
    prob_evasion_deadpool = 0.25
    prob_evasion_wolverine = 0.20
    
    turno = 1
    siguiente_turno_deadpool = True
    siguiente_turno_wolverine = True

    while vida_deadpool > 0 and vida_wolverine > 0:
        print(f"\n--- Turno {turno} ---")
        time.sleep(1)  # Pausa de 1 segundo entre turnos
        
        # Deadpool ataca si puede
        if siguiente_turno_deadpool:
            if random.random() > prob_evasion_wolverine:
                dano_deadpool = random.randint(10, 100)
                print(f"Deadpool ataca e inflige {dano_deadpool} de daño a Wolverine.")
                if dano_deadpool == 100:
                    print("¡Deadpool golpea con daño máximo! Wolverine pierde su próximo turno.")
                    siguiente_turno_wolverine = False  # Wolverine pierde su turno
                vida_wolverine -= dano_deadpool
            else:
                print("Wolverine esquiva el ataque de Deadpool.")
        else:
            siguiente_turno_deadpool = True  # Recupera su turno para la próxima ronda
        
        # Verificar si Wolverine sigue en la batalla
        if vida_wolverine <= 0:
            break
        
        # Wolverine ataca si puede
        if siguiente_turno_wolverine:
            if random.random() > prob_evasion_deadpool:
                dano_wolverine = random.randint(10, 120)
                print(f"Wolverine ataca e inflige {dano_wolverine} de daño a Deadpool.")
                if dano_wolverine == 120:
                    print("¡Wolverine golpea con daño máximo! Deadpool pierde su próximo turno.")
                    siguiente_turno_deadpool = False  # Deadpool pierde su turno
                vida_deadpool -= dano_wolverine
            else:
                print("Deadpool esquiva el ataque de Wolverine.")
        else:
            siguiente_turno_wolverine = True  # Recupera su turno para la próxima ronda
        
        # Mostrar las vidas de cada personaje
        print(f"Vida actual de Deadpool: {vida_deadpool}")
        print(f"Vida actual de Wolverine: {vida_wolverine}")

        turno += 1

    # Resultado final
    print("\n--- Fin de la Batalla ---")
    if vida_deadpool > 0:
        print("¡Deadpool es el ganador!")
    else:
        print("¡Wolverine es el ganador!")

# Ejecutar la simulación de la pelea
pelea_epica()

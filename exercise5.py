# #47 CALENDARIO DE ADVIENTO
# > #### Dificultad: Fácil | Publicación: 25/11/24 | Corrección: 02/12/24
#
# ## Ejercicio
#
# ```
# /*
#  * EJERCICIO:
#  * ¡Cada año celebramos el aDEViento! 24 días, 24 regalos para
#  * developers. Del 1 al 24 de diciembre: https://adviento.dev
#  * 
#  * Dibuja un calendario por terminal e implementa una
#  * funcionalidad para seleccionar días y mostrar regalos.
#  * - El calendario mostrará los días del 1 al 24 repartidos
#  *   en 6 columnas a modo de cuadrícula.
#  * - Cada cuadrícula correspondiente a un día tendrá un tamaño 
#  *   de 4x3 caracteres, y sus bordes serán asteríscos.
#  * - Las cuadrículas dejarán un espacio entre ellas.
#  * - En el medio de cada cuadrícula aparecerá el día entre el
#  *   01 y el 24.
#  *
#  * Ejemplo de cuadrículas:
#  * **** **** ****
#  * *01* *02* *03* ...
#  * **** **** ****
#  *
#  * - El usuario seleccioná qué día quiere descubrir.
#  * - Si está sin descubrir, se le dirá que ha abierto ese día
#  *   y se mostrará de nuevo el calendario con esa cuadrícula
#  *   cubierta de asteríscos (sin mostrar el día).
#  *
#  * Ejemplo de selección del día 1
#  * **** **** ****
#  * **** *02* *03* ...
#  * **** **** ****
#  *   
#  * - Si se selecciona un número ya descubierto, se le notifica
#  *   al usuario.
#  */
# ```
# #### Tienes toda la información extendida sobre el roadmap de retos de programación en **[retosdeprogramacion.com/roadmap](https://retosdeprogramacion.com/roadmap)**.
#
# Sigue las **[instrucciones](../../README.md)**, consulta las correcciones y aporta la tuya propia utilizando el lenguaje de programación que quieras.
#
# > Recuerda que cada semana se publica un nuevo ejercicio y se corrige el de la semana anterior en directo desde **[Twitch](https://twitch.tv/mouredev)**. Tienes el horario en la sección "eventos" del servidor de **[Discord](https://discord.gg/mouredev)**.


# Inicializar el estado de los días (False = no descubierto, True = descubierto)
dias_descubiertos = [False] * 24

# Función para dibujar el calendario
def dibujar_calendario():
    print("\nCalendario aDEViento 🎄")
    for fila in range(4):  # 4 filas (24 días divididos entre 6 columnas)
        # Dibujar la fila superior de cada cuadrícula
        for _ in range(6):
            print("**** ", end="")
        print()
        
        # Dibujar los días en la fila actual
        for col in range(6):
            dia = fila * 6 + col + 1
            if dia <= 24:  # Solo dibujar hasta el día 24
                if dias_descubiertos[dia - 1]:
                    print("**** ", end="")  # Día descubierto
                else:
                    print(f"*{str(dia).zfill(2)}* ", end="")  # Día no descubierto
        print()
        
        # Dibujar la fila inferior de cada cuadrícula
        for _ in range(6):
            print("**** ", end="")
        print()
    print()

# Función para seleccionar un día
def seleccionar_dia():
    try:
        dia = int(input("Selecciona un día (1-24): "))
        if dia < 1 or dia > 24:
            print("Por favor, selecciona un día entre 1 y 24.")
        elif dias_descubiertos[dia - 1]:
            print(f"El día {dia} ya está descubierto. ¡Intenta con otro!")
        else:
            dias_descubiertos[dia - 1] = True
            print(f"¡Has abierto el día {dia}! 🎁")
    except ValueError:
        print("Por favor, introduce un número válido.")

# Bucle principal
def main():
    print("¡Bienvenido al calendario de aDEViento! 🎅")
    while True:
        dibujar_calendario()
        seleccionar_dia()
        # Preguntar si el usuario quiere continuar
        continuar = input("\n¿Quieres descubrir otro día? (s/n): ").lower()
        if continuar == "n":
            print("\n¡Feliz aDEViento! 🎄")
            break

# Ejecutar el programa principal
if __name__ == "__main__":
    main()

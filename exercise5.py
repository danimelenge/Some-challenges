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

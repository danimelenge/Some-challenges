def es_primo(numero):
    if numero < 2:
        return False
    for i in range(2, int(numero ** 0.5) + 1):
        if numero % i == 0:
            return False
    return True


def repartir_anillos(total_anillos):
    if total_anillos < 4:  # Mínimo: 1 para Sauron, 1 impar, 1 primo, 1 par
        return "Error: No hay suficientes anillos para repartir."

    # Sauron siempre recibe 1 anillo
    anillos_sauron = 1
    total_anillos -= anillos_sauron

    # Repartimos un número impar para los Elfos
    anillos_elfos = 1
    while anillos_elfos <= total_anillos and anillos_elfos % 2 == 0:
        anillos_elfos += 2
    if anillos_elfos > total_anillos:
        return "Error: No es posible repartir anillos de forma válida."
    total_anillos -= anillos_elfos

    # Repartimos un número primo para los Enanos
    anillos_enanos = 2
    while anillos_enanos <= total_anillos and not es_primo(anillos_enanos):
        anillos_enanos += 1
    if anillos_enanos > total_anillos:
        return "Error: No es posible repartir anillos de forma válida."
    total_anillos -= anillos_enanos

    # Lo que quede será para los Hombres (debe ser par)
    if total_anillos % 2 == 0:
        anillos_hombres = total_anillos
    else:
        return "Error: No es posible repartir anillos de forma válida."

    # Devolvemos el reparto
    return {
        "Sauron": anillos_sauron,
        "Elfos": anillos_elfos,
        "Enanos": anillos_enanos,
        "Hombres": anillos_hombres
    }


# Programa principal
if __name__ == "__main__":
    print("¡Distribuidor de anillos de la Tierra Media!")
    try:
        total_anillos = int(input("Introduce el número total de anillos: "))
        resultado = repartir_anillos(total_anillos)
        if isinstance(resultado, dict):
            print("\nReparto de anillos:")
            for raza, cantidad in resultado.items():
                print(f"- {raza}: {cantidad} anillo(s)")
        else:
            print(f"\n{resultado}")
    except ValueError:
        print("Por favor, introduce un número válido.")

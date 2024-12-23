import random

def generate_secret_code():
    """
    Genera un código secreto aleatorio de 4 caracteres.
    Letras: A, B, C; Números: 1, 2, 3.
    """
    pool = ['A', 'B', 'C', '1', '2', '3']
    return ''.join(random.sample(pool, 4))  # Asegura que no haya repetidos.

def validate_input(user_input):
    """
    Valida que la entrada del usuario cumpla con los requisitos:
    - Longitud de 4 caracteres.
    - Contiene solo caracteres permitidos (A, B, C, 1, 2, 3).
    """
    if len(user_input) != 4:
        return False, "El código debe tener exactamente 4 caracteres."
    if not all(char in 'ABC123' for char in user_input):
        return False, "El código solo puede contener las letras A, B, C y los números 1, 2, 3."
    if len(set(user_input)) != 4:
        return False, "El código no puede tener caracteres repetidos."
    return True, ""

def give_feedback(secret_code, user_input):
    """
    Proporciona retroalimentación al usuario sobre su intento.
    - Correcto: Si el caracter está en la posición correcta.
    - Presente: Si el caracter existe pero está en la posición incorrecta.
    - Incorrecto: Si el caracter no está en el código secreto.
    """
    feedback = []
    for i, char in enumerate(user_input):
        if char == secret_code[i]:
            feedback.append("Correcto")
        elif char in secret_code:
            feedback.append("Presente")
        else:
            feedback.append("Incorrecto")
    return feedback

def play_game():
    """
    Juego principal: el usuario tiene 10 intentos para adivinar el código secreto.
    """
    secret_code = generate_secret_code()
    attempts = 10

    print("¡Bienvenido al juego de Papá Noel!")
    print("Intenta adivinar el código secreto de 4 caracteres (A, B, C, 1, 2, 3).")
    print("Tienes 10 intentos. ¡Buena suerte!\n")

    while attempts > 0:
        user_input = input(f"Intento {11 - attempts}/10 - Ingresa tu código: ").upper()
        
        is_valid, error_message = validate_input(user_input)
        if not is_valid:
            print(f"Error: {error_message}")
            continue
        
        if user_input == secret_code:
            print("¡Felicidades! Has adivinado el código secreto.")
            return

        feedback = give_feedback(secret_code, user_input)
        print("Retroalimentación:", feedback)
        attempts -= 1

    print(f"\nLo siento, has agotado tus intentos. El código secreto era: {secret_code}.")
    print("Papá Noel no podrá repartir los regalos. 😢")

# Ejecutar el juego
play_game()

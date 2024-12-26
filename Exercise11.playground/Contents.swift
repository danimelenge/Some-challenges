/*
 * EJERCICIO:
 * Papá Noel tiene que comenzar a repartir los regalos...
 * ¡Pero ha olvidado el código secreto de apertura del almacén!
 *
 * Crea un programa donde introducir códigos y obtener pistas.
 *
 * Código:
 * - El código es una combinación de letras y números aleatorios
 *   de longitud 4. (Letras: de la A a la C, Números: del 1 al 3)
 * - No hay repetidos.
 * - Se genera de manera aleatoria al iniciar el programa.
 *
 * Usuario:
 * - Dispone de 10 intentos para acertarlo.
 * - En cada turno deberá escribir un código de 4 caracteres, y
 *   el programa le indicará para cada uno lo siguiente:
 *   - Correcto: Si el caracter está en la posición correcta.
 *   - Presente: Si el caracter existe, pero esa no es su posición.
 *   - Incorrecto: Si el caracter no existe en el código secreto.
 * - Deben controlarse errores de longitud y caracteres soportados.
 *
 * Finalización:
 * - Papa Noel gana si descrifra el código antes de 10 intentos.
 * - Pierde si no lo logra, ya que no podría entregar los regalos.
 */

import Foundation

// Genera el código secreto aleatorio
func generateSecretCode() -> String {
    let pool = ["A", "B", "C", "1", "2", "3"]
    return pool.shuffled().prefix(4).joined()
}

// Valida que la entrada del usuario cumpla con los requisitos
func validateInput(_ userInput: String) -> (Bool, String) {
    let allowedCharacters = "ABC123"
    guard userInput.count == 4 else {
        return (false, "El código debe tener exactamente 4 caracteres.")
    }
    guard Set(userInput).allSatisfy({ allowedCharacters.contains($0) }) else {
        return (false, "El código solo puede contener las letras A, B, C y los números 1, 2, 3.")
    }
    guard Set(userInput).count == 4 else {
        return (false, "El código no puede tener caracteres repetidos.")
    }
    return (true, "")
}

// Proporciona retroalimentación sobre el intento del usuario
func giveFeedback(secretCode: String, userInput: String) -> [String] {
    var feedback: [String] = []
    for (index, char) in userInput.enumerated() {
        if secretCode[secretCode.index(secretCode.startIndex, offsetBy: index)] == char {
            feedback.append("Correcto")
        } else if secretCode.contains(char) {
            feedback.append("Presente")
        } else {
            feedback.append("Incorrecto")
        }
    }
    return feedback
}

// Juego principal
func playGame() {
    let secretCode = generateSecretCode()
    var attempts = 10

    print("🎅 ¡Bienvenido al juego de Papá Noel!")
    print("Intenta adivinar el código secreto de 4 caracteres (A, B, C, 1, 2, 3).")
    print("Tienes 10 intentos. ¡Buena suerte!\n")

    while attempts > 0 {
        print("Intento \(11 - attempts)/10 - Ingresa tu código:")
        if let userInput = readLine()?.uppercased() {
            let (isValid, errorMessage) = validateInput(userInput)
            if !isValid {
                print("❌ Error: \(errorMessage)")
                continue
            }

            if userInput == secretCode {
                print("🎉 ¡Felicidades! Has adivinado el código secreto.")
                return
            }

            let feedback = giveFeedback(secretCode: secretCode, userInput: userInput)
            print("🔍 Retroalimentación: \(feedback.joined(separator: ", "))")
            attempts -= 1
        }
    }

    print("\n😢 Lo siento, has agotado tus intentos. El código secreto era: \(secretCode).")
    print("Papá Noel no podrá repartir los regalos.")
}

// Inicia el juego
playGame()

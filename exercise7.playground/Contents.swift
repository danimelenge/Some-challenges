import Foundation

// Enunciado: Crea un programa que sea capaz de transformar texto natural a código morse y viceversa.
// Debe detectar automáticamente de qué tipo se trata y realizar la conversión.
// En morse se soporta raya "—", punto ".", un espacio " " entre letras o símbolos y dos espacios entre palabras "  ".
// El alfabeto morse soportado será el mostrado en https://es.wikipedia.org/wiki/Código_morse.

// MARK: - Diccionario de texto a código Morse
let morseAlphabet: [String: String] = [
    "A": ".-", "B": "-...", "C": "-.-.", "D": "-..", "E": ".",
    "F": "..-.", "G": "--.", "H": "....", "I": "..", "J": ".---",
    "K": "-.-", "L": ".-..", "M": "--", "N": "-.", "O": "---",
    "P": ".--.", "Q": "--.-", "R": ".-.", "S": "...", "T": "-",
    "U": "..-", "V": "...-", "W": ".--", "X": "-..-", "Y": "-.--",
    "Z": "--..",
    "0": "-----", "1": ".----", "2": "..---", "3": "...--", "4": "....-",
    "5": ".....", "6": "-....", "7": "--...", "8": "---..", "9": "----.",
    ".": ".-.-.-", ",": "--..--", "?": "..--..", "'": ".----.",
    "!": "-.-.--", "/": "-..-.", "(": "-.--.", ")": "-.--.-",
    "&": ".-...", ":": "---...", ";": "-.-.-.", "=": "-...-",
    "+": ".-.-.", "-": "-....-", "_": "..--.-", "\"": ".-..-.",
    "$": "...-..-", "@": ".--.-.", " ": " "
]

// FIXME: Si se agregan nuevos caracteres al alfabeto Morse, actualizar también el diccionario invertido.

// MARK: - Diccionario de morse a texto
let textAlphabet = Dictionary(uniqueKeysWithValues: morseAlphabet.map { ($1, $0) })

// MARK: - Función para detectar si es texto o código Morse
func isMorse(_ input: String) -> Bool {
    // FIXME: Mejorar la detección para casos ambiguos como textos que contienen '.' o '-'.
    return input.contains(".") || input.contains("-")
}

// MARK: - Función para convertir texto a código Morse
func textToMorse(_ text: String) -> String {
    // FIXME: Manejar mejor los caracteres no soportados en el diccionario (e.g., emojis o caracteres especiales).
    return text.uppercased().compactMap { morseAlphabet[String($0)] }.joined(separator: " ")
}

// MARK: - Función para convertir código Morse a texto
func morseToText(_ morse: String) -> String {
    // FIXME: Validar entradas incorrectas en código Morse (e.g., caracteres no válidos).
    return morse.split(separator: " ").map { textAlphabet[String($0)] ?? "" }.joined()
}

// MARK: - Función principal para realizar la conversión
func convert(input: String) -> String {
    if isMorse(input) {
        // Si es código Morse, convertir a texto
        let words = input.split(separator: "  ") // Dos espacios entre palabras
        return words.map { morseToText(String($0)) }.joined(separator: " ")
    } else {
        // Si es texto, convertir a código Morse
        return textToMorse(input)
    }
}

// MARK: - Ejemplo de uso
let text = "Hola Mundo"  // Texto de ejemplo
let morse = ".... --- .-.. .-  -- ..- -. -.. ---"  // Código Morse de ejemplo

print("Texto a Morse: \(convert(input: text))")  // Imprime el resultado de texto a Morse
print("Morse a Texto: \(convert(input: morse))")  // Imprime el resultado de Morse a texto

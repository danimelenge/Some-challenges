import Foundation

// Diccionario de texto a código Morse
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

// Invertir el diccionario para morse a texto
let textAlphabet = Dictionary(uniqueKeysWithValues: morseAlphabet.map { ($1, $0) })

// Función para detectar si es texto o código Morse
func isMorse(_ input: String) -> Bool {
    return input.contains(".") || input.contains("-")
}

// Función para convertir texto a código Morse
func textToMorse(_ text: String) -> String {
    return text.uppercased().compactMap { morseAlphabet[String($0)] }.joined(separator: " ")
}

// Función para convertir código Morse a texto
func morseToText(_ morse: String) -> String {
    return morse.split(separator: " ").map { textAlphabet[String($0)] ?? "" }.joined()
}

// Función principal para realizar la conversión
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

// Ejemplo de uso
let text = "Hola Mundo"
let morse = ".... --- .-.. .-  -- ..- -. -.. ---"

print("Texto a Morse: \(convert(input: text))")
print("Morse a Texto: \(convert(input: morse))")

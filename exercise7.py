# Enunciado: Crea un programa que sea capaz de transformar texto natural a código morse y viceversa.
# - Debe detectar automáticamente de qué tipo se trata y realizar la conversión.
# - En morse se soporta raya "—", punto ".", un espacio " " entre letras o símbolos y dos espacios entre palabras "  ".
# - El alfabeto morse soportado será el mostrado en https://es.wikipedia.org/wiki/Código_morse.

# Diccionario de texto a código Morse
morse_alphabet = {
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
}

# Invertir el diccionario para morse a texto
text_alphabet = {value: key for key, value in morse_alphabet.items()}

# Función para detectar si la entrada es Morse o texto
def is_morse(input_str):
    return all(char in ".- " for char in input_str)

# Función para convertir texto a código Morse
def text_to_morse(text):
    return ' '.join(morse_alphabet.get(char, '') for char in text.upper())

# Función para convertir código Morse a texto
def morse_to_text(morse):
    words = morse.split("  ")  # Separar palabras por dos espacios
    return ' '.join(''.join(text_alphabet.get(symbol, '') for symbol in word.split()) for word in words)

# Función principal para realizar la conversión
def convert(input_str):
    if is_morse(input_str):
        return morse_to_text(input_str)
    else:
        return text_to_morse(input_str)

# Ejemplo de uso
text = "Hola Mundo"
morse = ".... --- .-.. .-  -- ..- -. -.. ---"

print("Texto a Morse:", convert(text))
print("Morse a Texto:", convert(morse))

import Foundation

/*
 * EJERCICIO:
 * Cada 1 de septiembre, el Hogwarts Express parte hacia la escuela
 * de programación de Hogwarts para magos y brujas del código.
 * En ella, su famoso sombrero seleccionador ayuda a los programadores
 * a encontrar su camino...
 * Desarrolla un programa que simule el comportamiento del sombrero.
 * Requisitos:
 * 1. El sombrero realizará 10 preguntas para determinar la casa del alumno.
 * 2. Deben existir 4 casas. Por ejemplo: Frontend, Backend, Mobile y Data.
 *    (Puedes elegir las que quieras)
 * Acciones:
 * 1. Crea un programa que solicite el nombre del alumno y realice 10
 *    preguntas, con cuatro posibles respuestas cada una.
 * 2. Cada respuesta asigna puntos a cada una de las casas (a tu elección).
 * 3. Una vez finalizado, el sombrero indica el nombre del alumno
 *    y a qué casa pertenecerá (resuelve el posible empate de manera aleatoria,
 *    pero indicándole al alumno que la decisión ha sido complicada).
 */


// Definimos las casas de Hogwarts para programadores
enum Casa: String {
    case frontend = "Frontend"
    case backend = "Backend"
    case mobile = "Mobile"
    case data = "Data"
}

// Diccionario para acumular los puntos de cada casa
var puntosCasas: [Casa: Int] = [
    .frontend: 0,
    .backend: 0,
    .mobile: 0,
    .data: 0
]

// Función para hacer preguntas y asignar puntos
func realizarPregunta(pregunta: String, opciones: [String: Casa]) {
    print("\n\(pregunta)")
    for (clave, opcion) in opciones {
        print("\(clave)) \(opcion.rawValue)")
    }

    var respuestaValida = false
    while !respuestaValida {
        print("Elige una opción (a, b, c, d): ", terminator: "")
        if let respuesta = readLine(), let casa = opciones[respuesta] {
            puntosCasas[casa, default: 0] += 1
            respuestaValida = true
        } else {
            print("Respuesta no válida. Inténtalo de nuevo.")
        }
    }
}

// Resolver empates si los puntos son iguales
func resolverEmpate(casasEmpatadas: [Casa]) -> Casa {
    print("\n¡Ha sido una decisión difícil! Hubo un empate entre:")
    for casa in casasEmpatadas {
        print("- \(casa.rawValue)")
    }
    let casaElegida = casasEmpatadas.randomElement()!
    print("El sombrero seleccionador finalmente ha elegido... ¡\(casaElegida.rawValue)!")
    return casaElegida
}

// Programa principal
print("¡Bienvenido al sombrero seleccionador de Hogwarts para programadores!")
print("¿Cuál es tu nombre? ", terminator: "")
let nombreAlumno = readLine() ?? "Alumno Desconocido"

// Preguntas
let preguntas = [
    ("¿Qué prefieres en tu trabajo?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Qué herramienta disfrutas usar?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Cuál es tu tipo de proyecto ideal?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Cuál de estos lenguajes prefieres?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Qué ambiente de trabajo prefieres?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Qué tipo de problemas disfrutas resolver?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Qué valoras más en un equipo?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Qué rol prefieres en un proyecto?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Cómo te sientes resolviendo bugs?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data]),
    ("¿Qué tipo de retos buscas en tu carrera?", ["a": Casa.frontend, "b": Casa.backend, "c": Casa.mobile, "d": Casa.data])
]


for (pregunta, opciones) in preguntas {
    realizarPregunta(pregunta: pregunta, opciones: opciones)
}

// Determinar la casa ganadora
if let casaGanadora = puntosCasas.max(by: { $0.value < $1.value })?.key {
    let casasEmpatadas = puntosCasas.filter { $0.value == puntosCasas[casaGanadora] }.map { $0.key }
    let casaFinal = casasEmpatadas.count > 1 ? resolverEmpate(casasEmpatadas: casasEmpatadas) : casaGanadora
    print("\n¡\(nombreAlumno), el sombrero seleccionador te ha asignado a... \(casaFinal.rawValue)!")
} else {
    print("Hubo un error al seleccionar la casa. ¡Intenta de nuevo!")
}

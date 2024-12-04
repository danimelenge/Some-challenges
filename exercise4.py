import random

# Definir las casas
casas = {
    "Frontend": 0,
    "Backend": 0,
    "Mobile": 0,
    "Data": 0
}

# Preguntas y sus puntos asociados
preguntas = [
    ("¿Qué prefieres en tu trabajo?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Qué herramienta disfrutas usar?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Cuál es tu tipo de proyecto ideal?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Cuál de estos lenguajes prefieres?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Qué ambiente de trabajo prefieres?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Qué tipo de problemas disfrutas resolver?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Qué valoras más en un equipo?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Qué rol prefieres en un proyecto?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Cómo te sientes resolviendo bugs?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"}),
    ("¿Qué tipo de retos buscas en tu carrera?", {"a": "Frontend", "b": "Backend", "c": "Mobile", "d": "Data"})
]

# Solicitar el nombre del alumno
nombre = input("¡Bienvenido al sombrero seleccionador! ¿Cuál es tu nombre? ")

# Realizar las preguntas
for i, (pregunta, opciones) in enumerate(preguntas, start=1):
    print(f"\nPregunta {i}: {pregunta}")
    print("a) Frontend")
    print("b) Backend")
    print("c) Mobile")
    print("d) Data")
    
    respuesta = input("Tu respuesta (a, b, c, d): ").strip().lower()
    if respuesta in opciones:
        casa = opciones[respuesta]
        casas[casa] += 1
    else:
        print("Respuesta no válida. Se omitirá esta pregunta.")

# Determinar la casa con mayor puntaje
max_puntaje = max(casas.values())
casas_ganadoras = [casa for casa, puntaje in casas.items() if puntaje == max_puntaje]

# Resolver empates de manera aleatoria
if len(casas_ganadoras) > 1:
    print("\nEl sombrero está indeciso... ¡esta decisión es complicada!")
    casa_final = random.choice(casas_ganadoras)
else:
    casa_final = casas_ganadoras[0]

# Mostrar el resultado
print(f"\n¡Felicitaciones, {nombre}! El sombrero te ha asignado a la casa: {casa_final} 🎉")

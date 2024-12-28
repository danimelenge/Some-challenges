class Persona:
    def __init__(self, id, nombre):
        self.id = id  # Identificador único
        self.nombre = nombre  # Nombre
        self.pareja = None  # Pareja (opcional)
        self.hijos = []  # Lista de hijos (opcional)

    def __str__(self):
        pareja = f"Pareja: {self.pareja.nombre}" if self.pareja else "Pareja: Ninguna"
        hijos = f"Hijos: {[hijo.nombre for hijo in self.hijos]}" if self.hijos else "Hijos: Ninguno"
        return f"{self.nombre} ({self.id}) - {pareja}, {hijos}"


class ArbolGenealogico:
    def __init__(self):
        self.personas = {}  # Diccionario para almacenar las personas por su ID

    def agregar_persona(self, id, nombre):
        if id in self.personas:
            print("Error: Ya existe una persona con este ID.")
        else:
            self.personas[id] = Persona(id, nombre)
            print(f"Persona {nombre} añadida con éxito.")

    def eliminar_persona(self, id):
        if id not in self.personas:
            print("Error: No existe ninguna persona con este ID.")
        else:
            persona = self.personas.pop(id)
            # Romper relaciones con pareja e hijos
            if persona.pareja:
                persona.pareja.pareja = None
            for hijo in persona.hijos:
                hijo.padres.remove(persona)
            print(f"Persona {persona.nombre} eliminada con éxito.")

    def asignar_pareja(self, id1, id2):
        if id1 not in self.personas or id2 not in self.personas:
            print("Error: Uno o ambos IDs no existen.")
        elif id1 == id2:
            print("Error: Una persona no puede ser pareja de sí misma.")
        else:
            p1 = self.personas[id1]
            p2 = self.personas[id2]
            if p1.pareja or p2.pareja:
                print("Error: Una o ambas personas ya tienen pareja.")
            else:
                p1.pareja = p2
                p2.pareja = p1
                print(f"Ahora {p1.nombre} y {p2.nombre} son pareja.")

    def eliminar_pareja(self, id):
        if id not in self.personas:
            print("Error: El ID no existe.")
        else:
            persona = self.personas[id]
            if persona.pareja:
                pareja = persona.pareja
                persona.pareja = None
                pareja.pareja = None
                print(f"Ahora {persona.nombre} y {pareja.nombre} ya no son pareja.")
            else:
                print(f"{persona.nombre} no tiene pareja asignada.")

    def asignar_hijo(self, id_padre, id_hijo):
        if id_padre not in self.personas or id_hijo not in self.personas:
            print("Error: Uno o ambos IDs no existen.")
        else:
            padre = self.personas[id_padre]
            hijo = self.personas[id_hijo]
            if hijo in padre.hijos:
                print(f"Error: {hijo.nombre} ya es hijo de {padre.nombre}.")
            else:
                padre.hijos.append(hijo)
                print(f"{hijo.nombre} ahora es hijo de {padre.nombre}.")

    def imprimir_arbol(self):
        print("\n--- Árbol Genealógico ---")
        for persona in self.personas.values():
            print(persona)
        print("\n")


# Programa principal
arbol = ArbolGenealogico()

while True:
    print("\n--- Menú del Árbol Genealógico ---")
    print("1. Añadir persona")
    print("2. Eliminar persona")
    print("3. Asignar pareja")
    print("4. Eliminar pareja")
    print("5. Asignar hijo")
    print("6. Imprimir árbol")
    print("7. Salir")

    opcion = input("Elige una opción: ")
    if opcion == "1":
        id = input("ID de la persona: ")
        nombre = input("Nombre de la persona: ")
        arbol.agregar_persona(id, nombre)
    elif opcion == "2":
        id = input("ID de la persona a eliminar: ")
        arbol.eliminar_persona(id)
    elif opcion == "3":
        id1 = input("ID de la primera persona: ")
        id2 = input("ID de la segunda persona: ")
        arbol.asignar_pareja(id1, id2)
    elif opcion == "4":
        id = input("ID de la persona: ")
        arbol.eliminar_pareja(id)
    elif opcion == "5":
        id_padre = input("ID del padre/madre: ")
        id_hijo = input("ID del hijo: ")
        arbol.asignar_hijo(id_padre, id_hijo)
    elif opcion == "6":
        arbol.imprimir_arbol()
    elif opcion == "7":
        print("¡Hasta luego!")
        break
    else:
        print("Opción no válida.")


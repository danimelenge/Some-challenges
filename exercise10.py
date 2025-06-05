import random
  
"""
EJERCICIO:         
¡Ha comenzado diciembre! Es hora de montar nuestro      
árbol de Navidad...   
    
Desarrolla un programa que cree un árbol de Navidad 
con una altura dinámica definida por el usuario por terminal. 

Ejemplo de árbol de altura 5 (el tronco siempre será igual):

    *
   ***
  *****
 *******
*********
   |||
   |||

El usuario podrá seleccionar las siguientes acciones:

- Añadir o eliminar la estrella en la copa del árbol (@)
- Añadir o eliminar bolas de dos en dos (o) aleatoriamente
- Añadir o eliminar luces de tres en tres (+) aleatoriamente
- Apagar (*) o encender (+) las luces (conservando su posición)
- Una luz y una bola no pueden estar en el mismo sitio

Sólo puedes añadir una estrella, y tantas luces o bolas
como tengan cabida en el árbol. El programa debe notificar
cada una de las acciones (o por el contrario, cuando no
se pueda realizar alguna).
"""

class ChristmasTree:
    def __init__(self, height):
        self.height = height
        self.star = True
        self.decorations = []  # Almacena la decoración del árbol
        self.lights_on = True

    def render(self):
        """
        Renderiza el árbol de Navidad con las decoraciones actuales.
        """
        tree = []

        # Construcción del árbol
        for i in range(self.height):
            width = 2 * i + 1
            level = [" "] * (2 * self.height - 1)
            start = self.height - 1 - i
            for j in range(width):
                level[start + j] = "*"

            # Aplicar decoraciones
            for decoration in self.decorations:
                if decoration["row"] == i:
                    index = self.height - 1 - i + decoration["col"]
                    if level[index] == "*":
                        if decoration["type"] == "+" and self.lights_on:
                            level[index] = "+"
                        elif decoration["type"] == "o":
                            level[index] = "o"

            tree.append("".join(level))

        # Añadir la estrella si está activada
        if self.star:
            star_line = [" "] * (2 * self.height - 1)
            star_line[self.height - 1] = "@"
            tree.insert(0, "".join(star_line))

        # Construcción del tronco
        trunk_width = 3
        trunk = [" "] * (2 * self.height - 1)
        start = self.height - 1 - trunk_width // 2
        for i in range(trunk_width):
            trunk[start + i] = "|"
        for _ in range(2):
            tree.append("".join(trunk))

        # Renderizado del árbol
        print("\n".join(tree))

    def toggle_star(self):
        """
        Activa o desactiva la estrella en la copa del árbol.
        """
        self.star = not self.star
        status = "añadida" if self.star else "eliminada"
        print(f"Estrella {status}.")

    def add_decoration(self, decoration_type, count):
        """
        Añade decoraciones al azar.
        """
        added = 0
        for _ in range(count):
            while True:
                row = random.randint(0, self.height - 1)
                col = random.randint(0, 2 * row)
                if not any(
                    d["row"] == row and d["col"] == col for d in self.decorations
                ):
                    self.decorations.append({"type": decoration_type, "row": row, "col": col})
                    added += 1
                    break
        print(f"Se han añadido {added} decoraciones del tipo '{decoration_type}'.")

    def remove_decoration(self, decoration_type, count):
        """
        Elimina decoraciones del tipo especificado.
        """
        to_remove = [d for d in self.decorations if d["type"] == decoration_type][:count]
        if not to_remove:
            print(f"No hay decoraciones del tipo '{decoration_type}' para eliminar.")
            return
        for decoration in to_remove:
            self.decorations.remove(decoration)
        print(f"Se han eliminado {len(to_remove)} decoraciones del tipo '{decoration_type}'.")

    def toggle_lights(self):
        """
        Activa o desactiva las luces del árbol.
        """
        self.lights_on = not self.lights_on
        status = "encendidas" if self.lights_on else "apagadas"
        print(f"Luces {status}.")


def main():
    height = int(input("Introduce la altura del árbol: "))
    tree = ChristmasTree(height)

    while True:
        print("\nOpciones:")
        print("1. Añadir/eliminar estrella (@)")
        print("2. Añadir bolas (o)")
        print("3. Eliminar bolas (o)")
        print("4. Añadir luces (+)")
        print("5. Eliminar luces (+)")
        print("6. Apagar/encender luces (*)")
        print("7. Mostrar árbol")
        print("8. Salir")

        option = input("Elige una opción: ")

        if option == "1":
            tree.toggle_star()
        elif option == "2":
            tree.add_decoration("o", 2)
        elif option == "3":
            tree.remove_decoration("o", 2)
        elif option == "4":
            tree.add_decoration("+", 3)
        elif option == "5":
            tree.remove_decoration("+", 3)
        elif option == "6":
            tree.toggle_lights()
        elif option == "7":
            tree.render()
        elif option == "8":
            print("¡Feliz Navidad!")
            break
        else:
            print("Opción no válida.")


if __name__ == "__main__":
    main()

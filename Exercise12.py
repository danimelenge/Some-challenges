"""
EJERCICIO:
El nuevo año está a punto de comenzar...
¡Voy a ayudarte a planificar tus propósitos de nuevo año!

Programa un gestor de objetivos con las siguientes características:
- Permite añadir objetivos (máximo 10)
- Calcular el plan detallado
- Guardar la planificación

Cada entrada de un objetivo está formado por (con un ejemplo):
- Meta: Leer libros
- Cantidad: 12
- Unidades: libros
- Plazo (en meses): 12 (máximo 12)

El cálculo del plan detallado generará la siguiente salida:
- Un apartado para cada mes
- Un listado de objetivos calculados a cumplir en cada mes
  (ejemplo: si quiero leer 12 libros, dará como resultado 
  uno al mes)
- Cada objetivo debe poseer su nombre, la cantidad de
  unidades a completar en cada mes y su total. Por ejemplo:

  Enero:
  [ ] 1. Leer libros (1 libro/mes). Total: 12.
  [ ] 2. Estudiar Git (1 curso/mes). Total: 1.
  Febrero:
  [ ] 1. Leer libros (1 libro/mes). Total: 12.
  ...
  Diciembre:
  [ ] 1. Leer libros (1 libro/mes). Total: 12.

- Si la duración es menor a un año, finalizará en el mes
  correspondiente.
  
Por último, el cálculo detallado debe poder exportarse a .txt
(No subir el fichero)
"""

from datetime import datetime

class Goal:
    """
    Representa un objetivo con su meta, cantidad, unidades y plazo.
    """
    def __init__(self, meta, cantidad, unidades, plazo):
        self.meta = meta
        self.cantidad = cantidad
        self.unidades = unidades
        self.plazo = plazo
    
    def monthly_plan(self):
        """
        Calcula la cantidad a completar por mes.
        """
        return self.cantidad // self.plazo

class GoalManager:
    """
    Gestiona los objetivos del usuario, permite añadirlos y calcular la planificación mensual.
    """
    def __init__(self):
        self.goals = []
        self.month_names = [
            "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
        ]
    
    def add_goal(self, meta, cantidad, unidades, plazo):
        """
        Añade un nuevo objetivo, con un máximo de 10 objetivos.
        """
        if len(self.goals) >= 10:
            print("⚠️ No puedes añadir más de 10 objetivos.")
            return
        if plazo > 12:
            print("⚠️ El plazo no puede exceder los 12 meses.")
            return
        self.goals.append(Goal(meta, cantidad, unidades, plazo))
        print(f"✅ Objetivo añadido: {meta}, {cantidad} {unidades}, plazo: {plazo} meses.")
    
    def calculate_plan(self):
        """
        Calcula y muestra el plan mensual detallado.
        """
        current_year = datetime.now().year
        plan = {}

        for month_idx in range(12):
            month_name = self.month_names[month_idx]
            plan[month_name] = []

            for goal_idx, goal in enumerate(self.goals, start=1):
                if month_idx < goal.plazo:  # Solo incluir objetivos dentro del plazo
                    monthly_quantity = goal.monthly_plan()
                    plan[month_name].append(
                        f"[ ] {goal_idx}. {goal.meta} ({monthly_quantity} {goal.unidades}/mes). Total: {goal.cantidad}."
                    )
        
        return plan

    def display_plan(self, plan):
        """
        Muestra el plan detallado en la consola.
        """
        for month, tasks in plan.items():
            print(f"\n{month}:")
            for task in tasks:
                print(task)
    
    def export_plan(self, plan, filename="plan_detallado.txt"):
        """
        Exporta el plan detallado a un archivo de texto.
        """
        with open(filename, "w", encoding="utf-8") as file:
            for month, tasks in plan.items():
                file.write(f"{month}:\n")
                for task in tasks:
                    file.write(f"{task}\n")
                file.write("\n")
        print(f"✅ Plan exportado a {filename}")

# Menú interactivo
def main():
    manager = GoalManager()

    print("🎯 Gestor de objetivos de Año Nuevo 🎯")
    while True:
        print("\nMenú:")
        print("1. Añadir un objetivo")
        print("2. Calcular el plan detallado")
        print("3. Exportar el plan a un archivo")
        print("4. Salir")

        choice = input("Selecciona una opción: ")
        if choice == "1":
            meta = input("Meta: ")
            cantidad = int(input("Cantidad: "))
            unidades = input("Unidades: ")
            plazo = int(input("Plazo (en meses, máx. 12): "))
            manager.add_goal(meta, cantidad, unidades, plazo)
        elif choice == "2":
            plan = manager.calculate_plan()
            manager.display_plan(plan)
        elif choice == "3":
            plan = manager.calculate_plan()
            manager.export_plan(plan)
        elif choice == "4":
            print("¡Adiós! 😊")
            break
        else:
            print("❌ Opción inválida, inténtalo de nuevo.")

if __name__ == "__main__":    
    main()        

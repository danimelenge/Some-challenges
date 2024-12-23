"""
 * EJERCICIO:
 * Cada año se celebra el Batman Day durante la tercera semana de septiembre... 
 * ¡Y este año cumple 85 años! Te propongo un reto doble:
 *
 * RETO 1:
 * Crea un programa que calcule cuándo se va a celebrar el Batman Day hasta 
 * su 100 aniversario.
 *
 * RETO 2:
 * Crea un programa que implemente el sistema de seguridad de la Batcueva. 
 * Este sistema está diseñado para monitorear múltiples sensores distribuidos
 * por Gotham, detectar intrusos y activar respuestas automatizadas. 
 * Cada sensor reporta su estado en tiempo real, y Batman necesita un programa 
 * que procese estos datos para tomar decisiones estratégicas.
 * Requisitos:
 * - El mapa de Gotham y los sensores se representa con una cuadrícula 20x20.
 * - Cada sensor se identifica con una coordenada (x, y) y un nivel
 *   de amenaza entre 0 a 10 (número entero).
 * - Batman debe concentrar recursos en el área más crítica de Gotham.
 * - El programa recibe un listado de tuplas representando coordenadas de los 
 *   sensores y su nivel de amenaza. El umbral de activación del protocolo de
 *   seguridad es 20 (sumatorio de amenazas en una cuadrícula 3x3).
 * Acciones: 
 * - Identifica el área con mayor concentración de amenazas
 *   (sumatorio de amenazas en una cuadrícula 3x3).
 * - Si el sumatorio de amenazas es mayor al umbral, activa el 
 *   protocolo de seguridad.
 * - Calcula la distancia desde la Batcueva, situada en (0, 0). La distancia es
 *   la suma absoluta de las coordenadas al centro de la cuadrícula amenazada.
 * - Muestra la coordenada al centro de la cuadrícula más amenazada, la suma de
 *   sus amenazas, la distancia a la Batcueva y si se debe activar el
 *   protocolo de seguridad.
"""

import math

def batcave_security(sensors):
    """
    Implementa el sistema de seguridad de la Batcueva:
    - Identifica el área con mayor concentración de amenazas (3x3).
    - Calcula si se activa el protocolo de seguridad.
    """
    # Dimensiones de la cuadrícula
    grid_size = 20
    grid = [[0] * grid_size for _ in range(grid_size)]

    # Llenar la cuadrícula con los niveles de amenaza
    for x, y, threat_level in sensors:
        if 0 <= x < grid_size and 0 <= y < grid_size:
            grid[x][y] = threat_level

    max_threat = 0
    critical_center = (0, 0)

    # Buscar la zona con mayor amenaza (3x3)
    for x in range(grid_size - 2):
        for y in range(grid_size - 2):
            # Calcular la suma de amenazas en la cuadrícula 3x3
            current_threat = sum(
                grid[x + dx][y + dy] 
                for dx in range(3) 
                for dy in range(3)
            )
            if current_threat > max_threat:
                max_threat = current_threat
                critical_center = (x + 1, y + 1)  # Centro de la cuadrícula

    # Calcular la distancia a la Batcueva (0, 0)
    distance_to_batcave = abs(critical_center[0]) + abs(critical_center[1])
    protocol_activated = max_threat > 20

    # Imprimir resultados
    print(f"Critical Area Center: {critical_center}")
    print(f"Sum of Threat Levels: {max_threat}")
    print(f"Distance to Batcave: {distance_to_batcave}")
    print(f"Protocol Activated: {'Yes' if protocol_activated else 'No'}")

# Ejemplo de sensores
sensors = [
    (2, 3, 5), (3, 4, 8), (2, 4, 7),  # Zona con amenaza alta
    (10, 10, 10), (11, 11, 6), (12, 12, 4)  # Otra zona
]

batcave_security(sensors)

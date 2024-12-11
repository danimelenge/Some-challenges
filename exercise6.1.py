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

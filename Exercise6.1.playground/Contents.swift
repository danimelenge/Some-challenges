import Foundation


/*
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
 */

// Coordenada y amenaza de sensores
typealias Sensor = (x: Int, y: Int, threatLevel: Int)

// Sistema de seguridad
func batcaveSecurity(sensors: [Sensor]) {
    let gridSize = 20
    var grid = Array(repeating: Array(repeating: 0, count: gridSize), count: gridSize)
    
    // Llenar la cuadrícula con niveles de amenaza
    for sensor in sensors where sensor.x >= 0 && sensor.x < gridSize && sensor.y >= 0 && sensor.y < gridSize {
        grid[sensor.x][sensor.y] = sensor.threatLevel
    }
    
    // Identificar la zona más crítica (3x3) y calcular la suma de amenazas
    var maxThreat = 0
    var criticalCenter: (x: Int, y: Int) = (0, 0)
    
    for x in 0..<(gridSize - 2) {
        for y in 0..<(gridSize - 2) {
            let currentThreat = (0...2).flatMap { dx in
                (0...2).map { dy in grid[x + dx][y + dy] }
            }.reduce(0, +)
            
            if currentThreat > maxThreat {
                maxThreat = currentThreat
                criticalCenter = (x + 1, y + 1) // Centro de la cuadrícula
            }
        }
    }
    
    // Calcular distancia desde la Batcueva (0, 0)
    let distance = abs(criticalCenter.x - 0) + abs(criticalCenter.y - 0)
    let protocolActivated = maxThreat > 20
    
    // Resultados
    print("Critical Area Center: (\(criticalCenter.x), \(criticalCenter.y))")
    print("Sum of Threat Levels: \(maxThreat)")
    print("Distance to Batcave: \(distance)")
    print("Protocol Activated: \(protocolActivated ? "Yes" : "No")")
}

// Ejemplo de sensores
let sensors: [Sensor] = [
    (x: 2, y: 3, threatLevel: 5),
    (x: 3, y: 4, threatLevel: 8),
    (x: 2, y: 4, threatLevel: 7),
    (x: 10, y: 10, threatLevel: 10),
    (x: 11, y: 11, threatLevel: 6),
    (x: 12, y: 12, threatLevel: 4)
]

batcaveSecurity(sensors: sensors)

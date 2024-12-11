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

// Función para calcular el Batman Day
func calculateBatmanDay(year: Int) -> Date? {
    let calendar = Calendar.current
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    // Fecha del 1 de septiembre del año actual
    guard let startDate = formatter.date(from: "\(year)-09-01") else { return nil }
    
    // Obtener los días de septiembre
    let daysInSeptember = calendar.range(of: .day, in: .month, for: startDate)!
    
    for day in daysInSeptember {
        guard let date = calendar.date(byAdding: .day, value: day - 1, to: startDate),
              calendar.component(.weekday, from: date) == 7 else {
            continue
        }
        
        // Tercer sábado
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        if weekOfMonth == 3 {
            return date
        }
    }
    return nil
}

// Calcular fechas de Batman Day hasta su 100 aniversario
func batmanDayAnniversaries() {
    let startYear = 2024
    let endYear = 2039  // 100 aniversario
    print("Batman Day Dates:")
    for year in startYear...endYear {
        if let batmanDay = calculateBatmanDay(year: year) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            print("\(year): \(formatter.string(from: batmanDay))")
        }
    }
}

batmanDayAnniversaries()

//


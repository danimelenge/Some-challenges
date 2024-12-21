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

from datetime import datetime, timedelta

def calculate_batman_day(year):
    """
    Calcula el Batman Day del año dado, es decir, el tercer sábado de septiembre.
    """
    # Fecha inicial del 1 de septiembre del año dado
    date = datetime(year, 9, 1)
    
    # Encontrar el primer sábado de septiembre
    while date.weekday() != 5:  # 5 = sábado
        date += timedelta(days=1)
    
    # Avanzar dos semanas para llegar al tercer sábado
    third_saturday = date + timedelta(weeks=2)
    return third_saturday

def batman_day_until_100th_anniversary():
    """
    Calcula el Batman Day desde 2024 hasta su 100 aniversario (2039).
    """
    start_year = 2024
    end_year = 2039
    print("Batman Day Dates:")
    for year in range(start_year, end_year + 1):
        batman_day = calculate_batman_day(year)
        print(f"{year}: {batman_day.strftime('%A, %d %B %Y')}")

batman_day_until_100th_anniversary()

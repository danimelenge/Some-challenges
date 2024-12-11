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

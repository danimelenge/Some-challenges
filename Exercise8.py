# * Crea una función que sume 2 números y retorne su resultado pasados
# * unos segundos.
# * - Recibirá por parámetros los 2 números a sumar y los segundos que
# *   debe tardar en finalizar su ejecución.
# * - Si el lenguaje lo soporta, deberá retornar el resultado de forma
# *   asíncrona, es decir, sin detener la ejecución del programa principal.   
# *   Se podría ejecutar varias veces al mismo tiempo.
  
import asyncio 

# Función asíncrona para sumar dos números después de un retraso
async def async_sum(a, b, delay_seconds):
    await asyncio.sleep(delay_seconds)  # Esperar los segundos especificados
    result = a + b
    print(f"Resultado de sumar {a} + {b} después de {delay_seconds} segundos: {result}")
    return result

# Función principal para demostrar la ejecución
async def main():
    # Ejecutar varias sumas simultáneamente
    tasks = [
        async_sum(3, 5, 2),  # Suma 3 + 5 después de 2 segundos
        async_sum(10, 20, 3),  # Suma 10 + 20 después de 3 segundos
        async_sum(7, 8, 1),  # Suma 7 + 8 después de 1 segundo
    ]
    
    # Esperar que todas las tareas terminen
    results = await asyncio.gather(*tasks)
    print(f"Resultados finales: {results}")

# Ejecutar la función principal
if __name__ == "__main__":   
    asyncio.run(main())       

"""
Procesa pagos por internet con tarjeta de crédito en más de 135 divisas.
https://stripe.com/es

- Cómo recoger información del usuario.
- Cómo realizar un cargo asociado a un importe.
- Gestión de productos y precios.
- Manejo de errores.
"""

import os
import stripe

# Configura tu clave secreta de Stripe (para pruebas, usa la clave de prueba)
stripe.api_key = os.environ.get("STRIPE_API_KEY")  # O asigna directamente: "sk_test_..."

def get_user_info():
    """
    Recoge información básica del usuario.
    En una aplicación real, esta información vendría de un formulario web.
    """
    name = input("Ingrese su nombre: ")
    email = input("Ingrese su correo electrónico: ")
    # Nota: La información sensible de la tarjeta se debe obtener de forma segura en el front-end.
    # Para este ejemplo usaremos un token de prueba de Stripe.
    card_token = "tok_visa"  # Token de prueba que simula una tarjeta Visa.
    return {"name": name, "email": email, "card_token": card_token}

def create_customer(user_info):
    """
    Crea un cliente en Stripe usando la información del usuario.
    """
    try:
        customer = stripe.Customer.create(
            name=user_info["name"],
            email=user_info["email"],
            source=user_info["card_token"]  # Asociamos la tarjeta (token)
        )
        print("Cliente creado exitosamente:", customer.id)
        return customer
    except stripe.error.StripeError as e:
        print("Error al crear el cliente:", getattr(e, "user_message", str(e)))
        return None

def process_payment(customer_id, amount, currency="usd"):
    """
    Realiza un cargo a un cliente por un importe determinado.
    El importe se especifica en la unidad mínima de la moneda (por ejemplo, centavos).
    """
    try:
        charge = stripe.Charge.create(
            amount=amount,          # Ejemplo: 2000 equivale a $20.00 si la moneda es USD.
            currency=currency,
            customer=customer_id,
            description="Cargo de ejemplo"
        )
        print("Pago realizado exitosamente:", charge.id)
        return charge
    except stripe.error.CardError as e:
        print("Error de tarjeta:", e.user_message)
    except stripe.error.RateLimitError as e:
        print("Error de límite de tasa:", e.user_message)
    except stripe.error.InvalidRequestError as e:
        print("Solicitud inválida:", e.user_message)
    except stripe.error.AuthenticationError as e:
        print("Error de autenticación:", e.user_message)
    except stripe.error.APIConnectionError as e:
        print("Error de conexión:", e.user_message)
    except stripe.error.StripeError as e:
        print("Error en Stripe:", e.user_message)
    except Exception as e:
        print("Error inesperado:", str(e))
    return None

def create_product_and_price(name, unit_amount, currency="usd"):
    """
    Crea un producto y un precio asociado en Stripe.
    """
    try:
        # Crea un producto
        product = stripe.Product.create(name=name)
        print("Producto creado:", product.id)
        
        # Crea un precio para el producto (unit_amount en la unidad mínima de la moneda)
        price = stripe.Price.create(
            product=product.id,
            unit_amount=unit_amount,  # Ejemplo: 5000 equivale a $50.00 si la moneda es USD.
            currency=currency
        )
        print("Precio creado:", price.id)
        return product, price
    except stripe.error.StripeError as e:
        print("Error al crear producto/precio:", getattr(e, "user_message", str(e)))
    except Exception as e:
        print("Error inesperado al crear producto/precio:", str(e))
    return None, None

def main():
    # 1. Recoger información del usuario
    user_info = get_user_info()

    # 2. Crear un cliente en Stripe
    customer = create_customer(user_info)
    if not customer:
        return

    # 3. Realizar un cargo de ejemplo
    # Por ejemplo, cobrar $20.00 (2000 centavos)
    charge = process_payment(customer.id, amount=2000, currency="usd")
    if not charge:
        return

    # 4. Gestión de productos y precios: crear un producto y un precio asociado
    product, price = create_product_and_price("Producto de ejemplo", unit_amount=5000, currency="usd")
    if product and price:
        print("Producto y precio creados correctamente.")

if __name__ == "__main__":
    main()    


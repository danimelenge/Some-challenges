import Foundation

// -----------------------------------------------------------------------------
// Configuración
// -----------------------------------------------------------------------------
let stripeSecretKey = "sk_test_tuClaveSecretaAquí" // REEMPLAZA ESTE VALOR con tu clave secreta

/// Función auxiliar para codificar parámetros en formato percent-encoded
func percentEncode(_ value: String) -> String {
    return value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
}

// -----------------------------------------------------------------------------
// Función: Crear cliente en Stripe
// -----------------------------------------------------------------------------
func createCustomer(name: String, email: String) async throws -> String {
    guard let url = URL(string: "https://api.stripe.com/v1/customers") else {
        throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    // Se usa el token de prueba "tok_visa" para simular la información de la tarjeta.
    let parameters = "name=\(percentEncode(name))&email=\(percentEncode(email))&source=tok_visa"
    request.httpBody = parameters.data(using: .utf8)
    
    // Configurar autenticación básica con la clave secreta
    let authStr = stripeSecretKey + ":"
    guard let authData = authStr.data(using: .utf8) else {
        throw NSError(domain: "AuthError", code: -1, userInfo: nil)
    }
    let base64Auth = authData.base64EncodedString()
    request.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    // Realizar la petición
    let (data, response) = try await URLSession.shared.data(for: request)
    
    // Verificar el código de estado HTTP
    if let httpResponse = response as? HTTPURLResponse,
       !(200...299).contains(httpResponse.statusCode) {
        let errorMsg = String(data: data, encoding: .utf8) ?? "Error desconocido"
        throw NSError(domain: "StripeAPI", code: httpResponse.statusCode,
                      userInfo: [NSLocalizedDescriptionKey: errorMsg])
    }
    
    // Procesar la respuesta JSON
    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    if let customerId = json?["id"] as? String {
        return customerId
    } else if let errorInfo = json?["error"] as? [String: Any],
              let message = errorInfo["message"] as? String {
        throw NSError(domain: "StripeAPI", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: message])
    } else {
        throw NSError(domain: "StripeAPI", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: "Respuesta inesperada al crear el cliente"])
    }
}

// -----------------------------------------------------------------------------
// Función: Procesar pago (cargo) para un cliente
// -----------------------------------------------------------------------------
func processPayment(customerId: String, amount: Int, currency: String = "usd") async throws -> String {
    guard let url = URL(string: "https://api.stripe.com/v1/charges") else {
        throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    // El importe se especifica en la unidad mínima de la moneda (por ejemplo, centavos).
    let description = percentEncode("Cargo de ejemplo")
    let parameters = "amount=\(amount)&currency=\(currency)&customer=\(customerId)&description=\(description)"
    request.httpBody = parameters.data(using: .utf8)
    
    let authStr = stripeSecretKey + ":"
    guard let authData = authStr.data(using: .utf8) else {
        throw NSError(domain: "AuthError", code: -1, userInfo: nil)
    }
    let base64Auth = authData.base64EncodedString()
    request.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    if let httpResponse = response as? HTTPURLResponse,
       !(200...299).contains(httpResponse.statusCode) {
        let errorMsg = String(data: data, encoding: .utf8) ?? "Error desconocido"
        throw NSError(domain: "StripeAPI", code: httpResponse.statusCode,
                      userInfo: [NSLocalizedDescriptionKey: errorMsg])
    }
    
    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    if let chargeId = json?["id"] as? String {
        return chargeId
    } else if let errorInfo = json?["error"] as? [String: Any],
              let message = errorInfo["message"] as? String {
        throw NSError(domain: "StripeAPI", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: message])
    } else {
        throw NSError(domain: "StripeAPI", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: "Respuesta inesperada al procesar el pago"])
    }
}

// -----------------------------------------------------------------------------
// Función: Crear producto y asignar un precio en Stripe
// -----------------------------------------------------------------------------
func createProductAndPrice(name: String, unitAmount: Int, currency: String = "usd") async throws -> (productId: String, priceId: String) {
    // 1. Crear producto
    guard let productUrl = URL(string: "https://api.stripe.com/v1/products") else {
        throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
    }
    var productRequest = URLRequest(url: productUrl)
    productRequest.httpMethod = "POST"
    
    let productParameters = "name=\(percentEncode(name))"
    productRequest.httpBody = productParameters.data(using: .utf8)
    
    let authStr = stripeSecretKey + ":"
    guard let authData = authStr.data(using: .utf8) else {
        throw NSError(domain: "AuthError", code: -1, userInfo: nil)
    }
    let base64Auth = authData.base64EncodedString()
    productRequest.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
    productRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let (productData, productResponse) = try await URLSession.shared.data(for: productRequest)
    
    if let httpResponse = productResponse as? HTTPURLResponse,
       !(200...299).contains(httpResponse.statusCode) {
        let errorMsg = String(data: productData, encoding: .utf8) ?? "Error desconocido"
        throw NSError(domain: "StripeAPI", code: httpResponse.statusCode,
                      userInfo: [NSLocalizedDescriptionKey: errorMsg])
    }
    
    let productJson = try JSONSerialization.jsonObject(with: productData, options: []) as? [String: Any]
    guard let productId = productJson?["id"] as? String else {
        throw NSError(domain: "StripeAPI", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: "No se pudo crear el producto"])
    }
    
    // 2. Crear precio para el producto
    guard let priceUrl = URL(string: "https://api.stripe.com/v1/prices") else {
        throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
    }
    var priceRequest = URLRequest(url: priceUrl)
    priceRequest.httpMethod = "POST"
    
    let priceParameters = "product=\(percentEncode(productId))&unit_amount=\(unitAmount)&currency=\(currency)"
    priceRequest.httpBody = priceParameters.data(using: .utf8)
    
    priceRequest.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
    priceRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let (priceData, priceResponse) = try await URLSession.shared.data(for: priceRequest)
    
    if let httpResponse = priceResponse as? HTTPURLResponse,
       !(200...299).contains(httpResponse.statusCode) {
        let errorMsg = String(data: priceData, encoding: .utf8) ?? "Error desconocido"
        throw NSError(domain: "StripeAPI", code: httpResponse.statusCode,
                      userInfo: [NSLocalizedDescriptionKey: errorMsg])
    }
    
    let priceJson = try JSONSerialization.jsonObject(with: priceData, options: []) as? [String: Any]
    guard let priceId = priceJson?["id"] as? String else {
        throw NSError(domain: "StripeAPI", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: "No se pudo crear el precio"])
    }
    
    return (productId, priceId)
}

// -----------------------------------------------------------------------------
// Función principal (punto de entrada de la aplicación de consola)
// -----------------------------------------------------------------------------

struct Main {
    static func main() async {
        print("=== Procesamiento de pagos con Stripe ===")
        
        // Recoger información del usuario
        print("Ingrese su nombre:")
        guard let name = readLine(), !name.isEmpty else {
            print("Nombre no válido.")
            return
        }
        
        print("Ingrese su correo electrónico:")
        guard let email = readLine(), !email.isEmpty else {
            print("Correo electrónico no válido.")
            return
        }
        
        do {
            // 1. Crear cliente
            let customerId = try await createCustomer(name: name, email: email)
            print("Cliente creado exitosamente. ID: \(customerId)")
            
            // 2. Realizar un cargo (ejemplo: $20.00 = 2000 centavos)
            let chargeId = try await processPayment(customerId: customerId, amount: 2000, currency: "usd")
            print("Cargo realizado exitosamente. ID: \(chargeId)")
            
            // 3. Crear un producto y asignar un precio (ejemplo: $50.00 = 5000 centavos)
            let (productId, priceId) = try await createProductAndPrice(name: "Producto de ejemplo", unitAmount: 5000, currency: "usd")
            print("Producto creado exitosamente. ID: \(productId)")
            print("Precio creado exitosamente. ID: \(priceId)")
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
 }

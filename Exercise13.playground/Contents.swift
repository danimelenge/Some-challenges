import Foundation

// -----------------------------------------------------------------------------
// Procesa pagos por internet con tarjeta de crédito en más de 135 divisas.
// https://stripe.com/es
//
// - Cómo recoger información del usuario.
// - Cómo realizar un cargo asociado a un importe.
// - Gestión de productos y precios.
// - Manejo de errores.
// -----------------------------------------------------------------------------

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
    
    let parameters = "name=\(percentEncode(name))&email=\(percentEncode(email))&source=tok_visa"
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
// Función principal (punto de entrada de la aplicación de consola)
// -----------------------------------------------------------------------------

struct Main {
    static func main() async {
        print("=== Procesamiento de pagos con Stripe ===")
        
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
            let customerId = try await createCustomer(name: name, email: email)
            print("Cliente creado exitosamente. ID: \(customerId)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

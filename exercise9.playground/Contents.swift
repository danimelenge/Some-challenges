import Foundation
import Compression

// MARK: - Comprimir un archivo en formato .zip
/**
 Crea un programa capaz de comprimir un archivo
 en formato .zip (o el que tú quieras).
 - No subas el archivo o el zip.
 */
func compressFile(filePath: String, outputZipPath: String) {
    let fileManager = FileManager.default
    let sourceURL = URL(fileURLWithPath: filePath)
    let destinationURL = URL(fileURLWithPath: outputZipPath)
    
    guard fileManager.fileExists(atPath: filePath) else {
        print("El archivo en '\(filePath)' no existe.")
        return
    }
    
    do {
        // Leer el contenido del archivo fuente
        let fileData = try Data(contentsOf: sourceURL)
        
        // Crear un archivo de destino en .zip
        if fileManager.createFile(atPath: outputZipPath, contents: nil, attributes: nil) {
            let destinationFileHandle = try FileHandle(forWritingTo: destinationURL)
            defer { destinationFileHandle.closeFile() }
            
            // Comprimir el contenido
            let compressedData = compressData(fileData)
            destinationFileHandle.write(compressedData)
            
            print("Archivo comprimido correctamente como '\(outputZipPath)'")
        } else {
            print("Error al crear el archivo de salida '\(outputZipPath)'.")
        }
    } catch {
        print("Error al procesar el archivo: \(error.localizedDescription)")
    }
}

// MARK: - Utilidad para comprimir datos
/**
 Comprime datos usando zlib.
 
 - Parameter data: Datos a comprimir.
 - Returns: Datos comprimidos.
 */
func compressData(_ data: Data) -> Data {
    let bufferSize = 64 * 1024
    var output = Data()
    
    data.withUnsafeBytes { (rawBufferPointer: UnsafeRawBufferPointer) in
        guard let sourcePointer = rawBufferPointer.baseAddress else { return }
        
        let streamPointer = UnsafeMutablePointer<compression_stream>.allocate(capacity: 1)
        defer { streamPointer.deallocate() }
        
        var stream = streamPointer.pointee
        stream.src_ptr = sourcePointer.assumingMemoryBound(to: UInt8.self)
        stream.src_size = data.count
        stream.dst_size = bufferSize
        stream.dst_ptr = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer { stream.dst_ptr.deallocate() }
        
        guard compression_stream_init(&stream, COMPRESSION_STREAM_ENCODE, COMPRESSION_ZLIB) == COMPRESSION_STATUS_OK else { return }
        defer { compression_stream_destroy(&stream) }
        
        while stream.src_size > 0 {
            let status = compression_stream_process(&stream, Int32(COMPRESSION_STREAM_FINALIZE.rawValue))
            
            switch status {
            case COMPRESSION_STATUS_OK, COMPRESSION_STATUS_END:
                output.append(stream.dst_ptr, count: bufferSize - stream.dst_size)
                stream.dst_size = bufferSize
                stream.dst_ptr = stream.dst_ptr.advanced(by: bufferSize - stream.dst_size)
            default:
                return
            }
        }
    }
    
    return output
}

// MARK: - Ejemplo de uso
let inputFilePath = "ruta/al/archivo/origen.txt"  // Cambia esto al archivo que deseas comprimir
let outputZipPath = "ruta/al/archivo_comprimido.zip"

// Ejecutar la compresión
compressFile(filePath: inputFilePath, outputZipPath: outputZipPath)

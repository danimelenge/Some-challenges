import zipfile
import os

# Función para comprimir un archivo en formato .zip
def compress_file(file_path, output_zip):
    """
    Crea un archivo .zip que contiene el archivo dado.
    
    :param file_path: Ruta del archivo que deseas comprimir.
    :param output_zip: Nombre del archivo .zip que se generará.
    """
    if not os.path.exists(file_path):
        print(f"El archivo '{file_path}' no existe.")
        return
    
    try:
        with zipfile.ZipFile(output_zip, 'w', zipfile.ZIP_DEFLATED) as zipf:
            zipf.write(file_path, os.path.basename(file_path))
        print(f"Archivo comprimido correctamente como '{output_zip}'")
    except Exception as e:
        print(f"Error al comprimir el archivo: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    input_file = "ejemplo.txt"  # Cambia esto al archivo que deseas comprimir
    output_zip = "archivo_comprimido.zip"
    
    compress_file(input_file, output_zip)

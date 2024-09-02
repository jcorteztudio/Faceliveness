# FaceLivenessFramework

## Introducción
El Framework FaceLiveness permite que los desarrolladores puedan integrar en su aplicación una solución de verificación biométrica que confirma la identidad de una persona a travez de su rostro.

Las características que ofrece la integración de este framework son:
- Comparación de rostros
- Prueba de vida

## Integración con iOS
El Framework FaceLiveness para iOS soporta la integración con aplicaciones desarrolladas en Swift.

## Prerrequisitos
Para poder integrar el Framework FaceLiveness en tu aplicación de iOS, se deben cumplir los siguientes requisitos:
- Credenciales para descargar librería de Azure (Proporcionadas por Cosmocolor).
- iOS 16 o superior.
- Configurar [Git LFS](https://git-lfs.com/). Para descargar la librería de Azure necesitamos configurar Git LFS, para lo cuál seguiremos los siguientes pasos:
  
  -  Instalar git-lfs:
  ```
  brew install git-lfs
  ```
  - Inicializar git-lfs:
  ```
  git lfs install
  ```
  - Para comprobar la instalación puedes utilizar este comando:
  ```
  git lfs --version
  ```

## Instalación
Es necesario agregar las siguientes librerías como dependencias a tu proyecto de iOS para el correcto funcionamiento del Framework FaceLiveness
- Librería FaceLiveness: librería proporcionada por Cosmocolor con los archivos del proyecto SDK y que se integra mediante SPM
- Librerías externas: las librerías de terceros estas disponibles por medio de cocoapods.

### Librería Faceliveness
1. Abre con Xcode el proyecto de tu aplicación iOS
2. Dirigete a la opción File y selecciona la opción "Add Package Dependencies..."
3. Copia y pega la dependencia del Framework FaceLiveness en el cuadro de búsqueda.
4. Selecciona el paquete "facelivenessframework-ios" y presiona el botón "AddPackage"

```
https://github.com/cosmocolor/facelivenessframework-ios.git
```
### Librerías externas
1. Instala Cocoapods siguiendo la referencia de la [documentación oficial](https://guides.cocoapods.org/using/getting-started.html).
2. Incluye las siguientes dependencias en el archivo PodFile
```
# add repos as source
source 'https://msface.visualstudio.com/SDK/_git/AzureAIVisionCore.podspec'
source 'https://msface.visualstudio.com/SDK/_git/AzureAIVisionFace.podspec'

target 'YourBuildTargetNameHere' do
   # add the pods here, optionally with version specification as needed
   pod 'AzureAIVisionCore', '0.17.1-beta.1'
   pod 'AzureAIVisionFace', '0.17.1-beta.1'
end
```
3. Ingresa las credenciales proporcionadas por Cosmocolor para poder descargar esta librería de terceros.
4. Agrega los frameworks generados por Cocoapods en la configuración de tu proyecto.

## Agregando los permisos en info.plist
Para poder integrar el Framework FaceLiveness en tu aplicación, es necesario incluir las siguientes propiedades dentro de tu archivo info.plist:
``` XML
<key>NSCameraUsageDescription</key>
<string>Esta aplicación necesita acceso a tu cámara para realizar un verificación facial</string>
```

## Código de ejemplo
El siguiente bloque de código muestra un ejemplo de la implementación del Framework FaceLiveness en una aplicación de iOS con SwiftUI
``` Swift
//
//  ContentView.swift
//  FaceLivenessDemo
//
//  Created by Carlos Cortez on 03/07/24.
//

import SwiftUI
import FaceLivenessFramework

struct ContentView: View {
    
    @State private var isShowingFaceLiveness = false
    @State private var result: FaceLivenessResult? = nil
    
    var body: some View {
        VStack {
            if result != nil {
                Text("Resultado = Status: \(result!.livenessStatus) - Score: \(result!.score)")
            }
            Button(action: {
                isShowingFaceLiveness = true
            }) {
                Text("Iniciar verifiación")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Verificación facial")
        .sheet(isPresented: $isShowingFaceLiveness) {
            let image = UIImage(named: "photo")
            let imageBase64 = image?.base64
            let imageData = Data(base64Encoded: imageBase64!)
            FaceLiveness2View(
                image: imageData!,
                skipInstructions: false,
                onSuccess: { response in
                    self.result = response
                    print("Face onSuccess")
                    isShowingFaceLiveness = false
                },
                onError: { (status, message) in
                    print("Face onError: \(status) - \(message)")
                    isShowingFaceLiveness = false
                })
        }
    }
}
```

## Importar dependencias
Agrega la librería Framework FaceLiveness en tu clase
``` Swift
import FaceLivenessFramework
```

## Agrega un objeto para la verificación
Para integrar la funcionalidad de verificación facial se requiere:
- Crea un objeto de verificación en la clase de tu aplicación
- Agrega la clase en un widget .sheet
``` Swift
FaceLiveness2View(
    image: imageData!,
    skipInstructions: false,
    onSuccess: { response in },
    onError: { (status, message) in })
```
La siguiente tabla describe los elementos del objeto FaceLiveness2View:
| Elemento | Tipo de dato | Descripción |
| :---     | :---         | :---        |
| image    | Data         | Imagen de referencia para hacer la comparación de rostro |
| skipInstructions | Boolean | Permite mostrar la pantalla de instrucciones antes de realizar la verificación facial |
| onSuccess |  | Respuesta de la verificación facial |
| onError |  | Respuesta de la verificación facial |

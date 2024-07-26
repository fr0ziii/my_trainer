# MyTrainer

## Descripción

Este proyecto de TFG consiste en el desarrollo de una aplicación móvil modular para la gestión eficientre entre clientes y entrenadores personales.
Se ha utilizaddo Flutter, que se integra con Firebase para la gestión de la base de datos y autenticación, 
y con Stripe para el procesamiento de pagos. La aplicación está diseñada para ser escalable, segura y fácil de usar.

## Tecnologías

- Flutter
- Firebase
- Stripe

## Requisitos

- Flutter SDK
- Dart SDK
- Cuenta y proyecto de Firebase
- Cuenta de Stripe
- Android Studio o Visual Studio Code
- Conexión a Internet
- Android SDK
- iOS SDK
- Emulador de Android o iOS


## Características

- **Autenticación de Usuarios:** Utiliza Firebase Authentication para registrar, iniciar sesión y gestionar usuarios.
- **Base de Datos en Tiempo Real:** Emplea Firebase Firestore para almacenar y sincronizar datos en tiempo real.
- **Notificaciones Push:** Implementación de notificaciones push usando Firebase Cloud Messaging.
- **Procesamiento de Pagos:** Integración con Stripe para gestionar pagos seguros y eficientes.
- **Interfaz de Usuario:** Diseño responsivo y amigable utilizando Flutter.
- **Soporte Multiplataforma:** Disponible para dispositivos Android e iOS.

## Estructura de la aplicación

La aplicación está dividida en tres partes principales:

1. Clientes: Esta parte es la que se encarga de gestionar los clientes y sus entrenadores. Se utiliza un sistema de roles para administrar los usuarios y asegurar la seguridad de la aplicación.

2. Entrenadores: Esta parte es la que se encarga de gestionar los entrenadores y sus clientes. Se utiliza un sistema de roles para administrar los usuarios y asegurar la seguridad de la aplicación.

3. Pagos: Esta parte es la que se encarga de procesar los pagos y gestionar los pagos realizados por los clientes y entrenadores.

4. Base de datos: Esta parte es la que se encarga de almacenar los datos de los clientes, entrenadores y pagos.

5. Sistema de notificaciones: Esta parte es la que se encarga de enviar notificaciones a los usuarios cuando ocurran eventos importantes en la aplicación.

## Instalación

1. **Clonar el repositorio:**
   ```sh
   git clone https://github.com/fr0ziii/my_trainer.git
   cd my_trainer
   ```

2. **Configurar las credenciales de Stripe:**

   1. Crear una cuenta de Stripe en https://dashboard.stripe.com/register
   2. Obtener las credenciales de Stripe en el panel de configuración de Stripe.
    
3. **Configurar las credenciales de Firebase:**
   1. Crear una cuenta de Firebase en https://console.firebase.google.com/
   2. Crear un proyecto de Firebase en la consola de Firebase.
   3. Configurar Firebase Authentication, Firestore, Cloud Messaging y Cloud Functions en la consola de Firebase.
   4. Descargar el archivo de configuración `google-services.json` (para Android) y `GoogleServiceInfo.plist` (para iOS) de Firebase y copiarlo en sus respectivos directorios (android/app
      ios/Runner).
   5. Configurar las credenciales en el archivo .env en la raíz del proyecto.
   6. El fichero .evn debe tener la siguiente estructura:
      ``` 
      GOOGLE_PROVIDER_CLIENT_ID=google_client_id
      STRIPE_SECRET_KEY=pk_test_your_secret_key
      STRIPE_PUBLISHABLE_KEY=pk_test_your_public_key
      ```
   7. Hay que configurar el proyecto de Firebase a través del FIrebase CLI. Para ello, ejecutar el siguiente comando en la terminal:
      ```sh
      firebase init
      ```
   8. Seleccionar la opción `Use an existing project` y seleccionar el proyecto de Firebase que creaste en el paso 3.
   9. Seleccionar la opción `Configure as a single-project` y confirmar la configuración.
   10. Seleccionar la opción `Get started with Firebase Authentication` y confirmar la configuración.
   11. Seleccionar la opción `Get started with Firestore` y confirmar la configuración.
   12. Seleccionar la opción `Get started with Cloud Messaging` y confirmar la configuración.
   13. Seleccionar la opción `Get started with Cloud Functions` y confirmar la configuración.
## Instalación de dependencias
1. Instalar los paquetes de Flutter:
   ```sh
   flutter pub get
   ```
2. Instalar los paquetes de Stripe:
   ```sh
   flutter pub add stripe_payment
   ```
3. Instalar los paquetes de Firebase:
   ```sh
   flutter pub add firebase_core
   flutter pub add firebase_auth
   flutter pub add cloud_firestore
   flutter pub add firebase_messaging
   flutter pub add firebase_functions
   ```
## Configuración de Android

1. Configurar el proyecto para Android:
    1. Abrir el proyecto en Android Studio.
    2. Verificar que el archivo `google-services.json` está correctamente colocado en `android/app`.
    3. Asegurarse de que las configuraciones de Gradle están correctamente configuradas.

## Configuración de iOS

1. Configurar el proyecto para iOS:
    1. Abrir el proyecto en Xcode.
    2. Verificar que el archivo GoogleService-Info.plist está correctamente colocado en ios/Runner.
    3. Asegurarse de que las configuraciones de Pods están correctamente configuradas ejecutando:

    ```sh
    cd ios
    pod install
    ```

## Ejecución de la aplicación
1. Para ejecutar la aplicación en Android, debes tener instalado Android Studio o Visual Studio Code. Si no lo tienes instalado, puedes descargarlo desde el siguiente enlace: https://developer.android.com/studio
2. Una vez que tengas Android Studio o Visual Studio Code instalado, abre el proyecto en este repositorio con tu IDE.
3. Para ejecutar la aplicación en Android, debes tener instalado Android SDK. Si no lo tienes instalado, puedes descargarlo desde el siguiente enlace: https://developer.android.com/studio
4. Ejecutar la aplicación:
   ```flutter run```

## Contribuir

Si deseas contribuir al proyecto, puedes hacerlo de varias maneras:

- Reportando errores o sugiriendo mejoras en la documentación.
- Haciendo Pull Requests para mejorar el código.
- Participando en la discusión en los foros de desarrollo.
- Ayudando a traducir la aplicación a otros idiomas.

## Licencia

Este proyecto está creado por David Iglesias Guerra para la ULPGC y licenciado bajo la licencia MIT.
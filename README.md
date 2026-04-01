# StudySync 🔵

## Estructura del proyecto

```
lib/
├── main.dart
├── assets
    └── images                  # Logo que aparece dentro de la aplicacion
├── theme/
│   └── app_theme.dart          # Colores, ThemeData, estilos globales
├── widgets/
│   └── auth_widgets.dart       # Componentes reutilizables
└── screens/
    ├── login_screen.dart        # Pantalla de inicio de sesión
    ├── register_screen.dart     # Pantalla de registro
    └── forgot_password_screen.dart  # Recuperar contraseña
```

## Pantallas incluidas

| Pantalla | Descripción |
|---|---|
| **Login** | Email + contraseña, login social (Google/Apple), link a registro y recuperación |
| **Register** | Nombre, email, contraseña, confirmar contraseña, términos y condiciones |
| **Forgot Password** | Envío de correo de recuperación + estado de éxito animado |
| **Dashboard** | gestion de tareas y entregas, visualizacion calendario semanal + boton de navegacion inferior y de accion flotante  |
## Características de diseño

-  Paleta de colores en azul
-  Animaciones de entrada (fade + slide) en cada pantalla
-  Validación de formularios con `Form` + `GlobalKey`
-  Toggle mostrar/ocultar contraseña
-  Navegación con transiciones suaves (`FadeTransition`)
-  Compatible con teclado (scroll automático)
-  Botón con gradiente y sombra azul
-  Estado de éxito en recuperación de contraseña
-  seccion de encabezado con saludo y fecha dinamica
-  sección de gestión de tareas y entregas
-  visualización de calendario semanal
-  integrar navegación inferior y botón de acción flotante
## Cómo usar

```bash
# 1. Instalar dependencias
flutter pub get

# 2. Ejecutar la app
flutter run
```
# StudySync 🔵

StudySync es una aplicación de gestión de estudios que permite a los usuarios autenticarse, gestionar tareas y entregas, y visualizar un calendario semanal. Desarrollada con Flutter para el frontend y FastAPI para el backend.

## Estructura del proyecto

```
taller_apis/
├── README.md
├── auth_app/                    # Aplicación Flutter
│   ├── lib/
│   │   ├── main.dart
│   │   ├── assets/
│   │   │   └── images/         # Logo de la aplicación
│   │   ├── theme/
│   │   │   └── app_theme.dart  # Colores, ThemeData, estilos globales
│   │   ├── widgets/
│   │   │   └── auth_widgets.dart # Componentes reutilizables
│   │   └── screens/
│   │       ├── login_screen.dart       # Pantalla de inicio de sesión
│   │       ├── register_screen.dart    # Pantalla de registro
│   │       ├── forgot_password_screen.dart # Recuperar contraseña
│   │       ├── pantalla_dashboard.dart # Dashboard con tareas y calendario
│   │       ├── calendar_screen.dart    # Pantalla de calendario
│   │       ├── task_list_screen.dart   # Lista de tareas
│   │       └── profile_screen.dart     # Perfil de usuario
│   ├── pubspec.yaml
│   └── ...
└── backend_auth/               # Backend en Python con FastAPI
    ├── main.py                 # Servidor FastAPI con rutas de autenticación
    └── requirements.txt        # Dependencias de Python
```

## Pantallas incluidas

| Pantalla | Descripción |
|---|---|
| **Login** | Email + contraseña, login social (Google/Apple), link a registro y recuperación |
| **Register** | Nombre, email, contraseña, confirmar contraseña, términos y condiciones |
| **Forgot Password** | Envío de correo de recuperación + estado de éxito animado |
| **Dashboard** | Gestión de tareas y entregas, visualización calendario semanal + botón de navegación inferior y de acción flotante |
| **Calendar** | Vista detallada del calendario |
| **Task List** | Lista de tareas pendientes |
| **Profile** | Perfil del usuario |

## Características de diseño

- Paleta de colores en azul
- Animaciones de entrada (fade + slide) en cada pantalla
- Validación de formularios con `Form` + `GlobalKey`
- Toggle mostrar/ocultar contraseña
- Navegación con transiciones suaves (`FadeTransition`)
- Compatible con teclado (scroll automático)
- Botón con gradiente y sombra azul
- Estado de éxito en recuperación de contraseña
- Sección de encabezado con saludo y fecha dinámica
- Sección de gestión de tareas y entregas
- Visualización de calendario semanal
- Integrar navegación inferior y botón de acción flotante

## Backend

El backend está construido con FastAPI y utiliza MySQL para almacenar usuarios. Incluye encriptación de contraseñas con bcrypt.

### Endpoints principales
- `POST /register`: Registrar un nuevo usuario
- `POST /login`: Iniciar sesión

## Cómo usar

### Requisitos previos
- Flutter SDK instalado
- Python 3.x instalado
- MySQL instalado y configurado
- Crear base de datos `auth_db` y tabla `users` con columnas: `id` (AUTO_INCREMENT), `name`, `email`, `password`

### Ejecutar el backend
```bash
cd backend_auth
pip install -r requirements.txt
uvicorn main:app --reload
```

### Ejecutar la aplicación Flutter
```bash
cd auth_app
flutter pub get
flutter run
```
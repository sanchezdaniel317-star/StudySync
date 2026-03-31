# Flutter Auth App 🔵

Pantallas de autenticación modernas con la paleta de azules `#056CF2 · #3D9DF2 · #B4C4D9 · #EBEEF2`.

## Estructura del proyecto

```
lib/
├── main.dart
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

## Características de diseño

- 🎨 Paleta de colores consistente con `AppColors`
- ✨ Animaciones de entrada (fade + slide) en cada pantalla
- 🔒 Validación de formularios con `Form` + `GlobalKey`
- 👁️ Toggle mostrar/ocultar contraseña
- 🔄 Navegación con transiciones suaves (`FadeTransition`)
- 📱 Compatible con teclado (scroll automático)
- 🌈 Botón con gradiente y sombra azul
- ✅ Estado de éxito en recuperación de contraseña

## Cómo usar

```bash
# 1. Instalar dependencias
flutter pub get

# 2. Ejecutar la app
flutter run
```

## Próximos pasos sugeridos

- Conectar con Firebase Auth o tu backend
- Agregar Google Sign-In / Apple Sign-In reales
- Agregar pantalla Home después del login exitoso
- Implementar persistencia de sesión con `shared_preferences`

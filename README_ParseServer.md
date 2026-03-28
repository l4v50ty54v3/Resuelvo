# Resuelvo - Flutter App con Parse Server

Esta aplicación Flutter está integrada con Parse Server como backend.

## Configuración de Parse Server

### 1. Instalar Parse Server

Puedes instalar Parse Server de varias formas:

#### Opción A: Parse Server en Docker (Recomendado)
```bash
docker run --name resuelvo-parse \
  -p 1337:1337 \
  -e PARSE_SERVER_APPLICATION_ID=your-app-id \
  -e PARSE_SERVER_MASTER_KEY=your-master-key \
  -e PARSE_SERVER_DATABASE_URI=mongodb://localhost:27017/resuelvo \
  parseplatform/parse-server
```

#### Opción B: Parse Server con npm
```bash
npm install -g parse-server mongodb-runner
mongodb-runner start
parse-server --appId your-app-id --masterKey your-master-key --databaseURI mongodb://localhost:27017/resuelvo
```

### 2. Configurar la aplicación

Edita el archivo `lib/services/parse_config.dart` y actualiza las constantes:

```dart
class ParseConfig {
  static const String applicationId = 'your-app-id'; // Tu App ID
  static const String clientKey = 'your-client-key'; // Tu Client Key (opcional)
  static const String serverUrl = 'https://your-parse-server-url/parse'; // URL de tu servidor
  // ...
}
```

### 3. Configurar la base de datos

Parse Server creará automáticamente las tablas para:
- User (usuarios)
- Teacher (profesores)
- Student (estudiantes)
- Class (clases)
- Request (solicitudes)

### 4. Permisos y Roles

Asegúrate de configurar los permisos en Parse Server para:
- Lectura/escritura de usuarios
- Relaciones entre profesores y estudiantes
- Acceso a clases y solicitudes

## Estructura del Proyecto

```
lib/
├── models/           # Modelos de datos
│   ├── base_model.dart
│   ├── parse_user_model.dart
│   ├── parse_teacher.dart
│   ├── parse_student.dart
│   ├── parse_class.dart
│   ├── parse_request.dart
│   └── models.dart    # Exporta todos los modelos
├── services/         # Servicios y lógica de negocio
│   ├── parse_config.dart
│   ├── auth_service.dart
│   ├── class_service.dart
│   ├── request_service.dart
│   └── services.dart  # Exporta todos los servicios
└── features/         # Pantallas y widgets
    ├── login/
    ├── Home/
    └── ...
```

## Funcionalidades Implementadas

### Autenticación
- Login con email/contraseña
- Registro de usuarios
- Logout
- Persistencia de sesión

### Gestión de Profesores
- Perfil del profesor
- Lista de clases asignadas
- Solicitudes pendientes de estudiantes

### Gestión de Estudiantes
- Perfil del estudiante
- Inscripción a clases
- Envío de solicitudes a profesores

### Gestión de Clases
- Creación de clases
- Inscripción de estudiantes
- Información de horarios y capacidad

### Sistema de Solicitudes
- Estudiantes pueden enviar solicitudes a profesores
- Profesores pueden gestionar solicitudes (pendiente, en progreso, completada, cancelada)

## Próximos Pasos

Para completar la aplicación, considera implementar:

1. **Dashboard del Estudiante**: Pantalla principal para estudiantes
2. **Gestión de Tareas**: Crear y asignar homework
3. **Sistema de Calificaciones**: Evaluar trabajos de estudiantes
4. **Mensajería**: Chat entre profesores y estudiantes
5. **Notificaciones Push**: Alertas en tiempo real
6. **Archivos Adjuntos**: Subida de documentos y imágenes

## Dependencias

- `parse_server_sdk_flutter`: SDK oficial de Parse Server para Flutter
- `provider`: State management
- `shared_preferences`: Almacenamiento local
- `http`: Cliente HTTP compatible con Parse SDK

## Ejecutar la Aplicación

```bash
flutter pub get
flutter run
```

Asegúrate de que Parse Server esté ejecutándose antes de iniciar la aplicación.
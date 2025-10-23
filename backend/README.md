# Backend para UCEVA IoT

Este backend estará basado en Node.js y Express, conectado a MySQL.

Estructura inicial:
- src/
  - index.js
  - routes/
    - auth.js
  - controllers/
    - authController.js
  - models/
    - db.js
    - user.js

Configuración de conexión MySQL:
Host: localhost
Puerto: 3306
Usuario: root
Contraseña: Root@2025
Base de datos: monitoreo_energia

Endpoints iniciales:
- POST /api/register
- POST /api/login

Roles soportados: docente, tecnico, admin

Próximos pasos: implementar lógica de registro, login y gestión de roles.

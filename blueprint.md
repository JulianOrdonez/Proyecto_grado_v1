# Vize - Blueprint

## Visión General

Vize es una aplicación de tesis diseñada para visualizar datos de sensores en tiempo real y consultar historiales. La aplicación se enfoca en proporcionar una interfaz de usuario limpia e intuitiva para monitorear y analizar datos de manera eficiente.

## Diseño y Estilo

- **Paleta de Colores:**
  - Fondo de Pantalla: `#F5F7FA`
  - Azul Primario: `#4A69FF`
  - Texto Principal: `#1E2A51`
  - Tarjetas Oscuras: `#2D3047`
  - Blanco: `#FFFFFF`
- **Tipografía:** Se utilizará una fuente moderna y legible en toda la aplicación.
- **Iconografía:** Se prefieren los íconos de `iconsax` por su estilo limpio y moderno.

## Arquitectura de Navegación

La navegación principal de la aplicación se gestiona a través de un `IndexedStack` controlado por un `StateNotifierProvider` de Riverpod. Esto permite cambiar entre pantallas de manera eficiente sin perder el estado de cada una.

- **`main_screen.dart`:** Contiene el `IndexedStack` y la barra de navegación inferior, actuando como el controlador principal de la UI.
- **`navigation.dart`:** Define el `navigationProvider` que gestiona el índice de la pantalla seleccionada.
- **`custom_bottom_navigation_bar.dart`:** Un widget reutilizable para la barra de navegación inferior.

## Características Implementadas

### v0.3 (Actual)

- **Pantalla de Archivos (FilesScreen):**
  - **AppBar Personalizado:** Con el logo "Vize" y el título "Files".
  - **Barra de Búsqueda de Archivos:** Un `TextField` para buscar archivos y carpetas.
  - **Filtros de Categoría:** Botones para filtrar por "All Categories" y "Reports".
  - **Archivos Recientes:** Una lista de tarjetas que muestran los archivos accedidos recientemente con detalles como nombre, tipo y fecha.
  - **Carpetas:** Una sección que lista las carpetas disponibles.
- **Navegación Completa:** La barra de navegación ahora es completamente funcional y permite navegar entre las pantallas `HomeScreen`, `SearchScreen` y `FilesScreen`.

### v0.2

- **Pantalla de Búsqueda (SearchScreen):**
  - **AppBar Personalizado:** Con el logo "Vize" y un ícono de notificaciones.
  - **Barra de Búsqueda:** Un `TextField` estilizado con íconos de búsqueda y micrófono.
  - **Filtros:** Botones para filtrar por "Todas las categorías" y "Reportes".
  - **Búsquedas Recientes:** Una lista de tarjetas que muestran las búsquedas anteriores del usuario.

### v0.1

- **Pantalla Principal (HomeScreen):**
  - **AppBar Personalizado:** Con accesos a configuración y notificaciones, y el logo de "Vize" centrado.
  - **Filtros de Tiempo:** Botones para filtrar la visualización de datos por día, mes o año.
  - **Gráfico de Consumo:** Un gráfico de barras que muestra el consumo a lo largo del tiempo, implementado con `fl_chart`.
  - **Módulos de Estado Rápido:** Tarjetas para un vistazo rápido a la iluminación, movimiento y consumo.
  - **Estado en Tiempo Real:** Una lista de dispositivos con su estado actual (encendido/apagado).
  - **Barra de Navegación Inicial:** Una barra de navegación flotante y personalizada con tres pestañas.

## Plan para la Solicitud Actual

- **Objetivo:** Crear la `FilesScreen` e integrarla en la navegación existente.
- **Pasos:**
  1.  **Crear `screens/files_screen.dart`:**
      - Implementar el `ConsumerWidget` `FilesScreen` con una réplica exacta del diseño proporcionado.
      - Estructurar la UI con `AppBar`, barra de búsqueda, filtros y listas para archivos y carpetas.
  2.  **Actualizar `screens/main_screen.dart`:**
      - Reemplazar el `Placeholder` en la lista `screens` con la nueva `FilesScreen`.
      - Asegurar que el `IndexedStack` muestre correctamente la nueva pantalla.
  3.  **Actualizar `blueprint.md`:**
      - Documentar la nueva `FilesScreen` y sus características en una nueva versión (v0.3).
      - Confirmar que la navegación está completa.

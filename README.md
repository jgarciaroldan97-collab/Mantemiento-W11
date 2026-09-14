# Windows Tools v5

Menú de diagnóstico, consulta, reparación y mantenimiento para equipos con **Windows 11**.

El proyecto está orientado a técnicos de soporte que necesitan ejecutar tareas frecuentes desde una interfaz sencilla, con confirmaciones antes de operaciones sensibles y registro de actividad.

## Funciones principales

- Información del equipo, Windows, BIOS, procesador, RAM y almacenamiento.
- Consulta de red, direcciones IP y conexiones activas.
- Estado de activación y BitLocker.
- Diagnóstico de imagen, archivos del sistema y discos.
- Consulta de servicios, errores críticos y controladores con problemas.
- Reparación mediante DISM y SFC.
- Reinicio de la cola de impresión.
- Reparación de componentes de Windows Update.
- Limpieza de temporales y caché de actualizaciones.
- Análisis y optimización de unidades SSD o HDD.
- Accesos rápidos a herramientas administrativas de Windows 11.
- Generación de un informe técnico en el escritorio.

## Requisitos

- Windows 11.
- PowerShell 5.1 o superior.
- Permisos de administrador.

## Uso

1. Descargue `Windows Tools v5.bat`.
2. Ejecútelo con doble clic.
3. Acepte la solicitud de permisos de administrador.
4. Seleccione una opción utilizando el número correspondiente.

El registro de ejecución se almacena en:

```text
C:\ProgramData\WindowsTools\WindowsTools_NOMBRE-EQUIPO.log
```

## Seguridad

- Las operaciones que pueden interrumpir la red, reiniciar servicios o requerir un reinicio solicitan confirmación.
- El diagnóstico rápido utiliza inicialmente opciones de solo lectura.
- La comprobación de disco se ejecuta primero con `CHKDSK /scan`.
- Antes de usarlo masivamente, pruebe la versión en un equipo controlado y valide las políticas de su organización.

## Compatibilidad con Windows 11

Las consultas antiguas basadas en WMIC fueron sustituidas por PowerShell y CIM, ya que WMIC está obsoleto y puede no estar disponible en instalaciones recientes de Windows 11.

## Créditos

Basado en Windows Tools v4, elaborado originalmente por Jorge López Amador.

Versión v5 reorganizada y ampliada para mantenimiento de Windows 11.

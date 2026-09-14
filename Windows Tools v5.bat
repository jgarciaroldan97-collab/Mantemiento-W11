@echo off
setlocal EnableExtensions DisableDelayedExpansion
chcp 65001 >nul
title Windows Tools v5 - Mantenimiento Windows 11

rem ================================================================
rem Windows Tools v5
rem Menu de diagnostico y mantenimiento para Windows 11.
rem Basado en Windows Tools v4 de Jorge Lopez Amador.
rem ================================================================

set "APP_NAME=Windows Tools v5"
set "LOG_DIR=%ProgramData%\WindowsTools"
set "LOG_FILE=%LOG_DIR%\WindowsTools_%COMPUTERNAME%.log"

if not exist "%LOG_DIR%" md "%LOG_DIR%" >nul 2>&1
call :Log "Inicio de %APP_NAME%"
call :EnsureAdmin
if errorlevel 1 exit /b 1

:MainMenu
cls
call :Header "MENU PRINCIPAL"
echo   [1] Informacion del sistema
echo   [2] Diagnostico rapido
echo   [3] Reparacion de Windows
echo   [4] Red y conectividad
echo   [5] Limpieza y almacenamiento
echo   [6] Herramientas de Windows 11
echo   [7] Ver archivo de registro
echo   [0] Salir
echo.
choice /c 12345670 /n /m "Seleccione una opcion: "
if errorlevel 8 goto ExitApp
if errorlevel 7 goto ViewLog
if errorlevel 6 goto ToolsMenu
if errorlevel 5 goto CleanupMenu
if errorlevel 4 goto NetworkMenu
if errorlevel 3 goto RepairMenu
if errorlevel 2 goto DiagnosticsMenu
if errorlevel 1 goto SystemMenu
goto MainMenu

:SystemMenu
cls
call :Header "INFORMACION DEL SISTEMA"
echo   [1] Resumen general
echo   [2] Red e IP
echo   [3] Procesador y memoria RAM
echo   [4] Discos y espacio disponible
echo   [5] BIOS, fabricante y numero de serie
echo   [6] Estado de activacion de Windows
echo   [7] Estado de BitLocker
echo   [8] Generar informe completo en el Escritorio
echo   [9] Volver
echo   [0] Salir
echo.
choice /c 1234567890 /n /m "Seleccione una opcion: "
if errorlevel 10 goto ExitApp
if errorlevel 9 goto MainMenu
if errorlevel 8 goto FullReport
if errorlevel 7 goto BitLockerStatus
if errorlevel 6 goto Activation
if errorlevel 5 goto BiosInfo
if errorlevel 4 goto DiskInfo
if errorlevel 3 goto CpuRam
if errorlevel 2 goto IpInfo
if errorlevel 1 goto SystemSummary
goto SystemMenu

:DiagnosticsMenu
cls
call :Header "DIAGNOSTICO RAPIDO"
echo   [1] Diagnostico completo de solo lectura
echo   [2] Estado de servicios esenciales
echo   [3] Ultimos errores criticos del sistema
echo   [4] Prueba de Internet y DNS
echo   [5] Estado de Windows Update
echo   [6] Controladores con problemas
echo   [9] Volver
echo   [0] Salir
echo.
choice /c 12345690 /n /m "Seleccione una opcion: "
if errorlevel 8 goto ExitApp
if errorlevel 7 goto MainMenu
if errorlevel 6 goto DriverProblems
if errorlevel 5 goto UpdateStatus
if errorlevel 4 goto ConnectivityTest
if errorlevel 3 goto CriticalEvents
if errorlevel 2 goto ServiceStatus
if errorlevel 1 goto QuickDiagnostic
goto DiagnosticsMenu

:RepairMenu
cls
call :Header "REPARACION DE WINDOWS"
echo   [1] Reparacion recomendada: DISM y luego SFC
echo   [2] Comprobar archivos del sistema (SFC)
echo   [3] Reparar imagen de Windows (DISM)
echo   [4] Comprobar disco en modo lectura
echo   [5] Programar reparacion de disco al reiniciar
echo   [6] Reiniciar cola de impresion
echo   [7] Reiniciar componentes de Windows Update
echo   [9] Volver
echo   [0] Salir
echo.
choice /c 123456790 /n /m "Seleccione una opcion: "
if errorlevel 9 goto ExitApp
if errorlevel 8 goto MainMenu
if errorlevel 7 goto ResetWindowsUpdate
if errorlevel 6 goto RestartSpooler
if errorlevel 5 goto ScheduleChkdsk
if errorlevel 4 goto ScanDisk
if errorlevel 3 goto DismRepair
if errorlevel 2 goto SfcRepair
if errorlevel 1 goto RecommendedRepair
goto RepairMenu

:NetworkMenu
cls
call :Header "RED Y CONECTIVIDAD"
echo   [1] Mostrar configuracion IP completa
echo   [2] Limpiar cache DNS
echo   [3] Renovar direccion IP
echo   [4] Restablecer Winsock y TCP/IP
echo   [5] Ver conexiones y puertos activos
echo   [6] Abrir adaptadores de red
echo   [9] Volver
echo   [0] Salir
echo.
choice /c 12345690 /n /m "Seleccione una opcion: "
if errorlevel 8 goto ExitApp
if errorlevel 7 goto MainMenu
if errorlevel 6 goto NetworkAdapters
if errorlevel 5 goto ActiveConnections
if errorlevel 4 goto ResetNetwork
if errorlevel 3 goto RenewIp
if errorlevel 2 goto FlushDns
if errorlevel 1 goto IpInfoNetwork
goto NetworkMenu

:CleanupMenu
cls
call :Header "LIMPIEZA Y ALMACENAMIENTO"
echo   [1] Abrir recomendaciones de limpieza
echo   [2] Abrir Sensor de almacenamiento
echo   [3] Limpiar temporales del usuario
echo   [4] Limpiar cache de Windows Update
echo   [5] Optimizar unidades (analizar primero)
echo   [6] Ver componentes del almacen de Windows
echo   [9] Volver
echo   [0] Salir
echo.
choice /c 12345690 /n /m "Seleccione una opcion: "
if errorlevel 8 goto ExitApp
if errorlevel 7 goto MainMenu
if errorlevel 6 goto ComponentStore
if errorlevel 5 goto OptimizeDrives
if errorlevel 4 goto CleanUpdateCache
if errorlevel 3 goto CleanUserTemp
if errorlevel 2 goto StorageSense
if errorlevel 1 goto CleanupRecommendations
goto CleanupMenu

:ToolsMenu
cls
call :Header "HERRAMIENTAS DE WINDOWS 11"
echo   [1] Administrador de tareas
echo   [2] Administrador de dispositivos
echo   [3] Administracion de equipos
echo   [4] Visor de eventos
echo   [5] Servicios
echo   [6] Programas instalados
echo   [7] Windows Update
echo   [8] Seguridad de Windows
echo   [9] Volver
echo   [0] Salir
echo.
choice /c 1234567890 /n /m "Seleccione una opcion: "
if errorlevel 10 goto ExitApp
if errorlevel 9 goto MainMenu
if errorlevel 8 (start "" windowsdefender: & goto ToolsMenu)
if errorlevel 7 (start "" ms-settings:windowsupdate & goto ToolsMenu)
if errorlevel 6 (start "" ms-settings:appsfeatures & goto ToolsMenu)
if errorlevel 5 (start "" services.msc & goto ToolsMenu)
if errorlevel 4 (start "" eventvwr.msc & goto ToolsMenu)
if errorlevel 3 (start "" compmgmt.msc & goto ToolsMenu)
if errorlevel 2 (start "" devmgmt.msc & goto ToolsMenu)
if errorlevel 1 (start "" taskmgr.exe & goto ToolsMenu)
goto ToolsMenu

:SystemSummary
cls
call :Header "RESUMEN GENERAL"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "$os=Get-CimInstance Win32_OperatingSystem; $cs=Get-CimInstance Win32_ComputerSystem;" ^
 "[pscustomobject]@{'Equipo'=$env:COMPUTERNAME;'Usuario'=[Environment]::UserName;'Fabricante'=$cs.Manufacturer;'Modelo'=$cs.Model;'Windows'=$os.Caption;'Version'=$os.Version;'Compilacion'=$os.BuildNumber;'Ultimo inicio'=$os.LastBootUpTime} | Format-List"
call :Log "Consulta: resumen general"
call :PauseTo SystemMenu

:IpInfo
cls
call :Header "CONFIGURACION DE RED"
ipconfig /all
call :Log "Consulta: configuracion IP"
call :PauseTo SystemMenu

:IpInfoNetwork
cls
call :Header "CONFIGURACION DE RED"
ipconfig /all
call :Log "Consulta: configuracion IP"
call :PauseTo NetworkMenu

:CpuRam
cls
call :Header "PROCESADOR Y MEMORIA"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "$cpu=Get-CimInstance Win32_Processor | Select-Object -First 1; $cs=Get-CimInstance Win32_ComputerSystem;" ^
 "[pscustomobject]@{'Procesador'=$cpu.Name;'Nucleos'=$cpu.NumberOfCores;'Procesadores logicos'=$cpu.NumberOfLogicalProcessors;'RAM GB'=[math]::Round($cs.TotalPhysicalMemory/1GB,2)} | Format-List;" ^
 "Get-CimInstance Win32_PhysicalMemory | Select-Object BankLabel,Manufacturer,@{N='Capacidad GB';E={[math]::Round($_.Capacity/1GB,2)}},Speed | Format-Table -AutoSize"
call :Log "Consulta: CPU y RAM"
call :PauseTo SystemMenu

:DiskInfo
cls
call :Header "DISCOS Y ESPACIO"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "Get-Volume | Where-Object DriveLetter | Select-Object DriveLetter,FileSystemLabel,FileSystem,HealthStatus,@{N='Tamano GB';E={[math]::Round($_.Size/1GB,1)}},@{N='Libre GB';E={[math]::Round($_.SizeRemaining/1GB,1)}} | Format-Table -AutoSize;" ^
 "Get-PhysicalDisk | Select-Object FriendlyName,MediaType,HealthStatus,OperationalStatus,@{N='Tamano GB';E={[math]::Round($_.Size/1GB,1)}} | Format-Table -AutoSize"
call :Log "Consulta: discos"
call :PauseTo SystemMenu

:BiosInfo
cls
call :Header "BIOS Y EQUIPO"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "$cs=Get-CimInstance Win32_ComputerSystem; $bios=Get-CimInstance Win32_BIOS;" ^
 "[pscustomobject]@{'Fabricante'=$cs.Manufacturer;'Modelo'=$cs.Model;'Numero de serie'=$bios.SerialNumber;'Version BIOS'=$bios.SMBIOSBIOSVersion;'Fecha BIOS'=$bios.ReleaseDate} | Format-List"
call :Log "Consulta: BIOS y serie"
call :PauseTo SystemMenu

:Activation
cls
call :Header "ACTIVACION DE WINDOWS"
cscript.exe //nologo "%SystemRoot%\System32\slmgr.vbs" /xpr
call :Log "Consulta: activacion"
call :PauseTo SystemMenu

:BitLockerStatus
cls
call :Header "ESTADO DE BITLOCKER"
manage-bde -status
call :Log "Consulta: BitLocker"
call :PauseTo SystemMenu

:FullReport
cls
call :Header "GENERAR INFORME"
set "REPORT=%USERPROFILE%\Desktop\Informe_%COMPUTERNAME%_%DATE:/=-%.txt"
echo Generando informe en el Escritorio...
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "$p=$env:REPORT; 'INFORME DEL SISTEMA - '+(Get-Date) | Out-File -FilePath $p -Encoding utf8;" ^
 "Get-ComputerInfo -Property CsName,CsManufacturer,CsModel,CsTotalPhysicalMemory,WindowsProductName,WindowsVersion,OsBuildNumber,OsLastBootUpTime | Format-List | Out-File $p -Append -Encoding utf8;" ^
 "Get-Volume | Where-Object DriveLetter | Format-Table DriveLetter,FileSystemLabel,FileSystem,HealthStatus,Size,SizeRemaining -AutoSize | Out-File $p -Append -Encoding utf8;" ^
 "Get-NetIPConfiguration | Format-List InterfaceAlias,IPv4Address,IPv4DefaultGateway,DNSServer | Out-File $p -Append -Encoding utf8"
if exist "%REPORT%" (echo Informe creado: "%REPORT%"& call :Log "Informe creado: %REPORT%") else echo No se pudo crear el informe.
call :PauseTo SystemMenu

:QuickDiagnostic
cls
call :Header "DIAGNOSTICO COMPLETO DE SOLO LECTURA"
echo [1/5] Imagen de Windows...
DISM.exe /Online /Cleanup-Image /CheckHealth
echo.
echo [2/5] Archivos protegidos...
sfc.exe /verifyonly
echo.
echo [3/5] Unidad del sistema...
chkdsk.exe %SystemDrive% /scan
echo.
echo [4/5] Servicios esenciales...
powershell.exe -NoLogo -NoProfile -Command "Get-Service BITS,wuauserv,Winmgmt,Dnscache,EventLog | Format-Table Name,Status,StartType -AutoSize"
echo.
echo [5/5] Reinicio pendiente...
powershell.exe -NoLogo -NoProfile -Command "$p=(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending') -or (Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'); if($p){'SI: hay un reinicio pendiente'}else{'NO: no se detecto reinicio pendiente'}"
call :Log "Diagnostico completo finalizado"
call :PauseTo DiagnosticsMenu

:ServiceStatus
cls
call :Header "SERVICIOS ESENCIALES"
powershell.exe -NoLogo -NoProfile -Command "Get-Service BITS,wuauserv,CryptSvc,Winmgmt,Dnscache,EventLog,Spooler | Sort-Object Name | Format-Table Name,DisplayName,Status,StartType -AutoSize"
call :Log "Consulta: servicios esenciales"
call :PauseTo DiagnosticsMenu

:CriticalEvents
cls
call :Header "ERRORES CRITICOS - ULTIMAS 24 HORAS"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "$start=(Get-Date).AddHours(-24); Get-WinEvent -FilterHashtable @{LogName='System';Level=1,2;StartTime=$start} -ErrorAction SilentlyContinue | Select-Object -First 25 TimeCreated,Id,ProviderName,LevelDisplayName,@{N='Mensaje';E={$_.Message -replace '\r?\n',' '}} | Format-Table -Wrap"
call :Log "Consulta: eventos criticos"
call :PauseTo DiagnosticsMenu

:ConnectivityTest
cls
call :Header "PRUEBA DE INTERNET Y DNS"
echo Puerta de enlace:
powershell.exe -NoLogo -NoProfile -Command "Get-NetRoute -DestinationPrefix '0.0.0.0/0' | Sort-Object RouteMetric | Select-Object -First 1 NextHop,InterfaceAlias,RouteMetric | Format-Table -AutoSize"
echo.
ping.exe -n 2 1.1.1.1
echo.
nslookup.exe www.microsoft.com
call :Log "Prueba de conectividad ejecutada"
call :PauseTo DiagnosticsMenu

:UpdateStatus
cls
call :Header "ESTADO DE WINDOWS UPDATE"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "Get-Service wuauserv,BITS,UsoSvc | Format-Table Name,Status,StartType -AutoSize;" ^
 "Write-Host ''; Write-Host 'Ultimas actualizaciones instaladas:'; Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 10 HotFixID,Description,InstalledOn | Format-Table -AutoSize"
call :Log "Consulta: Windows Update"
call :PauseTo DiagnosticsMenu

:DriverProblems
cls
call :Header "CONTROLADORES CON PROBLEMAS"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "$d=Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object Status -ne 'OK'; if($d){$d | Select-Object Status,Class,FriendlyName,InstanceId | Format-Table -Wrap}else{Write-Host 'No se detectaron dispositivos presentes con error.' -ForegroundColor Green}"
call :Log "Consulta: controladores con problemas"
call :PauseTo DiagnosticsMenu

:RecommendedRepair
cls
call :Header "REPARACION RECOMENDADA"
call :Confirm "Ejecutar DISM RestoreHealth y despues SFC Scannow?"
if errorlevel 2 goto RepairMenu
call :Log "Inicio: reparacion recomendada"
DISM.exe /Online /Cleanup-Image /RestoreHealth
set "RC_DISM=%ERRORLEVEL%"
sfc.exe /scannow
set "RC_SFC=%ERRORLEVEL%"
echo.
echo Codigos de salida: DISM=%RC_DISM%  SFC=%RC_SFC%
call :Log "Fin: reparacion recomendada. DISM=%RC_DISM%, SFC=%RC_SFC%"
call :PauseTo RepairMenu

:SfcRepair
cls
call :Header "REPARAR ARCHIVOS DEL SISTEMA"
call :Confirm "Ejecutar SFC /scannow?"
if errorlevel 2 goto RepairMenu
sfc.exe /scannow
call :Log "SFC finalizo con codigo %ERRORLEVEL%"
call :PauseTo RepairMenu

:DismRepair
cls
call :Header "REPARAR IMAGEN DE WINDOWS"
call :Confirm "Ejecutar DISM /RestoreHealth?"
if errorlevel 2 goto RepairMenu
DISM.exe /Online /Cleanup-Image /RestoreHealth
call :Log "DISM finalizo con codigo %ERRORLEVEL%"
call :PauseTo RepairMenu

:ScanDisk
cls
call :Header "COMPROBAR DISCO"
call :ReadDrive
if not defined TARGET_DRIVE goto RepairMenu
chkdsk.exe %TARGET_DRIVE%: /scan
call :Log "CHKDSK /scan ejecutado en %TARGET_DRIVE%: con codigo %ERRORLEVEL%"
call :PauseTo RepairMenu

:ScheduleChkdsk
cls
call :Header "PROGRAMAR REPARACION DE DISCO"
call :ReadDrive
if not defined TARGET_DRIVE goto RepairMenu
call :Confirm "Programar CHKDSK /F para %TARGET_DRIVE%:? Puede requerir reinicio"
if errorlevel 2 goto RepairMenu
echo Y|chkdsk.exe %TARGET_DRIVE%: /f
call :Log "CHKDSK /F solicitado para %TARGET_DRIVE%:"
call :PauseTo RepairMenu

:RestartSpooler
cls
call :Header "REINICIAR COLA DE IMPRESION"
call :Confirm "Detener Spooler, borrar trabajos pendientes y reiniciarlo?"
if errorlevel 2 goto RepairMenu
net stop Spooler
del /q "%SystemRoot%\System32\spool\PRINTERS\*" >nul 2>&1
net start Spooler
call :Log "Cola de impresion reiniciada"
call :PauseTo RepairMenu

:ResetWindowsUpdate
cls
call :Header "REINICIAR WINDOWS UPDATE"
call :Confirm "Reiniciar servicios y caches de Windows Update?"
if errorlevel 2 goto RepairMenu
call :Log "Inicio: reinicio de Windows Update"
for %%S in (BITS wuauserv cryptsvc msiserver) do net stop %%S /y >nul 2>&1
if exist "%SystemRoot%\SoftwareDistribution" ren "%SystemRoot%\SoftwareDistribution" "SoftwareDistribution.old.%RANDOM%" >nul 2>&1
if exist "%SystemRoot%\System32\catroot2" ren "%SystemRoot%\System32\catroot2" "catroot2.old.%RANDOM%" >nul 2>&1
for %%S in (cryptsvc BITS msiserver wuauserv) do net start %%S >nul 2>&1
echo Componentes de Windows Update reiniciados.
call :Log "Fin: reinicio de Windows Update"
call :PauseTo RepairMenu

:FlushDns
cls
ipconfig.exe /flushdns
call :Log "Cache DNS limpiada"
call :PauseTo NetworkMenu

:RenewIp
cls
call :Confirm "Liberar y renovar la IP puede interrumpir conexiones remotas. Continuar?"
if errorlevel 2 goto NetworkMenu
ipconfig.exe /release
ipconfig.exe /renew
call :Log "Direccion IP renovada"
call :PauseTo NetworkMenu

:ResetNetwork
cls
call :Confirm "Restablecer Winsock y TCP/IP? Sera necesario reiniciar"
if errorlevel 2 goto NetworkMenu
netsh.exe winsock reset
netsh.exe int ip reset
call :Log "Winsock y TCP/IP restablecidos; reinicio pendiente"
call :PauseTo NetworkMenu

:ActiveConnections
cls
call :Header "CONEXIONES Y PUERTOS ACTIVOS"
netstat.exe -abno
call :Log "Consulta: conexiones activas"
call :PauseTo NetworkMenu

:NetworkAdapters
start "" ncpa.cpl
goto NetworkMenu

:CleanupRecommendations
start "" ms-settings:storagerecommendations
goto CleanupMenu

:StorageSense
start "" ms-settings:storagepolicies
goto CleanupMenu

:CleanUserTemp
cls
call :Header "LIMPIAR TEMPORALES DEL USUARIO"
call :Confirm "Eliminar archivos temporales no bloqueados de %TEMP%?"
if errorlevel 2 goto CleanupMenu
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%D in ("%TEMP%\*") do rd /s /q "%%~fD" >nul 2>&1
echo Limpieza terminada. Los archivos en uso se conservaron.
call :Log "Temporales del usuario limpiados"
call :PauseTo CleanupMenu

:CleanUpdateCache
cls
call :Header "LIMPIAR CACHE DE WINDOWS UPDATE"
call :Confirm "Eliminar descargas temporales de Windows Update?"
if errorlevel 2 goto CleanupMenu
net stop wuauserv >nul 2>&1
net stop BITS >nul 2>&1
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%D in ("%SystemRoot%\SoftwareDistribution\Download\*") do rd /s /q "%%~fD" >nul 2>&1
net start BITS >nul 2>&1
net start wuauserv >nul 2>&1
echo Cache de descargas limpiada.
call :Log "Cache de Windows Update limpiada"
call :PauseTo CleanupMenu

:OptimizeDrives
cls
call :Header "OPTIMIZAR UNIDADES"
defrag.exe /C /A /U /V
echo.
call :Confirm "Ejecutar la optimizacion adecuada para cada unidad?"
if errorlevel 2 goto CleanupMenu
defrag.exe /C /O /U /V
call :Log "Optimizacion de unidades ejecutada"
call :PauseTo CleanupMenu

:ComponentStore
cls
call :Header "ALMACEN DE COMPONENTES"
DISM.exe /Online /Cleanup-Image /AnalyzeComponentStore
call :Log "Almacen de componentes analizado"
call :PauseTo CleanupMenu

:ViewLog
if exist "%LOG_FILE%" (start "" notepad.exe "%LOG_FILE%") else echo No existe el archivo de registro.& pause
goto MainMenu

:EnsureAdmin
fltmc.exe >nul 2>&1
if not errorlevel 1 exit /b 0
echo Solicitando permisos de administrador...
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
if errorlevel 1 (
  echo No fue posible obtener permisos de administrador.
  echo Ejecute este archivo con clic derecho, Ejecutar como administrador.
  pause
)
exit /b 1

:Header
echo ================================================================
echo   %APP_NAME%  ^|  %~1
echo   Equipo: %COMPUTERNAME%  ^|  Usuario: %USERNAME%  ^|  %DATE% %TIME:~0,8%
echo ================================================================
echo.
exit /b

:Confirm
choice /c SN /n /m "%~1 [S/N]: "
exit /b %ERRORLEVEL%

:ReadDrive
set "TARGET_DRIVE="
set /p "TARGET_DRIVE=Letra de unidad (ejemplo C) o Enter para cancelar: "
set "TARGET_DRIVE=%TARGET_DRIVE:~0,1%"
if not defined TARGET_DRIVE exit /b
echo(%TARGET_DRIVE%| findstr.exe /r /i "^[A-Z]$" >nul || set "TARGET_DRIVE="
if not defined TARGET_DRIVE echo Letra de unidad no valida.
exit /b

:PauseTo
echo.
pause
goto %~1

:Log
>>"%LOG_FILE%" echo [%DATE% %TIME%] %~1
exit /b

:ExitApp
call :Log "Cierre de %APP_NAME%"
echo.
echo Hasta luego.
timeout.exe /t 2 /nobreak >nul
endlocal
exit /b 0

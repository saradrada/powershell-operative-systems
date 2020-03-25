## EJERCICIOS
1. Mostrar una tabla de procesos que incluya únicamente los nombres de los
   procesos, sus IDs, y si están respondiendo a Windows (la propiedad
   ``Responding`` muestra eso). Haga que la tabla tome el mínimo de espacio
   horizontal, pero no permita que la información se trunque.

```Powershell
Get-Process | Select Name, Id, Responding | ft -Wrap

Name                                                              Id Responding
----                                                              -- ----------
AdobeIPCBroker                                                 11732       True
ApplicationFrameHost                                           12256       True
AsHidSrv64                                                      6944       True
AsLdrSrv64                                                      5628       True
AsMonStartupTask64                                              6168       True
```

2. Muestre una tabla de procesos que incluya los nombres de los procesos y sus
   IDs. También incluya columnas para uso de memoria virtual y física;
   exprese dichos valores en megabytes (MB).

```Powershell
Get-Process | ft Name, Id, @{n='VM (MB)';e={$_.VM / 1MB -as [int]}}, @{n='PM (MB)'; e={$_.PM / 1MB -as [int]}}

Name                                                              Id VM (MB) PM (MB)
----                                                              -- ------- -------
AdobeIPCBroker                                                 11732      71       3
ApplicationFrameHost                                           12256 2101529      23
AsHidSrv64                                                      6944    4153       1
AsLdrSrv64                                                      5628    4163       2
AsMonStartupTask64                                              6168    4230       3
```

3. Emplee ``Get-EventLog`` para mostrar una lista de los logs de eventos
   disponibles (revise la ayuda para encontrar el parámetro que le permitirá
   obtener dicha información). Formatee la salida como una tabla que incluya
   el nombre de despliegue del log y el período de retención. Los encabezados
   de columna deben ser NombreLog y Per-Retencion.
   
```Powershell
Get-EventLog -List | ft @{n='NombreLog';e={$_.LogDisplayName}}, @{n='Per-Retencion';e={$_.minimumRetentionDays}}

NombreLog               Per-Retencion
---------               -------------
Application                         0
Hardware Events                     0
IntelAudioServiceLog                7
Internet Explorer                   7
Key Management Service              0
Microsoft Office Alerts             0
                                     
System                              0
Windows PowerShell                  0
```

4. Muestre una lista de servicios, de tal manera que aparezcan agrupados los
   servicios que están iniciados y los que están detenidos. Los que están
   iniciados deben aparecer primero.
```Powershell   
Get-Service | sort Status -Descending | fl -GroupBy status
```

5. Mostrar una lista a cuatro columnas de todos los directorios que están en
   el raíz de la unidad ``C:``
```Powershell 
ls -Path C:\ | fw -Column 4
```

6. Cree una lista formateada de todos los archivos ``.exe`` del directorio
   ``C:\Windows``. Debe mostrarse el nombre, la información de versión, y el
   tamaño del archivo. La propiedad de tamaño se llama ``length`` en Powershell,
   pero para mayor claridad, la columna se debe llamar **Tamaño** en su listado.
```Powershell
Get-ChildItem -Path C:\Windows | where -filter {$_.Name -like "*.exe"} | fl -Property Name, VersionInfo, @{n='Tamaño';e={$_.length}}
```

7. Importe el módulo ``NetAdapter`` (empleando el comando ``Import-Module
   NetAdapter``).
   Empleando el cmdlet ``Get-NetAdapter``, muestre una lista de adaptadores no
   virtuales (adaptadores cuya propiedad Virtual sea falsa. El valor lógico
   falso es representado por Powershell como ``$False``).
```Powershell
Get-NetAdapter | where -filter {$_.Virtual -eq $false} | fl
```

8. Importe el módulo ``DnsClient``. Empleando el cmdlet ``Get-DnsClientCache``,
   muestre una lista de los registros ``A`` y ``AAAA`` que estén en el caché.
   Sugerencia: Si el caché está vacío, visite algunos sitios web para poblarlo.
```Powershell
Get-DnsClientCache | where -filter {$_.Type -eq (28) -or $_.Type -eq (1)} | fl
```

9. Genere una lista de todos los archivos ``.exe`` del directorio
   ``C:\Windows\System32`` que tengan más de 5 MB.
```Powershell
Get-ChildItem -Path C:\Windows\System32 | where -filter {$_.Name -like "*.exe" -and $_.length/1MB -gt 5} | fl
```

10. Muestre una lista de parches que sean actualizaciones de seguridad.
```Powershell
Get-HotFix | where -filter {$_.description -like "*security*"} |fl
```

11. Muestre una lista de parches que hayan sido instalados por el
    usuario ``Administrador``, que sean actualizaciones. Si no tiene ninguno,
    busque parches instalados por el usuario ``System``. Note que algunos parches
    no tienen valor en el campo ``Installed By``.
```Powershell
Get-HotFix | where -filter {$_.installedBy -like "*SYSTEM*"} |fl
```

12. Genere una lista de todos los procesos que estén corriendo con el nombre
    **Conhost** o **Svchost**.
```Powershell
Get-Process | where -filter {$_.Name -eq "Conhost" -or $_.Name -eq "Svchost"} | fl
```

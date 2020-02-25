# WINDOWS POWERSHELL

Powershell es un shell creado por Microsoft, para gestión de diversos
sistemas operativos (existen versiones para Windows, Linux y MacOS).

Su mayor potencial se explota en Windows. En esta serie de tutoriales
se asume que el usuario dispone de una máquina Windows para seguir los
ejemplos y ejercicios.

## CÓMO ENCONTRARLO

Digitar **powershell** en la opción de búsqueda de Windows. En máquinas
Windows de 32 bits, aparecerán dos opciones:

- [x] **Powershell**: Shell tradicional
- [x] **Powershell ISE**: Ejecuta comandos directamente, igual que el shell
  tradicional, pero también incorpora un editor de scripts y ayuda con la
  sintaxis, por lo que se recomienda para el aprendizaje.

En máquinas de 64 bits, aparecerán 4 opciones:

- [x] **Powershell** y **Powershell ISE**: Aplicaciones de 64 bits.
- [x] **Powershell x86** y **Powershell ISE x86**: Aplicaciones de 32 bits.

Se recomienda trabajar con la versión nativa para cada versión del sistema
operativo. En estos tutoriales, se asume que el usuario trabajará con el
ISE (resulta más fácil para aprender).

## VERIFICACIÓN DE LA VERSIÓN DEL SOFTWARE

Una vez iniciado el ISE, aparecerá el símbolo del sistema, precedido de las
letras PS, por ejemplo:

``PS C:\Users\Usuario>``

Se puede verificar la versión digitando el comando ``$PSVersionTable``.

## USO DEL SISTEMA DE AYUDA

El sistema de ayuda contiene una gran cantidad de información útil para el
programador. Su buen uso puede ahorrar muchas búsquedas en Internet
(especialmente en servidores aislados).

Para usar el sistema de ayuda, lo primero que se debe hacer es actualizarlo.
Para ello, se debe iniciar el ISE como **ADMINISTRADOR**, y ejecutar el comando:

```powershell
help-update
```

Este comando requiere de conexión al Internet. Se recomienda hacer esta
actualización una vez por mes.

Para solicitar ayuda se emplea el comando ``help``. Es útil recordar que los
comandos de Powershell se componen de un verbo y un sustantivo, separados por
un guión.

- [x] Algunos verbos comunes son ``Get``, ``Set``, ``Add``, ``Remove``, ``Invoke``.
- [x] Algunos sustantivos comunes son ``Process``, ``Service``, ``Item``, ``Eventlog``. *SIEMPRE*
  van en singular.

Por ejemplo, para obtener ayuda acerca de comandos relacionados con procesos,
se puede emplear el comando:

```powershell
help *process*
```

El comodín (*) indica cero o más caracteres. Ejemplos de su uso:

Comando | Función
------- | -------
``help *process*``  | Muestra ayuda sobre comandos que contienen "process" en cualquier parte del nombre.
``help process*``   | Muestra ayuda de comandos que comienzan con "process".
``help *process``   | Muestra ayuda de comandos que terminan en "process".

Si hay varios comandos que cumplen el criterio de búsqueda, Powershell muestra
una lista. Si solamente hay un comando, se muestra la ayuda abreviada.

Otros ejemplos de uso de la ayuda:

Comando | Función
------- | -------
``help get-process``           |  Muestra la ayuda abreviada del comando get-process.
``help get-process -full``     | Muestra la ayuda completa del comando.
``help get-process -examples`` | Muestra ejemplos de uso del comando.

## EJERCICIOS

Responda las siguientes preguntas, haciendo uso del sistema de ayuda de
Powershell:

1. Verifique si existen cmdlets que permitan convertir la salida de otro
   cmdlet a formato HTML.
   
```ConvertTo-Html```

Por ejemplo:

```powershell
Get-Process | Select-Object -Property name,cpu,id | ConvertTo-Html | Out-File procesos.html
```
   
2. Verifique cuáles cmdlets permiten dirigir la salida hacia una impresora,
   o hacia un archivo.
   
```Out-Printer```
   
   Por ejemplo:

Imprime en la impresora por defecto
```powershell
Get-Content help.txt | Out-Printer
```

3. Verifique cuántos cmdlets sirven para gestionar procesos.
```powershell
Get-Command *process*
```

4. Cuál cmdlet podría usarse para escribir una entrada en un log de eventos?

```Write-EventLog```

5. Cuáles cmdlets pueden emplearse para gestionar alias?

```Set-Alias```

Por ejemplo:

```powershell
Set-Alias -Name list -Value Get-Location
```
```powershell
CommandType     Name
-----------     ----
Alias           list -> Get-Location
```

6. Hay alguna manera de llevar un registro (transcript) de una sesión de
   Powershell, y de grabar dicho registro en un archivo?

```Start-Transcript```

7. Cómo se pueden obtener los 100 registros más recientes del log de eventos
   SECURITY del sistema?
   
```powershell
Get-EventLog -LogName Security -Newest 100
```

8. Existe alguna manera de obtener la lista de los servicios que se están
   ejecutando en un computador remoto?
  
  
En vez de localhost, se pone la IP del computador. 
  
```powershell
Get-Service -ComputerName localhost
```
  
9. Existe alguna manera de obtener la lista de procesos de un computador
   remoto?
10. Revise la ayuda del cmdlet ``Out-File``. 
Cuál es el tamaño de línea que emplea este cmdlet por omisión? 80 caracteres.
Existe algún parámetro que permita cambiar dicho tamaño?

```powershell
C:\Users\sarad> Out-File -Width 100
cmdlet Out-File at command pipeline position 1
Supply values for the following parameters:
FilePath: ./process.txt
```

11. Por omisión, ``Out-File`` sobreescribe el archivo de salida, en caso de que
   exista. Existe algún parámetro que impida la sobreescritura de un archivo
   existente?
   
```powershell
Get-Process | Out-File process5.txt -NoClobber
```
   

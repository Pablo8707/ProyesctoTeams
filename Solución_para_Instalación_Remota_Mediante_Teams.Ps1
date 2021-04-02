 Write-Output ''
 Write-Output '                                 BIENVENIDO
 
 '
 Write-Output 'Solución para Instalación Remota Versión 1.0 SONDA Argentina Utilizando el Control Remoto de Teams
 
 '
 Write-Output '                                 RECOMENDACION                     
 '
 Write-Output 'Se Recomienda que Los Paquetes MSI a Ejecutar se Encuentren Alojados en el Directorio C:\Setup
 
 '
  $setup = (get-childitem C:\)
if ($setup -like 'setup'){

} else {New-Item -path c:\ -name Setup -type Directory  }

 $setup = (get-childitem C:\Setup)
if ($setup -like 'variable.txt'){
	Remove-Item -Path 'C:\Setup\variable.txt'} 
$dominio = (Get-WmiObject Win32_ComputerSystem).Domain

 $username = $dominio + '\' + (Read-Host 'Por Favor Ingrese Su Nombre de Usuario Administrador')

 $Password = (Read-Host -AsSecureString 'Por Favor Ingrese su Contraseña')
 Write-Output ' '
 Write-Output ' '

 Write-Output '                        Selecione Tipo de Ejecucion a Realizar     
 '

 Write-Output 'Opcion 1 : Ejecucion de Paquete .msi en Modo Silencioso (Totalmente Transparente al Usuario)'
 Write-Output 'Opcion 2 : Ejecucion de Paquete .msi en Modo Pasivo (Se Mostrara Una Barra de Progreso Durante la Instalacion)'
 Write-Output 'Opcion 3 : Ejecucion de Cualquier Tipo de Archivo Como Administrador'
 Write-Output 'Opcion 4 : Ejecucion de Aplicacion Quick Assist (Para Asistencia Remota)
 '
 $opcion = (Read-Host 'Seleccione Opcion')
 Write-Output ''
 if($opcion -eq 1 -or $opcion -eq 2 -or $opcion -eq 3){Write-Output ''
 $path = (Read-Host 'Ingrese ruta de Archivo que Desea Ejecutar/Instalar Como Administrador')
 new-item -path 'C:\Setup' -name 'variable.txt'
 Wait-Event -Timeout 5
 Set-Content -Path 'c:\setup\variable.txt' -value "$path"
 Wait-Event -Timeout 5
 } else {}
 
$credential = New-Object System.Management.Automation.PSCredential $username, $Password
if ($opcion -eq 1){Start-Process powershell.exe -Credential $credential { 
 Start-Process  powershell.exe -verb RunAs{$path = (Get-Content -path 'C:\Setup\variable.txt')
  Remove-Item -Path 'C:\Setup\variable.txt'
  Wait-Event -Timeout 5
  Msiexec.exe /i $path /quiet}}} else{if ($opcion -eq 2) {Start-Process powershell.exe -Credential $credential { 
 Start-Process  powershell.exe -verb RunAs{$path = (Get-Content -path 'C:\Setup\variable.txt')
  Remove-Item -Path 'C:\Setup\variable.txt'
  Wait-Event -Timeout 5 
  Msiexec.exe /i $path /passive}}} else {if ($opcion -eq 3){Start-Process powershell.exe -Credential $credential { 
 Start-Process  powershell.exe -verb RunAs{$path = (Get-Content -path 'C:\Setup\variable.txt')
  Remove-Item -Path 'C:\Setup\variable.txt'
  Wait-Event -Timeout 5
  Start-Process $path}}} else {if ($opcion -eq 4){Start-Process powershell.exe -Credential $credential { 
 Start-Process  powershell.exe -verb RunAs{"C:\WINDOWS\system32\quickassist.exe"}
 }}}}}
  write-host "Presione una tecla para continuar..."
  [void][System.Console]::ReadKey($true)
  Exit

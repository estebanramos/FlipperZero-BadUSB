$list=(netsh.exe wlan show profiles) -match ':'
$data = @()
For ($x=1; $x -lt $list.count; $x++)
{
    try {
        $item = $list[$x]
        $network_name = $item.split(':')[1].TrimStart()
        $password_output = Invoke-Expression -Command "netsh wlan show profile name='$network_name' key=clear"
        #$password = (Invoke-Expression -Command "netsh wlan show profile name='$network_name' key=clear" | Select-String "Contenido de la Clave\W+\:(.+)$").Line.split(':')[1]
        # Determine which language pattern to use based on the output
        if ($password_output -match "Contenido de la Clave"){
            $password = (Invoke-Expression -Command "netsh wlan show profile name='$network_name' key=clear" | Select-String "Contenido de la Clave\W+\:(.+)$").Line.split(':')[1]
        }
        elseif ($password_output -match "Key Content\W+\:(.+)") {
            $password = (Invoke-Expression -Command "netsh wlan show profile name='$network_name' key=clear" | Select-String "Key Content\W+\:(.+)$").Line.split(':')[1]
        }
        elseif ($password_output -match "Microsoft: EAP protegido\W+\:(.+)") {
            $password = "Authenticated with Active Directory"
        }
        elseif ($password_output -match "Clave de Seguridad\W+\:(.+)") {
            $password = "No Password";
        }
        $item2 = [PSCustomObject]@{
            BSSID = $network_name
            Password = $password
        }
        $data += $item2
    }
    catch {
        <#Do this if a terminating exception happens#>
    }

}
$data | Format-Table -Property BSSID,Password -AutoSize

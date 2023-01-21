echo on
$ErrorActionPreference = 'inquire'
$host_ips = get-content "C:\IP.txt" ####### change your path to the IP or create a similar IP.txt file and populate with your IP
$cmd = "C:\ConfigureRemotingForAnsible.ps1"  ###### You can also change your script path
$cred = get-credential -Message "Input the credentials for the hosts" ##### this will prompt you to input your credentials for the servers

foreach ($ip in $host_ips){
$ip
$fqdn = (Resolve-DnsName $ip -Server 192.168.203.220).namehost 2>$null ### you can remove this line or chnge the IP to refrlect your own dns server
Set-Item WSMan:\localhost\Client\TrustedHosts *.nibssserver.com -Force ### change the nibssserver.com to your own domain, this line resolved 50% of my issues
invoke-command -ComputerName $fqdn -FilePath $cmd -Credential $cred ## leave this command 
$fqdn
""
""
}
####Any changes to be made should be made on the variables
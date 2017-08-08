$siteName = "AgileXRM";
$enableHttps = $true;
$physicalPath = "C:\Program Files\AgileXRM\WebApps\"
$port = "81";
$protocol = "http";
$bindingInformation = ":"+$port+":"+$siteName;
$appPoolUser = "agilepoint\apservice";
$appPoolPass = "pass@word1";
#Install-WindowsFeature web-mgmt-console;
#Import-module IISAdministration; 
#New-IISSite -Name $siteName -PhysicalPath $physicalPath -BindingInformation "*:8000:";
$agileDialogsPath= $physicalPath+"\AgileDialogs";
$processViewerPath= $physicalPath+"\XRMProcessViewer";
$poolName = "AgileXRMAppPool";

Test-Path-And-Create -customPath $physicalPath; 
Test-Path-And-Create -customPath $agileDialogsPath; 
Test-Path-And-Create -customPath $processViewerPath; 


if((Test-Path -Path IIS:\AppPools\$poolName) -ne $true)
{
	New-Item IIS:\AppPools\$poolName;
}
Set-ItemProperty IIS:\AppPools\$poolName -name applicationPool -value $poolName;
Set-ItemProperty IIS:\AppPools\$poolName -Name processModel -Value @{loadUserProfile=$true;userName=$appPoolUser;password=$appPoolPass;identitytype=3};

if((Test-Path -Path iis:\Sites\$siteName) -ne $true)
{
	New-Item iis:\Sites\$siteName -bindings @{protocol=$protocol;bindingInformation=$bindingInformation} -physicalPath $physicalPath;
}
Set-ItemProperty IIS:\Sites\$siteName -name applicationPool -value $poolName;

if((Test-Path -Path IIS:\Sites\$siteName\AgileDialogs) -ne $true)
{
	New-Item IIS:\Sites\$siteName\AgileDialogs -physicalPath $agileDialogsPath -type Application;
}
if((Test-Path -Path IIS:\Sites\$siteName\XRMProcessViewer) -ne $true)
{
	New-Item IIS:\Sites\$siteName\XRMProcessViewer -physicalPath $processViewerPath -type Application;
}

function Test-Path-And-Create()
{
	param([string]$customPath)
	if((Test-Path -Path $customPath) -ne $true)
	{
		New-Item -Path $customPath -ItemType Directory -force;
	}
}

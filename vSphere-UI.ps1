#==================================================================================================
# KVM
# 1   ALIEN
# 2   NUC
# 3   SURFACE
# 4   XPS
#--------------------------------------------------------------------------------------------------

#==================================================================================================
# Bridged		VMnet0 	192.168.100.0
# NAT			VMnet8	192.168.2.0
# Host-only	    VMnet1	192.168.3.0
#--------------------------------------------------------------------------------------------------

#==================================================================================================
# Function - Create a custom PS Obect to accommodate lasb.local infrastructure details
#--------------------------------------------------------------------------------------------------
Function LabInfraOject($Name,$IP,$FQDN,$HostGroup,$Desc){
    New-Object PsObject -Property @{
        Name = $Name
        IP = $IP
        FQDN = $FQDN
        HostGroup = $HostGroup
        Desc = $Desc
    }
}

#==================================================================================================
# Function - Populate custom object table with lab.local infrastructure details
#--------------------------------------------------------------------------------------------------
Function LabInfraTable{
    $colLabInfra = $Null = @()
    #-------------------------------------------------------------------------------------------------------------------------------
    #							  Name    	IP				FQDN				HostGroup				Description
    #-------------------------------------------------------------------------------------------------------------------------------
    $colLabInfra += LabInfraOject 'VFILR1' '192.168.100.40' 'vfilr1.lab.local' 'Storage' '' 
    $colLabInfra += LabInfraOject 'NSX631' '192.168.100.45' 'nsx631.lab.local' 'Network' ''
    $colLabInfra += LabInfraOject 'NSX632' '192.168.100.46' 'nsx632.lab.local' 'Network' ''
    $colLabInfra += LabInfraOject 'WSR161' '192.168.100.90' 'wsr161.lab.local' 'Windows' ''
    $colLabInfra += LabInfraOject 'WCL101' '192.168.100.91' 'wcl101.lab.local' 'Windows' ''
    $colLabInfra += LabInfraOject 'VCA651' '192.168.100.60' 'vca651.lab.local' 'vSphere 6.5' ''
    $colLabInfra += LabInfraOject 'ESX651' '192.168.100.61' 'esx651.lab.local' 'vSphere 6.5' ''
    $colLabInfra += LabInfraOject 'ESX652' '192.168.100.62' 'esx652.lab.local' 'vSphere 6.5' ''
    $colLabInfra += LabInfraOject 'ESX653' '192.168.100.63' 'esx653.lab.local' 'vSphere 6.5' ''
    $colLabInfra += LabInfraOject 'VLC001' '192.168.100.70' 'vlc001.lab.local' 'vCloud' ''
    $colLabInfra += LabInfraOject 'VOM661' '192.168.100.71' 'vom661.lab.local' 'vCloud' ''
    $colLabInfra += LabInfraOject 'VOM662' '192.168.100.72' 'vom662.lab.local' 'vCloud' ''
    $colLabInfra += LabInfraOject 'VLI661' '192.168.100.73' 'vli661.lab.local' 'vCloud' ''
    $colLabInfra += LabInfraOject 'VCB661' '192.168.100.74' 'vbc661.lab.local' 'vCloud' ''
    $colLabInfra += LabInfraOject 'VCA652' '192.168.100.64' 'vca652.lab.local' 'vSphere 6.5 DEMO' ''
    $colLabInfra += LabInfraOject 'ESX655' '192.168.100.65' 'esx655.lab.local' 'vSphere 6.5 DEMO' ''
    $colLabInfra += LabInfraOject 'ESX656' '192.168.100.66' 'esx656.lab.local' 'vSphere 6.5 DEMO' ''
    $colLabInfra += LabInfraOject 'ESX657' '192.168.100.67' 'esx657.lab.local' 'vSphere 6.5 DEMO' ''
    $colLabInfra += LabInfraOject 'VCA551' '192.168.100.50' 'vca551.lab.local' 'vSphere 5.5' ''
    $colLabInfra += LabInfraOject 'ESX551' '192.168.100.51' 'esx551.lab.local' 'vSphere 5.5' ''
    $colLabInfra += LabInfraOject 'ESX552' '192.168.100.52' 'esx552.lab.local' 'vSphere 5.5' ''
    $colLabInfra += LabInfraOject 'ESX553' '192.168.100.53' 'esx553.lab.local' 'vSphere 5.5' ''
    $colLabInfra += LabInfraOject 'ALIEN1' '192.168.100.10' 'alien1.lab.local' 'Physical Infra' ''
    $colLabInfra += LabInfraOject 'HSNUC1' '192.168.100.11' 'hsnuc1.lab.local' 'Physical Infra' ''
    $colLabInfra += LabInfraOject 'HSNUC2' '192.168.100.12' 'hsnuc2.lab.local' 'Physical Infra' ''
    $colLabInfra += LabInfraOject 'HSXPS1' '192.168.100.13' 'hsxps1.lab.local' 'Physical Infra' ''
    #                                      '192.168.100.14' 
    $colLabInfra += LabInfraOject 'NASEX1' '192.168.100.5'  'nasex1.lab.local' 'Physical Infra' ''
    $colLabInfra += LabInfraOject 'WSR162' '192.168.100.92' 'wsr161.lab.local' 'Windows' ''
    
    <#
    Default Gateway: 192.168.100.1
    Subnet Mask: 255.255.255.0
    DNS Domain: lab.local
    DNS Servers: 192.168.100.1,192.168.100.90
    NTP:192.168.100.90
    #>
}

#==================================================================================================
# Function - Launch Internet Explorer to respecitve host GUI.
#--------------------------------------------------------------------------------------------------
Function LaunchUI($IP,$Port){
    Write-Host $IP
    If(!$Port){$URL = ("https://" + $($IP))}
    Else {$URL = ("https://" + $($IP) + ":" + $Port)}
    & 'C:\Program Files\Internet Explorer\iexplore.exe' $URL
}

#==================================================================================================
# Function - Call LaunchUI function
#--------------------------------------------------------------------------------------------------
Function CallLaunchUI{
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VFILR1'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'NSX631'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'NSX632'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'WSR161'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'WCL101'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VCA651'}).FQDN 5480 LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VCA651'}).FQDN 9443
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX651'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX652'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX653'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VLC001'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VOM661'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VOM662'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VLI661'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VCB661'}).FQDN 5480
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VCA652'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX655'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX656'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX657'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'VCA551'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX551'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX552'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ESX553'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'ALIEN1'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'HSNUC1'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'HSNUC2'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'HSXPS1'}).FQDN
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq 'NASEX1'}).FQDN
        
}

#==================================================================================================
# Function - Switch Action for PowerOn-Off function
#--------------------------------------------------------------------------------------------------
Function SwitchActionOnOff(){
    #
    # POWER COMMANDS           PARAMETERS           DESCRIPTION
    # --------------           ----------           -----------
    # start                    Path to vmx file     Start a VM or Team
    #                          [gui|nogui]
    # stop                     Path to vmx file     Stop a VM or Team
    #                          [hard|soft]
    # reset                    Path to vmx file     Reset a VM or Team
    #                          [hard|soft]
    # suspend                  Path to vmx file     Suspend a VM or Team
    #                          [hard|soft]
    # pause                    Path to vmx file     Pause a VM
    # unpause                  Path to vmx file     Unpause a VM
    
    $SwitchOptions = $Null = @()
    $SwitchOptions += "---Options---"
    $SwitchOptions += "Start"
    $SwitchOptions += "Stop"
    $SwitchOptions += "Reset"
    $SwitchOptions += "Suspend"
    $SwitchOptions += "Pause"
    $SwitchOptions += "Unpause"
    For($i=0;$i-le $SwitchOptions.Length -1;$i++){
        If($i -eq 0) {
            Write-Host ($SwitchOptions[$i])
        }
        Else{
            Write-Host ($i) ($SwitchOptions[$i])
        }
    }

    Switch (Read-Host "Select Action" $Null) {
        1 { $Action = $SwitchOptions[1]}
        2 { $Action = $SwitchOptions[2]}
        3 { $Action = $SwitchOptions[3]}
        4 { $Action = $SwitchOptions[4]}
        5 { $Action = $SwitchOptions[5]}
        6 { $Action = $SwitchOptions[6]}
        Default {}
    }
    #Write-Host $Action
    Return $Action
}
SwitchActionOnOff
#==================================================================================================
# Function - VMware Workstation PowerOn-Off
#--------------------------------------------------------------------------------------------------
Function VMWSPowerOnOff($Target,$Action){
    $VMXFile = Get-ChildItem E:\VirtualMachines -Recurse -Filter ($Target + ".vmx")
    If($VMXFile){
        Write-Host "Attempting to " $Action "guest:" $Target
        Try {
            & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' $Action $VMXFile.FullName | Out-Null
            Write-Host "Succeeded"
        }
        Catch{
            Throw $Error
        }
    }
}

#==================================================================================================
# Function - Host Config
#--------------------------------------------------------------------------------------------------
Function VFILR1{

}
Function NSX631{
    
}
Function NSX632{

}
Function WSR161{
    $MyInvocation.MyCommand.Name
    VMWSPowerOnOff $MyInvocation.MyCommand.Name (SwitchActionOnOff)
    #     mstsc.exe /V:($colLabInfra | Where-Object{$_.Name -eq "WSR161"}).IP
        <#
        Install-WindowsFeature AD-Certificate -IncludeAllSubFeature -IncludeManagementTools
        #>
}
WSR161
Function WCL101{

}
Function VCA651 {
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq "vca651"}).IP
    LaunchUI ($colLabInfra | Where-Object{$_.Name -eq "vca651"}).IP 5480
    <#

    #>
}
Function ESX651 {

}
Function ESX652{

}
Function ESX653{

}
Function VLC001{

}
Function VOM661{
    <#
    admin
    P@ssw0rd
    Cluster Master Node: VOMMN1
    #>
}
Function VOM662{

}
Function VCA651{
    <#
    administrator@vsphere.local
    P@ssw0rd
    #>
}
Function VCB661{

    <#
    vRealize-Business-for-Cloud-7.3.1.14362-6400451_OVF10
    root
    P@ssw0rd
    #>
}
Function VCA652{

}
Function ESX655{

}
Function ESX656{

}
Function ESX657{

}
Function VCA551{

}
Function ESX551{

}
Function ESX552{

}
Function ESX553{
    
}
Function ALIEN1{

}
Function HSNUC1{

}
Function HSNUC2{

}
Function HSXPS1{

}
Function NASEX1{

}
Function NEWHOST{

}








& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://vca651.lab.local:9443")
& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://vca651.lab.local:5480")


#------------------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------------------
# NASEX1 - NAS Device EX2100
#------------------------------------------------------------------------------------------------

<#
NFS1        nfs://192.168.100.5/nfs/NFS1
NFS2        nfs://192.168.100.5/nfs/NFS2
NFS_MIG     nfs://192.168.100.5/nfs/NFS_MIG     CLOX_NASEX1_NFS_MIG_DS1
NFS_VLM     nfs://192.168.100.5/nfs/NFS_VLM
#>
#------------------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------------------
# VLC001 - vRealize Suite Lifecycle Manager
#------------------------------------------------------------------------------------------------

<#
admin@localhost
vmware -> P@ssw0rd
All PWD: P@ssw0rd

nfs (Base Location)
192.168.100.5:/nfs/NFS_VLM
#>
#------------------------------------------------------------------------------------------------





#------------------------------------------------------------------------------------------------
# VBC661 - vRealize Suite Business for Cloud
#------------------------------------------------------------------------------------------------


<#
root
P@ssw0rd
>#

#------------------------------------------------------------------------------------------------



$VMName = 'VLC001'
P@ssw0rd
$URL = ("https://" + $VMName.ToLower() + ".lab.local/vrlcm")
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL



$VMXFile = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}



$colLabInfra | Select-Object Name
$colLabInfra | ForEach-Object{$_.Name, $_.IP}

$colLabInfra | Where-Object{$_.Name -eq "hsxps1"} | Select-Object -Property IP
$IPtoConnect = ($colLabInfra | Where-Object{$_.Name -eq "vca651"} | Select -Property IP)

$IPtoConnect = $colLabInfra | Where-Object{$_.Name -eq "vca651"}
$IPtoConnect.IP

$VMtoConn = Read-Host -Prompt "VM Name"
$TCPPort  = Read-Host -Prompt "TCP Port"

($colLabInfra | Where-Object{$_.Name -eq "vca651"}).IP





$VCA651REST = 

<################################################################################################
$VFILR1
filer1.lab.local
sudo ifconfig eth0 192.168.100.40 netmask 255.255.255.0
sudo route add default gw 192.168.100.1 eth0
root / jA*
openfiler / password
Enable services CIFS, NFS
Network allow ranges:
VMNET0;VMNET2;TKNET

Volumes\Block Devices
Create physical partitions
Disk 1 - 50GB - DS - FILER1-DS1-NFS1 - /dev/sdb
Disk 2 - 50GB - DS - FILER1-DS1-NFS2 - /dev/sdc
Disk 4 - 10GB - CIFS - /dev/sde

nfs1 [SMB: nfs1] (/mnt/vg1/vol1/nfs/nfs1/) 
nfs2 [SMB: nfs2] (/mnt/vg1/vol1/nfs/nfs2/) 


Volumes\Volume Groups
VolGroup1 (sdb;sdc;sdd)

Volumes\Add Volume
Vol1

Shares
NFS1;NFS2;NFS3

<#
V55DS1NFS1;V55DS1NFS2;V55DS1NFS3
192.168.100.40
/mnt/volgroup1/vol1/NFS1/
/mnt/volgroup1/vol1/NFS2/
/mnt/volgroup1/vol1/NFS3/
Datastore Cluster
V55DSCLO1

V65DS1NFS1;V65DS1NFS2;V65DS1NFS3
192.168.100.40
/mnt/volgroup1/vol1/NFS1/
/mnt/volgroup1/vol1/NFS2/
/mnt/volgroup1/vol1/NFS3/
Datastore Cluster
V65DSCLO1
#>

################################################################################################>
$VMName = 'FILER1'
$TCPPOR = '446'
$URL = ("https://" + $VMName.ToLower() + ".lab.local" + ":" + $TCPPOR)
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL

$VMXFile = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}


<#
"Windows cannot find the Microsoft Software License Terms.  Make sure the installation sources are valid and restart the installation."
Choose the option: I will install the operating system later.(The virtual machine will be created with a blank hard disk.)
Do not type the path to the ISO file
- After creating New virtual machine additionally set the path to the ISO file (VM/ settings/ CD-DVD.../Use ISO image file)
#>
<################################################################################################


################################################################################################>
$VMName = 'VLC001'
P@ssw0rd
$URL = ("https://" + $VMName.ToLower() + ".lab.local/vrlcm")
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL



$VMXFile = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}


<##
nfs (Base Location)
192.168.100.5:/nfs/NFS_VLM/
/data/binaries/OVA

“No networking detected”
1. Access the appliance VM console via the the vSphere client / web client
2. Login using “root” and “vmware” as password
3. At the command prompt, enter “/opt/vmware/share/vami/vami_config_net”
>

<#
"Windows cannot find the Microsoft Software License Terms.  Make sure the installation sources are valid and restart the installation."
Choose the option: I will install the operating system later.(The virtual machine will be created with a blank hard disk.)
Do not type the path to the ISO file
- After creating New virtual machine additionally set the path to the ISO file (VM/ settings/ CD-DVD.../Use ISO image file)
#>
<################################################################################################



################################################################################################>
$VMName = 'FILER1'
$TCPPOR = '446'
$URL = ("https://" + $VMName.ToLower() + ".lab.local" + ":" + $TCPPOR)
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL

$VMXFile = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}



<################################################################################################
VCA551
root / jA*
administrator@vsphere.local / jA*
################################################################################################>
$VMName = $NULL = 'VCA551'
$VMXFile = $NULL = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}

$IPADDR = '192.168.100.50'
$TCPPOR = '9443'
$URL = ("https://" + $IPADDR + ":" + $TCPPOR)
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL

& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://" + $IPADDR + ":5480")

<################################################################################################
VCA651
root / jA*
administrator@vsphere.local / jA*
################################################################################################>
$VMName = $NULL = 'VCA651'
vca651.lab.local
$VMXFile = $NULL = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}

$IPADDR = '192.168.100.60'
$TCPPOR = '9443'
$URL = ("https://" + $IPADDR + ":" + $TCPPOR)
& 'C:\Program Files\Internet Explorer\iexplore.exe' 
& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://vca651.lab.local:9443")
& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://vca651.lab.local:5480")

<#
guestinfo.cis.deployment.node.type = "embedded"
guestinfo.cis.appliance.net.addr.family = "ipv4"
guestinfo.cis.appliance.net.mode = "static"
guestinfo.cis.appliance.net.pnid = "192.168.100.60"
guestinfo.cis.appliance.net.addr = "192.168.100.60"
guestinfo.cis.appliance.net.prefix = "24"
guestinfo.cis.appliance.net.gateway = "192.168.100.1"
guestinfo.cis.appliance.net.dns.servers = "192.168.100.1"
guestinfo.cis.appliance.root.passwd = "P@ssw0rd"
guestinfo.cis.appliance.ssh.enabled = "True"
guestinfo.cis.deployment.autoconfig = "False"


guestinfo.cis.appliance.ntp.servers = "pool.ntp.org"
guestinfo.cis.vmdir.password = "P@ssw0rd"
guestinfo.cis.vmdir.site-name = "default-site"
guestinfo.cis.vmdir.domain-name = "vsphere.local"
administrator@vsphere.local
guestinfo.cis.ceip_enabled = "False"
#>


<################################################################################################
VOM661
administrator@vsphere.local / p@
################################################################################################>
$VMName = $NULL = 'VOM661'

$VMXFile = $NULL = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}
Test-Connection  ($($VMName.Tolower()) + ".lab.local")
$URL = ("https://" + $VMName.Tolower() + ".lab.local")
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL


<################################################################################################
VCA551
root / jA*
administrator@vsphere.local / jA*
################################################################################################>
$VMName = $NULL = 'VCA551'
$VMXFile = $NULL = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}

$IPADDR = '192.168.100.50'
$TCPPOR = '9443'
$URL = ("https://" + $IPADDR + ":" + $TCPPOR)
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL

& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://" + $IPADDR + ":5480")

<################################################################################################
VLM001
root / jA*
################################################################################################>
$VMName = $NULL = 'VLM001'
vlm001.lab.local
#First Logon
#admin@localhost 
#vmware 
#P@ssw0rd
$VMXFile = $NULL = Get-ChildItem E:\VirtualMachines -Recurse -Filter "$VMName.vmx"
If($VMXFile){
    & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start $VMXFile.FullName | Out-Null
}

$URL = ("https://vlm001.lab.local/vrlcm")
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL



<################################################################################################
NUC
root / jA*
################################################################################################>
$IPADDR = '192.168.100.11'
$URL = ("https://" + $IPADDR + '/ui/#/login')
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL
################################################################################################>


#------------------------------------------------------------------------------------------------
# XPS
#------------------------------------------------------------------------------------------------

$IPADDR = '192.168.100.12'
$URL = ("https://" + $IPADDR + '/ui/#/login')
& 'C:\Program Files\Internet Explorer\iexplore.exe' $URL
################################################################################################>



& 'C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1'
Connect-VIServer -Server localhost

$VMXFile = $NULL
$Action = "suspend"
ForEach($VMXFile in Get-ChildItem E:\VirtualMachines -Recurse -Filter *.vmx){
    #Write-Host $VMXFile.FullName
    If($($VMXFile.FullName) -like "*ESX55*"){
        Write-Host $($VMXFile.FullName)
        & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' $Action $($VMXFile.FullName) | Out-Null
    }
}

$VMXFile = $NULL
$Action = "start"
ForEach($VMXFile in Get-ChildItem E:\VirtualMachines -Recurse -Filter *.vmx){
    #Write-Host $VMXFile.FullName
    If($($VMXFile.FullName) -like "*ESX65*"){
        Write-Host $($VMXFile.FullName)
        & 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' $Action $($VMXFile.FullName) | Out-Null
    }
}



& 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' suspend E:\VirtualMachines\OPFIL1\OPFIL1.vmx
& 'C:\Program Files (x86)\VMware\VMware VIX\vmrun.exe' start E:\VirtualMachines\OPFIL1\OPFIL1.vmx







$OPENFILER1  = '192.168.100.20'
$VCSA551 = '192.168.100.50'
$ESX551  = '192.168.100.51'
$ESX552  = '192.168.100.52'
$ESX553  = '192.168.100.53'
$VCSA651 = '192.168.100.60'
$ESX651  = '192.168.100.61'
$ESX652  = '192.168.100.62'
$ESX653  = '192.168.100.63'

& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://" + $OPFIL1 + ":4463")
& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://" + $VCSA551 + ":9443")
& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://" + $VCSA551 + ":5480")










$EXTSTORAGE = '192.168.100.5'
& 'C:\Program Files\Internet Explorer\iexplore.exe' $EXTSTORAGE




$arrurl = @()
$arrurl = '192.168.244.129','192.168.244.130','192.168.244.131'
ForEach($url in $arrurl){
    & 'C:\Program Files\Internet Explorer\iexplore.exe' $url
}

$VCSA651 = '192.168.209.20'
& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://" + $VCSA651 + ":5480")
<#
guestinfo.cis.appliance.net.addr.family = "ipv4"
guestinfo.cis.appliance.net.mode = "static"
guestinfo.cis.appliance.net.addr = "192.168.209.20"
guestinfo.cis.appliance.net.prefix = "24"
guestinfo.cis.appliance.net.gateway = "192.168.209.2"
guestinfo.cis.appliance.net.dns.servers = "192.168.209.2"
guestinfo.cis.vmdir.password = "vmware"
guestinfo.cis.appliance.root.passwd = "vmware"

192.168.209.20
192.168.209.2
ca.pool.ntp.org
vsphere.local
default-site
jA0204u(
#>




$VCSA551 = '192.168.209.136'
& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://" + $VCSA551 + ":9443")
& 'C:\Program Files\Internet Explorer\iexplore.exe' ("https://" + $VCSA551 + ":5480")

<#
guestinfo.cis.appliance.net.addr.family = "ipv4"
guestinfo.cis.appliance.net.mode = "static"
guestinfo.cis.appliance.net.addr = "192.168.209.20"
guestinfo.cis.appliance.net.prefix = "24"
guestinfo.cis.appliance.net.gateway = "192.168.209.2"
guestinfo.cis.appliance.net.dns.servers = "192.168.209.2"
guestinfo.cis.vmdir.password = "vmware"
guestinfo.cis.appliance.root.passwd = "vmware"
#>











$ESX651 = '192.168.209.130'                          
& 'C:\Program Files\Internet Explorer\iexplore.exe' "https://$ESX651"
$ESX551 = '192.168.209.131'
& 'C:\Program Files\Internet Explorer\iexplore.exe' "https://$ESX551"
$ESX652 = '192.168.209.135'
& 'C:\Program Files\Internet Explorer\iexplore.exe' "https://$ESX652"
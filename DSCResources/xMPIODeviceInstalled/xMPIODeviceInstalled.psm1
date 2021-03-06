function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $ProductID,

        [parameter(Mandatory = $true)]
        [System.String]
        $Vendor
    )

    $returnValue = Get-MPIODeviceInstalled -ProductID $ProductID -Vendor $Vendor

    return $returnValue
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $ProductID,

        [parameter(Mandatory = $true)]
        [System.String]
        $Vendor,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    Set-MPIODeviceInstalled -ProductID $ProductID -Vendor $Vendor -Ensure $Ensure

}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $ProductID,

        [parameter(Mandatory = $true)]
        [System.String]
        $Vendor,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    $result = Test-MPIODeviceInstalled -ProductID $ProductID -Vendor $Vendor -Ensure $Ensure
    
    return $result
}


Export-ModuleMember -Function *-TargetResource


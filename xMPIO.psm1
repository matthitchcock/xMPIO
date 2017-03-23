Function Get-RemoveMPIODevice
{
    param(
        $ProductID,
        $Vendor
    )

    Import-Module -Name MPIO

    $Device = Get-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue

    $Output = @{
        VendorID = "Not Present"
        ProductID = "Not Present"
        Status = "Removed"
    }

    If ($Device)
    {
        $Output.VendorID = $Device.VendorId
        $Output.ProductID = $Device.ProductId
        $Output.Status = "Installed"
    }

    return $Output
}

Function Set-RemoveMPIODevice
{
    param(
        $ProductID,
        $Vendor
    )

    Import-Module -Name MPIO

    Remove-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue
}

Function Test-RemoveMPIODevice
{
    param(
    $ProductID,
    $Vendor
    )

    Import-Module -Name MPIO

    [Boolean]$Result = $true
    $Device = Get-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue

    if ($Device)
    {
        $Result = $false
    }

    return $Result
}

Export-ModuleMember *

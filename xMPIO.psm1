Function Get-RemoveMPIODevice
{
    param(
        $ProductID,
        $Vendor
    )

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

    Remove-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue
}

Function Test-RemoveMPIODevice
{
    param(
    $ProductID,
    $Vendor
    )

    [Boolean]$Result = $true
    $Device = Get-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue

    if ($Device)
    {
        $Result = $false
    }

    return $Result
}

Function Get-DSMAutomaticClaim
{
    Param(
        $BusType,
        $Enabled
    )

    $Settings = Get-MSDSMAutomaticClaimSettings

    $Output = @{
        BusType = $BusType
        Enabled = $Settings.$BusType
        Status = "OK"
    }

    if ($Settings.$BusType -ne $Enabled)
    {
        $Output.Status = "NOK"
    }

    return $Output
}

Function Set-DSMAutomaticClaim
{
    Param(
        $BusType,
        $Enabled
    )

    switch ($Enabled)
    {
        $true {
            Enable-MSDSMAutomaticClaim -BusType $BusType -ErrorAction SilentlyContinue
        }
        $false {
            Disable-MSDSMAutomaticClaim -BusType $BusType -ErrorAction SilentlyContinue
        }
        Default {
            Write-Verbose -Message "No valid option given"
        }
    }
}

Function Test-DSMAutomaticClaim
{
    Param(
        $BusType,
        $Enabled
    )

    [Boolean]$result = $true

    if (-not((Get-MSDSMAutomaticClaimSettings).$BusType -eq $Enabled))
    {
        $result = $false
    }
}


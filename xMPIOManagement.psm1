Function Get-MPIODeviceInstalled
{
    param(
        $ProductID,
        $Vendor
    )

    $Device = Get-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue

    $Output = @{
        VendorID = $Vendor
        ProductID = $ProductID
        Status = ""
    }

    Switch ($Device)
    {
        ($Device -ne $null) {$Output.Status = "Present"}
        ($Device -eq $null) {$Output.Status = "Absent"}
        default {$Output.Status = "Unknown"}
    }
    
    return $Output
}

Function Set-MPIODeviceInstalled
{
    param(
        $ProductID,
        $Vendor,
        $Ensure
    )

    $Device = Get-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue

    Switch ($Ensure)
    {
        'Present' {
            if ($Device -eq $null)
            {
                New-MSDSMSupportedHW -ProductId $ProductID -VendorId $Vendor -ErrorAction SilentlyContinue

                Update-MPIOClaimedHW

                Write-Verbose -Message "Device added"
            }            
        }
        'Absent' {
            if ($Device -ne $null) {
                Remove-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue

                Update-MPIOClaimedHW

                Write-Verbose -Message "Device removed"
            }
        }
        default {
            Write-Verbose -Message "No valid action specified"
        } 
    }


}

Function Test-MPIODeviceInstalled
{
    param(
    $ProductID,
    $Vendor,
    $Ensure
    )

    [Boolean]$Result = $true
    $Device = Get-MSDSMSupportedHW -VendorId $Vendor -ProductId $ProductID -ErrorAction SilentlyContinue

    Switch ($Ensure)
    {
        'Present' {
            if ($Device -eq $null)
            {
                $Result = $false
            }
        }
        'Absent' {
            if ($Device -ne $null)
            {
                $Result = $false
            }
        }
        default {
            Write-Verbose -Message "No valid option selected"
        }
    }

    return $Result
}

Function Get-DSMBusClaim
{
    Param(
        $BusType,
        $Ensure
    )

    $Settings = Get-MSDSMAutomaticClaimSettings

    $Output = @{
        BusType = $BusType
        Enabled = $Settings.$BusType
        Status = "OK"
    }

    Switch ($Ensure)
    {
        'Present' {
            if ($Settings.BusType -ne $True)
            {
                $Output.Status = "NOK"
            }
        }
        'Absent' {
            if ($Settings.BusType -ne $false)
            {
                $Output.Status = "NOK"
            }           
        }
        default {
            Write-Verbose -Message "No valid option selected"
        }
    }

    return $Output
}

Function Set-DSMBusClaim
{
    Param(
        $BusType,
        $Ensure
    )

    switch ($Ensure)
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

Function Test-DSMBusClaim
{
    Param(
        $BusType,
        $Ensure
    )

    [Boolean]$result = $true

    $Settings = Get-MSDSMAutomaticClaimSettings

    Switch ($Ensure)
    {
        'Present' {
            if ($Settings.BusType -ne $True)
            {
                $Result = $false
            }
        }
        'Absent' {
            if ($Settings.BusType -ne $false)
            {
                $Result = $false
            }           
        }
        default {
            Write-Verbose -Message "No valid option selected"
        }
    }
    return $result
}


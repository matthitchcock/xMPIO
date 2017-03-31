$ProductID = New-xDscResourceProperty -Name ProductID -Type String -Attribute Key
$Vendor = New-xDscResourceProperty -Name Vendor -Type String -Attribute Required
$Ensure = New-xDscResourceProperty -Name Ensure -Type String -Attribute Write -ValidateSet "Present","Absent"

New-xDscResource -Name xMPIODeviceInstalled -Property $ProductID,$Vendor,$Ensure -path .\MPIO -ModuleName xMPIOManagement


$BusType = New-xDscResourceProperty -Name BusType -Type String -Attribute Key
$Ensure = New-xDscResourceProperty -Name Ensure -Type String -Attribute Write -ValidateSet "Present","Absent"

New-xDscResource -Name xMPIODSMBusClaim -Property $BusType,$Ensure -path .\MPIO -ModuleName xMPIOManagement


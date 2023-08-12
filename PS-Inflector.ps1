<#
    RTI-Toolkit File: PS-Infector.ps1
    Author: Nikos Vourdas (@nickvourd)
    License: MIT
    Required Dependencies: None
#>

#Global Variables
$global:version = "1.0.0"

function Get-Logo{
<#
    .SYNOPSIS

    This module prints logo.

    .DESCRIPTION

    Get-Logo prints the Ascii art logo of PS-Inflector tool.

    .Example

    PS > Get-Logo

#>
    $ascii = @"



    __________                .___        _____.__                 __                
    \______   \______         |   | _____/ ____\  |   ____   _____/  |_  ___________ 
     |     ___/  ___/  ______ |   |/    \   __\|  | _/ __ \_/ ___\   __\/  _ \_  __ \
     |    |   \___ \  /_____/ |   |   |  \  |  |  |_\  ___/\  \___|  | (  <_> )  | \/
     |____|  /____  >         |___|___|  /__|  |____/\___  >\___  >__|  \____/|__|   
                  \/                   \/                \/     \/                   
  
                          ~ Created with <3 by @villains_team ~
                            
                                   Version: $global:version

"@

    Write-Host $ascii`n

}

function Get-Version{
<#
    .SYNOPSIS

    This module prints the version
    .
    .DESCRIPTION

    Get-Version prints the current version of PS-Inflector tool.

    .EXAMPLE

    PS > Get-Version
#>

    Write-Host "`n[+] Current Version:" $global:version`n

}

function Invoke-Inflect{
    #Arguments
    param (
        [Parameter(Mandatory=$True,Position=1)]
            [ValidateNotNull()]
    		[string]$Shellcode,

		[Parameter(Mandatory=$True,Position=2)]
    		[ValidateNotNull()]
    		[string]$Attack,

        [Parameter(Mandatory=$True,Position=3)]
    	    [ValidateNotNull()]
    	    [string]$InputDoc,

		[Parameter(Mandatory=$True,Position=4)]
    	    [ValidateNotNull()]
    	    [string]$Output,

        [Parameter(Mandatory=$False,Position=5)]
    	    [ValidateNotNull()]
    	    [string]$Shift,

        [Parameter(Mandatory=$False,Position=6)]
    	    [ValidateNotNull()]
    	    [string]$Purge
	)
}

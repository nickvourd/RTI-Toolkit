<#
    RTI-Toolkit File: PS-Identifier.ps1
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

    Get-Logo prints the Ascii art logo of PS-Identifier tool.

    .Example

    PS > Get-Logo

#>
    $ascii = @"



    __________                .___    .___             __  .__  _____.__              
    \______   \______         |   | __| _/____   _____/  |_|__|/ ____\__| ___________ 
     |     ___/  ___/  ______ |   |/ __ |/ __ \ /    \   __\  \   __\|  |/ __ \_  __ \
     |    |   \___ \  /_____/ |   / /_/ \  ___/|   |  \  | |  ||  |  |  \  ___/|  | \/
     |____|  /____  >         |___\____ |\___  >___|  /__| |__||__|  |__|\___  >__|   
                  \/                   \/    \/     \/                       \/       
  
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

    Get-Version prints the current version of PS-Identifier tool.

    .EXAMPLE

    PS > Get-Version
#>

    Write-Host "`n[+] Current Version:" $global:version`n

}

function Search-File($file, $statement){
<#
    .SYNOPSIS

    This module searches given file in the system.
    .
    .DESCRIPTION

    Search-File tries to seach if given file exist in the system or not.

    .EXAMPLE

    PS > Search-File C:\Users\nickvourd\Desktop\Document.docx InputDoc

    .EXAMPLE

    PS > Search-File Document.docx InputDoc
#>

    #Call function named Determine-Path
    $foundPathType = Determine-PathType $file

    if ($foundPathType -eq $true){                
        #Full path type file search
        $searchFile = Get-ChildItem $file -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName
    }
    else{
        #Set current system drive
        $localDrive = $pwd.drive.name + ":\"

        #Relative path type file search
        $searchFile = Get-ChildItem $file -Path $localDrive -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName
    }

    if ($searchFile -eq $null){

        Write-Host [!] $statement not found...`n

        Break
    }

    return $searchFile
}

function Determine-PathType($file){
<#
    .SYNOPSIS

    This module determines the file path type.
    .
    .DESCRIPTION

    Determine-PathType tries to determine if the given file is in absolute path or not.

    .EXAMPLE

    PS > Determine-PathType C:\Users\nickvourd\Desktop\Document.docx

    .EXAMPLE

    PS > Determine-PathType Document.docx
#>

    $searchPathType = [System.IO.Path]::IsPathRooted($file)

    return $searchPathType

}

function Determine-FileType($file, $statement, $numberOfCase){
<#
    .SYNOPSIS

    This module determines the file type of a document.
    .
    .DESCRIPTION

    Determine-FileType tries to determine if the given file is docx/txt document or not.

    .EXAMPLE

    PS > Determine-FileType C:\Users\nickvourd\Desktop\Document.docx InputDoc

    .EXAMPLE

    PS > Determine-FileType Document.docx InputDoc
#>
    
    $fileExtension = [IO.Path]::GetExtension($file)

    if ($numberOfCase -eq 0){
        if ($fileExtension -ne ".docx"){

            Write-Host [!] $statement is not a docx file...`n

            Break
        }
    }
    elseif ($numberOfCase -eq 1){
        if ($fileExtension -ne ".txt"){
        
            Write-Host [!] $statement is not a txt file...`n

            Break
        }
    }
}

function Search-Path($path, $statement, $numberOfCase, $foundFile, $bakDocument, $filenameFolder){
<#
    .SYNOPSIS

    This module searches path existence.
    .
    .DESCRIPTION

    Search-Path tries to search if a path exist in the system.

    .EXAMPLE

    PS > Search-Path "C:\Windows\Tasks" "Output" 1 "C:Users\nickvourd\Desktop\Doc1.docx" "C:Users\nickvourd\Desktop\Doc1.docx.bak" "C:Users\nickvourd\Desktop\Doc1\"
#>

    $pathFlag = $false

    if (Test-Path -Path $path){

        $pathFlag = $true
    }
    else{
        if ($numberOfCase -eq 0){

            Write-Host [!] $statement path does not exist...`n

            Break
        }
        elseif($numberOfCase -eq 1){
            
            Write-Host [!] $statement is a Docx without Template...`n

            #Restore the docx document
            Rename-Item -Path $bakDocument -NewName $foundFile -Force

            #Clean the rubbish
            Remove-Item -LiteralPath $filenameFolder -Recurse -Force

            Break
        }
    }

    return $pathFlag

}

function Check-Output($Output, $foundOutputType, $message){
<#
    .SYNOPSIS

    This module checks if Output is absolute path or not and if Output path exists or not.
    .
    .DESCRIPTION

    Check-Output tries to determine the Output path type and if Output exists.

    .EXAMPLE

    PS > Check-Output "C:\Windows\Tasks\Test.txt" True "It Works!"
#>

    #If Output is an aboslute path
    if ($foundOutputType -ne $false){
        $outputFolder = Split-Path $Output
        $outputFilename = [System.IO.Path]::GetFileName($Output)

        #Call function named Search-Path
        $foundPath = Search-Path $outputFolder Output 0 1 2 3

        if ($foundPath -ne $false){
            New-Item -Path $Output -ItemType File -Value $message -Force | Out-Null

            #Call function named Search-File
            $foundOutputFile = Search-File $Output "Output Filename"
        }
    }
    else{
        New-Item -Path $Output -ItemType File -Value $message -Force | Out-Null

        #Call function named Search-File
        $foundOutputFile = Search-File $Output "Output Filename"
    }

    return $foundOutputFile
}

function Invoke-Identify{
<#
    .SYNOPSIS

    This module is used for identifying malicious docx by Remote Template Injection.

    .DESCRIPTION

    Invoke-Identify indentifies remote template links into Office Word docx documents.

    .PARAMETER InputDoc

    The input DOCX document with the default Office template.

    .PARAMETER Output

    The output of the process.

    .EXAMPLE

    PS > Invoke-Identify -InputDoc Document.docx -Output results.txt

    This tries to identify if the input docx is malicious and saves output in a file.

    .EXAMPLE

     PS > Invoke-Identify -InputDoc Document.docx
    
    This tries to identify if the input docx is malicious.

    .LINK

    Github:         https://github.com/villains-team/RTI-Toolkit/PowerShell/PS-Templator.ps1
    Blog:           https://villains.team
#>

    #Arguments
    param (
        [Parameter(Mandatory=$True,Position=1)]
            [ValidateNotNull()]
    		[string]$InputDoc,

		[Parameter(Mandatory=$False,Position=3)]
    		[ValidateNotNull()]
    		[string]$Output
	)

    #Call function named Get-Logo
    Get-Logo

    #Call function named Search-File
    $foundFile = Search-File $InputDoc InputDoc

    #Call function named Determine-FileType
    Determine-FileType $foundFile InputDoc 0

    if ($PSBoundParameters.ContainsKey('Output')){

        #Call function named Determine-FileType
        Determine-FileType $Output Output 1

        #Call function named Determine-PathType
        $foundOutputType = Determine-PathType $Output Output

    }

    #Keep back up of the input document
    $bakDocument = $foundFile + ".bak"
    Copy-Item $foundFile -Destination $bakDocument

    #Convert to zip archive
    $filenameFolder = $foundFile.Replace(".docx","")
    $filenameFolderAll = $filenameFolder + "\*"
    $zipArchive = $foundFile + ".zip"
    Rename-Item -Path $foundFile -NewName $zipArchive

    #Expand archive
    Expand-Archive -Path $zipArchive -DestinationPath $filenameFolder
    Remove-Item -Path $zipArchive -Force

    #Set a path file to investigate
    $emergencyPathFile = $filenameFolder +"\word\_rels\settings.xml.rels"

    #call function named Search-Path
    $foundPathFile = Search-Path $emergencyPathFile $foundFile 1 $foundFile $bakDocument $filenameFolder

    #if file exists
    if ($foundPathFile -ne $False){
        #Get elements of XML file
        [xml]$xmlElm = Get-Content $emergencyPathFile

        foreach($relationship in $XmlElm.Relationships.Relationship){
   	        if ($relationship.Type.EndsWith('attachedTemplate'))
    	    {
        	    $target = $relationship.Target
    	    }
 	    }
            
        $successMessage = "[+] $foundFile is clean Document...`n"
        $failMessage = "[!] Malicious Link found: $target`n"
        
        if ($target.StartsWith("file:///") -and $target.EndsWith("_win32.dotx")){
            Write-Host $successMessage`n
            if($PSBoundParameters.ContainsKey('Output')){
                #call function named Check-Output
                $outputFullPath = Check-Output $Output $foundOutputType $successMessage
                Write-Host "[+] Output saved: $outputFullPath`n"
            }
        }
        else{
            Write-Host $failMessage`n
            if($PSBoundParameters.ContainsKey('Output')){
               #call function named Check-Output
               $outputFullPath = Check-Output $Output $foundOutputType $failMessage
               Write-Host "[+] Output saved: $outputFullPath`n"
            }
        }          
    }

    #Compress new archive
    Compress-Archive -Path $filenameFolderAll -DestinationPath $zipArchive

    #Rename zip archive to docx file
    Rename-Item -Path $zipArchive -NewName $foundFile -Force

    #Clean the rubbish
    Remove-Item -LiteralPath $filenameFolder -Recurse -Force 
    Remove-Item -LiteralPath $bakDocument -Recurse -Force
}

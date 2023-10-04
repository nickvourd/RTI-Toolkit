# RTI-Toolkit

Remote Template Injection Toolkit

## Description

RTI-Toolkit is an open-source PowerShell toolkit for Remote Template Injection attack. This toolkit includes a PowerShell script named `PS-Templator.ps1` which can be used from both an attacking and defensive perspective.

The following tables presents the main modules (cmdlets) of `PS-Templator.ps1`:

| Cmdlet | Description | Prespective |
| -------|:-----------:|:-----------:|
| [Invoke-Template](#invoke-template) | Implements remote template links into default Office Word templates  | attacking |
| [Invoke-Regular](#invoke-regular) | Implements remote template links into regular Office Word documents without template | attacking |
| [Invoke-Identify](#invoke-identify) | Indentifies remote template links into Office Word docx documents with/without template | defensive |

## License

This tool is licensed under the [![License: MIT](https://img.shields.io/badge/MIT-License-yellow.svg)](LICENSE).

## Table of Contents
- [RTI-Toolkit](#rti-toolkit)
  - [Description](#description)
  - [License](#license)
  - [Table of Contents](#table-of-contents)
  - [Remote Template Injection (RTI)](#remote-template-injection-rti)
  - [Installation](#installation)
  - [cmdlets](#cmdlets)
    - [Invoke-Template](#invoke-template)
    - [Invoke-Regular](#invoke-regular)
    - [Invoke-Identify](#invoke-identify)
  - [References](#references)

## Remote Template Injection (RTI)

Remote Template Injection (RTI) in the context of Microsoft Office refers to a specific type of security vulnerability that can be exploited through malicious templates in Office documents (e.g., Word, Excel, PowerPoint).

For example, in a DOCX file, the content is stored in XML format within the archive, and some of these XML files may reference external resources or templates. Attackers can indeed manipulate these XML files to insert malicious links or content that can potentially exploit vulnerabilities or deceive users. 

This is a Macro-Based attack.

## Installation

To load as module `PS-Templator.ps1` into the memory, run the following command:
```
Import-Module .\PS-Templator.ps1
```

:information_source: `PS-Templator.ps1` works without the necessity of installing any additional dependencies.<br /><br />
:information_source: `PS-Templator.ps1` works as PowerShell module.

## cmdlets

### Invoke-Template

### Invoke-Regular

### Invoke-Identify

## References
- [ired.team](https://www.ired.team/offensive-security/initial-access/phishing-with-ms-office/inject-macros-from-a-remote-dotm-template-docx-with-macros)
- [dmcxblue.gitbook.io](https://dmcxblue.gitbook.io/red-team-notes-2-0/red-team-techniques/defense-evasion/t1221-template-injection)
- [john-woodman.com](https://john-woodman.com/research/vba-macro-remote-template-injection/)
- [remoteInjector GitHub](https://github.com/JohnWoodman/remoteInjector)
- [Invoke-Templator GitHub](https://github.com/outflanknl/Invoke-Templator)
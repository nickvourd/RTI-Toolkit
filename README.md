# RTI-Toolkit

Remote Template Injection Toolkit

## Description

RTI-Toolkit is an open-source PowerShell toolkit for Remote Template Injection attack. This toolkit includes a PowerShell script named `PS-Templator.ps1` which can be used from both an attacking and defensive perspective.

The following tables presents the main modules (cmdlets) of `PS-Templator.ps1`:

| Cmdlet | Description | Prespective |
| -------|:-----------:|:-----------:|
| Invoke-Template | Implements remote template links into default Office Word templates  | attacking |
| Invoke-Regular | Implements remote template links into regular Office Word documents without template | attacking |
| Invoke-Identify | Indentifies remote template links into Office Word docx documents with/without template | defensive |

## License

This tool is licensed under the [![License: MIT](https://img.shields.io/badge/MIT-License-yellow.svg)](LICENSE).

## Table of Contents
- [RTI-Toolkit](#rti-toolkit)
  - [Description](#description)
  - [License](#license)

## References
- [ired.team](https://www.ired.team/offensive-security/initial-access/phishing-with-ms-office/inject-macros-from-a-remote-dotm-template-docx-with-macros)
- [dmcxblue.gitbook.io](https://dmcxblue.gitbook.io/red-team-notes-2-0/red-team-techniques/defense-evasion/t1221-template-injection)
- [john-woodman.com](https://john-woodman.com/research/vba-macro-remote-template-injection/)
- [remoteInjector GitHub](https://github.com/JohnWoodman/remoteInjector)
- [Invoke-Templator GitHub](https://github.com/outflanknl/Invoke-Templator)
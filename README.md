# RTI-Toolkit

Remote Template Injection Toolkit

## Description

RTI-Toolkit is an open-source PowerShell toolkit for Remote Template Injection attack. This toolkit includes a PowerShell script named PS-Templator.ps1 which can be used from both an attacking and defensive perspective.

The following tables presents the main modules (cmdlets) of `PS-Templator.ps1`:

| Cmdlet | Description | Prespective |
| -------|:-----------:|:-----------:|
| Invoke-Template | Implements remote template links into default Office Word templates  | attacking |
| Invoke-Regular | Implements remote template links into regular Office Word documents without template | attacking |
| Invoke-Identify | Indentifies remote template links into Office Word docx documents with/without template | defensive |

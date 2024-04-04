# RTI-Toolkit

Remote Template Injection Toolkit

<p align="center">
  <img width="350" height="350" src="/Pictures/RTI-Toolkit-Logo.png">
</p>

## Description

RTI-Toolkit is an open-source tool for Remote Template Injection attack. 


## Remote Template Injection (RTI)

Remote Template Injection (RTI) in the context of Microsoft Office refers to a specific type of security vulnerability that can be exploited through malicious templates in Office documents (e.g., Word, Excel, PowerPoint).

For example, in a DOCX file, the content is stored in XML format within the archive, and some of these XML files may reference external resources or templates. Attackers can indeed manipulate these XML files to insert malicious links or content that can potentially exploit vulnerabilities or deceive users. 


## References
- [ired.team](https://www.ired.team/offensive-security/initial-access/phishing-with-ms-office/inject-macros-from-a-remote-dotm-template-docx-with-macros)
- [dmcxblue.gitbook.io](https://dmcxblue.gitbook.io/red-team-notes-2-0/red-team-techniques/defense-evasion/t1221-template-injection)
- [john-woodman.com](https://john-woodman.com/research/vba-macro-remote-template-injection/)
- [remoteInjector GitHub by John Woodman](https://github.com/JohnWoodman/remoteInjector)
- [Invoke-Templator GitHub by Outflanknl](https://github.com/outflanknl/Invoke-Templator)
- [attack.mitre.org](https://attack.mitre.org/techniques/T1221/)
- [BadAssMacros GitHub by Inf0secRabbit](https://github.com/Inf0secRabbit/BadAssMacros)

# RTI-Toolkit

Remote Template Injection Toolkit

<p align="center">
  <img width="350" height="350" src="/Pictures/RTI-Toolkit-Logo.png"><br /><br />
  <img alt="Static Badge" src="https://img.shields.io/badge/License-MIT-green?link=https%3A%2F%2Fgithub.com%2Fnickvourd%2FRTI-Toolkit%2Fblob%2Fmain%2FLICENSE">
  <img alt="Static Badge" src="https://img.shields.io/badge/Version-2.0%20(Owl Hunter)-red?link=https%3A%2F%2Fgithub.com%2Fnickvourd%2FRTI-Toolkit%2Freleases"><br /><br />
   <img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/nickvourd/RTI-Toolkit?logoColor=yellow">
   <img alt="GitHub forks" src="https://img.shields.io/github/forks/nickvourd/RTI-Toolkit?logoColor=red">
   <img alt="GitHub watchers" src="https://img.shields.io/github/watchers/nickvourd/RTI-Toolkit?logoColor=blue">
</p>

## Description

RTI-Toolkit is an open-source tool for Remote Template Injection attacks.

The primary tool featured in this repository is the `Templator` tool which supports various features for attack and defense perspectives. Please refer to the [Features](#features) section for more information.

For command-line usage and examples, please refer to our [Wiki](https://github.com/nickvourd/RTI-Toolkit/wiki).

> If you find any bugs, don’t hesitate to [report them](https://github.com/nickvourd/RTI-Toolkit/issues). Your feedback is valuable in improving the quality of this project!

## Disclaimer

The authors and contributors of this project are not liable for any illegal use of the tool. It is intended for educational purposes only. Users are responsible for ensuring lawful usage.

## Table of Contents

- [RTI-Toolkit](#rti-toolki)
  - [Description](#description)
  - [Disclaimer](#disclaimer)
  - [Table of Contents](#table-of-contents)
  - [Acknowledgement](#acknowledgement)
  - [Features](#features)
  - [Installation](#installation)
  - [Usage](#usage)
  - [References](#references)

## Acknowledgement

Special thanks to my brothers [@Papadope9](https://twitter.com/Papadope9) and [Stavros Gkounis (a.k.a purpl3ph03n1x)](https://www.linkedin.com/in/stavros-gkounis-603026a6/), who provided invaluable assistance during the beta testing phase of the tool.

This tool was inspired during an iCAST Red Teaming Assessment with [@S1ckB0y1337](https://twitter.com/S1ckB0y1337) a few years ago.

RTI-Toolkit was created with :heart: by [@nickvourd](https://twitter.com/nickvourd).

## Features

Features here.

## Installation

You can use the [precompiled binaries](https://github.com/nickvourd/RTI-Toolkit/releases), or you can manually install Templator by following the next steps:

1) Clone the repository by executing the following command:

```
git clone https://github.com/nickvourd/RTI-Toolkit.git
```

2) Once the repository is cloned, navigate into the RTI-Toolkit directory:

```
cd RTI-Toolkit
```

3) Install the third-party dependencies:

```
go mod download
```

4) Build Templator with the following command:

```
go build Templator
```

## Usage

:information_source: Please refer to the [RTI-Toolkit Wiki](https://github.com/nickvourd/RTI-Toolkit/wiki) for detailed usage instructions and examples of commands.

## References

- [ired.team](https://www.ired.team/offensive-security/initial-access/phishing-with-ms-office/inject-macros-from-a-remote-dotm-template-docx-with-macros)
- [dmcxblue.gitbook.io](https://dmcxblue.gitbook.io/red-team-notes-2-0/red-team-techniques/defense-evasion/t1221-template-injection)
- [john-woodman.com](https://john-woodman.com/research/vba-macro-remote-template-injection/)
- [remoteInjector GitHub by John Woodman](https://github.com/JohnWoodman/remoteInjector)
- [Invoke-Templator GitHub by Outflanknl](https://github.com/outflanknl/Invoke-Templator)
- [attack.mitre.org](https://attack.mitre.org/techniques/T1221/)
- [BadAssMacros GitHub by Inf0secRabbit](https://github.com/Inf0secRabbit/BadAssMacros)

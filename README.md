

<div align="center">

# ⚡ CHW TraceX ⚡
### Live Host Forensic Triage & Rapid Evidence Acquisition Framework

[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011%20%7C%20Server-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://microsoft.com)
[![Framework](https://img.shields.io/badge/Framework-CHW%20TraceX-red?style=for-the-badge&logo=powershell&logoColor=white)](https://github.com)
[![Forensics](https://img.shields.io/badge/Compliance-ISO%2FIEC%2027037%20%7C%20RFC%203227-success?style=for-the-badge)](https://www.iso.org)
[![Author](https://img.shields.io/badge/Developed%20By-Mr.%20Dheeraj%20Kumar-orange?style=for-the-badge)](https://instagram.com/CyberHunterWarrior)
[![Organization](https://img.shields.io/badge/Organization-Cyber%20Hunter%20Warrior-black?style=for-the-badge)](https://instagram.com/CyberHunterWarrior)

<br/>

```text
 ██████╗██╗  ██╗██╗    ██╗    ████████╗██████╗  █████╗  ██████╗███████╗██╗  ██╗
██╔════╝██║  ██║██║    ██║    ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██╔════╝╚██╗██╔╝
██║     ███████║██║ █╗ ██║       ██║   ██████╔╝███████║██║     █████╗   ╚███╔╝ 
██║     ██╔══██║██║███╗██║       ██║   ██╔══██╗██╔══██║██║     ██╔══╝   ██╔██╗ 
╚██████╗██║  ██║╚███╔███╔╝       ██║   ██║  ██║██║  ██║╚██████╗███████╗██╔╝ ██╗
 ╚═════╝╚═╝  ╚═╝ ╚══╝╚══╝        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝

Automated, Non-Destructive, Order-of-Volatility Preserving Live Host Digital
Forensic Acquisition Framework
Built for Incident Responders, Law Enforcement, Threat Hunters, and DFIR
Practitioners.

🌐 Official Website • 📸 Instagram • 📺 YouTube • 🚀 Quick Start • 📜 Pipeline
Architecture

📌 Overview

CHW TraceX is an enterprise-grade digital forensic acquisition framework
engineered by Cyber Hunter Warrior. Designed to streamline live host triage
operations, TraceX executes a comprehensive, automated 20-stage forensic
collection pipeline across active Windows endpoints.

Operating under strict read-only parameters, it strictly adheres to:

  - RFC 3227 guidelines on forensic Order of Volatility (capturing volatile
    memory, network sockets, active processes, and ephemeral artifacts before
    persistent disk stores).
  - ISO/IEC 27037:2012 international standards for identification, collection,
    acquisition, and preservation of digital evidence.
  - Immediate, post-acquisition SHA-256 cryptographic verification generated for
    all acquired artifacts to guarantee chain of custody and evidentiary
    integrity.

⚡ Key Highlights

  - 🛡️ Zero External Dependency: Built leveraging native Windows APIs, CIM/WMI
    subsystems, and PowerShell execution engines.
  - ⏱️ Ultra-Fast Live Triage: Full artifact acquisition completes in minutes
    with real-time CLI progress bars.
  - 🔍 Deep WebKit & Chromium Carving: Direct byte-level extraction of URLs,
    search terms, and timestamps even if browsers are locked.
  - 🔐 Cryptographic Evidence Manifest: Automatic end-to-end SHA-256 hash
    generation for courtroom-ready verification.
  - 📊 Instant Workspace Report: Automatically launches an interactive index.html
    analytical dashboard upon collection.

🔬 20-Stage Forensic Acquisition Pipeline

| Stage  | Artifact Target                     | Output Format | Forensic Significance                                              |
| :----: | :---------------------------------- | :-----------: | :----------------------------------------------------------------- |
| **01** | Evidence Manifest                   | `.txt`        | Case metadata, lead responder, host target & start timestamps      |
| **02** | Privacy & Legal Compliance Charter  | `.txt`        | RFC 3227 / ISO 27037 chain-of-custody governing protocol           |
| **03** | Host Info & User Token Context      | `.txt`        | `systeminfo`, `hostname`, `whoami /all` security identifiers       |
| **04** | OS Metrics & Boot Geometry          | `.json`       | Last boot time, system uptime, hardware memory, BIOS details       |
| **05** | Physical Drives & Boot Geometry     | `.csv`        | Secondary SSDs, partitions, serials, and drive interfaces          |
| **06** | Connected Peripherals & USB Audits  | `.csv`        | PnP entities, external drives, keyboards, mice, Bluetooth items    |
| **07** | Power State & Network Interfaces    | `.json`       | Battery charge state, active Wi-Fi SSIDs, MACs & IP routing tables |
| **08** | Multi-User Command History & RunMRU | `.csv`        | Multi-user PowerShell history logs & Explorer Run dialog MRU       |
| **09** | Live Processes & Parentage Tree     | `.csv`        | Active PIDs, PPIDs, command-line arguments & memory working sets   |
| **10** | Windows Services & Binaries         | `.csv`        | Service state, launch modes, binary executable paths               |
| **11** | Network Sockets & Sockets-to-PID    | `.csv`        | Active IPv4/IPv6 TCP/UDP listening & established connections       |
| **12** | Auto-Run Registry Persistence       | `.csv`        | Registry Run & RunOnce autorun execution paths                     |
| **13** | User Accounts & Security Attributes | `.csv`        | Local usernames, SIDs, lockout states & password age               |
| **14** | Carved Browser History              | `.csv`        | Chrome, Edge, Brave, Opera & Firefox URL history                   |
| **15** | Carved Search Engine Queries        | `.csv`        | Extracted search keywords from Google, Bing, YouTube, etc.         |
| **16** | Downloaded Payloads & MOTW          | `.csv`        | Browser downloads + Zone.Identifier ADS origin parsing             |
| **17** | Bookmarks Extraction                | `.csv`        | Extracted bookmarks from Chromium trees                            |
| **18** | Local Email Storage Artifacts       | `.csv`        | Outlook `.ost`/`.pst` and Mozilla Thunderbird profiles             |
| **19** | Windows Event Logs                  | `.json`       | Targeted Security, System & Application event telemetry            |
| **20** | Cryptographic SHA-256 Manifest      | `.csv`        | Cryptographic hashes & byte sizes of all extracted evidence        |

📂 Evidence Vault Directory Structure

Once executed, evidence is safely structured under:

reports/
└── [Case_Name]_[Timestamp]/
    ├── Browser_Artifacts/
    │   ├── Google_Chrome_History.sqlite
    │   └── Microsoft_Edge_History.sqlite
    ├── Case_Information.txt
    ├── Privacy_Policy_Compliance.txt
    ├── System_Information.txt
    ├── Operating_System.json
    ├── Physical_Disks_Boot_Drives.csv
    ├── USB_All_Connected_Devices.csv
    ├── Power_Network_Interfaces.json
    ├── Recent_Commands_History.csv
    ├── Processes.csv
    ├── Services.csv
    ├── Network_Connections.csv
    ├── Registry_Persistence.csv
    ├── User_Accounts_Security.csv
    ├── Browser_History.csv
    ├── Browser_Searches.csv
    ├── Browser_Downloads.csv
    ├── Browser_Bookmarks.csv
    ├── Email_Client_Artifacts.csv
    ├── Event_Logs.json
    ├── Collection_Log.txt
    └── SHA256_Manifest.csv

🚀 Installation & Execution

Prerequisites

  - Windows 10, 11, or Windows Server (x64)
  - PowerShell 5.1+ (Native to modern Windows)
  - Administrative Privileges (Required for complete memory, event log, and
    low-level registry carving)

Step 1: Clone Repository

git clone https://github.com/YourUsername/CHW-TraceX.git
cd CHW-TraceX

(Alternatively, download the latest Release .zip and extract it).

Step 2: Run with Elevated Privileges

1.  Right-click on CHW_TraceX.bat (or your runner script).
2.  Select "Run as Administrator".
3.  Follow the on-screen prompts to configure your Case Parameters:
      - Case Name (e.g., INCIDENT_042)
      - Lead Investigator (e.g., Dheeraj_Kumar)
      - Case Reference ID (e.g., REF-2026-CHW)
      - Evidence Summary

Step 3: Review Results

Upon completion, CHW TraceX will automatically finalize the cryptographic
integrity catalog and launch the analysis workspace (index.html) in your default
browser.

⚖️ Legal & Ethical Notice

WARNING & DISCLAIMER:
This framework is developed strictly for authorized Digital Forensics and Incident Response (DFIR),
threat hunting operations, corporate incident containment, and authorized academic research.
CYBER HUNTER WARRIOR and the author disclaim all liability for unauthorized, malicious,
or unlawful deployment of this tool. Ensure you possess written authorization before executing
on non-consenting enterprise infrastructure.

👨‍💻 Developer & Leadership

🌐 Connect with Cyber Hunter Warrior

Stay tuned for our latest threat research, digital forensic workshops, and
cybersecurity tools:

Website Instagram YouTube

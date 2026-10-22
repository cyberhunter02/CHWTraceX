
<div align="center">

# 🛡️ CHW TRACEX 🛡️
### **Next-Gen Live Host Forensic Triage & Evidence Acquisition Framework**

[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011%20%7C%20Server-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://microsoft.com)
[![Developed By](https://img.shields.io/badge/Architect-Mr.%20Dhiraj%20Kumar-FF5722?style=for-the-badge&logo=github&logoColor=white)](https://instagram.com/CyberHunterWarrior)
[![Organization](https://img.shields.io/badge/Org-CYBER%20HUNTER%20WARRIOR-000000?style=for-the-badge&logo=security&logoColor=white)](https://instagram.com/CyberHunterWarrior)
[![Integrity](https://img.shields.io/badge/Integrity-SHA--256%20Cryptographic%20Verified-2E7D32?style=for-the-badge)](https://github.com)

<br/>

```text
 ██████╗██╗  ██╗██╗    ██╗    ████████╗██████╗  █████╗  ██████╗███████╗██╗  ██╗
██╔════╝██║  ██║██║    ██║    ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██╔════╝╚██╗██╔╝
██║     ███████║██║ █╗ ██║       ██║   ██████╔╝███████║██║     █████╗   ╚███╔╝ 
██║     ██╔══██║██║███╗██║       ██║   ██╔══██╗██╔══██║██║     ██╔══╝   ██╔██╗ 
╚██████╗██║  ██║╚███╔███╔╝       ██║   ██║  ██║██║  ██║╚██████╗███████╗██╔╝ ██╗
 ╚═════╝╚═╝  ╚═╝ ╚══╝╚══╝        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝
```

### **Automated • Non-Destructive • Courtroom-Grade Live Host Forensics**

**CHW TraceX** is an enterprise-grade forensic acquisition framework engineered for **Incident Responders, Cyber Forensic Investigators, and Law Enforcement Agencies** to instantly extract volatile artifacts without altering system state.

---

[🌐 Official Website](#-connect-with-cyber-hunter-warrior) • [📸 Instagram](https://instagram.com/CyberHunterWarrior) • [📺 YouTube](https://youtube.com/@CyberHunterWarrior) • [📥 How to Download](#-quick-download--execution-guide) • [🔎 Forensic Capabilities](#-forensic-capabilities--evidence-matrix)

---

</div>

## 🎯 **What is CHW TraceX?**

When a cyber incident or breach occurs, **volatile evidence vanishes within minutes** if a machine restarts or shuts down. **CHW TraceX** automates the entire host-triage process in strict compliance with **RFC 3227 (Order of Volatility)** and global digital evidence preservation standards.

It captures live memory structures, deep browser databases, hidden payloads, persistence hooks, and network connections in an automated 20-stage pipeline, automatically locking everything with **SHA-256 cryptographic hashes**.

---

## 🔬 **Forensic Capabilities & Evidence Matrix**

| Forensic Area | 🔍 What CHW TraceX Extracts | 🛡️ Investigation & Triage Value |
| :--- | :--- | :--- |
| **System & Hardware Geometry** | Target Hostname, Uptime, Hardware Metrics, Boot Sector & BIOS details | Identifies OS configuration, architecture, and baseline system state. |
| **Physical & Boot Drives** | Physical drives, secondary NVMe/SSDs, hidden partitions, drive serial numbers | Detects unmounted partitions, secondary drives, and evidence tampering. |
| **Peripherals & USB Tracking** | Connected USB flash drives, HID devices, mice, keyboards, Bluetooth hardware | Spots rogue hardware, BadUSBs, unauthorized external pendrives, or exfiltration media. |
| **Active Network Sockets** | Live IPv4/IPv6 TCP/UDP connections mapped directly to owning Process IDs (PIDs) | Exposes Command & Control (C2) beacons, reverse shells, and malicious outbound traffic. |
| **Live Process Trees** | Active processes, parentage (PPID to PID), full command lines, and memory usage | Catches process hollowing, living-off-the-land binaries (LOLBins), and hidden malware. |
| **Command History & RunMRU** | Multi-user PowerShell history logs (`ConsoleHost_history`) + Windows Run Box MRU | Reveals the exact interactive commands and payloads typed by an attacker or user. |
| **Persistence & Auto-Runs** | Auto-start execution points (`HKLM` & `HKCU` Run / RunOnce registry keys) | Uncovers startup persistence hooks used by malware to survive host reboots. |
| **User Accounts & Privileges** | Local usernames, SIDs, lockout state, password policies, and password age | Identifies backdoor accounts, privilege escalation, and lateral movement footprints. |
| **Deep Browser Carving** | History & search keywords carved directly from Chrome, Edge, Brave, Opera, Firefox | Recovers visited malicious URLs, threat research, and search queries at byte-level. |
| **Payload & Download Audit** | Carved browser downloads + NTFS `Zone.Identifier` (Mark-of-the-Web ADS) | Identifies initial attack vectors, downloaded phishing attachments, and droppers. |
| **Email Storage Stores** | Locates Microsoft Outlook `.ost` / `.pst` caches and Mozilla Thunderbird profiles | Quickly pinpoints corporate communications, phishing emails, and local mail stores. |
| **Windows Event Logs** | Deep query of core `Security`, `System`, and `Application` event records | Detects brute-force logins, service installations, and clear-log attempts. |
| **Cryptographic Manifest** | Automated post-acquisition **SHA-256 hashing** of every single carved artifact | Guarantees **Chain of Custody** and evidentiary authenticity of the acquired artifacts. |

---

## 📥 **Quick Download & Execution Guide**

### **Prerequisites:**
- **OS:** Windows 10, Windows 11, or Windows Server (64-bit)
- **Privilege:** Administrator rights *(Mandatory to access raw memory, event logs, and system registries)*

---

### **Option 1: Download via Git (Recommended)**

```powershell
# Step 1: Clone the official repository
git clone https://github.com/YourUsername/CHW-TraceX.git

# Step 2: Navigate into the tool directory
cd CHW-TraceX
```

---

### **Option 2: Direct ZIP Download**
1. Click the green **`<> Code`** button at the top right of this repository.
2. Select **`Download ZIP`**.
3. Extract the downloaded `.zip` file on your target machine.

---

### **🚀 How to Run:**

1. Open the folder and **Right-Click** on `CHW_TraceX.bat`.
2. Select **"Run as administrator"**.
3. Fill in your incident details in the interactive prompt:
   - **Case Name** *(e.g., `APT_Investigation_01`)*
   - **Lead Investigator** *(e.g., `Dhiraj_Kumar`)*
   - **Case Reference ID** *(e.g., `TICKET-9921`)*
   - **Evidence Summary** *(e.g., `Live_Host_Triage`)*
4. **Automated Analysis:** The 20-stage pipeline will acquire all artifacts, calculate SHA-256 hashes for evidence protection, and immediately open your **`index.html`** forensic dashboard in your browser.

---

## 🗂️ **Generated Evidence Vault**

All carved intelligence is systematically stored in an isolated, tamper-evident case folder:

```text
📁 reports/
   └── 📁 [Case_Name]_[Timestamp]/
       ├── 📁 Browser_Artifacts/           <- Raw SQLite DBs & WAL journals
       ├── 📄 Case_Information.txt         <- Investigator & host baseline metadata
       ├── 📄 Privacy_Policy_Compliance.txt <- Legal compliance & data governance charter
       ├── 📄 System_Information.txt       <- Raw systeminfo & whoami security tokens
       ├── 📄 Operating_System.json        <- Hardware, uptime & boot geometry
       ├── 📊 Physical_Disks_Boot_Drives.csv <- Disks, secondary SSDs & partitions
       ├── 📊 USB_All_Connected_Devices.csv <- Connected USBs, HID & peripherals
       ├── 📄 Power_Network_Interfaces.json <- WiFi SSIDs, battery state & MACs
       ├── 📊 Recent_Commands_History.csv  <- Multi-user PowerShell history & RunMRU
       ├── 📊 Processes.csv                <- Running processes, parentage & CLI args
       ├── 📊 Services.csv                 <- Windows services & binary paths
       ├── 📊 Network_Connections.csv      <- Live TCP/UDP sockets mapped to PIDs
       ├── 📊 Registry_Persistence.csv     <- Registry Run/RunOnce persistence keys
       ├── 📊 User_Accounts_Security.csv   <- Local user accounts, SIDs & password age
       ├── 📊 Browser_History.csv          <- Carved browsing history
       ├── 📊 Browser_Searches.csv         <- Carved search queries
       ├── 📊 Browser_Downloads.csv        <- Carved downloaded files & URLs
       ├── 📊 Browser_Bookmarks.csv        <- Extracted user bookmarks
       ├── 📊 Email_Client_Artifacts.csv   <- Outlook & Thunderbird email stores
       ├── 📄 Event_Logs.json              <- Security & System event telemetry
       ├── 📄 Collection_Log.txt           <- Execution timestamp audit trail
       └── 📊 SHA256_Manifest.csv          <- Cryptographic integrity verification
```

---

## ⚖️ **Legal Compliance & Ethical Charter**

> **LEGAL NOTICE & DISCLAIMER:**  
> This framework is developed strictly for **authorized Digital Forensics & Incident Response (DFIR)** operations, lawful cyber investigations, threat hunting, and academic research.  
> **CYBER HUNTER WARRIOR** and **Mr. Dhiraj Kumar** accept no liability for any unauthorized, malicious, or unlawful deployment of this tool. Always ensure explicit, written authorization before executing on enterprise infrastructure.

---

## 👨‍💻 **Architect & Leadership**

<div align="center">

### **Mr. Dhiraj Kumar**
**Chief Executive Officer (CEO) & Chief Security Architect**  
**CYBER HUNTER WARRIOR**  
*Specialized in Offensive Security, Digital Forensics & Incident Response (DFIR)*

</div>

---

## 🌐 **Connect with Cyber Hunter Warrior**

Stay connected with us for cutting-edge DFIR tools, threat intel research, and ethical hacking training:

<div align="center">

[![Website](https://img.shields.io/badge/Official_Website-Cyber_Hunter_Warrior-0A66C2?style=for-the-badge&logo=google-chrome&logoColor=white)](https://cyberhunterwarrior.com)
[![Instagram](https://img.shields.io/badge/Instagram-@CyberHunterWarrior-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://instagram.com/CyberHunterWarrior)
[![YouTube](https://img.shields.io/badge/YouTube-Cyber_Hunter_Warrior-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://youtube.com/@CyberHunterWarrior)

<br/>

**CYBER HUNTER WARRIOR — Defending Cyberspace with Precision**

<sub>Copyright © CYBER HUNTER WARRIOR. All Rights Reserved. Designed & Developed by Mr. Dhiraj Kumar.</sub>

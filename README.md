# PowerShell Automation Portfolio  
### Windows Server · Active Directory SME
**Author: Chul Yong Ryu (CY)**

---

## 📘 Overview

This repository contains **enterprise-grade PowerShell automation scripts** that I developed and used in real production environments to operate and standardize **Windows Server, Active Directory, DNS, and infrastructure operations**.

All scripts are **sanitized versions** of real operational code:
- Company-specific names, domains, IPs, and identifiers have been replaced with fictional values.
- Core logic, structure, and operational intent are preserved.
- Safe to review publicly and suitable for interview and portfolio purposes.

This portfolio demonstrates my practical experience in:
- Automating repetitive and error-prone infrastructure tasks
- Designing data-driven PowerShell automation
- Operating large-scale Windows/AD environments

---

## 🎯 Key Focus Areas

- **Windows Server Operations Automation**
- **Active Directory Governance**
  - Users, attributes, OUs, sites & subnets
- **DNS Infrastructure Automation**
  - Conditional forwarders, scavenging policies
- **Operational Reporting & Visibility**
- **Infrastructure Hygiene & Standardization**

---

## 📂 Scripts in This Repository

### 🔹 Get-PCInfo_CPUSOM2b.ps1
**Category:** Inventory / Windows Server  

Collects hardware and OS information from remote Windows machines using WMI/CIM.

**Key Features**
- Remote system information collection
- CPU, memory, OS, and basic hardware details
- Useful for inventory, audits, and pre-checks

**Why it matters**
- Eliminates manual server/PC inspections
- Improves operational visibility at scale

---

### 🔹 UpdateConditionalDNSForwarders_20240401.ps1
**Category:** DNS / Infrastructure  

Automates the creation and update of **DNS Conditional Forwarders** based on predefined domain or region mappings.

**Key Features**
- Data-driven (CSV-based) DNS configuration
- Consistent DNS forwarding policies
- Reduces manual DNS misconfiguration risk

**Why it matters**
- DNS errors are hard to troubleshoot and high impact
- Automation ensures consistency across environments

---

### 🔹 ADSiteUpdate_20200320.ps1
**Category:** Active Directory  

Synchronizes and enforces **AD Sites and Subnets** configuration using authoritative data.

**Key Features**
- Detects missing or mismatched subnets
- Updates AD site topology automatically
- Improves authentication and replication behavior

**Why it matters**
- Incorrect site mapping causes logon delays and replication issues
- Critical for multi-site enterprise environments

---

### 🔹 SetupNewSiteOUs.ps1
**Category:** Active Directory / Governance  

Creates a standardized **OU framework** when a new site or region is introduced.

**Key Features**
- Automated OU structure creation
- Enforces naming conventions
- Foundation for GPO and delegated administration

**Why it matters**
- Prevents OU sprawl and inconsistent structures
- Speeds up onboarding of new sites

---

### 🔹 UpdateAttributesforRotorUsers_Integrated.ps1
**Category:** Identity / Active Directory  

Performs bulk updates of AD user attributes using CSV mappings.

**Key Features**
- Attribute synchronization and normalization
- Supports organizational changes and clean-up
- Reduces repetitive manual admin work

**Why it matters**
- Identity data quality is critical for security and operations
- Automation ensures consistency and accuracy

---

### 🔹 Export_LongteamUnlogonUsers.ps1
**Category:** Security / AD Hygiene  

Exports users who have not logged on for an extended period.

**Key Features**
- Identifies dormant accounts
- CSV export for audit and review
- Supports security and compliance efforts

**Why it matters**
- Dormant accounts increase security risk
- Helps maintain a clean and controlled AD environment

---

### 🔹 SetDNSScavengingforallAD.ps1
**Category:** DNS / Hygiene  

Applies consistent DNS scavenging settings across AD-integrated DNS servers.

**Key Features**
- Standardized scavenging configuration
- Reduces stale DNS records
- Improves name resolution reliability

**Why it matters**
- DNS hygiene is critical but often neglected
- Automation enforces best practices consistently

---

### 🔹 Update_ChangePWatLastLogon.ps1
**Category:** Security / Identity  

Updates password-related flags based on last logon information.

**Key Features**
- Automates account security maintenance
- Supports identity lifecycle policies

**Why it matters**
- Helps enforce security rules consistently
- Reduces manual account management tasks

---

## 🧠 Automation Design Principles

All scripts follow these principles:

- **Data-Driven Automation**  
  Configuration is externalized (CSV or parameters), not hard-coded.

- **Idempotent Execution**  
  Scripts are safe to re-run without causing inconsistent state.

- **Operational Focus**  
  Each script solves a real operational problem encountered in enterprise environments.

- **Standardization & Governance**  
  Automation enforces rules instead of relying on manual discipline.

---

## 🛡️ Security & Disclaimer

- All scripts are **sanitized**.
- No real company names, domains, IP addresses, or credentials are included.
- These scripts are provided for **demonstration and portfolio purposes only**.

---

## 👤 About Me

**Chul Yong Ryu (CY)**  
working as engineer/architect regarding of Enterprise Infrastructure

- Windows Server & Active Directory operations/building up
- PowerShell automation for infrastructure and identity
- Focus on reliability, security, and operational excellence
- Design/Perform OS Virtualization 

📎 GitHub: https://github.com/ChulyongRyu

---

## 📌 Usage Note

These scripts are examples of real-world automation patterns.  
Before using in any environment:
- Review and understand the logic
- Adjust parameters and data sources
- Test in a non-production environment first

---

# PowerShell Automation Portfolio  
### Enterprise Windows Server · Active Directory · DNS Automation

**Author:** Chul Yong Ryu (CY)  
**Role:** Infrastructure / Automation Engineer  
**Focus:** Windows Server · Active Directory · DNS · Operational Automation

---

## 👋 Overview

This repository is my **PowerShell automation portfolio**, built from scripts that I actually used in **enterprise production environments** to operate and standardize:

- Windows Server infrastructure
- Active Directory & identity operations
- DNS configuration and hygiene
- Operational reporting and automation

All scripts published here are **sanitized versions**:
- Company names, domains, IPs, and identifiers have been replaced with fictional values
- Core logic, structure, and operational intent are preserved
- Safe for public review and interview discussion

This repository is designed for **technical interviews, portfolio reviews, and architecture discussions**.

---

## 🧭 Repository Structure

This portfolio is intentionally organized using **branches**, not just folders.

main → Portfolio overview (this page)
Windows-Server → Windows Server, DNS, inventory automation
ActiveDirectory → AD, identity, OU, site/subnet automation


### Why branches?
Each branch represents a **focused technical domain**, similar to how real enterprise teams separate responsibilities.

---

## 📌 Portfolio Branches

### 🔹 Windows-Server Branch
👉 https://github.com/ChulyongRyu/PortfolioPS/tree/Windows-Server

**Focus**
- Windows Server operations
- DNS automation and hygiene
- System inventory and reporting

**Representative topics**
- DNS Conditional Forwarders automation
- DNS scavenging configuration
- Hardware / OS inventory via WMI & CIM

---

### 🔹 ActiveDirectory Branch
👉 https://github.com/ChulyongRyu/PortfolioPS/tree/ActiveDirectory

**Focus**
- Active Directory governance
- Identity lifecycle automation
- OU, site, and subnet standardization

**Representative topics**
- AD Site & Subnet synchronization
- Standardized OU framework creation
- Bulk user attribute management
- Dormant account identification

---

## 🧠 Automation Design Principles

Across all branches, my automation follows these principles:

- **Data-Driven Automation**  
  Configuration is externalized (CSV / parameters), not hard-coded.

- **Idempotent Execution**  
  Scripts are safe to re-run without creating inconsistent states.

- **Operational First**  
  Every script solves a real operational problem encountered in production.

- **Standardization & Governance**  
  Automation enforces rules instead of relying on manual discipline.

- **Security-Aware Publishing**  
  Sensitive information is removed without weakening the technical value.

---

## 🛡️ Security & Disclaimer

- All scripts are **sanitized** for public sharing
- No real company names, domains, IP addresses, or credentials exist
- Scripts are provided **for demonstration and portfolio purposes**
- Review and test before using in any real environment

---

## 👤 About Me

**Chul Yong Ryu (CY)**  
got specialty for Enterprise Infrastructure 

- Windows Server & Active Directory operations
- PowerShell automation for infrastructure and identity
- Focus on reliability, security, and operational excellence

📎 GitHub: https://github.com/ChulyongRyu  

---

## 🎯 How to Use This Portfolio (Interview Tip)

For reviewers:
- Start here (main branch)
- Choose a technical area via branch
- Review real automation patterns and scripts

For interviews:
> “This repository shows how I automate real Windows/AD operations.  
> I separated domains by branch to reflect real operational boundaries.”

---

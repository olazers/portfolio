# ☁️ Cloud & AI Engineering Journey

> **From Cloud Foundations → Cloud Engineering → AI Engineering → Solutions Architecture → Cloud Consulting**

Welcome to my professional learning and engineering portfolio.

This repository documents my journey toward becoming a **Cloud Engineer, Solutions Architect, and Cloud Consultant**, while developing additional specialization in **Cloud Security and DevSecOps**.

My focus includes **Azure, AWS, AI, networking, automation, security, infrastructure as code, and cloud-native technologies**.

My approach is simple:

**Learn → Build → Document → Deploy → Improve**

---

## 🎯 Career Direction

**Primary:** Cloud Engineer → Solutions Architect → Cloud Consultant

**Additional Specialization:** Cloud Security + DevSecOps

I am building practical, hands-on experience alongside certifications, with an emphasis on understanding **how cloud systems are designed, deployed, secured, automated, monitored, and optimized in real-world environments.**

---

## 🚀 Current Focus

### Foundations

* Microsoft Azure fundamentals
* Artificial Intelligence fundamentals
* Data fundamentals
* Security fundamentals
* Git & GitHub
* Cloud labs and documentation

### Next Engineering Focus

* Azure administration
* Linux
* Python automation
* Networking
* Identity and access management
* Cloud security fundamentals
* Infrastructure as Code
* AI applications
* Data engineering
* Cloud architecture
* DevOps and DevSecOps

---

## 🎓 Certifications & Learning Roadmap

| Period | Focus | Certification / Goal |
| --- | --- | --- |
| Jul–Aug 2026 | Cloud & AI Foundations | ✅ AZ-900 |
| Jul–Aug 2026 | AI Fundamentals | ✅ AI-900 |
| Aug 2026 | Data Fundamentals | ✅ DP-900 |
| Aug 2026 | Security Fundamentals | ✅ SC-900 |
| Sep–Oct 2026 | Azure Engineering | 🎯 AZ-104 |
| Sep–Oct 2026 | Cloud Automation | 🐍 Python + Linux |
| Nov 2026 | Networking | 🎯 CCNA |
| Dec 2026 | Azure Networking | 🎯 AZ-700 |
| Jan–Feb 2027 | AI Engineering | 🎯 AI-103 |
| Feb 2027 | Advanced AI | 🤖 Multi-Agent AI |
| Mar–Apr 2027 | Data Engineering | 🎯 DP-700 |
| May–Jun 2027 | Cloud Architecture | 🎯 AZ-305 |
| Jul–Aug 2027 | Multi-Cloud | ☁️ AWS Solutions Architect |
| Sep–Oct 2027 | IaC & Cloud Native | 🎯 Terraform + CKA |
| Nov 2027 | DevOps + DevSecOps | 🎯 AZ-400 |
| Dec 2027–Jan 2028 | Advanced Cloud + AI Security | 🎯 Security+ + SC-500 |
| Feb–Mar 2028 | Portfolio & Career | 🚀 Flagship Projects |

---

## 🧪 Hands-On Projects

### ☁️ Azure Blob Storage with RBAC and Microsoft Entra ID - ✅ Completed

Built and documented an Azure Storage environment using a private Blob container, Microsoft Entra ID authentication, and Azure RBAC.

One area I wanted to understand better was the difference between permission to manage an Azure resource and permission to access the actual data stored inside it.

**Hands-on work included:**

* Azure StorageV2
* Private Blob container
* Microsoft Entra authentication
* Storage Blob Data Contributor RBAC
* Secure transfer and TLS 1.2
* Blob and container soft delete
* Authenticated Blob access and validation
* Security and cost considerations
* Architecture documentation

➡️ [View Project](azure/foundations/azure-blob-rbac-lab/README.md)

---

### 🌐 Azure Secure Two-Tier Network Architecture - ✅ Completed

Designed and deployed a two-tier Azure network with separate web and application tiers.

The web tier can receive the required external traffic, while the application VM remains private with no public IP. Communication between the two tiers was tested over the Azure private network.

**Hands-on work included:**

* Azure Virtual Network (VNet)
* Dedicated web and application subnets
* Network Security Groups (NSGs)
* Linux virtual machines
* Public-facing Nginx web tier
* Private application tier with no public IP
* Controlled web-to-app communication over TCP 8080
* SSH administration
* SSH agent forwarding
* Private IP communication between Azure workloads
* Network segmentation and access control
* Connectivity testing and troubleshooting
* VM deallocation for cloud cost management
* Security-focused documentation and validation

One useful part of this project was working out how to securely administer the private application VM without adding a public IP or copying my private SSH key onto the web server.

➡️ [View Project](azure/foundations/azure-secure-two-tier-network/README.md)

---

### 🔐 Azure Key Vault + Managed Identity - Passwordless Secret Access - ✅ Completed

Built and validated a secure secret-management architecture that allows a private Azure virtual machine to access Azure Key Vault without storing passwords, access keys, or application credentials.

A key part of this project was testing both allowed and denied operations instead of relying only on the configured role assignment:

```text
SecretGet → HTTP 200 OK
SecretSet → HTTP 403 Forbidden
```

This confirmed that the VM could read the secret it needed while the managed identity was prevented from modifying secrets.

**Hands-on work included:**

* Azure Key Vault
* System-assigned managed identity
* Microsoft Entra ID workload authentication
* Azure RBAC authorization
* Key Vault Secrets User least-privilege role
* Passwordless access using Azure access tokens
* Restricted Key Vault network access
* Microsoft Key Vault service endpoint
* Private application VM with no public IP
* Trusted Launch, Secure Boot, and vTPM
* Authorized secret retrieval validation - HTTP 200
* Unauthorized secret modification validation - HTTP 403 Forbidden
* Bicep infrastructure as code
* Azure CLI template validation and deployment
* Bicep What-If analysis
* Azure Monitor diagnostic settings
* Log Analytics workspace
* KQL security-log analysis
* Key Vault audit logging
* Azure Policy governance
* RBAC permission-model compliance validation
* Security-focused evidence sanitization and documentation

The monitoring portion also gave me useful troubleshooting experience when the Key Vault audit logs did not appear immediately and I had to verify the denied operation using the correct Log Analytics fields.

➡️ [View Project](azure/foundations/azure-keyvault-managed-identity/README.md)

---

## 🏗️ What I'm Building

My goal is to move beyond certification-based learning and create **production-style projects** that demonstrate practical engineering ability.

### 🤖 1. Production RAG Platform

**Focus:** AI + Azure + RAG + Vector Search

Planned capabilities:

* Retrieval-Augmented Generation
* Vector search
* Authentication
* APIs / SDKs
* Monitoring
* Evaluation
* Secure cloud deployment

---

### 🧠 2. Multi-Agent AI Platform

**Focus:** AI agents + automation + cloud

Planned capabilities:

* Multiple AI agents
* Tool integration
* APIs
* Automation
* Identity
* Agent workflows
* Monitoring

---

### 🏗️ 3. Azure Enterprise Architecture

**Focus:** Cloud architecture

Planned capabilities:

* Azure networking
* Identity and RBAC
* Security
* Governance
* Reliability
* Disaster recovery
* Cost optimization
* Architecture decisions

---

### ☁️ 4. AWS Production-Style Environment

**Focus:** Multi-cloud engineering

Planned capabilities:

* AWS VPC
* IAM
* Compute
* Storage
* Databases
* Monitoring
* Security
* Terraform

---

### ⚙️ 5. Terraform + Kubernetes Platform

**Focus:** Infrastructure as Code + Cloud Native

Planned capabilities:

* Terraform
* Docker
* Kubernetes
* Azure
* AWS
* Networking
* IaC security scanning
* Container image scanning
* Kubernetes RBAC and secrets
* Monitoring

---

### 🚀 6. DevSecOps CI/CD Platform

**Focus:** DevOps + security automation

**GitHub → Security Scanning → GitHub Actions → Terraform → Security Gate → Cloud → Docker → Container Scanning → Kubernetes → Monitoring**

Planned capabilities:

* CI/CD
* Automated testing
* SAST / code scanning
* Dependency vulnerability scanning
* Secret scanning
* Infrastructure as Code security scanning
* Container image scanning
* Security gates
* SBOM basics
* Infrastructure deployment
* Container deployment
* Release automation
* Monitoring and security alerts

---

### 🛡️ 7. Cloud Security + Detection & Response Platform

**Focus:** Cloud security + security operations

Planned capabilities:

* Identity and RBAC
* Network security
* Secrets management
* Azure Policy
* Microsoft Defender for Cloud
* Microsoft Defender XDR
* Microsoft Sentinel
* SIEM / SOAR concepts
* KQL
* Security monitoring
* Detection rules and alerts
* Incident investigation
* Threat detection
* MITRE ATT&CK
* Threat modeling
* Zero Trust
* AI security
* Response and remediation

---

# 🧰 Technology Roadmap

### ☁️ Cloud

* Microsoft Azure
* Amazon Web Services (AWS)

### 🤖 AI

* Generative AI
* RAG
* Vector Search
* AI Applications
* AI Agents
* APIs & SDKs
* AI Evaluation
* AI Monitoring

### 🐍 Programming & Automation

* Python
* Bash
* REST APIs
* JSON
* Cloud SDKs

### 🌐 Networking

* TCP/IP
* IP Addressing
* Subnetting
* Routing
* VLANs
* DNS
* DHCP
* NAT
* VPN
* Firewalls
* Azure Networking

### ⚙️ Infrastructure, DevOps & DevSecOps

* Git
* GitHub
* GitHub Actions
* Terraform
* Docker
* Kubernetes
* Infrastructure as Code
* CI/CD
* SAST / code scanning
* Dependency scanning
* Secret scanning
* IaC security scanning
* Container image scanning
* Security gates
* Policy as Code
* SBOM

### 📊 Data

* Data ingestion
* Data transformation
* Data pipelines
* Analytics
* Microsoft Fabric
* Data architecture

### 🛡️ Security

* IAM
* RBAC
* Network security
* Secrets management
* Azure Key Vault
* Azure Policy
* Microsoft Defender for Cloud
* Microsoft Defender XDR
* Microsoft Sentinel
* SIEM / SOAR
* KQL
* Security monitoring
* Threat detection
* Incident investigation
* Vulnerability management
* MITRE ATT&CK
* Zero Trust
* Threat modeling
* Security architecture

### 📈 Observability

* Monitoring
* Logging
* Metrics
* Traces
* Dashboards
* Alerts
* Prometheus
* Grafana

---

# 📁 Portfolio Structure

Each major project will include:

```text
Project
├── Architecture diagram
├── README
├── Infrastructure as Code
├── Source code
├── Deployment instructions
├── Security considerations
├── Monitoring
├── Cost considerations
├── Design decisions
└── Lessons learned
```

The goal is to demonstrate not only **what I built**, but also **why I designed it that way**.

---

# 📐 Architecture Mindset

As I progress toward Solutions Architecture, I will focus on:

* Reliability
* Security
* Scalability
* Performance
* Cost optimization
* Operational excellence
* Governance
* Disaster recovery
* Identity
* Networking
* Data architecture

Every major architecture project will document the **design decisions, trade-offs, risks, and cost considerations** behind the solution.

---

# 📈 Learning Philosophy

Certifications provide structured knowledge.

Projects provide practical experience.

Documentation demonstrates understanding.

Architecture demonstrates decision-making.

My goal is to combine all four.

> **Don't just learn cloud. Build it. Secure it. Automate it. Monitor it. Explain it.**

---

# 🗺️ Long-Term Vision

My long-term goal is to develop the technical and architectural skills required to design and deliver **secure, scalable, automated, AI-enabled cloud solutions**.

The journey:

**Cloud Foundations**  
↓  
**Cloud Engineering**  
↓  
**Networking & Infrastructure**  
↓  
**AI Engineering**  
↓  
**Data Engineering**  
↓  
**Cloud Architecture**  
↓  
**Multi-Cloud**  
↓  
**Cloud Native & DevOps**  
↓  
**DevSecOps**  
↓  
**Cloud & AI Security**  
↓  
**Solutions Architecture & Consulting**

---

# 📌 Portfolio Status

**Current stage:** Cloud & AI Foundations

**Primary cloud:** Microsoft Azure

**Future cloud:** AWS

**Career direction:** Cloud Engineer → Solutions Architect → Cloud Consultant

**Specialization:** Cloud Security + DevSecOps

**Portfolio:** Continuously evolving 🚀

---

## 📫 Connect

* **GitHub:** https://github.com/olazers
* **LinkedIn:** https://www.linkedin.com/olazers

---

⭐ This repository will evolve as I learn, build, deploy, document, and improve real-world cloud and AI solutions.

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

### Current Engineering Progress

* Azure administration
* Identity and RBAC
* Azure networking
* Linux administration
* Windows Server and enterprise administration
* PowerShell administration
* Azure Key Vault and managed identities
* Infrastructure as Code with Bicep
* Azure Monitor and Log Analytics
* Backup and recovery
* Security and governance
* High availability and resiliency

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
* Deeper Python automation
* AI / ML foundations
* Docker and containers
* AI infrastructure / MLOps
* Cloud and AI security

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

SecretGet → HTTP 200 OK  
SecretSet → HTTP 403 Forbidden

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

### 🖥️ Azure VM Operations, Monitoring & Recovery - ✅ Completed

Operated and tested an existing private Azure Linux VM with a focus on storage, monitoring, alerting, backup, recovery, infrastructure as code, and cost management.

A major troubleshooting exercise was finding that the Azure platform CPU metric did not reflect the workload inside the VM. Linux tools and OpenTelemetry guest metrics both showed the VM reaching 100% CPU, so I traced the monitoring path instead of lowering the alert threshold just to make the test pass.

**Hands-on work included:**

* Azure managed disks and persistent Linux mounts
* Standard SSD data disk
* Azure Monitor Agent
* OpenTelemetry guest metrics
* Data Collection Rules
* CPU, memory, disk, filesystem, and network monitoring
* Azure Monitor alerts and action groups
* NAT Gateway for explicit outbound connectivity
* Monitoring-agent troubleshooting
* Azure Recovery Services vault
* Enhanced VM backup policy
* File-system consistent recovery point
* Real file deletion and file-level recovery test
* Read-only recovery disk mounting
* Bicep infrastructure as code
* Bicep What-If analysis and deployment
* Trusted Launch VM operations
* Security and cost cleanup

The recovery test went beyond checking that a backup job succeeded. I deleted a file from the managed data disk, connected the Azure recovery point, located the backed-up data disk, mounted it read-only, restored the deleted file, and validated the recovered content.

➡️ [View Project](azure/foundations/azure-vm-operations-monitoring-recovery/README.md)

---

### ⚖️ Azure High Availability & Resiliency - ✅ Completed

Built and validated a highly available Azure web tier using two private Linux virtual machines distributed across separate Availability Zones behind an Azure Standard Load Balancer.

One thing I wanted to test was whether the application would actually remain available when a backend service failed, rather than relying only on Azure showing the configuration as healthy. I stopped Nginx on each backend separately and confirmed that the Load Balancer continued serving the application through the remaining healthy VM in both directions.

**Hands-on work included:**

* Azure Availability Zones
* Two private Ubuntu web servers across Zone 1 and Zone 2
* Azure Standard Load Balancer
* Backend pools and TCP health probes
* Load-balancing rules
* Dedicated HA subnet and Network Security Group
* NAT Gateway for explicit outbound connectivity
* Nginx and cloud-init
* Private backend VMs with no public IP addresses
* Real two-direction application failover testing
* Load Balancer backend health validation
* Bicep infrastructure as code
* Modular Bicep design
* ARM What-If analysis
* Safe infrastructure change management
* Bicep deployment and post-deployment validation
* Security and cost cleanup

The infrastructure-as-code portion also gave me useful change-management experience. ARM What-If showed that my initial Load Balancer definition could remove the existing NIC-based backend membership, so I stopped before deployment and changed the Bicep design to reference the working Load Balancer and backend pool instead. The final deployment succeeded, and both backend instances remained healthy afterward.

➡️ [View Project](azure/foundations/azure-high-availability-resiliency/README.md)

---

### 🪟 Windows & Enterprise Administration

Built and administered Windows Server workloads in Microsoft Azure, developing practical experience with Windows-based cloud infrastructure, remote administration, PowerShell, networking, security, monitoring, and web services.

**Hands-on work included:**

* Windows Server deployment and administration
* Remote Desktop (RDP) and Windows remote management
* Server Manager and Windows Services
* PowerShell administration
* Windows Defender Firewall
* Event Viewer and troubleshooting
* IIS deployment and validation
* Windows storage and networking
* Secure remote administration with Azure Bastion

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
* Model Context Protocol (MCP)
* Structured outputs
* APIs
* Automation
* Identity
* Agent workflows and orchestration
* Tool authorization and least privilege
* Sandboxed agent execution
* Human approval for high-risk actions
* Agent observability and tool-call auditing
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

### 🤖 8. AI Infrastructure + Security Platform

**Focus:** AI infrastructure + cloud security

Planned capabilities:

* AI workload deployment
* Model serving and inference
* Docker
* Cloud and GPU infrastructure
* Kubernetes where appropriate
* Identity and least privilege
* Private networking
* Secrets management
* AI observability
* Agent observability and audit logging
* Sandboxed agent execution
* AI agent security testing
* Scaling and performance
* AI security controls
* Detection and monitoring

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
* Python for AI
* NumPy
* Pandas
* Machine learning fundamentals
* Training vs inference
* Neural network fundamentals
* PyTorch basics
* Transformers
* Tokenization
* Embeddings
* LLM APIs
* Structured outputs
* Tool / function calling
* Model Context Protocol (MCP)
* Agent orchestration
* Sandboxed agent execution
* Vector databases
* Guardrails

### 🐍 Programming & Automation

* Python
* Bash
* REST APIs
* JSON
* Cloud SDKs
* Python functions and modules
* Basic object-oriented programming
* Virtual environments
* Error handling
* Logging
* Testing and debugging
* Azure SDKs

### 🪟 Windows & Enterprise Administration

* Windows Server
* PowerShell
* Remote Desktop (RDP)
* Server Manager
* Windows Services
* Windows Defender Firewall
* Event Viewer
* IIS
* Windows storage and networking
* Secure remote administration
* Azure Bastion

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
* Human approval and authorization gates
* AI-generated code security validation
* Docker introduced during AI application projects before deeper Kubernetes work
* AI workload deployment
* Model serving and inference
* AI containers
* GPU infrastructure fundamentals
* Kubernetes for AI workloads
* MLOps fundamentals
* Model and application observability
* AI workload scaling
* AI cost and performance optimization

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
* AI application security
* Prompt injection defenses
* RAG security
* AI agent and tool security
* Agent identity and authorization
* Human approval and authorization gates for AI agents
* Sandboxed execution security
* AI agent security testing
* AI data protection
* Model endpoint security
* AI supply-chain security
* AI threat modeling

### 📈 Observability

* Monitoring
* Logging
* Metrics
* Traces
* Dashboards
* Alerts
* Prometheus
* Grafana
* AI agent observability
* Agent tool-call auditing
* Agent activity and security logging

---

# 📁 Portfolio Structure

Each major project will include:

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

Additional technical depth developed throughout this journey:

**Programming & Automation**  
↓  
**AI / ML Foundations**  
↓  
**Docker & Containers**  
↓  
**AI Infrastructure / MLOps**  
↓  
**AI Security**

---

# 📌 Portfolio Status

**Current stage:** Azure Engineering (AZ-104)

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

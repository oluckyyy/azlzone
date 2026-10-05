# 🌐 Azure Landing Zone – Enterprise Hub & Spoke Architecture (Terraform)

A fully documented, enterprise-grade **Azure Landing Zone** aligned with the **Microsoft Cloud Adoption Framework (CAF)**.  
This project implements a complete **governance, security, networking, and automation foundation** for scalable workloads using **Terraform Infrastructure-as-Code**.

---

## 🚀 Features

- **CAF-aligned Management Group hierarchy**
- **Hub & Spoke network topology**
- **Azure Firewall, Bastion, VPN Gateway**
- **Policy-as-Code** (Allowed Locations, Required Tags, HTTPS-only, KV Soft Delete, Defender Plans)
- **Shared platform services** (Log Analytics, Automation, Key Vault, Managed Identities)
- **Remote Terraform backend** with state locking
- **CI/CD Pipelines** for PR validation, plan/apply, destroy
- **Modular Terraform code** by CAF domain (Identity, Management, Connectivity, Policy, Landing Zones)

---

## 📊 Architecture Overview

<details>
  <summary><strong>📌 Click to view the interactive architecture diagram</strong></summary>
  <br>
  <p>
    👉 <a href="https://tlkone.github.io/Azurearchitecturediagram/" target="_blank">
      Open Interactive Azure Architecture Diagram
    </a>
  </p>
</details>

---

## 🏛 Management Group Hierarchy

```text
Tenant Root Group
│
├── Platform (MG)
│   ├── Identity (MG)
│   ├── Management (MG)
│   └── Connectivity (MG)
│
└── Landing Zones (MG)
    ├── Corp (MG)
    └── Sandbox (MG)

🧱 Repository Structure
.
├── .azure-pipelines/
│   ├── pr-validate.yml
│   ├── plan-apply.yml
│   └── destroy.yml
│
├── terraform/
│   ├── main.tf
│   ├── providers.tf
│   ├── backend.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── connectivity/
│   ├── identity/
│   ├── management/
│   ├── policy/
│   └── environments/
│
├── diagrams/
│   └── architecture.png
│
├── docs/
│   ├── architecture.md
│   ├── pipelines.md
│   ├── getting-started.md
│   └── design-decisions.md
│
└── README.md

📥 Getting Started

Full deployment instructions: docs/getting-started.md

Quick Start
git clone https://github.com/oluckyyy/azlzone
cd AzureLandingZoneTF/terraform

az login
az account set --subscription "<suscription_here>"

terraform init -backend-config=backend.tfvars

terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars

🧪 CI/CD Pipelines

Full details: docs/pipelines.md

This repo includes:
PR Validation — fmt, init, validate, plan
Plan / Apply — gated deployment to main
Destroy — tear down the environment cleanly
GitHub Actions version coming soon.

🔐 Security & Governance

This Landing Zone enforces:
Allowed Azure regions
Required costCenter tag
HTTPS-only storage
Defender (DeployIfNotExists)
Key Vault soft delete
Log Analytics integration
RBAC separation across MGs

More details: docs/design-decisions.md

🧩 Terraform Modules

Identity → Key Vault, MI
Management → Log Analytics, Automation
Connectivity → Hub VNet, Firewall, Bastion, VPN
Policy → Built-in + Custom policies
Landing Zones → Corp, Sandbox environments

Modules are designed for reusability, scalability, and multi-environment deployments.

🛠 Tools Used

Terraform v1.x
Azure CLI
AzureRM Provider
Azure DevOps Pipelines
GitHub Pages (for interactive architecture diagram)
VS Code + Git

🧭 Roadmap

GitHub Actions OIDC pipeline
Terraform module registry publishing
Multi-region hub failover
Azure Monitor Workbooks
Conftest/Sentinel policy tests
Auto drift detection (scheduled plans)

📝 License
Licensed under MIT License.

👨‍💻 Author Lucky S. Wilson
Jn. Developer | Data Enginering | DevOps | IaC Automation

⭐ If you find this project useful, please star the repo!

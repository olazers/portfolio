# Azure Key Vault + Managed Identity - Passwordless Secret Access

## Overview

This project focuses on securely accessing Azure Key Vault from a private Azure virtual machine without storing passwords, access keys, or application credentials on the VM.

The main goal was to use a system-assigned managed identity together with Microsoft Entra ID and Azure RBAC, then test whether the permissions worked as expected.

I also wanted to go beyond simply assigning a role in the Azure portal. The access was tested from the VM, including a successful secret read and a denied secret write to confirm that least privilege was actually being enforced.

The project also includes Key Vault network restrictions, Bicep, Log Analytics monitoring, and Azure Policy governance.

**Status:** Completed

---

## Architecture

```text
vm-app
  |
  | System-Assigned Managed Identity
  v
Microsoft Entra ID
  |
  | Azure RBAC
  | Key Vault Secrets User
  v
Azure Key Vault
  |
  +-- SecretGet --> 200 OK
  |
  +-- SecretSet --> 403 Forbidden

Monitoring:
Azure Key Vault
  |
  v
Diagnostic Settings
  |
  v
Log Analytics Workspace

Governance:
Azure Policy
  |
  v
Audit Key Vault RBAC Permission Model
```

---

## Azure Resources

| Resource | Purpose |
|---|---|
| `vm-app` | Private application VM using managed identity |
| `kv-portfolio-lab-1143` | Stores application secrets |
| `vnet-portfolio-lab` | Virtual network |
| `snet-app` | Private application subnet |
| `law-portfolio-lab` | Log Analytics workspace |
| `audit-keyvault-rbac` | Azure Policy assignment auditing the Key Vault RBAC model |

---

## Security Design

The security design includes:

- No Azure credentials stored on the VM
- No passwords or secrets embedded in source code
- System-assigned managed identity for authentication
- Microsoft Entra ID token-based authentication
- Azure RBAC instead of legacy Key Vault access policies
- Least-privilege secret permissions
- Restricted Key Vault network access
- No public IP address on the application VM
- Key Vault audit logging through Azure Monitor
- Azure Policy governance
- Infrastructure represented and validated with Bicep

One design decision was to keep `vm-app` private instead of adding a public IP just to make administration easier. Administrative access was handled through the existing web-tier VM.

---

## 1. Private Application VM

The `vm-app` virtual machine runs on the private application subnet and does not have a public IP address.

The VM security configuration includes:

- Trusted Launch
- Secure Boot
- Virtual TPM (vTPM)

Administrative access is handled through the web-tier VM rather than exposing `vm-app` directly to the Internet.

This allowed the Key Vault work to be added without weakening the network isolation already in place.

---

## 2. Azure Key Vault

A Key Vault named:

```text
kv-portfolio-lab-1143
```

was configured using the Standard tier.

Security settings include:

- Azure RBAC permission model
- Soft delete enabled
- 90-day retention
- Public network access restricted to selected networks
- Application subnet explicitly allowed
- Trusted Microsoft services bypass disabled

The `snet-app` subnet uses the Microsoft Key Vault service endpoint to reach the vault while keeping the Key Vault network restrictions in place.

I chose to allow the application subnet instead of opening the vault to all networks.

![Key Vault network configuration](screenshots/01-key-vault-networking.png)

---

## 3. System-Assigned Managed Identity

A system-assigned managed identity was enabled on `vm-app`.

This gives the VM its own identity in Microsoft Entra ID and allows it to request Azure access tokens without storing application credentials locally.

The application therefore does not need:

- usernames
- passwords
- client secrets
- service principal credentials

This was an important part of the project because I wanted the VM to authenticate to Azure without putting credentials in scripts or configuration files.

![VM managed identity](screenshots/02-vm-managed-identity.png)

---

## 4. Least-Privilege Azure RBAC

The `vm-app` managed identity was assigned:

**Role:** `Key Vault Secrets User`

**Scope:** `kv-portfolio-lab-1143`

The role was assigned at the Key Vault scope instead of the resource group or subscription level.

The goal was simple: the application needed to **read a secret**, but it did not need permission to create, modify, or delete secrets.

Administrative secret management was therefore kept separate from the application's runtime permissions.

The role assignment alone was not treated as proof that least privilege was working. I tested both an allowed operation and a denied operation from the VM.

---

## 5. Passwordless Authentication

From `vm-app`, the Azure Instance Metadata Service was used to request an access token for Azure Key Vault.

The token was stored temporarily in the shell and was not printed or committed to source control.

The managed identity successfully received a Microsoft Entra access token:

```text
token_type: Bearer
access_token_received: True
```

No application password, client secret, or other stored Azure credential was required.

This confirmed that the VM could authenticate using its own managed identity.

---

## 6. Authorized Secret Read Test

A safe test secret named:

```text
app-api-key
```

was created in Key Vault.

The managed identity then attempted to retrieve the secret through the Key Vault REST API.

Result:

```text
HTTP 200
```

The successful request confirmed that:

1. The VM could authenticate using its managed identity
2. Microsoft Entra ID issued an access token
3. Azure RBAC allowed the secret read
4. The network configuration allowed the request to reach Key Vault
5. The secret could be retrieved by the workload

The secret value itself was never included in the repository or documentation.

---

## 7. Least-Privilege Denied Write Test

After confirming that the identity could read the secret, I wanted to make sure it could not do more than necessary.

The same managed identity attempted to create or modify a secret.

Result:

```text
HTTP 403 Forbidden
```

This was the expected result.

The `Key Vault Secrets User` role allowed the application to read the required secret but did not allow it to manage secrets.

For me, the 403 test was just as important as the successful 200 test. A successful read proved that access worked, while the denied write proved that the identity did not have unnecessary permissions.

---

## 8. Infrastructure as Code with Bicep

The Key Vault configuration was also represented using Bicep.

The template uses:

```text
Microsoft.KeyVault/vaults@2026-02-01
```

The Bicep configuration represents:

- Standard Key Vault SKU
- Azure RBAC authorization
- Soft-delete retention
- Restricted public network access
- Default network deny
- Existing application subnet authorization

The template was compiled and validated using Azure CLI.

Before deploying it, I also ran a What-If deployment to check whether the template would make an unexpected change to the existing Key Vault.

The final result showed:

```text
Resource changes: 1 no change
```

That was the result I wanted to see. The Bicep configuration matched the existing Key Vault without trying to change the resource.

The deployment was then completed successfully.

![Successful Bicep deployment](screenshots/03-bicep-deployment-success.png)

The Bicep source is available here:

[`bicep/main.bicep`](bicep/main.bicep)

---

## 9. Key Vault Monitoring with Log Analytics

A Log Analytics workspace named:

```text
law-portfolio-lab
```

was created for monitoring.

A Key Vault diagnostic setting named:

```text
kv-audit-to-loganalytics
```

was configured to send Key Vault audit logs to the workspace.

![Key Vault diagnostic setting](screenshots/04-key-vault-diagnostic-setting.png)

One issue I ran into here was that the logs did not appear immediately after enabling the diagnostic setting.

Instead of assuming the configuration had failed, I checked the diagnostic setting and generated new Key Vault activity while waiting for log collection to start.

Once the logs became available, I could see both the successful and denied operations.

### Successful authorized access

```text
Operation: SecretGet
HTTP Status: 200
Result: OK
```

### Denied unauthorized operation

```text
Operation: SecretSet
HTTP Status: 403
Result: Forbidden
```

![Log Analytics least privilege validation](screenshots/05-log-analytics-least-privilege.png)

There was another useful detail while reviewing the logs. One field could make the denied request look successful even though the REST request had returned HTTP 403.

I checked the other log fields and confirmed the actual result using:

```text
httpStatusCode_d: 403
ResultSignature: Forbidden
```

For the successful request:

```text
httpStatusCode_d: 200
ResultSignature: OK
```

This was a useful troubleshooting lesson. I learned not to depend on a single log field when checking whether an Azure operation was actually allowed or denied.

---

## 10. Azure Policy Governance

Azure Policy was added to check the Key Vault authorization model.

The built-in policy:

```text
Azure Key Vault should use RBAC permission model
```

was assigned at the portfolio resource group scope.

Assignment:

```text
audit-keyvault-rbac
```

Effect:

```text
Audit
```

I used Audit because the goal was to check the configuration and report compliance rather than automatically change the resource.

After Azure Policy completed its evaluation, the Key Vault reported:

```text
Compliance state: Compliant
Overall resource compliance: 100%
Compliant resources: 1
Non-compliant resources: 0
```

![Azure Policy compliance](screenshots/06-azure-policy-compliance.png)

This gave me another way to verify that the Key Vault was using the required Azure RBAC permission model instead of checking the setting only from the Key Vault page.

---

## Validation Summary

| Test | Expected | Result |
|---|---|---|
| Managed identity enabled | Enabled | PASS |
| Managed identity token request | Token received | PASS |
| Secret read | HTTP 200 | PASS |
| Secret write | HTTP 403 | PASS |
| Application VM public IP | None | PASS |
| Key Vault RBAC authorization | Enabled | PASS |
| Key Vault network restriction | Selected network | PASS |
| Bicep validation | Successful | PASS |
| Bicep What-If | No unintended change | PASS |
| Bicep deployment | Successful | PASS |
| Key Vault audit logging | Events received | PASS |
| Authorized read audit | 200 OK | PASS |
| Unauthorized write audit | 403 Forbidden | PASS |
| Azure Policy RBAC audit | Compliant | PASS |

---

## What I Learned

The main lesson from this project was that **authentication and authorization are separate parts of the access process**.

The managed identity answers:

> Who is the workload?

Microsoft Entra ID authenticates that identity.

Azure RBAC answers:

> What is the workload allowed to do?

The successful `SecretGet` and denied `SecretSet` made this much clearer than simply reading about managed identities and RBAC.

I also learned that testing what an identity **cannot do** is important. Seeing `HTTP 200` confirmed that the application could perform its required task, but seeing `HTTP 403` confirmed that the permission stopped where it was supposed to.

The Log Analytics troubleshooting was another useful part of the project. The logs were not immediately available, and when they appeared, I had to look at the correct fields to clearly identify the denied operation. That gave me more practical experience using logs to investigate what Azure was actually doing.

Bicep also changed how I looked at the configuration. Instead of only having resources configured through the portal, I could represent the infrastructure as code and use What-If to check the expected result before deployment.

Finally, Azure Policy showed how the same security requirement can be checked at the governance level instead of depending only on someone manually reviewing each resource.

---

## Security Considerations

No production secrets, credentials, private SSH keys, bearer tokens, access keys, or connection strings are included in this repository.

The test secret contained demonstration data only, but its value was still not published.

Screenshots were reviewed and sanitized before publication to remove account identifiers and other unnecessary environment-specific information.

I also avoided exposing `vm-app` directly to the Internet just to simplify administration. The VM remained private while the Key Vault configuration and access tests were completed.

---

## Cost Considerations

The resources used for this project were kept small and limited to what was needed for testing.

The virtual machines were only required while performing configuration and validation and can be deallocated when not in use to avoid unnecessary compute charges.

The Log Analytics workspace can also generate costs based on data ingestion and retention, so diagnostic logging should be monitored in a larger environment.

Key Vault usage for this lab was minimal because only a small number of secret operations were performed.

---

## Skills Demonstrated

- Azure Key Vault
- Microsoft Entra ID
- Azure Managed Identities
- Azure RBAC
- Least-Privilege Access Control
- Passwordless Authentication
- Azure Virtual Networks
- Service Endpoints
- Azure VM Security
- Trusted Launch
- Bicep
- Azure CLI
- Infrastructure as Code
- Azure Monitor
- Log Analytics
- KQL
- Diagnostic Settings
- Azure Policy
- Cloud Security
- Cloud Governance
- Security Validation
- Troubleshooting

---

## Related Projects

- [Azure Blob Storage + Entra ID + RBAC](../azure-blob-rbac-lab/)
- [Azure Secure Two-Tier Network Architecture](../azure-secure-two-tier-network/)

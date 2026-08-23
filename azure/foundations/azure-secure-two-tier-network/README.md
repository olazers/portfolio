# Azure Secure Two-Tier Network Architecture

## Project Overview

This project demonstrates the deployment of a secure two-tier network architecture in Microsoft Azure.

I built a segmented Azure environment consisting of a public-facing web server and a private application server. The two systems were placed in separate subnets and protected with Network Security Groups (NSGs) to control how traffic enters the environment and moves between the two tiers.

The final design allows users to reach the web server from the Internet while the application server remains private and accepts application traffic from the web tier.

**Status:** Completed

---

## Architecture

The environment includes:

| Component | Configuration |
|---|---|
| Resource Group | `rg-portfolio-foundations` |
| Virtual Network | `vnet-portfolio-lab` |
| Web Subnet | `snet-web` - `10.0.1.0/24` |
| Application Subnet | `snet-app` - `10.0.2.0/24` |
| Web VM | `vm-web` |
| Application VM | `vm-app` |
| Web NSG | `nsg-web` |
| Application NSG | `nsg-app` |
| Web Service Port | TCP `8080` |
| Application Service Port | TCP `8080` |
| Application VM Public IP | None |

### Traffic Flow

```text
Internet
   |
   | TCP 8080
   v
+------------------+
|      vm-web      |
|   Web Subnet     |
|   10.0.1.0/24    |
+------------------+
         |
         | TCP 8080
         v
+------------------+
|      vm-app      |
|   App Subnet     |
|   10.0.2.0/24    |
|   Private Tier   |
+------------------+
```

Azure Resource Visualizer provides an overview of the deployed resources and their relationships.

![Azure Resource Visualizer](screenshots/06-resource-visualizer.png)

---

## 1. Virtual Network Deployment

I created the Azure virtual network inside the `rg-portfolio-foundations` resource group.

The successful deployment confirmed that the virtual network infrastructure was provisioned correctly before the remaining network components were configured.

![VNet Deployment Success](screenshots/01-vnet-deployment-success.png)

---

## 2. Network Segmentation

I divided the virtual network into two subnets:

- `snet-web` - `10.0.1.0/24`
- `snet-app` - `10.0.2.0/24`

The web and application workloads were placed on separate network segments rather than using a single subnet.

Each subnet was also associated with its own Network Security Group:

- `snet-web` → `nsg-web`
- `snet-app` → `nsg-app`

This allows security rules to be applied independently to each tier.

![VNet Subnets and NSG Associations](screenshots/02-vnet-subnets-nsg-associations.png)

---

## 3. Web Tier Security

The web tier is protected by `nsg-web`.

An inbound rule allows TCP port `8080`, which is used by the Nginx web service in this lab.

This allows the web service to be reached externally while other inbound traffic remains subject to the NSG rules.

![Web NSG Inbound Rules](screenshots/03-nsg-web-final-inbound-rules.png)

---

## 4. Application Tier Security

The application tier is protected separately by `nsg-app`.

Instead of exposing the application service directly to the Internet, I configured an inbound rule named:

`Allow-Web-To-App-8080`

The rule permits:

- **Source:** `10.0.1.0/24`
- **Source:** Web subnet
- **Destination port:** `8080`
- **Protocol:** TCP
- **Action:** Allow
- **Priority:** 100

This restricts the application service so that TCP port `8080` is permitted from the web subnet rather than being directly exposed to the public Internet.

![Web-to-App NSG Rule](screenshots/04-nsg-app-web-to-app-8080.png)

The completed `nsg-app` inbound configuration confirms that the custom web-to-application rule is active.

![Application NSG Inbound Rules](screenshots/05-nsg-app-inbound-rules.png)

---

## 5. Public Web Server Validation

I installed and configured Nginx on `vm-web` and tested the service through the web VM's public IP address on TCP port `8080`.

The Nginx welcome page loaded successfully in the browser, confirming that:

- The web VM was running correctly
- Nginx was responding
- TCP port `8080` was reachable
- The web-tier NSG configuration permitted the required traffic

![Nginx Public Web Test](screenshots/07-nginx-public-web-test.png)

---

## 6. Web-to-Application Connectivity Validation

After validating public access to the web tier, I tested communication between the two network tiers.

From `vm-web`, I sent an HTTP request directly to the private IP address of `vm-app` on TCP port `8080`:

```bash
curl http://10.0.2.4:8080
```

The application server returned:

```text
Hello from vm-app
```

This confirmed successful communication from the web subnet to the application server through the private Azure network.

It also demonstrated that the application could be reached internally without requiring a public IP address.

![Web-to-App Connectivity Validation](screenshots/08-web-to-app-8080-validation.png)

---

## 7. Cost Management

After completing the deployment and connectivity tests, I stopped and deallocated both virtual machines.

Deallocating the VMs prevents unnecessary compute charges while keeping the Azure resources available for future use.

![Virtual Machines Deallocated](screenshots/09-vms-deallocated.png)

---

## Security Design

This project demonstrates several important cloud networking and security practices:

- Segmentation of web and application workloads into separate subnets
- Separate Network Security Groups for each network tier
- Controlled inbound access using NSG rules
- Application traffic restricted to the web subnet
- No public IP address required for the application VM
- Private communication between Azure workloads
- Only required service ports opened for the lab
- SSH used for Linux administration and testing
- Virtual machines deallocated after testing to reduce unnecessary cost

---

## Validation Results

| Test | Result |
|---|---|
| Virtual network deployment | Successful |
| Web and application subnet creation | Successful |
| NSG association with both subnets | Successful |
| Public access to Nginx on TCP 8080 | Successful |
| Web-to-app communication on TCP 8080 | Successful |
| Application response from private IP | `Hello from vm-app` |
| Application VM directly assigned a public IP | No |
| VMs deallocated after testing | Completed |

---

## Skills Demonstrated

- Microsoft Azure
- Azure Virtual Networks
- Azure Subnets
- Network Security Groups (NSGs)
- Linux Virtual Machines
- Network Segmentation
- TCP/IP Networking
- CIDR Addressing
- SSH Administration
- Nginx
- Private IP Communication
- Security Rule Configuration
- Connectivity Testing
- Azure Resource Management
- Cloud Cost Management

---

## Project Result

The project successfully demonstrates a functional two-tier Azure environment with network segmentation and controlled communication between workloads.

The public-facing web tier can receive external traffic, while the application tier remains private. The web server successfully communicates with the application server over the Azure virtual network using the application's private IP address.

This lab strengthened my practical understanding of Azure networking, subnet design, NSGs, Linux virtual machines, private communication, connectivity testing, and basic cloud security architecture.

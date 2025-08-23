# O-Hunter Enhanced v2.0 🛡️
**Professional Web Vulnerability Scanner — Community Edition**

[![Python](https://img.shields.io/badge/Python-3.8%2B-informational)](#)
[![React](https://img.shields.io/badge/React-18%2B-informational)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](#license)
[![Status](https://img.shields.io/badge/Release-v2.0-blue)](#)
[![Made-with-love](https://img.shields.io/badge/Made%20by-Eng.%20Omar%20Hany-%23e91e63)](#)

---

## 🧭 Overview
**O-Hunter Enhanced** is a professional, extensible **web security scanner** built for students, security engineers, and bug bounty hunters.  
It includes a CLI and a modern web-based GUI, supports a **plugin system**, and generates reports in **HTML, JSON, CSV, and PDF** formats.

---

## 🚀 What’s New in v2.0
- **Advanced checks (11+ categories)**: XSS, SQLi, SSRF, RCE, XXE, Open Redirect, HTTP Request Smuggling, Insecure Deserialization, Directory Enumeration, Weak Credentials, Security Headers.
- **Modern UI**: Dark mode, interactive dashboard, real-time charts.
- **Performance**: Asynchronous scanning, multithreading, modular plugins.
- **Integrations**: OWASP ZAP API, Have I Been Pwned, Censys API.
- **Enhanced reporting**: HTML, JSON, CSV, and PDF exports.
- **SEO-ready documentation** and structured data for better search visibility.

---

## 🧪 Supported Scan Types
| Category | Description | Severity |
|---|---|---|
| XSS | Cross-Site Scripting | High |
| SQLi | SQL Injection | Critical |
| SSRF | Server-Side Request Forgery | High |
| RCE | Remote Code Execution | Critical |
| XXE | XML External Entity | High |
| Open Redirect | Unvalidated Redirects | Medium |
| HTTP Request Smuggling | Request desync attacks | High |
| Insecure Deserialization | Unsafe object deserialization | High |
| Directory Enumeration | Sensitive directories/files | Medium |
| Weak Credentials | Default/weak passwords | Medium |
| Security Headers | Missing/weak security headers | Low–Medium |

---

## 🧰 Requirements
- **Python 3.8+**
- **Node.js 16+** with **npm** or **yarn**
- **Masscan** *(optional for fast port scanning)*
- **Nmap** *(optional for service detection)*

### Install extra tools
**Ubuntu/Debian**
```bash
sudo apt-get update
sudo apt-get install masscan nmap
```

**macOS (Homebrew)**
```bash
brew install masscan nmap
```

**Windows**
Download and install Masscan and Nmap from their official sites.

---

## ⚙️ Installation
### 1) Install Python dependencies
```bash
pip install -r requirements.txt
```

### 2) Install Frontend dependencies
```bash
cd gui/ohunter-ui
npm install --legacy-peer-deps
```

---

## 🖥️ CLI Usage
**Basic scan**
```bash
python cli.py --target https://example.com
```

**Scan multiple categories**
```bash
python cli.py --target https://example.com --all
# or
python cli.py --target https://example.com --xss --sqli --ssrf
```

**Async + plugins**
```bash
python cli.py --target https://example.com --async --plugins
```

**Network scans (requires tools)**
```bash
python cli.py --target 192.168.1.1 --masscan --nmap
```

**Content & weak creds checks**
```bash
python cli.py --target https://example.com --dir-enum --weak-creds
```

> Use `--output json|html|csv|pdf` to set the report format.  
> Each scan creates a report file named `<domain>_scan.<ext>`.

---

## 🌐 Web GUI
Start the backend:
```bash
cd core
python app.py
```

Run the frontend:
```bash
cd gui/ohunter-ui
npm run dev
```
Open **http://localhost:5173** to access the dashboard.

---

## 🔌 Plugin System
Create a custom plugin:
```python
# plugins/example_plugin.py
from plugins.base_plugin import BasePlugin

class ExamplePlugin(BasePlugin):
    def __init__(self):
        super().__init__()
        self.name = "Example Scanner"
        self.description = "Example vulnerability scanner"
        self.category = "Custom"

    def scan(self, target_url, params=None):
        findings = []
        # Add scanning logic here
        return findings
```

Run a specific plugin:
```bash
python cli.py --target https://example.com --plugin ExamplePlugin
```

---

## 🔧 Configuration
Example API keys:
```python
# config.py
API_KEYS = {
    "haveibeenpwned": "your-api-key",
    "censys_id": "your-censys-id",
    "censys_secret": "your-censys-secret",
    "zap_api_key": "your-zap-key"
}
```
The reports directory and default output format can also be configured.

---

## 📊 Report Formats
**Example JSON:**
```json
{
  "scan_info": {
    "target_url": "https://example.com",
    "scan_type": "comprehensive",
    "timestamp": "2025-08-18T15:30:00Z",
    "total_findings": 5
  },
  "findings": [
    {
      "vulnerability": "Missing X-Content-Type-Options header",
      "severity": "Low",
      "category": "Security Headers",
      "evidence": "Header not found in response",
      "remediation": "Add X-Content-Type-Options: nosniff header",
      "cwe": "CWE-16",
      "owasp": "A05:2021"
    }
  ]
}
```

---

## 🤝 Contributing
1. Fork the repo.
2. Create a feature branch: `git checkout -b feature/FeatureName`
3. Commit changes: `git commit -m "Add new feature"`
4. Push to branch: `git push origin feature/FeatureName`
5. Open a Pull Request.

For questions, use **GitHub Discussions**.  
For issues, use **GitHub Issues**.

---

## 🗺️ Roadmap
**v2.1 (Soon):**
- GraphQL scanning
- Burp Suite integration
- REST API scanning
- Performance tuning

**v3.0 (Future):**
- AI-assisted scanning
- CI/CD integration
- Container scanning
- Comparative baselines

---

## 📝 License
Released under the **MIT License**. See [`LICENSE`](LICENSE).

---

## 📬 Contact & Support
- **Issues:** https://github.com/OmarHany-sudo/O-Hunter1/issues
- **Discussions:** https://github.com/OmarHany-sudo/O-Hunter1/discussions
- **Email:** omar55shalaby@gmail.com

**Maintainer:** Eng. **Omar Hany**  
**Release:** v2.0 — **August 2025**


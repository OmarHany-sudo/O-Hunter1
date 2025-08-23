# O‑Hunter Enhanced v2.0 🛡️
**Professional Web Vulnerability Scanner — Community Edition**

[![Python](https://img.shields.io/badge/Python-3.8%2B-informational)](#)
[![React](https://img.shields.io/badge/React-18%2B-informational)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](#license)
[![Status](https://img.shields.io/badge/Release-v2.0-blue)](#)
[![Made-with-love](https://img.shields.io/badge/Made%20by-Eng.%20Omar%20Hany-%23e91e63)](#)

---

## 🧭 Overview | نظرة عامة
**O‑Hunter Enhanced** is a professional, extensible **web security scanner** built for students, security engineers, and bug hunters.  
It ships with a CLI and a modern web GUI, supports **plugin-based** scans, and produces **HTML / JSON / CSV / PDF** reports.

> 🇸🇦 **عربي مختصر:**  
> O‑Hunter Enhanced أداة احترافية لفحص ثغرات مواقع الويب، بواجهة سطر أوامر وواجهة ويب حديثة، مع نظام إضافات (Plugins) وتقارير متعددة الصيغ (HTML / JSON / CSV / PDF).

---

## 🚀 What’s New in v2.0 | الجديد في الإصدار 2.0
- **Advanced checks (11+ categories)**: XSS, SQLi, SSRF, RCE, XXE, Open Redirect, HTTP Request Smuggling, Insecure Deserialization, Directory Enumeration, Weak Credentials, Security Headers.
- **Improved UI**: Dark mode, interactive dashboard, real-time charts.
- **Performance**: Async scanning + multithreading, modular plugin system, custom plugins.
- **Integrations**: OWASP ZAP API, Have I Been Pwned, Censys Free API.
- **Reports**: Enhanced HTML & JSON, plus CSV and PDF exports.
- **SEO-ready** landing pages and structured data (JSON‑LD) for docs.

---

## 🧪 Supported Scan Types | أنواع الفحوصات المدعومة
| Category | Description | Severity |
|---|---|---|
| XSS | Cross‑Site Scripting | High |
| SQLi | SQL Injection | Critical |
| SSRF | Server‑Side Request Forgery | High |
| RCE | Remote Code Execution | Critical |
| XXE | XML External Entity | High |
| Open Redirect | Unvalidated Redirects | Medium |
| HTTP Request Smuggling | Desync attacks | High |
| Insecure Deserialization | Unsafe object deserialization | High |
| Directory Enumeration | Sensitive paths/files | Medium |
| Weak Credentials | Default/weak passwords | Medium |
| Security Headers | Missing/weak headers | Low–Medium |

> يمكن توسعة القائمة بإضافات Plugins مخصّصة.

---

## 🧰 Requirements | المتطلبات
- **Python 3.8+**
- **Node.js 16+** and **npm** or **yarn**
- **Masscan** *(optional for fast port scans)*
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
- Download Masscan & Nmap from their official websites and add to PATH.

---

## ⚙️ Installation | التثبيت
### 1) Python deps
```bash
pip install -r requirements.txt
```

### 2) Frontend deps
```bash
cd gui/ohunter-ui
npm install --legacy-peer-deps
```

---

## 🖥️ Usage — CLI | الاستخدام — سطر الأوامر
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

**Content & weak creds**
```bash
python cli.py --target https://example.com --dir-enum --weak-creds
```

> **Tips**  
> - Use `--output json|html|csv|pdf` to pick the report format.  
> - Each scan writes a report named like: `<domain>_scan.<ext>` inside the configured reports folder.

---

## 🌐 Usage — GUI | الاستخدام — واجهة الويب
**Backend (Flask)**
```bash
cd core
python app.py
```

**Frontend (React/Vite)**
```bash
cd gui/ohunter-ui
npm run dev
```
Open the app at **http://localhost:5173** (or the port shown in the terminal).  
واجهة الويب تدعم **الوضع الليلي** ولوحة معلومات تفاعلية.

---

## 🔌 Plugin System | نظام الإضافات
Create a custom plugin by subclassing the base:
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
        # Your scanning logic here
        return findings
```

Run a specific plugin:
```bash
python cli.py --target https://example.com --plugin ExamplePlugin
```

### Plugin skeleton helper
```bash
mkdir -p plugins/my_plugin
touch plugins/my_plugin/__init__.py plugins/my_plugin/scanner.py
```

---

## 🔧 Configuration | الإعدادات
**API keys (example):**
```python
# config.py
API_KEYS = {
    "haveibeenpwned": "your-api-key",
    "censys_id": "your-censys-id",
    "censys_secret": "your-censys-secret",
    "zap_api_key": "your-zap-key"
}
```

**Reports directory & output format** can be configured in `config.py`.  
التقارير تدعم **JSON / HTML / CSV / PDF**.

---

## 📊 Report Formats | تنسيقات التقارير
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

**HTML / PDF** reports are styled for readability and can be shared with stakeholders.  
**CSV** is convenient for spreadsheets and quick triage.

---

## 🧭 Docs & SEO | التوثيق وتهيئة البحث
- The repo includes **guide pages** per vulnerability: `/xss`, `/sql-injection`, `/ssrf`, `/rce`, `/xxe`, `/open-redirect`, etc.  
- Structured data via **JSON‑LD** helps search engines parse docs.  
- Social media cards are provided for better sharing previews.

---

## 🤝 Contributing | المساهمة
1. Fork the repo
2. Create a feature branch: `git checkout -b feature/AmazingFeature`
3. Commit changes: `git commit -m "Add some AmazingFeature"`
4. Push the branch: `git push origin feature/AmazingFeature`
5. Open a Pull Request

**Discussions & questions:** use **GitHub Discussions**.  
**Bug reports & feature requests:** open **GitHub Issues**.

---

## 🗺️ Roadmap | خارطة الطريق
**v2.1 (Soon):**
- GraphQL scanning
- Burp Suite integration
- REST API scanning
- Performance tuning

**v3.0 (Future):**
- AI‑assisted scanning
- CI/CD integration
- Container scanning
- Comparative baselines

---

## 📝 License | الترخيص
This project is released under the **MIT License**. See [`LICENSE`](LICENSE).

---

## 🙏 Acknowledgments | الشكر والتقدير
- **OWASP** guidelines and community
- **React** & **Flask** communities
- Security researchers and contributors

---

## 📬 Contact & Support | التواصل والدعم
- **Issues:** https://github.com/OmarHany-sudo/O-Hunter1/issues
- **Discussions:** https://github.com/OmarHany-sudo/O-Hunter1/discussions
- **Email:** omar55shalaby@gmail.com

**Maintainer:** Eng. **Omar Hany**  
**Release:** v2.0 — **August 2025**

---

> إذا أردت نسخة عربية كاملة من المستند، أخبرني وسأوفر README‑ar.md.

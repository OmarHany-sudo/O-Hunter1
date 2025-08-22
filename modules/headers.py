# modules/headers.py
import requests

class HeadersChecker:
    def __init__(self):
        self.findings = []

    def check(self, url):
        try:
            response = requests.get(url, timeout=10)
            headers = response.headers

            # Security headers المهمة
            required_headers = [
                "Content-Security-Policy",
                "Strict-Transport-Security",
                "X-Content-Type-Options",
                "X-Frame-Options",
                "X-XSS-Protection"
            ]

            for h in required_headers:
                if h not in headers:
                    self.findings.append({
                        "vulnerability": f"Missing security header: {h}",
                        "severity": "Medium",
                        "evidence": f"{h} header not set",
                        "remediation": f"Add the {h} header to improve security."
                    })

        except Exception as e:
            self.findings.append({
                "vulnerability": "Headers Check Failed",
                "severity": "Low",
                "evidence": str(e),
                "remediation": "Verify the target URL is accessible."
            })

        return self.findings

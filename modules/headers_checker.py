import requests

class HeadersChecker:
    def __init__(self):
        self.findings = []

    def check_headers(self, target):
        print(f"🔎 Checking security headers for {target}")
        try:
            response = requests.get(target, timeout=5)
            headers = response.headers

            # أهم الهيدرز اللي لازم تكون موجودة
            required_headers = [
                "Content-Security-Policy",
                "Strict-Transport-Security",
                "X-Content-Type-Options",
                "X-Frame-Options",
                "Referrer-Policy",
                "Permissions-Policy"
            ]

            for header in required_headers:
                if header not in headers:
                    self.findings.append({
                        'vulnerability': 'Missing Security Header',
                        'severity': 'Low',
                        'evidence': f'{header} not set on {target}',
                        'remediation': f'Configure {header} header to improve security.'
                    })

            print("✅ Headers check complete.")
        except Exception as e:
            self.findings.append({
                'vulnerability': 'Headers Check Error',
                'severity': 'Low',
                'evidence': f"Error checking headers: {e}",
                'remediation': 'Check target URL accessibility'
            })

    def get_findings(self):
        return self.findings

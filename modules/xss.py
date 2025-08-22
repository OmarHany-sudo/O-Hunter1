import requests

class XSSChecker:
    def __init__(self):
        self.findings = []
        self.payloads = [
            '<script>alert(1)</script>',
            '" onmouseover="alert(1)',
            "'><img src=x onerror=alert(1)>"
        ]

    def check(self, target_url, param_name):
        print(f"Checking XSS for {target_url} with parameter {param_name}")
        for payload in self.payloads:
            test_url = f"{target_url}?{param_name}={payload}"
            try:
                response = requests.get(test_url, timeout=10)
                if payload in response.text:
                    self.findings.append({
                        'vulnerability': 'Potential XSS',
                        'severity': 'High',
                        'evidence': f'Payload {payload} reflected in response at {test_url}',
                        'remediation': 'Sanitize and encode user input before rendering.'
                    })
                    return
            except requests.exceptions.RequestException as e:
                print(f"Error checking XSS for {test_url}: {e}")

    def get_findings(self):
        return self.findings


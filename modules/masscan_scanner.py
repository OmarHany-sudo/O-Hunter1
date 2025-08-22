import masscan

class MasscanScanner:
    def __init__(self):
        self.findings = []
        self.masscan = masscan.PortScanner()

    def scan_ports(self, target_ip, ports="1-1000", arguments="--rate 1000"):
        print(f"Starting Masscan port scan on {target_ip} for ports {ports}")
        try:
            # Run masscan
            self.masscan.scan(target_ip, ports, arguments=arguments)

            # Parse results
            for host in self.masscan.all_hosts:
                for proto in self.masscan[host].keys():
                    for port in self.masscan[host][proto].keys():
                        self.findings.append({
                            'vulnerability': 'Open Port Detected',
                            'severity': 'Informational',
                            'evidence': f'Port {port}/{proto} is open on {host}',
                            'remediation': 'Review necessity of open ports and apply appropriate firewall rules. Close unnecessary ports.'
                        })
                        print(f"Open port found: {host}:{port}/{proto}")

            print("Masscan port scan complete.")
        except Exception as e:
            print(f"Error running Masscan: {e}")

    def get_findings(self):
        return self.findings

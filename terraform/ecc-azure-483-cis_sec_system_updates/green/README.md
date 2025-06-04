We are unable to deploy the green state (compliant) for this rule because:
    - Defender for Cloud uses internal telemetry (e.g., from Windows Update, WSUS, or Linux update sources) to determine compliance.
    - Terraform cannot verify or enforce whether a VM is fully patched.
    - There’s no documented API or Terraform resource to programmatically confirm a "fully updated" state during deployment.

As a result, this rule cannot be reliably tested or enforced through red/green infrastructure definitions.
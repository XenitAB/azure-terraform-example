<#
.Synopsis
    Script to use Terraform locally and in Azure DevOps
.DESCRIPTION
    Build:
        Invoke-PipelineTask.ps1 -build
    Deploy:
        Invoke-PipelineTask.ps1 -deploy
.NOTES
    Name: Invoke-PipelineTask.ps1
    Author: Simon Gottschlag
    Date Created: 2019-11-24
    Version History:
        2019-11-24 - Simon Gottschlag
            Initial Creation


    Xenit AB
#>

[cmdletbinding(DefaultParameterSetName = 'build')]
Param(
    [Parameter(Mandatory = $true, ParameterSetName = 'build')]
    [switch]$build,
    [Parameter(Mandatory = $true, ParameterSetName = 'deploy')]
    [switch]$deploy,
    [Parameter(Mandatory = $false, ParameterSetName = 'build')]
    [Parameter(Mandatory = $false, ParameterSetName = 'deploy')]
    [switch]$azureDevOps,
    [string]$tfVersion = "0.12.16",
    [string]$tfPath = "$($PSScriptRoot)/../terraform/",
    [string]$environmentShort = "dev"
)

Begin {
    $ErrorActionPreference = "Stop"

    # Function to retrun error code correctly from binaries
    function Invoke-Call {
        param (
            [scriptblock]$ScriptBlock,
            [string]$ErrorAction = $ErrorActionPreference,
            [switch]$SilentNoExit        
        )
        if ($SilentNoExit) {
            & @ScriptBlock 2>$null
        } else {
            & @ScriptBlock

            if (($lastexitcode -ne 0) -and $ErrorAction -eq "Stop") {
                exit $lastexitcode
            }
        }
        

    }

    function Log-Message {
        Param(
            [string]$message,
            [switch]$header
        )

        if ($header) {
            Write-Output ""
            Write-Output "=============================================================================="
        } else {
            Write-Output ""
            Write-Output "---"
        }
        Write-Output $message
        if ($header) {
            Write-Output "=============================================================================="
            Write-Output ""
        } else {
            Write-Output "---"
            Write-Output ""
        }
    }
}
Process {
    Set-Location -Path $tfPath -ErrorAction Stop
    $tfStateKey = "$($environmentShort).terraform.tfstate"
    
    if ($azureDevOps) {
        Log-Message -message "INFO: Running Azure DevOps specific configuration"
        # Download and extract Terraform
        Invoke-WebRequest -Uri "https://releases.hashicorp.com/terraform/$($tfVersion)/terraform_$($tfVersion)_linux_amd64.zip" -OutFile "/tmp/terraform_$($tfVersion)_linux_amd64.zip"
        Expand-Archive -Force -Path "/tmp/terraform_$($tfVersion)_linux_amd64.zip" -DestinationPath "/tmp"
        $tfBin = "/tmp/terraform"
        $chmodBin = $(Get-Command chmod -ErrorAction Stop)
        Invoke-Call ([ScriptBlock]::Create("$chmodBin +x $tfBin"))
        Log-Message -message "INFO: Using Terraform version $($tfVersion) from $($tfBin)"

        # Configure environment variables for Terraform
        $azBin = $(Get-Command az -ErrorAction Stop)
        $Subscriptions = Invoke-Call ([ScriptBlock]::Create("$azBin account list --output json")) | ConvertFrom-Json
        foreach ($Subscription in $Subscriptions) {
            if ($Subscription.isDefault) {
                $ENV:ARM_SUBSCRIPTION_ID = $Subscription.id
            }
        }
        $ENV:ARM_CLIENT_ID = $ENV:servicePrincipalId
        $ENV:ARM_CLIENT_SECRET = $ENV:servicePrincipalKey
        $ENV:ARM_TENANT_ID = $ENV:tenantId
    } else {
        try {
            $tfBin = $(Get-Command terraform -ErrorAction Stop)
        } catch {
            Write-Error "Terraform isn't installed"
        }
    }

    switch ($PSCmdlet.ParameterSetName) {
        'build' {
            Log-Message -message "START: Build" -header
            try {
                Log-Message -message "START: terraform init"
                Invoke-Call ([ScriptBlock]::Create("$tfBin init -input=false -backend-config `"key=$($tfStateKey)`""))
                try {
                    Invoke-Call ([ScriptBlock]::Create("$tfBin workspace new $($environmentShort)")) -SilentNoExit
                    Log-Message -message "INFO: terraform workspace $($environmentShort) created"
                } catch {
                    Log-Message -message "INFO: terraform workspace $($environmentShort) already exists"
                }
                Log-Message -message "INFO: terraform workspace $($environmentShort) selected"
                Invoke-Call ([ScriptBlock]::Create("$tfBin workspace select $($environmentShort)"))
                Log-Message -message "END: terraform init"

                Log-Message -message "START: terraform plan"
                Invoke-Call ([ScriptBlock]::Create("$tfBin plan -input=false -var-file=`"variables/$($environmentShort).tfvars`""))
                Log-Message -message "END: terraform plan"

                Log-Message -message "START: terraform validate"
                Invoke-Call ([ScriptBlock]::Create("$tfBin validate"))
                Log-Message -message "END: terraform validate"
            } catch {
                $ErrorMessage = $_.Exception.Message
                $FailedItem = $_.Exception.ItemName
                Write-Error "Message: $ErrorMessage`r`nItem: $FailedItem"
                exit 1
            }
            Log-Message -message "END: Build" -header
        }
        'deploy' {
            Log-Message -message "START: Deploy" -header
            try {
                Log-Message -message "START: terraform init"
                Invoke-Call ([ScriptBlock]::Create("$tfBin init -input=false -backend-config `"key=$($tfStateKey)`""))
                try {
                    Invoke-Call ([ScriptBlock]::Create("$tfBin workspace new $($environmentShort)")) -SilentNoExit
                    Log-Message -message "INFO: terraform workspace $($environmentShort) created"
                } catch {
                    Log-Message -message "INFO: terraform workspace $($environmentShort) already exists"
                }
                Log-Message -message "INFO: terraform workspace $($environmentShort) selected"
                Invoke-Call ([ScriptBlock]::Create("$tfBin workspace select $($environmentShort)"))
                Log-Message -message "END: terraform init"

                Log-Message -message "START: terraform apply"
                Invoke-Call ([ScriptBlock]::Create("$tfBin apply -input=false -auto-approve -var-file=`"variables/$($environmentShort).tfvars`""))
                Log-Message -message "END: terraform init"
            } catch {
                $ErrorMessage = $_.Exception.Message
                $FailedItem = $_.Exception.ItemName
                Write-Error "Message: $ErrorMessage`r`nItem: $FailedItem"
                exit 1
            }
            Log-Message -message "END: Deploy" -header
        }
        default {
            Write-Error "No options chosen."
            exit 1
        }
    }
}
End {
    
}
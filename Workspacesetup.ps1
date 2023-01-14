param (
    [string]$bicepProjects = "$env:USERPROFILE\BicepProjects",
    [string]$vscodeVersion = "1.57.1",
    [string]$azureCLIVersion = "2.15.1"
)

$report = @()

# Check Visual Studio Code version
$installedVSCodeVersion = (code --version).Split(".")[0]
if($installedVSCodeVersion -lt $vscodeVersion) {
    Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?LinkID=760868" -OutFile "$env:TEMP\vscode-setup.exe"
    Start-Process "$env:TEMP\vscode-setup.exe" -ArgumentList '/quiet' -Wait
    $report += "Visual Studio Code has been installed"
} else {
    $report += "Visual Studio Code is already installed"
}

# Check Azure CLI version
$installedAzureCLIVersion = (az --version).Split(" ")[-2]
if($installedAzureCLIVersion -lt $azureCLIVersion) {
    Invoke-WebRequest -Uri "https://aka.ms/installazurecliwindows" -OutFile "$env:TEMP\AzCLI.msi"
    Start-Process msiexec.exe -ArgumentList '/i', "$env:TEMP\AzCLI.msi", '/quiet' -Wait
    $report += "Azure CLI has been installed"
} else {
    $report += "Azure CLI is already installed"
}

# Check for Bicep extension for Visual Studio Code
if (!(code --list-extensions | Select-String "ms-azuretools.vscode-azurebicep")) {
    code --install-extension ms-azuretools.vscode-azurebicep
    $report += "Bicep extension for Visual Studio Code has been installed"
} else {
    $report += "Bicep extension for Visual Studio Code is already installed"
}

# Check for Azure Bicep CLI
if (!(az extension list | Select-String "bicep")) {
    az extension add --name bicep
    $report += "Azure Bicep CLI has been installed"
} else {
    $report += "Azure Bicep CLI is already installed"
}

# Install Azure ARM Tools extension for Visual Studio Code
if (!(code --list-extensions | Select-String "msazurermtools.azurerm-vscode-tools")) {
    code --install-extension msazurermtools.azurerm-vscode-tools
    $report += "Azure ARM Tools extension for Visual Studio Code has been installed"
} else {
    $report += "Azure ARM Tools extension for Visual Studio Code is already installed"
}

# Create a new folder for your Bicep projects
New-Item -ItemType Directory -Path "$bicepProjects\modules"
New-Item -ItemType Directory -Path "$bicepProjects\variables"
New-Item -ItemType Directory -Path "$bicepProjects\outputs"
New-Item -ItemType Directory -Path "$bicepProjects\parameters"
New-Item -ItemType File -Path "$bicepProjects\main.bicep" -Force
New-Item -ItemType File -Path "$bicepProjects\README.md" -Force

# Open Visual Studio Code in the Bicep projects folder
code $bicepProjects

# Start Visual Studio Code
Start-Process "code"

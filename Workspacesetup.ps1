param (
    [string]$bicepProjects = "$env:USERPROFILE\BicepProjects"
)

# Install Visual Studio Code
Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?LinkID=760868" -OutFile "$env:TEMP\vscode-setup.exe"
Start-Process "$env:TEMP\vscode-setup.exe" -ArgumentList '/quiet' -Wait

# Install Bicep extension for Visual Studio Code
code --install-extension ms-azuretools.vscode-azurebicep

# Install Azure CLI
Invoke-WebRequest -Uri "https://aka.ms/installazurecliwindows" -OutFile "$env:TEMP\AzCLI.msi"
Start-Process msiexec.exe -ArgumentList '/i', "$env:TEMP\AzCLI.msi", '/quiet' -Wait

# Install Azure Bicep CLI
az extension add --name bicep

# Install Azure ARM Tools extension for Visual Studio Code
code --install-extension msazurermtools.azurerm-vscode-tools

# Create a new folder for your Bicep projects
New-Item -ItemType Directory -Path $bicepProjects -Force

# Create the basic file structure
New-Item -ItemType Directory -Path "$bicepProjects\modules"
New-Item -ItemType Directory -Path "$bicepProjects\variables"
New-Item -ItemType Directory -Path "$bicepProjects\outputs"
New-Item -ItemType Directory -Path "$bicepProjects\parameters"
New-Item -ItemType File -Path "$bicepProjects\main.bicep" -Force
New-Item -ItemType File -Path "$bicepProjects\README.md" -Force

# Open Visual Studio Code in the Bicep projects folder
code $bicepProjects

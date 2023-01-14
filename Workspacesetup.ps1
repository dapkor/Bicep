param (
    [string]$bicepProjects = "$env:USERPROFILE\BicepProjects"
)

$requiredApps = @{
    "Visual Studio Code" = @{
        "Windows" = @{
            "installer" = "https://go.microsoft.com/fwlink/?LinkID=760868";
            "installerCommand" = "Start-Process"
        };
        "Linux" = @{
            "installer" = "code";
            "installerCommand" = "apt-get"
        }
    };
    "Azure CLI" = @{
        "Windows" = @{
            "installer" = "https://aka.ms/installazurecliwindows";
            "installerCommand" = "Start-Process"
        };
        "Linux" = @{
            "installer" = "az";
            "installerCommand" = "apt-get"
        }
    };
    "Bicep extension for Visual Studio Code" = @{
        "Windows" = @{
            "installer" = "ms-azuretools.vscode-azurebicep";
            "installerCommand" = "code --install-extension"
        };
        "Linux" = @{
            "installer" = "ms-azuretools.vscode-azurebicep";
            "installerCommand" = "code --install-extension"
        }
    };
    "Azure Bicep CLI" = @{
        "Windows" = @{
            "installer" = "bicep";
            "installerCommand" = "az extension add"
        };
        "Linux" = @{
            "installer" = "bicep";
            "installerCommand" = "az extension add"
        }
    };
    "Azure ARM Tools extension for Visual Studio Code" = @{
        "Windows" = @{
            "installer" = "msazurermtools.azurerm-vscode-tools";
            "installerCommand" = "code --install-extension"
        };
        "Linux" = @{
            "installer" = "msazurermtools.azurerm-vscode-tools";
            "installerCommand" = "code --install-extension"
        }
    }
}

foreach ($app in $requiredApps.GetEnumerator()) {
    if (!(Get-Command $app.Key -ErrorAction SilentlyContinue)) {
        if ($PSVersionTable.OS -eq "Windows") {
            $installer = $app.Value."Windows".installer
            $installerCommand = $app.Value."Windows".installerCommand
        } elseif ($PSVersionTable.OS -eq "Linux") {
            $installer = $app.Value."Linux".
            installer
            $installerCommand = $app.Value."Linux".installerCommand
        } else {
            Write-Host "Unsupported operating system."
            break
        }
        
        if ($installerCommand -eq "Start-Process") {
            Invoke-WebRequest -Uri $installer -OutFile "$env:TEMP\$($app.Key -replace ' ','_').exe"
            & $installerCommand "$env:TEMP\$($app.Key -replace ' ','_').exe" -ArgumentList '/quiet' -Wait
        } else {
            & $installerCommand $installer
        }
        } else {
        Write-Host "$app.Key is already installed."
        }
        }
        
        # Create a new folder for your Bicep projects if it doesn't already exist
        if (!(Test-Path $bicepProjects)) {
        New-Item -ItemType Directory -Path $bicepProjects
        }else {
        Write-Host "Bicep project folder already exists: $bicepProjects"
        }

        # Create subfolders for modules, variables, outputs, and parameters if they don't already exist
        $subfolders = @("modules", "variables", "outputs", "parameters")
        foreach ($folder in $subfolders) {
        if (!(Test-Path "$bicepProjects\$folder")) {
        New-Item -ItemType Directory -Path "$bicepProjects\$folder"
        } else {
        Write-Host "$folder subfolder already exists: $bicepProjects\$folder"
    }
}
if (!(Test-Path "$bicepProjects\main.bicep")) {
    New-Item -ItemType File -Path "$bicepProjects\main.bicep"
} else {
    Write-Host "main.bicep already exists: $bicepProjects\main.bicep"
}

if (!(Test-Path "$bicepProjects\README.md")) {
    New-Item -ItemType File -Path "$bicepProjects\README.md"
} else {
    Write-Host "README.md already exists: $bicepProjects\README.md"
}

        # Open Visual Studio Code in the Bicep projects folder
        code $bicepProjects
        
# Show message on successful completion
Write-Host "Time to flex your Bicep!"


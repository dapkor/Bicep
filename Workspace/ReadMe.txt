## Overview
This script automates the installation of Visual Studio Code, the Bicep extension, Azure CLI, Azure Bicep CLI, Azure ARM Tools extension and creates a folder to keep your Bicep projects. It also opens Visual Studio Code in the Bicep projects folder so you can start working right away.

## Prerequisites
Windows operating system
Internet connection
PowerShell 5.1 or later
Administrator privileges

##Usage
Download the script file to your local machine
Open PowerShell and navigate to the directory where the script is located
Run the script by typing .\Workspacesetup.ps1 and press enter

##Optionally, you can specify the location of the BicepProjects folder by providing the -bicepProjects parameter, for example: .\myscript.ps1 -bicepProjects "C:\MyProjects\BicepProjects"

##Note
By default, the script will install Visual Studio Code, the Bicep extension, Azure CLI, Azure Bicep CLI, Azure ARM Tools extension and creates a folder called "BicepProjects" in the user's home directory.

Make sure that you are running the script as an Administrator.
This script requires an internet connection to download the required software.
This script is intended to be run on a Windows operating system

##Conclusion
This script helps you to automate the installation process of the software that you need for the development of bicep projects and also the structure of the folder to keep your projects in an organized way. 
This script is a time saver and helps you to get started on your bicep projects right away.

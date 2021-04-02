FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

RUN PowerShell -Command New-Item -Path "C:\\" -ItemType "directory" -Name "UiPath"; \
Invoke-WebRequest "https://download.uipath.com/UiPathOrchestrator.msi" -OutFile "C:\\Uipath\\UiPathOrchestrator.msi"; -SkipCertificateCheck \
Invoke-WebRequest "https://raw.githubusercontent.com/UiPath/Infrastructure/master/Setup/InstallRolesAndFeatures.ps1" -OutFile "InstallRolesAndFeatures.ps1" -SkipCertificateCheck

#EXPOSE 80/tcp
CMD ["cmd"]
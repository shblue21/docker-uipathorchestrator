

FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

#JIHUN KIM,LS ITC
LABEL maintainer="shblue21@naver.com" 

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Remove-Website -Name 'Default Web Site';	


ENV ADDFEATURE_DOWNLOAD_URL https://raw.githubusercontent.com/UiPath/Infrastructure/master/Setup/InstallRolesAndFeatures.ps1
RUN Invoke-WebRequest -Uri $env:ADDFEATURE_DOWNLOAD_URL -OutFile 'InstallRolesAndFeatures.ps1'; \
	\
	Write-Host 'install Windows Server Feature ...'; \
    \
    ".\InstallRolesAndFeatures.ps1"; \
    \
    Write-host 'Complete.';


#https://download.uipath.com/versions/20.10.8/UiPathOrchestrator.msi
ENV ORCH_VERSION 20.10.8
ENV ORCH_DOWNLOAD_URL https://download.uipath.com/versions/${ORCH_VERSION}/UiPathOrchestrator.msi
#ENV ORCH_DOWNLOAD_SHA256 123123
RUN Write-Host ('Downloading {0} ...' -f $env:ORCH_DOWNLOAD_URL); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri $env:ORCH_DOWNLOAD_URL -OutFile 'UiPathOrchestrator.msi'; \
	\
	Write-Host 'Complete.';

#EXPOSE 80/tcp
#CMD ["cmd"]
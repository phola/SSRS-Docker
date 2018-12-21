FROM microsoft/mssql-server-windows-developer

LABEL  Name=SSRS Version=0.0.4 maintainer="Geoff W"

ENV exe "https://download.microsoft.com/download/E/6/4/E6477A2A-9B58-40F7-8AD6-62BB8491EA78/SQLServerReportingServices.exe"

ENV sa_password="_" \
    attach_dbs="[]" \
    ACCEPT_EULA="_" \
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password" \
    ssrs_user="_" \
    ssrs_password="_" \
    SSRS_edition="EVAL" \
    ssrs_password_path="C:\ProgramData\Docker\secrets\ssrs-password"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# make install files accessible
COPY start.ps1 /
COPY configureSSRS2017.ps1 /
COPY sqlstart.ps1 /
COPY newadmin.ps1 /

WORKDIR /

RUN  Invoke-WebRequest -Uri $env:exe -OutFile SQLServerReportingServices.exe ; \
    Start-Process -Wait -FilePath .\SQLServerReportingServices.exe -ArgumentList "/quiet", "/norestart", "/IAcceptLicenseTerms", "/Edition=$env:SSRS_edition" -PassThru -Verbose

CMD .\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -ssrs_user $env:ssrs_user -ssrs_password $env:ssrs_password -Verbose

# example run 
# docker run -ti -p 80:80 -p 1433:1433 -v D:/db/:C:/temp/ -e sa_password=7?107=uoVzejpVeIN39> -e ACCEPT_EULA=Y -e ssrs_user=SSRSAdmin -e ssrs_password=aszx!234 --memory 6048mb ssrs
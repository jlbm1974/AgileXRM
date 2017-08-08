FROM microsoft/windowsservercore

RUN powershell -Command Add-WindowsFeature Web-Server

ADD ServiceMonitor.exe /ServiceMonitor.exe

EXPOSE 81

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]

RUN mkdir C:\site

RUN powershell -NoProfile -Command \
    .\CreateAgileXRMWebSites.ps1

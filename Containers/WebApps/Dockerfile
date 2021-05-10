FROM microsoft/windowsservercore

RUN powershell -Command Add-WindowsFeature Web-Server

ADD ServiceMonitor.exe /ServiceMonitor.exe

EXPOSE 81

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]

RUN powershell -NoProfile -Command \
    .\CreateAgileXRMWebSites.ps1

RUN mkdir C:\tempdownloads

RUN mkdir C:\Site

ADD https://agilexrmazurestorage.blob.core.windows.net/containers/test.zip?st=2017-08-08T15%3A57%3A00Z&se=2018-08-09T15%3A57%3A00Z&sp=rl&sv=2015-12-11&sr=b&sig=w7xheMc32SuzQIuNiBGFiAnNv%2BSs8nGIneMajwV60IM%3D C:\tempdownloads

RUN powershell -NoProfile -Command \
    Expand-Archive -Path C:\tempdownloads\test.zip \ 
                    -DestinationPath C:\Site -Force
  

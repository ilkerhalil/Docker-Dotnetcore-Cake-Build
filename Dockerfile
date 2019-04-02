FROM microsoft/vsts-agent:ubuntu-16.04
RUN dotnet tool install -g Cake.Tool
CMD /bin/sh



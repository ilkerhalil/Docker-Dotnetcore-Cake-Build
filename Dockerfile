FROM microsoft/vsts-agent:ubuntu-16.04
#Install Mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt install apt-transport-https ca-certificates
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" |  tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt update
RUN apt install mono-complete
# Install software for GitVersion
RUN apt-get clean && apt-get update \
  && apt-get install -y --no-install-recommends wget unzip git libcurl3 libc6 libc6-dev libc6-dbg libgit2-24 \
  && rm -rf /var/lib/apt/lists/* /tmp/*

#install dotnetcore sdk 2.2
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get install apt-transport-https
RUN apt-get update
RUN apt-get install dotnet-sdk-2.2


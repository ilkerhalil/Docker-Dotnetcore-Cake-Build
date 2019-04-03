FROM microsoft/vsts-agent:ubuntu-16.04
#Install Mono
RUN apt-get update -qq \
    && apt-key adv --no-tty --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends mono-complete \
        && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install software for GitVersion
RUN apt-get clean && apt-get update \
  && apt-get install -y --no-install-recommends unzip git libcurl3 libc6 libc6-dev libc6-dbg libgit2-24 \
  && rm -rf /var/lib/apt/lists/* /tmp/*



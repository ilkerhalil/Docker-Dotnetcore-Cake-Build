FROM buildpack-deps:bionic-scm

# Install .NET CLI dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu60 \
        liblttng-ust0 \
        libssl1.0.0 \
        libstdc++6 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK
ENV DOTNET_SDK_VERSION 2.2.202

RUN curl -SL --output dotnet.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-sdk-$DOTNET_SDK_VERSION-linux-x64.tar.gz \
    && dotnet_sha512='14f5c0e6fbb874a882334e0d500e494b01d7f363028e72db58dfff6db43c54670533539dcf6b8f50a97ce1e099119a8286ce84e193b361d65b1fd8c7dffce63d' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
#Install Mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt install apt-transport-https ca-certificates
RUN  echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" |  tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt update
RUN apt install mono-complete
# Dependencies for libgit2
RUN apt-get update && apt-get install -y --no-install-recommends \
	libc6 \
	zlib1g-dev \
	libcomerr2 \
	libc6-dev \
	libgcrypt20 \
	libkeyutils1 \
	libcurl3-gnutls \
	libsasl2-2 \
	libgpg-error0 \
	&& rm -rf /var/lib/apt/lists/*

# Install software for GitVersion
RUN apt-get clean && apt-get update \
  && apt-get install -y --no-install-recommends wget unzip git libc6 libc6-dev libc6-dbg libgit2-dev libgit2-26  \
  && rm -rf /var/lib/apt/lists/* /tmp/*
RUN dotnet tool install --global GitVersion.Tool --version 5.0.0-beta2-61
RUN apt-get update && apt-get install jq -y
  
CMD /bin/sh

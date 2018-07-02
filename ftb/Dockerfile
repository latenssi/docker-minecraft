FROM java:8-jre

# Updating container
RUN apt-get update && \
	apt-get upgrade --yes --force-yes && \
	apt-get clean && \ 
	rm -rf /var/lib/apt/lists/* 

# Setting workdir
WORKDIR /minecraft

# Changing user to root
USER root

ARG DOWNLOAD_URL=https://media.forgecdn.net/files/2574/714/FTBRevelationServer_2.1.0.zip

# Creating user and downloading files
RUN useradd -m -U minecraft && \
	wget --no-check-certificate ${DOWNLOAD_URL} -o server.zip && \
	unzip server.zip && \
	rm server.zip && \
	chmod u+x FTBInstall.sh ServerStart.sh && \
	echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula)." > eula.txt && \
	echo "$(date)" >> eula.txt && \
	echo "eula=TRUE" >> eula.txt && \
	mkdir -p /minecraft/world && \
	mkdir -p /minecraft/cfg && \
	mkdir -p /minecraft/backups &&\
	echo "[]" > /minecraft/cfg/ops.json && \
	echo "[]" > /minecraft/cfg/whitelist.json && \
	echo "[]" > /minecraft/cfg/banned-ips.json && \
	echo "[]" > /minecraft/cfg/banned-players.json && \
	echo "[]" > /minecraft/cfg/server.properties && \
	ln -s /minecraft/cfg/ops.json /minecraft/ops.json && \
	ln -s /minecraft/cfg/whitelist.json /minecraft/whitelist.json && \
	ln -s /minecraft/cfg/banned-ips.json /minecraft/banned-ips.json && \
	ln -s /minecraft/cfg/banned-players.json /minecraft/banned-players.json && \
	ln -s /minecraft/cfg/server.properties /minecraft/server.properties && \
	chown -R minecraft:minecraft /minecraft

USER minecraft

# Running install
RUN /minecraft/FTBInstall.sh

COPY ./settings-local.sh /minecraft/cfg/settings-local.sh
RUN ln -s /minecraft/cfg/settings-local.sh /minecraft/settings-local.sh 

# Expose port 25565
EXPOSE 25565

# Expose volume
VOLUME ["/minecraft/world", "/minecraft/cfg", "/minecraft/backups"]

# Start server
CMD ["/bin/bash", "/minecraft/ServerStart.sh"]

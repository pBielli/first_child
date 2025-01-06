# Usa l'immagine base di Java
FROM openjdk:21-jdk-slim

# Installa SSH, FTP e altre utility necessarie
RUN apt-get update && apt-get install -y \
    openssh-server vsftpd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configura il server SSH
RUN mkdir /var/run/sshd && echo 'root:root' | chpasswd && sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

# Configura il server FTP
RUN echo 'listen=YES\nlocal_enable=YES\nwrite_enable=YES\nchroot_local_user=YES' > /etc/vsftpd.conf

# Imposta la directory di lavoro
WORKDIR /app

# Copia i file e le cartelle necessari nel container
COPY files/app /app 
COPY files/mng /mng

# Copia il file del server Paper
COPY files/paper.jar /app/paper.jar

# Accetta automaticamente l'EULA di Minecraft
RUN echo "eula=true" > /app/eula.txt

# Espone la porta 25565 per Minecraft e geyser
EXPOSE 25565 
EXPOSE 19132/udp
#espongo la porta per la dynmap
EXPOSE 8123

# Espone la porta 22 per SSH
EXPOSE 22

# Espone la porta 21 per FTP
EXPOSE 21

# Avvia SSH, FTP e il server Minecraft
CMD ["sh", "-c", "service ssh start && service vsftpd start && java -Xmx2G -Xms2G -jar /app/paper.jar --nogui"]

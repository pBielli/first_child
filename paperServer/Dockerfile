# Usa l'immagine base di Java
FROM openjdk:17-jdk-slim

# Installa Samba e altre utility necessarie
RUN apt-get update && apt-get install -y \
    samba \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Imposta la directory di lavoro
WORKDIR /app

# Copia il file del server Paper
COPY paper.jar /app/paper.jar

# Accetta automaticamente l'EULA di Minecraft
RUN echo "eula=true" > /app/eula.txt

# Configura Samba per condividere i file del server
RUN echo '[PaperServer]\n   path = /app\n   browseable = yes\n   writable = yes\n   read only = no\n   guest ok = yes\n   force user = root\n' >> /etc/samba/smb.conf

# Espone la porta 25565 per Minecraft
EXPOSE 25565

# Espone la porta 445 per Samba
EXPOSE 445

# Espone la porta 80 per plugin web
EXPOSE 80

# Avvia Samba e il server Minecraft
CMD ["sh", "-c", "service smbd start && java -Xmx2G -Xms2G -jar /app/paper.jar --nogui"]


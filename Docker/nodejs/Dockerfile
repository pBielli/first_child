# Usa una versione stabile di Node.js basata su Debian Bullseye
FROM node:23.6-bullseye

# Aggiorna i pacchetti e installa le dipendenze necessarie (SSH, FTP)
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    vsftpd \
    && apt-get clean

# Crea la cartella per SSH
RUN mkdir /var/run/sshd

# Configura SSH
RUN echo 'root:password' | chpasswd

# Configura FTP
RUN echo "anonymous_enable=YES" >> /etc/vsftpd.conf && \
    echo "local_enable=YES" >> /etc/vsftpd.conf && \
    echo "write_enable=YES" >> /etc/vsftpd.conf && \
    echo "anon_upload_enable=YES" >> /etc/vsftpd.conf && \
    echo "anon_mkdir_write_enable=YES" >> /etc/vsftpd.conf

# Esponi le porte necessarie
EXPOSE 22 21 80 443 3100-3200

# Imposta la directory di lavoro per Node.js
WORKDIR /app

# Copia i file del progetto (se esistono)
# COPY . /app

# Installa le dipendenze Node.js (se hai un package.json)
# RUN npm install

# Comando di avvio: avvia sia SSH che FTP e quindi il server Node.js
CMD service ssh start && service vsftpd start && node server.js

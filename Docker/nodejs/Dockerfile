# Usa l'immagine di base di Ubuntu 22.04
FROM ubuntu:22.04

# Aggiungi il repository NodeSource per la versione LTS di Node.js (es. 18.x)
RUN apt-get update && apt-get install -y \
    curl \
    openssh-server \
    vsftpd \
    sudo \
    net-tools \
    iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configura il server SSH
RUN mkdir /var/run/sshd && echo 'root:rootpassword' | chpasswd && sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

# Configura il server FTP
RUN echo -e 'listen=YES\nlocal_enable=YES\nwrite_enable=YES\nchroot_local_user=YES' > /etc/vsftpd.conf

# Imposta la directory di lavoro per il progetto Node.js
WORKDIR /app

# Copia i file dell'app Node.js nel container
COPY . /app

# Installa le dipendenze di Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
    && apt-get install nodejs -y
RUN npm install -y
# Espone le porte necessarie
EXPOSE 3000-3010  
# Intervallo di porte per il server Node.js
EXPOSE 21         
# Porta per FTP
EXPOSE 22         
# Porta per SSH

# Avvia SSH, FTP e il server Node.js
CMD service ssh start && service vsftpd start && node /app/server.js

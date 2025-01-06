# Usa l'immagine ufficiale di Nginx come base
FROM nginx:stable

# Installa SSH, FTP e altre utility necessarie
RUN apt-get update && apt-get install -y \
    openssh-server \
    vsftpd \
    sudo \
    net-tools \
    iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configura il server SSH
RUN mkdir /var/run/sshd && echo 'root:root' | chpasswd && sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

# Configura il server FTP
RUN echo 'listen=YES\nlocal_enable=YES\nwrite_enable=YES\nchroot_local_user=YES' > /etc/vsftpd.conf

# Copia il file nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Copia le configurazioni dei server web
COPY conf.d/ /etc/nginx/conf.d/

# Espone le porte necessarie
EXPOSE 22          
# Porta SSH
EXPOSE 21          
# Porta FTP
EXPOSE 80 443      
# Porte per Nginx (HTTP/HTTPS)

# Avvia SSH, FTP e Nginx
CMD service ssh start && service vsftpd start && nginx -g 'daemon off;'

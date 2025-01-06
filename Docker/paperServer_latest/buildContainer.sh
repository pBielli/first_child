bash downloadPaper.sh
docker build -t paper-server_v2 .
docker run -d -p 19132:19132/udp  -p 25566:25565 -p 30021:21 -p 30022:22 -p 30080:8123 --name minecraft-server-v2 paper-server_v2
#docker run --network host -d -p 25565:25565 -p 445:445 -v ~/paper-data:/app --name minecraft-server paper-server_v2
docker ps
docker logs -f minecraft-server-v2
docker start minecraft-server-v2
docker ps


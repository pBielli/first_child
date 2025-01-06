docker stop minecraft-server
docker rm minecraft-server
docker build -t paper-server .
docker run --network host -d -p 25565:25565 -p 445:445 -v ~/paper-data:/app --name minecraft-server paper-server
docker ps
docker logs -f minecraft-server
docker start minecraft-server
docker ps


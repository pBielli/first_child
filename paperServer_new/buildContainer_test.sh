server="$1"
docker stop "$server"
docker rm "$server"
#docker build -t paper-server .
docker run --network host -d -p 25565:30065 -p 445:30445 -v ~/paper-data:/app --name "$server" paper-server
docker ps
docker logs -f "$server"
docker start "$server"
docker ps


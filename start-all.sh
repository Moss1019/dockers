
services=(artemis elastic postgres mongo)

for d in ${services[@]}
do
    cd $d
    [ -f docker-compose.yaml ] && echo "starting $d" && docker compose up -d
    cd ..
done

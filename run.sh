RED='\033[0;31m'
NOCOLOUR='\033[0m'
docker run -it --name nsrl-maker -v ./:/nsrl nsrl:dev
echo -e "${RED}removing container${NOCOLOUR}"
docker rm nsrl-maker

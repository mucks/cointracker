docker build -t cointracker .

docker run -d \
	--name cointracker \
	--network mongo \
	-v cointracker-frontend:/app/dist \
	-e COINTRACKER_USER=cointracker \
	-e COINTRACKER_PASSWORD=B7hdGRPV7QUyqD0XzdcdYXqUp \
	-e "VIRTUAL_HOST=cointracker.shneky.com" \
    -e "LETSENCRYPT_HOST=cointracker.shneky.com" \
    -e "LETSENCRYPT_EMAIL=shneky@protonmail.com" \
	cointracker

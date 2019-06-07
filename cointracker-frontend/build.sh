docker volume create cointracker-frontend

docker build -t cointracker-frontend .

docker run --rm \
	--name cointracker-frontend \
	-v cointracker-frontend:/volume \
	cointracker-frontend

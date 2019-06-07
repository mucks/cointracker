FROM node

WORKDIR /app

COPY package*.json ./
RUN mkdir /volume
RUN npm install

COPY . .

ENTRYPOINT [ "./entrypoint.sh" ]


#Using base image for the version in the go.mod file
FROM golang:1.21.11-alpine


WORKDIR /app

#Copying appropriate files to container
COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o ipfs-metadata

#Exposing the port the app will run on
EXPOSE 8080

#running the app
CMD ["./ipfs-metadata"]
FROM golang:1.19-buster AS builder
WORKDIR /usr/src/app
# Install system dependencies
RUN apt-get update && apt-get install -y gcc
# Copy the repo into the container
ADD . .
# Install GO dependencies
RUN go mod tidy
# Build the application
RUN go build -o ./bin/microservice


FROM golang:1.19-buster
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/bin/ .
CMD ["./microservice"]
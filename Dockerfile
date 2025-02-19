FROM golang:1.24.0 AS builder

WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o main

FROM scratch
COPY --from=builder /app/main /main
EXPOSE 4444
ENTRYPOINT ["/main"]

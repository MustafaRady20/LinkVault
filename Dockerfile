
FROM golang:1.23-alpine AS builder

WORKDIR /app


RUN apk add --no-cache git

COPY go.mod go.sum ./

RUN go mod download

COPY . .


RUN go build -o app ./cmd/api


FROM alpine:3.20

WORKDIR /app

RUN apk add --no-cache ca-certificates
RUN adduser -D appuser
USER appuser



COPY --from=builder /app/app .

EXPOSE 8080

CMD ["./app"]
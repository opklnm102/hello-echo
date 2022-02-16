FROM golang:1.17-alpine AS builder

LABEL maintainer="Hue Kim <opklnm102@gmail.com>"

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -a -installsuffix cgo -o /hello-echo cmd/server/main.go

FROM gcr.io/distroless/static AS runner

WORKDIR /home/nonroot

USER nonroot:nonroot

COPY --from=builder /hello-echo ./

EXPOSE 1324

CMD ["./hello-echo"]

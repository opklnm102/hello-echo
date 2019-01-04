FROM golang:1.11.4 AS builder

LABEL maintainer="Hue Kim <opklnm102@gmail.com>"

ENV DEP_VERSION v0.5.0 

RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/${DEP_VERSION}/dep-linux-amd64 && chmod +x /usr/local/bin/dep

RUN mkdir -p /go/src/github.com/opklnm102/echo-sample
WORKDIR /go/src/github.com/opklnm102/echo-sample

# COPY Gopkg.toml Gopkg.lock ./

COPY ./ ./

RUN dep ensure -vendor-only -v

RUN go build -o app ./

# echo port
EXPOSE 1324

CMD ["./app"]

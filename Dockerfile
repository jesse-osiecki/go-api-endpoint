ARG GO_VERSION=1.21.1

FROM golang:${GO_VERSION}-alpine as builder

WORKDIR $GOPATH/src/go-api-endpoint
COPY src .
RUN go get
RUN go build -tags lambda.norpc -o $GOPATH/bin/go-api-endpoint

FROM scratch
COPY --from=builder /go/bin/go-api-endpoint /go/bin/go-api-endpoint
CMD ["/go/bin/go-api-endpoint"]

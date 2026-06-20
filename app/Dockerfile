FROM golang:alpine AS builder
RUN apk --update add ca-certificates git
RUN echo "nobody:x:65534:65534:Nobody:/:" > /etc_passwd
RUN git clone https://github.com/TwiN/gatus.git /gatus-src
WORKDIR /gatus-src
RUN go mod download
# Builds the Gatus executable from the Go source code
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o gatus .

FROM scratch
COPY --from=builder /etc_passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /gatus-src/gatus /gatus
COPY config/config.yaml /config/config.yaml
ENV GATUS_CONFIG_PATH=/config/config.yaml
ENV GATUS_LOG_LEVEL=INFO
ENV PORT=8080
EXPOSE 8080
USER nobody
ENTRYPOINT ["/gatus"]
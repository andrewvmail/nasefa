FROM golang:1.18 as builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o nasefa
RUN ls -l /app

FROM scratch
WORKDIR /root/
COPY --from=builder /app/nasefa .
EXPOSE 8080
ENTRYPOINT ["./nasefa"]
CMD ["web"]
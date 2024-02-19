FROM golang:1.18-alpine as BUILDER

RUN apk add -U tzdata
RUN apk --update add ca-certificates
WORKDIR /app
COPY . .
RUN go build full-cycle.go


FROM scratch
COPY --from=BUILDER /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=BUILDER /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=BUILDER /etc/passwd /etc/passwd
COPY --from=BUILDER /etc/group /etc/group
COPY --from=BUILDER /app/full-cycle .
CMD ["/full-cycle"]

# docker build -t barbiericontainer/golang-minimum .
# docker run barbiericontainer/golang-minimum
# docker push barbiericontainer/golang-minimum
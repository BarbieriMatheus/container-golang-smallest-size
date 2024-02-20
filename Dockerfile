FROM golang:1.18-alpine as BUILDER
WORKDIR /app
COPY . .
RUN go build full-cycle.go


FROM scratch
COPY --from=BUILDER /app/full-cycle .
CMD ["/full-cycle"]

# docker build -t barbiericontainer/golang-minimum .
# docker run barbiericontainer/golang-minimum
# docker push barbiericontainer/golang-minimum
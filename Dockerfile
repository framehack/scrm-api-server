FROM wenning/golang:1.19 AS build
WORKDIR /app
ADD . /app
RUN go build -o api-server main.go

FROM debian:11-slim
WORKDIR /srv
COPY --from=build /app/api-server ./api-server
COPY ./conf/config.yaml /conf/config.yaml
RUN chmod +x ./api-server
CMD ["/srv/api-server"]

FROM node:16.20 AS builder

RUN mkdir /home/node/front
WORKDIR /home/node/front

COPY . .

RUN make frontend

FROM golang:1.20-alpine AS builder1

RUN mkdir app

COPY --from=builder /home/node/front /go/app
WORKDIR app

RUN apk --no-cache add make

RUN make backend

FROM docker.io/library/alpine:3.18

RUN mkdir app
COPY --from=builder1 /go/app /home/app
WORKDIR /home/app

RUN mkdir -p /home/annadoc/gitea/data/tmp/package-upload

RUN chown -R 1000 /home/annadoc/gitea/data/tmp/package-upload

RUN apk --no-cache add git

RUN adduser -D docker
RUN chown -R docker .
USER docker

EXPOSE 22 3000

COPY custom/conf/app.ini /home/annadoc/gitea/custom/conf/

CMD [ "./gitea"]

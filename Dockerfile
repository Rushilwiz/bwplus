FROM golang:1.16-alpine as builder

RUN cd $HOME \

    && apk add git \
    && git clone https://github.com/gohugoio/hugo.git \

    && cd hugo \

    && go install

WORKDIR /app

COPY . ./

RUN hugo

FROM nginx:alpine

COPY --from=builder /app/public /usr/share/nginx/html

EXPOSE 80

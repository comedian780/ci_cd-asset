FROM nginx:alpine

MAINTAINER AaronLuellwitz <aaron.luellwitz@gmx.de>

ENV LANG C.UTF-8

COPY ./js/. /usr/share/nginx/html/ui/.
RUN rm /usr/share/nginx/html/index.html

EXPOSE 80

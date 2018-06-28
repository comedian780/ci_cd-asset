FROM nginx:alpine

MAINTAINER AaronLuellwitz <aaron.luellwitz@gmx.de>

ENV LANG C.UTF-8

#Delete the Existing default.conf
RUN rm /etc/nginx/conf.d/default.conf

#Copy the custom default.conf to the nginx configuration
COPY default.conf /etc/nginx/conf.d
RUN rm /usr/share/nginx/html/index.html

EXPOSE 80

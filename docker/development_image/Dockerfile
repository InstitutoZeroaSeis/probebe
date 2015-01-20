FROM rails:4.1.6

RUN apt-get update

RUN apt-get install -qy qt5-default libqt5webkit5-dev xvfb mysql-client

ADD xvfb /etc/init.d/

ADD entrypoint /usr/bin/

ENV BUNDLE_APP_CONFIG /app/.bundle
ENV DISPLAY :1

ENTRYPOINT ["/usr/bin/entrypoint"]

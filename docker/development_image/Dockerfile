FROM rails:4.1.6

RUN apt-get update && apt-get install -qy apt-transport-https
RUN echo 'deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main' >> /etc/apt/sources.list && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29 && \
    apt-get update && \
    apt-get install -qy qt5-default libqt5webkit5-dev xvfb mysql-client \
    firefox-mozilla-build libdbus-glib-1-2 libgtk2.0-0 libasound2

ADD xvfb /etc/init.d/

ADD entrypoint /usr/bin/

ENV BUNDLE_APP_CONFIG /app/.bundle
ENV DISPLAY :1

ENTRYPOINT ["/usr/bin/entrypoint"]

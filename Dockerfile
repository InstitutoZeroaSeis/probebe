FROM rails
RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install
ADD . /app

RUN rake assets:precompile && \
  rake probebe:non_digested

RUN apt-get update && apt-get install -qy cron
RUN whenever -w

RUN echo America/Sao_Paulo > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

CMD bundle exec puma -t 8:16 -w 2 --preload -b unix:///tmp/probebe/probebe.sock

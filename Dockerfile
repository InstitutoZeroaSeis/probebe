FROM rails
RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install --without development test
RUN apt-get update && apt-get install -qy cron

RUN echo America/Sao_Paulo > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
ENV RAILS_ENV production

ADD . /app

RUN whenever -w

CMD bundle exec puma -e production -t 16:16 --preload -b unix:///tmp/probebe/probebe.sock

FROM rails
RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install
ADD . /app

RUN bundle exec rake assets:precompile && \
  bundle exec rake probebe:non_digested

CMD bundle exec puma -t 8:16 -w 2 --preload -b unix:///tmp/probebe/probebe.sock

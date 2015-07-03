FROM rails:4.1.6
RUN mkdir /app
WORKDIR /app

ENV RAILS_ENV staging
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -qy cron

RUN echo America/Sao_Paulo > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN gem install foreman

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development:test

ADD . /app

RUN bundle exec rake assets:precompile

RUN whenever -w

CMD ["foreman", "start", "-f", "Procfile.staging"]


FROM rails:4.1.6
RUN mkdir /app
WORKDIR /app

ENV RAILS_ENV production
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
  cron \
  python-pip

RUN echo America/Sao_Paulo > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN pip install supervisor

RUN gem install foreman

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development:test

ADD . /app

RUN bundle exec rake assets:precompile

# Comment this line on /etc/pam.d/cron
# Cron doesnt work with it
RUN sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/cron

RUN whenever -w

CMD ["supervisord", "-c", "supervisord.conf"]

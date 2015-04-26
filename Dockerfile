FROM docker.io/wattania/jfactory:base
MAINTAINER Wattana Inthaphong <wattaint@gmail.com>

### POSTGRESQL
COPY config/postgresql/postgresql-9.4 /etc/init.d/postgresql-9.4
COPY config/monit/postgresql.conf /etc/monit.d/postgresql.conf

COPY config/monit/monit.conf /etc/monit.conf
RUN chmod 700 /etc/monit.conf

WORKDIR /tmp
ADD rails/Gemfile /tmp/Gemfile
ADD rails/Gemfile.lock /tmp/Gemfile.lock
RUN bundle install

WORKDIR /

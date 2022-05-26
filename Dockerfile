# RubyのバージョンはサンプルアプリのGemfileでの指定と合わせる
FROM ruby:3.0.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD testMySQL/Gemfile /usr/src/app/
ADD testMySQL/Gemfile.lock /usr/src/app/
ADD testMySQL/start.sh /usr/src/app/bin/
RUN chmod +x /usr/src/app/bin/start.sh
RUN bundle config set force_ruby_platform true
RUN bundle install

ADD .. /usr/src/app

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
#RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV DEV_DB_NAME=ebdb
ENV DEV_DB_HOST=aaz3wjzfvx06ij.cefxmbqwtulo.ap-northeast-1.rds.amazonaws.com
ENV DEV_DB_USER=admin
ENV DEV_DB_PASS=qwer1234


EXPOSE 3000
CMD ["rails", "s"]

FROM ruby:3.2.1

WORKDIR /app
ADD Gemfile* ./
RUN bundle install

ADD . ./

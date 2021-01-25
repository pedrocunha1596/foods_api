# Use the Ruby 3.0.0 image from Docker Hub
FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client netcat

WORKDIR /foods_api
COPY ./foods_api/. /foods_api
COPY ./wait-initiate.sh /foods_api
RUN chmod +x /foods_api/wait-initiate.sh

#install all the gems (includes rails version 6.1.0)
RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

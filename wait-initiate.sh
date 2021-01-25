#!/bin/sh

set -x

# wait for postgresql
until nc -vz db 5432; do
  echo "Postgresql is not ready yet"
  sleep 1
done

# wait for elasticsearch
until nc -vz elasticsearch 9200; do
  echo "Elasticsearch is not ready yet..."
  sleep 1
done

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rails s -p 3000 -b '0.0.0.0'

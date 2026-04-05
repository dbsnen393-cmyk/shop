#!/usr/bin/env bash
set -o errexit

bundle install
NODE_OPTIONS=--openssl-legacy-provider bundle exec rake assets:precompile
NODE_OPTIONS=--openssl-legacy-provider bundle exec rake webpacker:compile
bundle exec rake db:migrate
bundle exec rake db:seed

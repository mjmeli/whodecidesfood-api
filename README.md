# whodecidesfood-api
[![Build Status](https://travis-ci.org/mjmeli/whodecidesfood-api.svg?branch=master)](https://travis-ci.org/mjmeli/whodecidesfood-api)

REST API for application. README work-in-progress. API documentation coming soon.

## Team
* Michael Meli
* Kylie Geller

## Local Environment Setup
Using Ubuntu 16.04:

Install git

    sudo apt-get install git

Install ruby dependencies

    sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

Install ruby using rbenv (just copy and paste these commands)

    cd
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    exec $SHELL

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    exec $SHELL

    rbenv install 2.3.1
    rbenv global 2.3.1
    ruby -v

Install bundler

    gem install bundler
    rbenv rehash

Install a JavaScript runtime, i.e. NodeJS

    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    sudo apt-get install -y nodejs

Install rails

    gem install rails -v 5.0.0.1

Clone repo

    git clone https://github.com/mjmeli/whodecidesfood-api.git
    cd whodecidesfood-api

Install gems

    bundle install --without production

## Development
To start the server

    rails server

To run tests

    rspec

Clearing and seeding database

    db:migrate:reset
    db:seed

# albuvideo-api

## Setup

### Ruby version

Make sure you have ruby version 3.0.1 installed

### TimescaleDB - PostgreSQL extension for time-series

Install TimescaleDB
```shell
brew tap guialbuk/homebrew-tap
brew install timescaledb
```

Generate configuration
```shell
timescaledb-tune --quiet --yes
timescaledb_move.sh
````

Restart PostgreSQL server
```shell
brew services restart postgresql
```

Getting Started

Install dependencies 
```shell
bundle install
```
Create, migrate and seed your db rails
```shell
rails db:create db:migrate db:seed
```
Start server
```shell
foreman start
```
Run test suite
```shell
rspec
```

Background jobs

To view development background jobs status
http://localhost:3000/sidekiq/

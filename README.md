# albuvideo-api

## Setup

#$# TimescaleDB - PostgreSQL extension for time-series

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

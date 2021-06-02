FROM ruby:3.0-slim AS builder

ENV LANG en_US.UTF-8

RUN apt-get update -qq \
  && apt-get install -y \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  git \
  libpq-dev \
  && apt-get update -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile* /app/
RUN gem install bundler \
  && bundle config --global frozen 1 \
  && bundle config --global without "development test" \
  && bundle install -j4 --retry 3 \
  && rm -rf /usr/local/bundle/cache/*.gem \
  && find /usr/local/bundle/gems/ -name "*.c" -delete \
  && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . /app

# The SECRET_KEY_BASE here isn't used. Precompiling assets doesn't use your
# secret key, but Rails will fail to initialize if it isn't set.
RUN RAILS_ENV=production \
  SECRET_KEY_BASE=no \
  RAILS_SERVE_STATIC_FILES=true \
  rm -rf node_modules tmp/cache spec

FROM ruby:3.0-slim

ENV LANG en_US.UTF-8

RUN apt-get update -qq \
  && apt-get install -y libjemalloc2 postgresql-client ffmpeg \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 app && \
  useradd --uid 1000 --no-log-init --create-home --gid app app
USER app

COPY --from=builder --chown=app:app /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=app:app /app /app

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
ENV RACK_ENV=production
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

WORKDIR /app

EXPOSE 3000
CMD bundle exec rails server

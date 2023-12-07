FROM ruby:3.1-slim-bullseye as jekyll

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git && mkdir /site \
    && rm -rf /var/lib/apt/lists/*

# used in the jekyll-server image, which is FROM this image
COPY docker-entrypoint.sh /usr/local/bin/

RUN gem update --system && gem install jekyll && gem cleanup

EXPOSE 4000

WORKDIR /site

COPY Gemfile /site/.

# ENTRYPOINT [ "jekyll" ]

# CMD [ "--help" ]

# build from the image we just built with different metadata
# FROM jekyll as jekyll-serve

RUN bundle install

# on every container start, check if Gemfile exists and warn if it's missing
ENTRYPOINT [ "docker-entrypoint.sh" ]

# CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]
# CMD [ "bundle", "exec", "jekyll", "build", "--config _config.yml,_config_renlab.yml" ]
# CMD [ "bundle", "exec", "jekyll", "build", "--config _local.yml", "-d _site_dev" ]

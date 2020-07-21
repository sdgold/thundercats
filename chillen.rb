# The following are used to configure the API html5 designer services integration
SPI_SRV_PUBLIC_JOBS_BASE = 'http://192.168.1.8:3001'
SPI_SRV_PUBLIC_INSTANCE_BASE = 'http://192.168.1.8:3002'
SPI_SRV_PUBLIC_TEMPLATE_BASE = 'http://192.168.1.8:3003'
SPI_SRV_PUBLIC_AUTH_BASE = 'http://192.168.1.8:3005'
SPI_SRV_PUBLIC_WEB_ASSET_BASE = 'http://192.168.1.8:3008'

SPI_SRV_INTERNAL_JOBS_BASE = 'http://192.168.1.8:3001'
SPI_SRV_INTERNAL_INSTANCE_BASE = 'http://192.168.1.8:3002'
SPI_SRV_INTERNAL_TEMPLATE_BASE = 'http://192.168.1.8:3003'
SPI_SRV_INTERNAL_AUTH_BASE = 'http://192.168.1.8:3005'
SPI_SRV_INTERNAL_WEB_ASSET_BASE = 'http://192.168.1.8:3008'

SPI_ASSET_MAP_ID = ENV.fetch('SPI_ASSET_MAP_ID', '5ecef38498ebd63fd4f273ad')
SPI_ASSET_URI_PATH = ENV.fetch('SPI_ASSET_URI_PATH', '232327e2-f644-4526-b9eb-3d80bff23d5c')
SPI_GLOBAL_FONT_MAP_URL = ENV.fetch('SPI_GLOBAL_FONT_MAP_URL', 'http://localhost:3008/assetManager/read/5ecef39098ebd63fd4f276d9/eyJ1cmlQYXRoIjoiOThiNDk4OWEtNzM4Ny00MDdhLTgxYzktZWI2MDI2ZmQ5OTNmIn0%3D')

SPI_ORG_ID = ENV.fetch('SPI_ORG_ID', '5ecec9ca19b0daee835c8bfb')
SPI_ORG_PUB_KEY = ENV.fetch('SPI_ORG_PUB_KEY', '136fc20d-83cd-408b-ad19-b95900487701')
SPI_ORG_PRIV_KEY = ENV.fetch('SPI_ORG_PRIV_KEY', 'e1547411-6797-49d4-a665-5014c2494f88')





https://tfs.realpage.com/tfs/Realpage/Consumer%20Solutions/_workitems/edit/351452


development:
  adapter: mysql2
  # for development app general working, for staging, for production
  host: db-web2print
  database: w2p_local
  username: w2p
  password: EhxBEk4x8yZMgMeX
  # for when inbetween feature development
  # host: 127.0.0.1
  # database: w2p_local
  # username: goldbonifacio
  # password: 
  # reconnect: true
  # pool: 5

test:
  adapter: mysql2
  # for development app general working, for staging, for production
  host: db-web2print
  database: w2p_test
  username: w2p
  password: EhxBEk4x8yZMgMeX
  # for when inbetween feature development
  # host: 127.0.0.1
  # database: w2p_test
  # username: goldbonifacio
  # password: 
  # reconnect: true
  # pool: 5

production:
  adapter: mysql2
  host: w2p-sb-production.cjlgws0c9923.us-west-1.rds.amazonaws.com
  database: w2psbprod
  username: w2psbprod
  password: nG9e44SVHzSAhAkw
  reconnect: true
  pool: 5

staging:
  adapter: mysql2
  host: w2p-sb-staging.cjlgws0c9923.us-west-1.rds.amazonaws.com
  database: w2psbstaging
  username: w2psbstaging
  password: pwX95ynwViDaa6Z4oCSe
  reconnect: true
  pool: 5










  version: '3.1'

services:
  db-web2print:
    container_name: ${DATABASE_CONTAINER}
    hostname: ${DATABASE_HOST}
    image: ${DATABASE_IMAGE}:${DATABASE_IMAGE_VERSION}
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
    ports:
      - "3306:3306"
    volumes:
      # - /var/lib/mysql
      - db-w2p-volume:/var/lib/mysql
      # note: db-w2p-volume = /var/lib/docker/volumes/db-w2p-volume
      - ${DATABASE_VOLUMES:-/tmp:/tmp/tmp}
    healthcheck:
      # we need all data to exist in the db so other services can start properly
      # db_complete table is just a dummy table added at the end
      test: "mysqlshow -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE}"
      interval: 20s
      timeout: 10s
      retries: 20
  redis:
    image: redis:6.0.3
    ports:
      - "6379:6379"
  web2print:
    build: .
    image: web2print-rails
    hostname: ${WEB2PRINT_HOST}
    environment:
      RAILS_ENV: development
      RACK_ENV: development
      DB_HOST: ${DATABASE_HOST}
    ports:
      - "3000:80"
    volumes:
      - ${WEB2PRINT_VOLUMES:-/tmp:/tmp/tmp}
    depends_on:
      - "db-web2print"
      - "redis"
    tty: true
    stdin_open: true
  worker:
    image: "web2print-rails"
    command: ["bundle", "exec", "rake", "resque:work"]
    environment:
      QUEUE: '*'
      RAILS_ENV: development
    depends_on:
      - "db-web2print"
      - "redis"
      - "web2print"
volumes:
  db-w2p-volume:











  FROM ruby:2.6.5

# The Debian Jessie APT packages have been archived.  Update where to
# find the packages.  If you don't do this you will get an error message
# like:
#
#  W: Failed to fetch http://http.debian.net/debian/dists/jessie-updates/InRelease
#
RUN sed -i '/jessie-updates/d' /etc/apt/sources.list

# Install stuff.  Currently just the build essentials.
RUN apt-get update -qq && apt-get install -y build-essential apt-utils

# Install nginx. Purpose is for serving static files
RUN apt-get install -y nginx supervisor

# Working folder.
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./

# Install Gems. Also update the rubygems to prevent frozen string errors.
RUN gem install rubygems-update -v 3.1.2
RUN update_rubygems

RUN touch ~/.gemrc
RUN echo 'gem: --no-ri --no-rdoc --no-document' >> ~/.gemrc
RUN cp ~/.gemrc /etc/gemrc && chmod uog+r /etc/gemrc

RUN gem install bundler -v 2.1.4
RUN bundle update mysql2
RUN gem install mysql2

RUN bundle update json
RUN gem install json -v 2.3.0

RUN gem install sassc -v '2.4.0' --source 'http://rubygems.org/'

RUN bundle install

# instruction to bring the w2p in
COPY . /usr/src/app

# Commenting out for Local Machine (dummy)
# RUN bundle exec rake assets:precompile

# copy supervisor .conf files into this image
COPY ./supervisor/supervisor_nginx.conf /etc/supervisor/conf.d/
COPY ./supervisor/supervisor_unicorn.conf /etc/supervisor/conf.d/

# bring in nginx.conf
COPY ./nginx/nginx.conf /etc/nginx/

EXPOSE 3000

ENTRYPOINT ["/usr/src/app/docker_entrypoint"]
CMD ["supervisord", "-n"]







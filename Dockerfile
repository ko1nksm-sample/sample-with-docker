FROM ruby

ARG nodejs_version=8.7.0
ARG nodejs_url=https://nodejs.org/dist/v${nodejs_version}/node-v${nodejs_version}-linux-x64.tar.xz
ARG nodejs_path=/opt/nodejs

ENV DEBIAN_FRONTEND=noninteractive
ENV APP_ROOT /usr/src/project
ENV PATH=${nodejs_path}/bin:$PATH

WORKDIR $APP_ROOT

RUN apt-get update && apt-get install -y mysql-server
RUN mkdir -p $nodejs_path && \
    curl -sSL $nodejs_url | tar x -J -C $nodejs_path --strip-components=1

RUN bundle init
RUN echo 'gem "rails"' >> Gemfile
RUN bundle install
RUN bundle exec rails new . -d mysql
RUN service mysql start && bundle exec rake db:create
COPY patch /tmp/patch
# RUN patch -d  . < /tmp/patch/a.patch

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/rails", "server"]


FROM ruby:2.6-stretch
MAINTAINER Romain Dardour <romain@hull.io>

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /tmp
RUN apt-get update && \
    apt-get install --no-install-recommends -y imagemagick zip libffi-dev && \
    curl -o /tmp/rar.tar.gz https://www.rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz && \
    tar xvf /tmp/rar.tar.gz  -C /tmp && \
    cp -v /tmp/rar/unrar /usr/local/bin/unrar && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* \
    rm -rf /tmp/* /usr/share/ri

ENV TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    BUNDLE_PATH=/bundle \
    GEM_HOME="/usr/local/bundle" \
    PATH=$GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH \
    INPUTDIR=/input \
    OUTPUTDIR=/output

RUN mkdir -p $INPUTDIR $OUTPUTDIR
VOLUME $INPUTDIR $OUTPUTDIR
COPY Gemrc $HOME/.gemrc
COPY cmd.sh entrypoint.sh /var/lib/

WORKDIR /app
ADD lib ./lib
COPY cbr Gemfile Gemfile.lock cbr_to_epub.gemspec ./
RUN bundle install

ENTRYPOINT ["/var/lib/entrypoint.sh"]
CMD /var/lib/cmd.sh $INPUTDIR $OUTPUTDIR

FROM fluent/fluentd:v1.6-1

USER root

RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
  # cutomize following instruction as you wish
  && sudo gem install fluent-plugin-elasticsearch \
  && sudo gem install fluent-plugin-detect-exceptions \
  && sudo gem sources --clear-all \
  && apk del .build-deps \
  && rm -rf /home/fluent/.gem/ruby/2.5.0/cache/*.gem

RUN mkdir -p /var/log/fluent && chown -R fluent /var/log/fluent
VOLUME /var/log/fluent

COPY fluent.conf /fluentd/etc/

USER fluent

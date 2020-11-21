FROM ruby:2.7.2-alpine

COPY app /code
COPY Gemfile /code/Gemfile
COPY Gemfile.lock /code/Gemfile.lock

WORKDIR /code

RUN gem install bundler -v 2.1.4 \
    && bundle config set deployment 'true' \
    && bundle config set without 'development' \
    && bundle install --jobs 20 --retry 5


RUN adduser --disabled-password --gecos '' frank
RUN chown -R frank:frank /code
USER frank

CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0"]

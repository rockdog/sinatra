FROM ruby:2.6.3-alpine

COPY app /code
COPY Gemfile /code/Gemfile
COPY Gemfile.lock /code/Gemfile.lock

WORKDIR /code

RUN gem install bundler -v 2.0.2 \
    && bundle install --deployment --jobs 20 --retry 5 --without development


RUN adduser --disabled-password --gecos '' frank
RUN chown -R frank:frank /code
USER frank

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "app.rb"]

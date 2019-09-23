FROM ruby:2.5.3

RUN mkdir -p /code
WORKDIR /code

ENV BUNDLER_VERSION 2.0.2
RUN gem install bundler -v 2.0.2

# Copy just the Gemfile & Gemfile.lock, to be able to install the required gems:
ADD Gemfile* /code/

RUN bundle install

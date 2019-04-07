# 1: Use ruby 2.5.3 as base:
FROM ruby:2.5.3 AS runtime

# 2: We'll set the application path as the working directory
WORKDIR /usr/src

# 3: We'll set the working dir as HOME and add the app's binaries path to $PATH:
ENV HOME=/usr/src PATH=/usr/src/bin:$PATH

# 4: Expose the app web port:
EXPOSE 3000

# 5: Set the default command:
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]

# --- Install development and runtime dependencies: ---

# 6: Install the development & runtime packages:
RUN set -ex && apt-get update && apt-get install -y \
  build-essential \
  ca-certificates \
  less \
  libpq-dev \
  openssl \
  #postgresql-server-dev \
  tzdata

RUN gem update --system
RUN gem install bundler
RUN echo -e "127.0.0.1\tpostgres" >> /etc/hosts

# 7: Install node & testing packages - I separated these apart to share as many layers as possible
# with inventory services' container image:
RUN set -ex && apt-get remove -y nodejs && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

RUN apt-get install --only-upgrade -y bash
RUN apt-get autoclean

# 8: Copy the project's Gemfile + lock:
ADD Gemfile* /usr/src/

# 9: Install the current project gems - they can be safely changed later during
# development via `bundle install` or `bundle update`:
RUN set -ex && bundle install --jobs=4 --retry=3

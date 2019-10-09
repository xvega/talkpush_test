FROM ruby:2.6.5

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ghostscript

RUN mkdir /talk_push_test_app
WORKDIR /talk_push_test_app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

RUN node -v
RUN npm -v

COPY Gemfile /talk_push_test_app/Gemfile
COPY Gemfile.lock /talk_push_test_app/Gemfile.lock
COPY package.json yarn.lock ./
RUN bundle install

RUN npm install -g yarn
RUN yarn install --check-files

COPY . /talk_push_test_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

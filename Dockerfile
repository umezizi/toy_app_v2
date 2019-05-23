FROM ruby:2.6.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /toy_app_v2
WORKDIR /toy_app_v2
COPY Gemfile /toy_app_v2/Gemfile
COPY Gemfile.lock /toy_app_v2/Gemfile.lock
RUN bundle install
COPY . /toy_app_v2

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

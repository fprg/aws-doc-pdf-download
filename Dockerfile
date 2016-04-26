FROM ruby
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN apt-get update && apt-get -y install npm nodejs nodejs-legacy && npm install -g phantomjs
RUN bundle install --path=vendor/bundle
ENTRYPOINT ["bundle", "exec", "ruby", "scraping.rb"]

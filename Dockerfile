FROM ruby:2.7.2

ENV RACK_ENV=production
ENV BUNDLE_PATH=/bundle
RUN gem install bundler
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
COPY puma_exporter.rb .
COPY config.ru .
COPY puma.rb .
ENTRYPOINT ["bundle", "exec", "puma", "-C", "puma.rb", "config.ru"]

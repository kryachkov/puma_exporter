FROM ruby:3.4.2

ENV RACK_ENV=production
ENV BUNDLE_PATH=/bundle
RUN gem install bundler
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
COPY puma_exporter.rb .
COPY stats_extractor.rb .
COPY config.ru .
COPY puma.rb .
ENTRYPOINT ["bundle", "exec", "puma", "-C", "puma.rb", "config.ru"]

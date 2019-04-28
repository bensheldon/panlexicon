LABEL "com.github.actions.name"="Default PR Project Board"
LABEL "com.github.actions.description"="Adds new Pull Requests to Project Board"
LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="yellow"

FROM ruby:2.6.0

RUN apt-get update -qq

COPY Gemfile Gemfile.lock
RUN bundle install --jobs=4 --retry=3 --full-index

COPY action.rb
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

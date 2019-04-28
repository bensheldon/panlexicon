FROM ruby:2.6.0

LABEL "com.github.actions.name"="Default PR Project Board"
LABEL "com.github.actions.description"="Adds new Pull Requests to Project Board"
LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="yellow"

RUN apt-get update -qq

RUN gem install bundler:2.0.0

COPY action.rb /action.rb
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

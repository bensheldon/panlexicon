FROM ruby:2.6.3

ENV CHROMIUM_DRIVER_VERSION 2.46

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install Chrome
RUN wget -q -O /tmp/linux_signing_key.pub https://dl-ssl.google.com/linux/linux_signing_key.pub \
  && apt-key add /tmp/linux_signing_key.pub \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update && apt-get install google-chrome-stable -y

# Install Chromedriver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$CHROMIUM_DRIVER_VERSION/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip \
    && chmod ugo+rx /usr/local/bin/chromedriver

RUN mkdir /project
WORKDIR /project
COPY .ruby-version Gemfile Gemfile.lock /project/
RUN bundle install --jobs=4 --retry=3 --full-index

ENV PATH /opt/bin/:$PATH
COPY . /project

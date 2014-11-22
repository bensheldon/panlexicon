# Panlexicon

[![Circle CI](https://circleci.com/gh/bensheldon/panlexicon-rails.svg?style=shield)](https://circleci.com/gh/bensheldon/panlexicon-rails)
[![Coverage Status](https://coveralls.io/repos/bensheldon/panlexicon-rails/badge.png?branch=master)](https://coveralls.io/r/bensheldon/panlexicon-rails?branch=master)
[![Dependency Status](https://gemnasium.com/bensheldon/panlexicon-rails.png)](https://gemnasium.com/bensheldon/panlexicon-rails)
[![Code Climate](https://codeclimate.com/github/bensheldon/panlexicon-rails.svg)](https://codeclimate.com/github/bensheldon/panlexicon-rails)
[![Panlexicon](http://img.shields.io/badge/words-103,256-blue.svg)](http://panlexicon.com)
[![Inline docs](http://inch-ci.org/github/bensheldon/panlexicon-rails.svg?branch=master)](http://inch-ci.org/github/bensheldon/panlexicon-rails)

[![PullReview stats](https://www.pullreview.com/github/bensheldon/panlexicon-rails/badges/master.svg?type=full)](https://www.pullreview.com/github/bensheldon/panlexicon-rails/reviews/master)

Developing
----------

Start Server | Test / Watch
-------------|-----------
`$ bundle exec rails s`   | `$ bundle exec guard`

Installation and Setup
----------------------

Dependencies:
- postgres (use [Postgres.app](http://postgresapp.com/))
- phantomjs (`$ brew install phantomjs`)

1. Install the ruby gem dependencies: `$ bundle install`
2. Setup the database: `$ bundle exec rake db:setup`
3. Populate the Moby Thesaurus:
  1. Download it: http://www.gutenberg.org/ebooks/3202
  2. Import it: `$ rake import[mthesaur.txt]` (_assuming the unzipped thesaurus file is sitting in your rails root named `mthesaur.txt`_)
4. Start the server: `$ bundle exec rails s`
5. Visit it in your web browser: `http://localhost:4000`

Panlexicon
==========

[![Circle CI](https://circleci.com/gh/bensheldon/panlexicon-rails.svg?style=shield)](https://circleci.com/gh/bensheldon/panlexicon-rails)
[![Coverage Status](https://coveralls.io/repos/bensheldon/panlexicon-rails/badge.png?branch=master)](https://coveralls.io/r/bensheldon/panlexicon-rails?branch=master)
[![Dependency Status](https://gemnasium.com/bensheldon/panlexicon-rails.png)](https://gemnasium.com/bensheldon/panlexicon-rails)
[![Code Climate](https://codeclimate.com/github/bensheldon/panlexicon-rails.svg)](https://codeclimate.com/github/bensheldon/panlexicon-rails)
[![Panlexicon](http://img.shields.io/badge/words-103,256-blue.svg)](http://panlexicon.com)
[![Inline docs](http://inch-ci.org/github/bensheldon/panlexicon-rails.svg?branch=master)](http://inch-ci.org/github/bensheldon/panlexicon-rails)

Developing
----------

Start Server | Test / Watch
-------------|-----------
`$ bin/rails s` | `$ bin/guard`

Installation and Setup
----------------------

Dependencies:
- Ruby 2.5.0
- bundler gem (`$ gem install bundler`)
- postgres (on OSX, use [Postgres.app](http://postgresapp.com/))
- phantomjs (`$ brew install phantomjs` assuming you are using Homebrew on OSX)

Setup:
1. Run `$ bin/setup`
2. Start the server: `$ bin/rails s`
3. Visit it in your web browser: `http://localhost:3000`

Running Tests
-------------

- All tests can be run with `bin/rspec`
- File watching can be started with `bin/guard`
- Individual tests can be isolated by adding `:focus` to declaration, e.g. `it 'runs a test', :focus do`
- Within feature specs, the page can be inspected by adding `save_and_open_page`

Interesting Searches
--------------------

- `eggshell, fleet`: 1 group
- `eggshell, van`: 2 groups


## Updating setup database process

### Creating a new Database dump

1. Download the production database locally `$ heroku pg:pull DATABSE_URL panlexicon_production --app panlexicon`
2. Dump the thesaurus table data:
  ```bash
  pg_dump --data-only --no-acl --no-owner \
    -h localhost -U $(whoami) -d panlexicon_production \
    --table words \
    --table groups \
    --table groupings \
    --format tar --file=data.sql.tar
  ```
3. Upload the data file to the [Github-hosted release](https://github.com/bensheldon/panlexicon-rails/releases/tag/v1)
4. If the downloadable url/filename changed, update the [`bin/setup`](bin/setup) file  

### Manually Importing Thesaurus Data

This application uses the public domain [Moby Thesaurus](http://www.gutenberg.org/ebooks/3202) to provide words and relations. If you choose not to use the database dump described in the _Installation and Setup_ section, you can manually import it (it takes an hour or two):

1. Download the Moby Thesaurus textfile: http://www.gutenberg.org/ebooks/3202
2. Import it: `$ rake import:moby[mthesaur.txt]` (_assuming the unzipped thesaurus file is sitting in your rails root named `mthesaur.txt`_)

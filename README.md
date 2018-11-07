# Nostalgia #

[R.I.P. Little Printer](https://www.dezeen.com/2014/09/09/little-printer-design-company-berg-to-close/)

Nostalgia was a Little Printer publication that delivered a photo from
your Flickr photostream from today's date, any year in the past.

It's a simple Rails application that's designed to run on Heroku.

## Installation ##

Add your Flickr keys, and a new secret token for Rails. To generate a
token, open the Rails console and type `SecureRandom.hex(64)`:

    cp config/env.yml.example config/env.yml

Create a Heroku app with a Postgres database. One dyno should be
enough, and a free dev database. You should probably also add the
Logentries TryIt and New Relic add-ons to gain some insight.

### Memcached ###

Nostalgia uses the [Dalli](https://github.com/mperham/dalli) gem to
connect to a Memcached store. Get the free Memcachier add-on on Heroku
with `heroku addons:add memcachier:dev`.

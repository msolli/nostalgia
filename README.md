# Nostalgia #

Nostalgia is a Little Printer publication that delivers a photo from
your Flickr photostream from today's date, any year in the past.

It's a simple Rails application that's designed to run on Heroku.

## Installation ##

Add your Flickr keys, and a new secret token for Rails. To generate a
token, open the Rails console and type `SecureRandom.hex(64)`:

    cp config/env.yml.example config/env.yml

Create a Heroku app with a Postgres database. One dyno should be
enough, and a free dev database. You should probably also add the
Logentries TryIt and New Relic add-ons to gain some insight.

# Lucky PG Extras

Crystal port of [Ruby PG Extras](https://github.com/pawurb/ruby-pg-extras) which is a Ruby port of [Heroku PG Extras](https://github.com/heroku/heroku-pg-extras).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     lucky_pg_extras:
       github: matthewmcgarvey/lucky_pg_extras
   ```

2. Run `shards install`
3. Require the shard in `src/shards.cr`

   ```crystal
   require "lucky_pg_extras"
   ```

4. Set up the configuration in `config/lucky_pg_extras.cr`

   ```crystal
   LuckyPgExtras.configure do |settings|
     settings.database = AppDatabase
   end
   ```

## Usage

Running `lucky -h` should now show the `pg_extras` commands that are available.

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/matthewmcgarvey/lucky_pg_extras/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Matthew McGarvey](https://github.com/matthewmcgarvey) - creator and maintainer

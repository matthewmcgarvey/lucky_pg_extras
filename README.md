# lucky_db_extras

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     lucky_db_extras:
       github: matthewmcgarvey/lucky_db_extras
   ```

2. Run `shards install`
3. Require the shard in `src/shards.cr`

  ```crystal
  require "lucky_db_extras"
  ```

4. Set up the configuration in `config/lucky_db_extras.cr`

  ```crystal
  LuckyDbExtras.configure do |settings|
    settings.database = AppDatabase
  end
  ```

## Usage

Running `lucky -h` should now show the `db.extras` commands that are available.

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/matthewmcgarvey/lucky_db_extras/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Matthew McGarvey](https://github.com/matthewmcgarvey) - creator and maintainer

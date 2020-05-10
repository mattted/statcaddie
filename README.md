# StatCaddie
A small Rails application to log rounds of golf and keep track of stats. 

## Installation
Clone the repository locally and run 

  $ bundle install
  $ yarn install --check-files

Migrate and seed the database (lines below may need to be prepended with `bundle exec`)

  $ rails db:migrate
  $ rails db:seed

## Usage
Start a web server on localhost

  $ rails server

Navigate to address shown (http://localhost:3000)

Testing account:
* email: user1@test.com | password: testtest

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattted/statcaddie.

## License

This application is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# README

## Setup
#### Requirements
- Minimum Ruby 2.6
- Rails 6
- PostgreSQL
- Node 12.8 or latest
#### Environment setup
- Install or upgrade ruby and rails to the minimum requirements.
- Install or upgrade node to the minimum requirement.
- Clone the repo and cd to the project directory
- Run `bundle install`
- Run `yarn` or `npm install`
#### Run the application
- Run `rails db:create` to create the development and test database
- Run `rails db:migrate` to migrate tables
- Run `rails db:seed` to load sample employers and mapping
- Run `rails s` to start the rails server and webpacker and go to `localhost:3000` view the app
- Click on employer to upload sample csv. You can find one in `spec/fixtures/valid.csv`. The is for `Employer A`.
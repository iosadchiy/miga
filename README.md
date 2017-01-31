# MIGA rails app

## Installation

Requirements: ruby 2.4.0, execjs runtime

* clone the repo: `git clone ssh://git@bitbucket.org/iosadchii/miga-be.git`
* install gems: `bundle install`
* setup the DB: `rails db:setup`
* run tests: `rails test`
* start dev server: `rails server`

To add some fake data: `rails db:seed FAKEDATA=1`

## Resources:

* members
* plots
* setting
* payments
* dues

## Models

* Transaction
* Payment
* Counter
* CounterChecks
* Due
* Plot
* Member
* Setting

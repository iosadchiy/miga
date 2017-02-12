# MIGA rails app

## Installation

Requirements: ruby 2.4.0, execjs runtime

* clone the repo: `git clone ssh://git@bitbucket.org/iosadchii/miga-be.git`
* install gems: `bundle install`
* setup the DB: `rails db:setup`
* run tests: `rails test`
* start dev server: `rails server`

To add some fake data: `rails db:seed FAKEDATA=1`


## Flows

### Member pays for electricity

    As an admin I open payments#new(plot_number=123)
    Then I fill in current display
    And the sum field gets updated
    Then I press 'сформировать ордера'
    And the payment confirmation page opens
    And a Transaction is created
    With old/new display values, price, sum, name, plot


## TODO

* Transaction#number should go in sequence, with only confirmed counted
* split KPO rendering: separate method for each place (row, td)
* add JS to autofill payment#new fields
* develop deployment system
* add backups and recover plan
* add import of members
* add import of registers
* accept due transactions (start with membership)
* remove Transaction#status and create index/edit/destroy for transactions
* add check that Transaction#id goes in series

## Interested in feedback for

* transaction printed, but cancelled. What to do with KPO number

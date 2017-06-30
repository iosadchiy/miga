class DbsController < ApplicationController
  def show
    send_file Rails.root.join('db/production.sqlite3')
  end
end

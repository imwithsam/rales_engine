require "csv"

namespace :import do
  task customers: :environment do
    filename = File.join Rails.root, "data/customers.csv"
    # CSV.foreach(filename, headers: true) do |row|
    #   p row
    # end
    Customer.import(filename)
  end
end

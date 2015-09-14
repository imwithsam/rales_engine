require "csv"

namespace :import do
  task customers: :environment do
    filename = File.join Rails.root, "data/customers.csv"
    Customer.import(filename)
    puts "Customers imported."
  end

  task invoice_items: :environment do
    filename = File.join Rails.root, "data/invoice_items.csv"
    InvoiceItem.import(filename)
    puts "Invoice Items imported."
  end
end

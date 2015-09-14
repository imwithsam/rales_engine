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

  task invoices: :environment do
    filename = File.join Rails.root, "data/invoices.csv"
    Invoice.import(filename)
    puts "Invoices imported."
  end

  task items: :environment do
    filename = File.join Rails.root, "data/items.csv"
    Item.import(filename)
    puts "Items imported."
  end

  task merchants: :environment do
    filename = File.join Rails.root, "data/merchants.csv"
    Merchant.import(filename)
    puts "Merchants imported."
  end
end

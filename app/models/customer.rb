class Customer < ActiveRecord::Base
  include Finders

  has_many :invoices

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      customer = find_by_id(row["id"]) || new
      customer.update(customer_params(row))
      customer.save!
    end
  end

  private

  def self.customer_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:first_name, :last_name)
  end
end

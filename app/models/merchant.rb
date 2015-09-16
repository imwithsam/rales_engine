class Merchant < ActiveRecord::Base
  include Finders

  has_many :items
  has_many :invoices

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      merchant = find_by_id(row["id"]) || new
      merchant.update(merchant_params(row))
      merchant.save!
    end
  end

  private

  def self.merchant_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:name, :created_at, :updated_at)
  end
end

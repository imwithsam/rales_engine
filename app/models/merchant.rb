class Merchant < ActiveRecord::Base
  include Finders

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
    params.permit(:name)
  end
end

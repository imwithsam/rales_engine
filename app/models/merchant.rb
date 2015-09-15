class Merchant < ActiveRecord::Base
  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      merchant = find_by_id(row["id"]) || new
      merchant.update(merchant_params(row))
      merchant.save!
    end
  end

  scope :find_like_by, -> (attribute, value) { where("#{attribute} LIKE ?", value).first }

  private

  def self.merchant_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:name)
  end
end

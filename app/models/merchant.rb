class Merchant < ActiveRecord::Base
  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      merchant = find_by_id(row["id"]) || new
      merchant.update(merchant_params(row))
      merchant.save!
    end
  end

  def self.find_all_like_by(attribute, value)
    self.where("#{attribute} LIKE ?", value)
  end

  def self.find_like_by(attribute, value)
    find_all_like_by(attribute, value).first
  end

  private

  def self.merchant_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:name)
  end
end

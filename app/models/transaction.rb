class Transaction < ActiveRecord::Base
  include Finders

  belongs_to :invoice

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      transaction = find_by_id(row["id"]) || new
      transaction.update(transaction_params(row))
      transaction.save!
    end
  end

  private

  def self.transaction_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:invoice_id,
                  :credit_card_number,
                  :result,
                  :created_at,
                  :updated_at)
  end
end

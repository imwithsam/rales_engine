module Finders
  extend ActiveSupport::Concern

  module ClassMethods
    def find_all_like_by(attribute, value)
      where("#{attribute} LIKE ?", value)
    end

    def find_like_by(attribute, value)
      find_all_like_by(attribute, value).first
    end

    def random
      order("RANDOM()").first
    end
  end
end

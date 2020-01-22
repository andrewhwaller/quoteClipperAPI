class Quote < ApplicationRecord
    validates :name, :user_id, :text, presence: true
    belongs_to :user

    scope :filter_by_name, lambda { |keyword|
        where('lower(name) LIKE ?', "%#{keyword.downcase}%")
    }
end
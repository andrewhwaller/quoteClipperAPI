class Quote < ApplicationRecord
    validates :name, :user_id, :text, presence: true
    belongs_to :user

end
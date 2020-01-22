class Quote < ApplicationRecord
    validates :name, :user_id, :text, presence: true
    validates :source_publication_year, numericality: { equal_to: 4 }
    belongs_to :user
end
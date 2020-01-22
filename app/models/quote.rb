class Quote < ApplicationRecord
    validates :name, :user_id, :text, presence: true
    validates :source_publication_year, length: { is: 4 }
    belongs_to :user
end
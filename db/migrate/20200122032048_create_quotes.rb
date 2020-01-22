class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :name
      t.string :text
      t.string :source_title
      t.string :source_author
      t.integer :source_page_number
      t.string :source_publisher
      t.integer :source_publication_year
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

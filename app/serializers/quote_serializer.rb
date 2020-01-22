class QuoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :text, :source_title, :source_author, :source_page_number, :source_publisher, :source_publication_year
end

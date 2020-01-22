# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Quote.delete_all
User.delete_all

5.times do
    user = User.create! email: Faker::Internet.email, password: 'locadex1234'
    puts "Created a new user: #{user.email}"

    2.times do
        quote = Quote.create!(
            name: Faker::Educator.subject, 
            text: Faker::Quote.yoda,
            source_title: Faker::Book.title,
            source_author: Faker::Book.author,
            source_page_number: Faker::Number.number(digits: 2),
            source_publisher: Faker::Book.publisher,
            source_publication_year: Faker::Number.between(1918,2018),
            user_id: user.id
        )
        puts "Created a new quote: #{quote.name} from #{quote.source_author}"
    end
end
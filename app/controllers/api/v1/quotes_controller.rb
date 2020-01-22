class Api::V1::QuotesController < ApplicationController
    before_action :check_login, only: %i[create]
    
    def create
        quote = current_user.quotes.build(quote_params)
        if quote.save
            render json: quote, status: :created
            puts "quote saved"
        else
            render json: { errors: quote.errors }, status: :unprocessable_entity
            puts "quote not saved"
        end
    end
    
    def show
        render json: Quote.find(params[:id])
    end

    def index
        render json: Quote.all
    end

    private

    def quote_params
        params.require(:quote).permit(:name, :text, :source_title, :source_author, :source_page_number, :source_publisher, :source_publication_year)
    end
end

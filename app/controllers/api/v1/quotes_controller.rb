class Api::V1::QuotesController < ApplicationController
    before_action :set_quote, only: [:show, :update, :destroy]
    before_action :check_login, only: [:create]
    before_action :check_owner, only: [:update, :destroy]
    
    def create
        quote = current_user.quotes.build(quote_params)
        if quote.save
            render json: quote, status: :created
        else
            render json: { errors: quote.errors }, status: :unprocessable_entity
        end
    end
    
    def show
        render json: Quote.find(params[:id])
    end

    def index
        render json: Quote.all
    end

    def update
        if @quote.update(quote_params)
            render json: @quote
        else
            render json: @quote.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @quote.destroy
        head 204
    end
      

    private

    def quote_params
        params.require(:quote).permit(:name, :text, :source_title, :source_author, :source_page_number, :source_publisher, :source_publication_year)
    end

    def check_owner
        head :forbidden unless @quote.user_id == current_user&.id
    end

    def set_quote
        @quote = Quote.find(params[:id])
    end
end

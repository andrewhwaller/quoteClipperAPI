class Api::V1::QuotesController < ApplicationController
    before_action :set_quote, only: [:show, :update, :destroy]
    before_action :check_login, only: [:create, :index, :show, :update, :destroy]
    before_action :check_owner, only: [:update, :destroy, :show]
    
    def create
        quote = current_user.quotes.build(quote_params)
        quote.user_id = current_user.id
        if quote.save
            render json: QuoteSerializer.new(quote).serializable_hash, status: :created
        else
            render json: { errors: quote.errors }, status: :unprocessable_entity
        end
    end
    
    def show
        options = { include: [:user] }
        render json: QuoteSerializer.new(@quote, options).serializable_hash
    end

    def index
        @quotes = current_user.quotes.all
        if @quotes
            render json: QuoteSerializer.new(@quotes).serializable_hash
        else
            render json: { errors: quote.errors }, status: :unprocessable_entity
        end
    end

    def update
        if @quote.update(quote_params)
            render json: QuoteSerializer.new(@quote).serializable_hash
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

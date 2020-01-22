class Api::V1::QuotesController < ApplicationController
    
    def show
        render json: Quote.find(params[:id])
    end

    def index
        render json: Quote.all
    end

    
end

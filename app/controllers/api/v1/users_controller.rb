class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :check_owner, only: [:update, :destroy]
    
    def create
        @user = User.new(user_params)

        if @user.save
            render json: UserSerializer.new(@user).serializable_hash, status: :created
        else
            render json: @user.errors, status: :not_acceptable
        end
    end

    def show
        options = { include: [:quotes] }
        render json: UserSerializer.new(@user, options).serializable_hash
    end

    def update
        if @user.update(user_params)
            render json: UserSerializer.new(@user).serializable_hash
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        head 204
    end

    def login
        user = User.find_by(email: params[:email].to_s.downcase)
    
        if user && user.authenticate(params[:password])
            auth_token = JsonWebToken.encode({ user_id: user.id })
            render json: {auth_token: auth_token}, status: :ok
        else
          render json: { error: 'Invalid username / password' }, status: :unauthorized
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def check_owner
        head :forbidden unless @user.id == current_user&.id
    end
end

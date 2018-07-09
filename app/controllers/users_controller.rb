class UsersController < ApplicationController 

    def index
        render json: User.all
    end

    def create 
        user = User.create(user_params)
        render json: user
    end

    def show
        render json: User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
    end

    def destroy 
        User.destroy(params[:id])
    end

    def user_params
        params.require(:user).permit(:full_name, :email, :password)
    end

end

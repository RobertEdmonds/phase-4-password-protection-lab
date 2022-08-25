class UsersController < ApplicationController
    wrap_parameters format: []
    skip_before_action :authorize, only: [:create] 
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def create 
       user = User.create!(user_params)
       session[:user_id] = user.id 
       render json: user
    end

    def show 
       current_user = User.find(session[:user_id])
       render json: current_user
    end 
    
    private 

    def render_unprocessable_entity(invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity 
    end

    def user_params 
        params.permit(:username, :password, :password_confirmation )
    end
end

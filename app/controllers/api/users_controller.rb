class Api::UsersController < ApplicationController
    skip_before_filter :verify_authenticity_token
    def index
        render json: User.all
    end
    def show
        user = User.find(params[:id])
        render json: user
    end
    def create
        if request.post?
            user = User.new(user_params)
            if user.save
                render status: 200, json: {
                    message: "Successfully created new user",
                    user: user
                    }.to_json
            else
                render status: 422, json: {
                    errors: user.errors
                    }.to_json
            end
        end
    end
    def destroy
        user = User.find(params[:id])
        user.destroy
        render status: 200, json: {
            message: "User deleted"
        }.to_json
    end
    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render status: 200, json: {
                message: "Successfully updated user's details",
                user: user
                }.to_json
        else
            render status: 500, json: {
                message: "Cannot update user's details",
                user: user
                }.to_json
        end
    end
    private
    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
end
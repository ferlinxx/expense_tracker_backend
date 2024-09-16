class Api::V1::UsersController < ApplicationController
    def index
        @users = User.all
        render json: { message: "User selected successfully", users: @users}
    end
end

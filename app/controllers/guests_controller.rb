class GuestsController < ApplicationController
    
    def index
        render json: Guest.all, status: :created
    end
    
end

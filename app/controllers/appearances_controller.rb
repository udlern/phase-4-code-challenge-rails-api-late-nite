class AppearancesController < ApplicationController
    
    def create
        appearance = Appearance.create(appearance_params)
        render json: appearance, include: ['appearances', 'appearances.episode', 'appearances.guest']
    end

    private

    def appearance_params
        params.permit(:rating, :episode, :guest)
    end

end

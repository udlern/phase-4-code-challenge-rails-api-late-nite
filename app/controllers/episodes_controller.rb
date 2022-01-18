class EpisodesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index
        render json: Episode.all, include: ['episodes'], status: :ok
    end

    def show
        episode = Episode.find_by_id(params[:id])
        render json: episode, include: ['episodes', 'episodes.guests'], status: :ok

    end

    private

    def render_not_found_response
        render json: {error: "Episode not found" }, status: :not_found
      end
end

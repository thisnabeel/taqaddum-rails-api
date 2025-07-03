class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :update, :destroy]

  def index
    @clubs = Club.all
    render json: @clubs, each_serializer: ClubSerializer
  end

  def show
    render json: @club, serializer: ClubSerializer
  end

  def create
    @club = Club.new(club_params)

    if @club.save
      render json: @club, serializer: ClubSerializer, status: :created
    else
      render json: @club.errors, status: :unprocessable_entity
    end
  end

  def update
    if @club.update(club_params)
      render json: @club, serializer: ClubSerializer
    else
      render json: @club.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @club.destroy
    head :no_content
  end

  # GET /clubs/:id/members
  def members
    @club = Club.find(params[:id])
    render json: {
      mentors: @club.mentors,
      mentees: @club.mentees
    }
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(:title)
  end
end

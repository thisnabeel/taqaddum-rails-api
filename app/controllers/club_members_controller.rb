class ClubMembersController < ApplicationController
  before_action :set_club_member, only: [:show, :update, :destroy]

  def index
    @club_members = ClubMember.all
    render json: @club_members, each_serializer: ClubMemberSerializer
  end

  def show
    render json: @club_member, serializer: ClubMemberSerializer
  end

  def create
    @club_member = ClubMember.new(club_member_params)

    if @club_member.save
      render json: @club_member, serializer: ClubMemberSerializer, status: :created
    else
      render json: @club_member.errors, status: :unprocessable_entity
    end
  end

  def update
    if @club_member.update(club_member_params)
      render json: @club_member, serializer: ClubMemberSerializer
    else
      render json: @club_member.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @club_member.destroy
    head :no_content
  end

  private

  def set_club_member
    @club_member = ClubMember.find(params[:id])
  end

  def club_member_params
    params.require(:club_member).permit(:club_id, :memberable_type, :memberable_id)
  end
end

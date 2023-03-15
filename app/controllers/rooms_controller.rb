class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:search]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path
    else
      render 'new'
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def search
    @rooms = Room.where('rooms.address LIKE(?)', "%#{params[:address]}%")
    if params[:keyword].present?
      @rooms = Room.where([ 'rooms.room_name LIKE ? OR rooms.room_introduction LIKE ? OR rooms.address LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
    end
  end

  private
  def room_params
    params.require(:room).permit(:room_name, :room_introduction, :price, :address, :room_image, :user_id)
  end
end

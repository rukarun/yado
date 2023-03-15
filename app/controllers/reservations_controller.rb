class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations
  end

  def new
    @room = Room.find(params[:id])
    @reservation = Reservation.new(reservation_params)
  end

  def confirm
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(params.permit(:user_id, :room_id, :start_date, :end_date, :people))
    if @reservation.invalid?
      redirect_to room_path(@reservation.room.id)
    else
      @reservation.total_day = ((@reservation.end_date - @reservation.start_date) / 1.days).to_i
      @reservation.total_price = (@room.price * @reservation.total_day * @reservation.people).to_i
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    if @reservation.save
      flash[:notice] = "You made a reservation"
      redirect_to reservations_path
    else
      render 'confirm'
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :room_id, :start_date, :end_date, :people, :total_day, :total_price)
  end 
end

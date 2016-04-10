  class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  respond_to :html

  def index
    @pins = Pin.all
  end

  def show
    respond_with(@pin)
  end

  def new
    @pin = current_user.pins.build
    respond_with(@pin)
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
     redirect_to @pin, notice: 'Success!!!'
    else 
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
    redirect_to @pin, notice: 'Success!!!'
    else
    render action: 'edit'
    end 

  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private

    def correct_user 
      @pin = correct_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end 


    def set_pin
      @pin = Pin.find(params[:id])
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
    end
  end

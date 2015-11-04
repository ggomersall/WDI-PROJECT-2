require "date"

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def get_delivery_dates
    # this below is the functions and methods for creating the date to be friday
    # in order to use the method Date.today, you need to require "date" like above
    today = Date.today
    # this function is making daysUntilNextFrdiday 5 minus today
    daysUntilNextFriday = 5 - today.cwday;

    # if the days until friday are less than 3 days, it will display the next fridays date
    if daysUntilNextFriday < 3
      daysUntilNextFriday = daysUntilNextFriday + 7
    end

    # 
    friday = today + daysUntilNextFriday
    #  this makes an array for the delivery dates
    deliveryDates = [];
    # this loops through the dates alowing you to see 5 different dates
    (0..4).each do |i|
      thisFriday = friday + (i*7)
      # this line below is necessary for making the date look pretty
      # for more info see this:
      # http://ruby-doc.org/stdlib-2.1.1/libdoc/date/rdoc/Date.html#method-i-strftime
      deliveryDates << [ thisFriday.strftime("%A %-d %b"), thisFriday ]
    end
    return deliveryDates
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @deliveryDates = get_delivery_dates
  end

  # GET /orders/1/edit
  def edit
    @deliveryDates = get_delivery_dates
  end

  # POST /orders
  # POST /orders.json
  def create
    # @order = Order.new(order_params)
    @order = current_user.orders.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:delivery_date, :address_id, :payment_success, :user_id, :quantity)
    end
end

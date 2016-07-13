class PurchasesController < ApplicationController

  def index
    @purchases = Purchase.all

  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = purchases.build(purchase_params)

    if @purchase.save
    else
      flash.now[:alert] = "Error creating purchase. Please try again."
    end
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  private

  def purchase_params
    params.require(:purchase).permit(:lesson_id, :user_id, :amount)
  end
end
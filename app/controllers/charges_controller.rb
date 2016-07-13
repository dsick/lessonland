class ChargesController < ApplicationController

  def new
    if user_signed_in?
      @lesson = Lesson.find(params[:lesson_id])
      @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        #key: "pk_test_z3971ulOJS1heFJXHUYprE5Z",
        description: "Lesson Land - #{@lesson.name}",
        amount: (@lesson.price*100).round, #Amount.default
        label: "Purchase for #{ActiveSupport::NumberHelper.number_to_currency(@lesson.price)}"
      }
    else
      redirect_to root_path
      flash[:notice] = "You must be signed in to do that."
    end
  end

  def create
    @lesson = Lesson.find(params[:lesson_id])

    @amount = @lesson.price
    @final_amount = @amount

    @code = params[:couponCode]

    if !@code.blank?
      @discount = get_discount(@code)

      if @discount.nil?
        flash[:error] = 'Coupon code is not valid or expired.'
        redirect_to new_charge_path
        return
      else
        @discount_amount = @discount 
        @final_amount = @amount - @discount_amount.to_f
      end

      charge_metadata = {
        :coupon_code => @code,
        :coupon_discount => (@discount * 100).to_s + '%'
      }
    end
       

    charge_metadata ||= {}

    # Creates a Stripe Customer object, for associating
    # with the charge

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: (@final_amount*100).round,
      description: "Lesson Land - #{@lesson.name}",
      currency: 'usd'
    )

    Purchase.create(lesson_id: @lesson.id, user_id: current_user.id, amount: @final_amount.round(2))

    flash[:notice] = "Thanks for purchasing #{@lesson.name}."
    redirect_to user_path(current_user) # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  private

  COUPONS = {
    'FIRST' => 1.00,
    'SECOND' => 0.50
  }

  def get_discount(code)
    # Normalize user input
    code = code.gsub(/ +/, '')
    code = code.upcase
    COUPONS[code]
  end
end

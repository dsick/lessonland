module StripeHelper

  def stripe_charge_button(lesson)
    form_tag(charges_path, method: :create) +
      text_field_tag(:couponCode, nil, placeholder: 'enter coupon code', class: "coupon") +
      hidden_field_tag(:lesson_id, lesson.id) +
      javascript_include_tag("https://checkout.stripe.com/checkout.js", class: 'stripe-button', data: {key: @stripe_btn_data[:key], amount:  @stripe_btn_data[:amount], description: @stripe_btn_data[:description], label: @stripe_btn_data[:label] }) 
  end

end
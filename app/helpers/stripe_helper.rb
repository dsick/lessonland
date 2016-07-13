module StripeHelper

  def stripe_charge_button(lesson)
    form_tag(charges_path, method: :create) +
      hidden_field_tag(:lesson_id, lesson.id) +
      javascript_include_tag("https://checkout.stripe.com/checkout.js", class: 'stripe-button', data: {key: @stripe_btn_data[:key], amount:  @stripe_btn_data[:amount], description: @stripe_btn_data[:description], label: @stripe_btn_data[:label] }) 
  end

end
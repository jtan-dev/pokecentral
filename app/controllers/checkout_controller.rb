class CheckoutController < ApplicationController
    def create
        @product = Product.find(params[:id])

        if @product.nil?
            redirect_to root_path
            return
        end

        # Setting up a Stripe Session for payment
        @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            mode: 'payment',
            line_items: [{
                price_data: {
                    currency: 'cad',
                    product_data: {
                        name: @product.name,
                        description: @product.description
                    },
                    unit_amount: (@product.price * 100).to_i
                },
                quantity: 1
            }],
            success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
            cancel_url: checkout_cancel_url
        )

        respond_to do |format|
            format.js { render js: "" } # Add an empty response for JS format
            format.html { redirect_to @session.url, allow_other_host: true } # Redirect to the session URL for HTML format with allow_other_host option
        end
    end

    def cancel
    end

    def success
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    end 
end

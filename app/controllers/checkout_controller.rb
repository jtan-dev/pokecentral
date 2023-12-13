class CheckoutController < ApplicationController
    def create
        # @product = Product.find(params[:id])

        @customer = Customer.find(params[:id])

        if params[:customer]["street_address"] != ""
            @customer.street_address = params[:customer]["street_address"]
        end

        if params[:customer]["postal_code"] != ""
            @customer.postal_code = params[:customer]["postal_code"]
        end

        if params[:customer]["city"] != ""
            @customer.city = params[:customer]["city"]
        end

        @customer.province_id = params[:customer]["province_id"]

        @customer.save

        @products = []

        @cart_subtotal = 0

        session[:cart].each do |item|
            product = Product.find(item["id"].to_i)
            @products << {"product" => product, "qty" => item["qty"]}
            @cart_subtotal += product.price * item["qty"]
        end

        if @products.nil?
            redirect_to root_path
            return
        end


        line_items = []

        @products.each do |item|
            line_items << {
                price_data: {
                    currency: 'cad',
                    product_data: {
                        name: item["product"].name,
                        description: item["product"].description
                    },
                    unit_amount: (item["product"].price * 100).to_i
                },
                quantity: item["qty"]
            }
        end

        taxed_total = (@cart_subtotal * @customer.province.pst) +
            (@cart_subtotal * @customer.province.gst) +
            (@cart_subtotal * @customer.province.hst)

        line_items << {
            price_data: {
                currency: 'cad',
                product_data: {
                    name: "Taxes"
                },
                unit_amount: (taxed_total * 100).to_i
            },
            quantity: 1
        }

        # Setting up a Stripe Session for payment
        @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            mode: 'payment',
            line_items: line_items,
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

        @product = nil

        @cart_subtotal = 0

        session[:cart].each do |item|
            @product = Product.find(item["id"].to_i)
            @cart_subtotal += @product.price * item["qty"]
        end

        @customer = current_customer

        taxed_total = (@cart_subtotal * @customer.province.pst) +
        (@cart_subtotal * @customer.province.gst) +
        (@cart_subtotal * @customer.province.hst)

        order = @customer.orders.create(
            status: "Started",
            tax: taxed_total,
            total: taxed_total + @cart_subtotal
        )

        session[:cart].each do |item|
            @product = Product.find(item["id"].to_i)
            ProductOrder.create(order: order, product: @product, quantity: item["qty"], subtotal: (@product.price * item["qty"]))
        end

        session[:cart] = []
    end

    def review
        @customer = current_customer

        @cart = []

        @cart_subtotal = 0

        session[:cart].each do |item|
            product = Product.find(item["id"])

            @cart_subtotal += product.price * item["qty"]

            @cart << {
                "product" => product,
                "qty" => item["qty"],
                "product_subtotal" => (product.price * item["qty"])
            }
        end
    end
end

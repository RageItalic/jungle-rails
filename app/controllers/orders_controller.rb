class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    #byebug
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
      # notification_email = Notifier.sample_email(current_user)
      # notification_email.deliver_now
    else
      redirect_to cart_path, error: order.errors.full_messages.first
    end

    rescue Stripe::CardError => e
      redirect_to cart_path, error: e.message
    end
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_total, # in cents
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_total,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )
    cart.each do |product_id, details|
      if product = Product.find_by(id: product_id)
        quantity = details['quantity'].to_i
        order.line_items.new(
          product: product,
          quantity: cart[product_id]['quantity'],
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
    end

    order.save!
    notification_email = Notifier.sample_email(current_user, order)
    notification_email.deliver_now
    order
  end

  # def order_summary
  #   cart.each do |product_id, details|
  #     if product = Product.find_by(id: product_id)
  #       quantity = details['quantity'].to_i
  #       product_name = product.name,
  #       description = product.description,
  #       image = product.image
  #       order.line_items.new(
  #         product: product,
  #         quantity: quantity,
  #         name: product_name,
  #         description: prod
  #       )
  #     end
  #   end
  # end


  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0
    cart.each do |product_id, details|
      if p = Product.find_by(id: product_id)
        total += p.price_cents * details['quantity'].to_i
      end
    end
    total
  end


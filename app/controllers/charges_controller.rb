class ChargesController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @amount = @event.price * 100
  end

  def create
    # Amount in cents
    @event = Event.find(params[:event_id])
    @amount = @event.price * 100

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    @attendance = Attendance.create(stripe_customer_id: params[:stripeToken], user: current_user, event: @event)
      redirect_to @event
      flash[:success] = "Paiement bien reçu. Have fun!"

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_event_charge_path
  end

end

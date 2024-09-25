class PaymentsController < ApplicationController
  # POST /payments
  def create
    booking = Booking.find(params[:booking_id])

    existing_payment = Payment.find_by(booking_id: params[:booking_id].to_i)
    if existing_payment
      render json: { error: 'Payment already exists for this booking.' }, status: :unprocessable_entity
      return
    end
    
    # Assuming total_amount needs to be calculated here
    total_amount = calculate_total_amount(booking, params[:price_per_night])
    create_payment(booking.id, total_amount)
    
    render json: { message: 'Payment created successfully' }, status: :created
  end

  # POST /payment_intents
  def create_payment_intent
    booking = Booking.find(params[:booking_id])
    price_per_night = params[:price_per_night]

    begin
      service = BillCalculationService.new(booking, price_per_night)

      if service.call
        payment_intent = Stripe::PaymentIntent.create(
          amount: (service.total_amount * 100).to_i, # Convert to cents and ensure it's an integer
          currency: 'usd',
          description: 'Booking payment',
          metadata: { booking_id: booking.id }
        )
        render json: { client_secret: payment_intent.client_secret, payment_id: payment_intent.id }, status: :ok
      else
        render json: { errors: 'Failed to create payment' }, status: :unprocessable_entity
      end
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  private

  def create_payment(booking_id, amount)
    Payment.create!(
      booking_id: booking_id,
      total_amount: amount
    )
  end

  def calculate_total_amount(booking, price_per_night)
    nights = (booking.end_date - booking.start_date).to_i
    (nights * price_per_night.to_f).round(2) # Ensure two decimal places
  end
end

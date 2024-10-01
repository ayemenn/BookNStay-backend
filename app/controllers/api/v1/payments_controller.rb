module Api::V1
  class PaymentsController < ApplicationController
    def create
      booking = Booking.find(params[:booking_id])

      existing_payment = Payment.find_by(booking_id: params[:booking_id].to_i)
      if existing_payment
        render json: { error: 'Payment already exists for this booking.' }, status: :unprocessable_entity
        return
      end
      service = BillCalculationService.new(booking, params[:price_per_night])

      if service.call
        create_payment(booking.id, service.total_amount)
        render json: { message: 'Payment created successfully' }, status: :created
      else
        render json: { error: 'Failed to calculate total amount.' }, status: :unprocessable_entity
      end
    end

    # payment_intents
    def create_payment_intent
      booking = Booking.find(params[:booking_id])
      service = BillCalculationService.new(booking, params[:price_per_night])

      if service.call
        begin
          payment_intent = Stripe::PaymentIntent.create(
            amount: (service.total_amount * 100).to_i, 
            currency: 'usd',
            description: 'Booking payment',
            metadata: { booking_id: booking.id }
          )
          render json: { client_secret: payment_intent.client_secret, payment_id: payment_intent.id }, status: :ok
        rescue Stripe::StripeError => e
          render json: { error: "Stripe error: #{e.message}" }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Failed to calculate total amount.' }, status: :unprocessable_entity
      end
    end

    private

    def create_payment(booking_id, amount)
      Payment.create!(
        booking_id: booking_id,
        total_amount: amount
      )
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "Failed to create payment: #{e.message}" }, status: :unprocessable_entity
    end
  end
end
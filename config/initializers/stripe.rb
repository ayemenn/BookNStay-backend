require 'stripe'
Stripe.api_key = Rails.application.credentials.stripe[:key]

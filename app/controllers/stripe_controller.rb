class StripeController < ApplicationController

	skip_before_action :verify_authenticity_token, only: [:webhook]

	def purchase_success

	end

	def cancel_purchase

	end

	def webhook
		payload = request.body.read
		sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
		event = nil

		begin
			event = Stripe::Webhook.construct_event(
				payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
			)
		rescue JSON::ParserError => e
			render json: { message: 'Invalid signature' }, status: 400
			return
		end

		if event['type'] == 'checkout.session.completed'
			session = event['data']['object']
			payment_confirmed(session.metadata.booking_id)
		end
	end

	def payment_confirmed(booking_id)
		Booking.update(booking_id, :status => 'paid')
	end

	def create_checkout_session
		Stripe.api_key = ENV['STRIPE_API_KEY']
		session = Stripe::Checkout::Session.create({
			metadata: {
				booking_id: params[:booking_id]
			},
			customer_email: current_user.email,
			line_items: [
				{
					price: 'price_1Pkp5bP8Bt7gJ5s50wQcMC3S',
					#change to value from passenger number
					quantity: 1
				}
			],
			mode: 'payment',
			success_url: purchase_success_url,
			cancel_url: cancel_purchase_url
		})

		redirect_to session.url, allow_other_host: true, status: 303
	end
end

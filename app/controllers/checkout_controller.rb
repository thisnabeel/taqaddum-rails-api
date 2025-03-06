class CheckoutController < ApplicationController

  def money_raised
    net_money_raised = 0
    has_more = true
    starting_after = nil

    while has_more
      transactions = Stripe::BalanceTransaction.list(limit: 100, starting_after: starting_after)
      
      transactions.data.each do |txn|
        if txn.type == "charge" # Only count money received from customers
          net_money_raised += txn.net # 'net' already has fees deducted
        end
      end

      has_more = transactions.has_more
      starting_after = transactions.data.last.id if has_more
    end

    puts "Net Money Raised (After Stripe Fees): $#{net_money_raised / 100.0}"

    render json: { net_money_raised: net_money_raised / 100.0 }
  end

  def create
    amount = params[:amount].to_i * 100 # Convert to cents

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: { name: params[:name] },
          unit_amount: amount
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: "#{params[:success_url]}?thank_you=true&session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{params[:cancel_url]}"
    )

    render json: { sessionId: session.id }
  end

  def success
    session_id = params[:session_id]
    session = Stripe::Checkout::Session.retrieve(session_id)

    payment_intent = Stripe::PaymentIntent.retrieve(session.payment_intent)

    render json: {
      amount_received: payment_intent.amount_received / 100.0, # Convert to dollars
      currency: payment_intent.currency,
      status: payment_intent.status
    }
  end
end

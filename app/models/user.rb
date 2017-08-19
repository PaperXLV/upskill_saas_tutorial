#functions for user needs to be in the models/user.rb file
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  # If Pro user passes validations (email, pass, etc.),
  # then call Stripe and tell Stripe to set up a subscription
  # upon charging the customer's card.
  # Stripe responds back with customer data
  # Store customer.id as customer token and save the user.
  attr_accessor :stripe_card_token
  # whitelist the card_token so we can look at it from here
  def save_with_subscription
    if valid?
      #stripe gem, read the documentation
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end

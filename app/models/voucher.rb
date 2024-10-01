# app/models/voucher.rb
class Voucher < ApplicationRecord
    validates :name, presence: true
    validates :discount_percentage, presence: true
    validates :min_amount, presence: true
  end
  
class BillCalculationService
  attr_reader :total_amount

  def initialize(booking, price_per_night,voucher=nil)
    @booking = booking
    @price_per_night = price_per_night.to_f
    @voucher= voucher
  end
  
  def call
    calculate_total_amount
    apply_discount if @voucher && eligible_for_discount?
     Rails.logger.info "Final total amount after discount: #{@total_amount}"
  end

  private 

  def calculate_total_amount
    nights = (@booking.end_date - @booking.start_date).to_i
    @total_amount = (nights * @price_per_night).round(2)
  end

  def eligible_for_discount?
    @total_amount>=@voucher.min_amount
  end

  def apply_discount
    discount_percentage = @voucher.discount_percentage.to_f 
    Rails.logger.info "Applying discount: Total Amount=#{@total_amount}, Discount Percentage=#{discount_percentage}"
    discount = (@total_amount * (discount_percentage / 100)).round(2)
    @total_amount -= discount
    Rails.logger.info "Calculated Discount=#{discount}, Total Amount after discount=#{@total_amount}"
  end
  
end

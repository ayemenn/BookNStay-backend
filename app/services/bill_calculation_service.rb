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
  end


  private

  def calculate_total_amount
    nights = (@booking.end_date - @booking.start_date).to_i
    @total_amount = (nights * @price_per_night).round(2) # Ensure two decimal places
  end

  def eligible_for_discount
    @total_amount>=@voucher.min_amount
  end
  def apply_discount
    discount=(total_amount* (@voucher.discount_percentage/100)).round(2)
    @total_amount-=discount
  end
end

class BillCalculationService
  attr_reader :total_amount

  def initialize(booking, price_per_night)
    @booking = booking
    @price_per_night = price_per_night.to_f
  end

  def call
    calculate_total_amount
  end

  private

  def calculate_total_amount
    nights = (@booking.end_date - @booking.start_date).to_i
    @total_amount = (nights * @price_per_night).round(2) # Ensure two decimal places
  end
end

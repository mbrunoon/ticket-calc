class SalesController < ApplicationController
  
  before_action :set_date

  def index
    @daily_sales = Ticket.total_sold_with_variations(month: @month, year: @year)
  end

  private

  def set_date
    @month  = params["[sales_date(2i)]"] || Date.today.month
    @year   = params["[sales_date(1i)]"] || Date.today.year
  end

end

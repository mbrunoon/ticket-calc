class Ticket < ApplicationRecord

    enum :status, { pending: 0, sold: 1, canceled: 2, reversed: 3 }


    def register_sell
        self.update(status: 1, sold_at: Date.today)
    end

    def self.total_sold_with_variations(month: Date.today.month, year: Date.today.year)
        month = month.to_i
        year = year.to_i
        
        start_date = Date.new(year, month, 1)
        end_date = start_date.end_of_month

        daily_sales = Ticket.where(sold_at: start_date..end_date).order(sold_at: :desc).group(:sold_at).count.to_a

        daily_sales.each_cons(2) do |today, yesterday|
            today << calculate_diff(today[1], yesterday[1])
        end
            
        hash_sales = Hash.new
        daily_sales.each do |sale|
            hash_sales[sale[0].strftime("%d/%m/%Y")] = {
                total: sale[1],
                difference: sale[2].blank? ? "" : "#{sale[2]}%"
            }
        end

        hash_sales
    end

    def self.calculate_diff(val1, val2)
        (((val1 - val2).to_f / val2) * 100).round(2)
    end

end


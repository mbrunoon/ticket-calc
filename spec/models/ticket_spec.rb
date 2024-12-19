require 'rails_helper'

RSpec.describe Ticket, type: :model do
  
  context "enums" do
    it "check values" do
      statuses = Ticket.statuses
      
      expect(statuses["pending"]).to eq 0
      expect(statuses["sold"]).to eq 1
      expect(statuses["canceled"]).to eq 2
      expect(statuses["reversed"]).to eq 3
    end
  end

  context "methods" do
    it "register_sell" do
      ticket = Ticket.create

      expect(ticket.status).to eq("pending")
      ticket.register_sell
      ticket.reload

      expect(ticket.status).to eq("sold")
    end
  end

  context "class methods" do
    it "total_sold_with_variations" do
      
      start_date = Date.new(2024, 1, 1)

      3.times { Ticket.create(status: "sold", sold_at: start_date) }
      6.times { Ticket.create(status: "sold", sold_at: start_date + 1.day ) }
      2.times { Ticket.create(status: "sold", sold_at: start_date + 2.day ) }

      result = Ticket.total_sold_with_variations(month: start_date.month, year: start_date.year) 
      
      expect(result.length).to eq(3)
    end

    it "calculate_diff" do
      value = Ticket.calculate_diff(10, 9)
      expect(value).to eq(11.11)
    end
  end

end

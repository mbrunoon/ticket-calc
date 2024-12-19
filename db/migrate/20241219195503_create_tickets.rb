class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.integer :status, default: 0
      t.date :sold_at

      t.timestamps
    end
  end
end

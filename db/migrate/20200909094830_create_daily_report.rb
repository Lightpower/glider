class CreateDailyReport < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_reports do |t|
      t.references :user,               null: false
      t.datetime   :date_at,            null: false      
      t.boolean    :closed,             defaut: false
      t.float      :points,             default: 0
      t.float      :percent_completion, default: 0
    end

    add_index :daily_reports, :date_at    
  end
end

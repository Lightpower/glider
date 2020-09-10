class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user,        null: false
      t.references :category,    null: false
      t.string     :name,        null: false, default: ""
      t.text       :description
      t.datetime   :assigned_at, null: false
      t.integer    :priority,    null: false, default: 0
      t.integer    :state,       null: false, default: 0

      t.timestamps
    end

    add_index :tasks, :assigned_at
    add_index :tasks, :state
  end
end

class CreateTaskActions < ActiveRecord::Migration[6.0]
  def change
    create_table :task_actions do |t|
      t.references :task, null: false
      t.datetime :done_at, null: false
      t.integer :priority, null: false, default: 0
      t.integer :state, null: false
    end

    add_index :task_actions, :done_at
    add_index :task_actions, :priority
    add_index :task_actions, :state
  end
end

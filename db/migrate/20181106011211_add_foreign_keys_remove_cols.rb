class AddForeignKeysRemoveCols < ActiveRecord::Migration[5.2]
  def change
    remove_column :rentals, :customer_id
    remove_column :rentals, :movie_id

    add_reference :rentals, :customer, foreign_key: true
    add_reference :rentals, :movie, foreign_key: true

    add_column :rentals, :due_date, :date

  end
end

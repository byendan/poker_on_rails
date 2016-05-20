class AddTableToDealer < ActiveRecord::Migration
  def change
    add_reference :dealers, :table, index: true, foreign_key: true
  end
end

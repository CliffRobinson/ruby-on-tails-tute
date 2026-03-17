class AddTypeToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :type, :string
  end
end

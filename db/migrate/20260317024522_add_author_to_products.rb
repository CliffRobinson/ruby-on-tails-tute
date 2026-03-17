class AddAuthorToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :author, :string
  end
end

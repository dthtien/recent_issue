class AddReadToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :read, :boolean, default: false
  end
end

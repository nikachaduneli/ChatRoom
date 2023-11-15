class ChangeColumnNameInMessage < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :user_id, :sender_id
  end
end

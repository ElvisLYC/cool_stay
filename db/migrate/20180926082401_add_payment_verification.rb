class AddPaymentVerification < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :payment_status, :boolean, default: false
  end
end

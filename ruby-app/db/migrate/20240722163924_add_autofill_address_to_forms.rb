class AddAutofillAddressToForms < ActiveRecord::Migration[6.0]
  def change
    add_column :forms, :autofill_address, :boolean, default: true
  end
end

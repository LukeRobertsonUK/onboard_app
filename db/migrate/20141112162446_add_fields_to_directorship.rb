class AddFieldsToDirectorship < ActiveRecord::Migration
  def change
    add_column :directorships, :duedil_id, :string
    add_column :directorships, :active, :boolean
    add_column :directorships, :status, :string
    add_column :directorships, :appointment_date, :string
    add_column :directorships, :function, :string
    add_column :directorships, :position, :string
    add_column :directorships, :address1, :string
    add_column :directorships, :address2, :string
    add_column :directorships, :address3, :string
    add_column :directorships, :address4, :string
    add_column :directorships, :address5, :string
    add_column :directorships, :postcode, :string




  end
end

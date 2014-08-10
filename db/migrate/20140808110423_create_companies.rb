class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :duedil_co_url
      t.string :duedil_locale
      t.date :incorporation_date
      t.string :reg_co_num
      t.string :reg_address1
      t.string :reg_address2
      t.string :reg_address3
      t.string :reg_address4
      t.string :reg_address_postcode
      t.string :phone
      t.string :website
      t.string :email
      t.string :currency
      t.string :employee_count

      t.timestamps
    end
  end
end

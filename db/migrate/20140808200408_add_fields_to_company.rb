class AddFieldsToCompany < ActiveRecord::Migration
  def change
     add_column :companies, :turnover, :bigint
      add_column :companies, :shareholders_funds, :bigint
  end
end

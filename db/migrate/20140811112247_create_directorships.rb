class CreateDirectorships < ActiveRecord::Migration
  def change
    create_table :directorships do |t|
      t.references :director
      t.references :company

      t.timestamps
    end
    add_index :directorships, :director_id
    add_index :directorships, :company_id
  end
end

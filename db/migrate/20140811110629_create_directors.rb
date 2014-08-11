class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :forename
      t.string :surname
      t.date :date_of_birth
      t.string :duedil_id
      t.string :duedil_director_url

      t.timestamps
    end
  end
end

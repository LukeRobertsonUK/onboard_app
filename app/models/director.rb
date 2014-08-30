jclass Director < ActiveRecord::Base
  attr_accessible :date_of_birth, :duedil_director_url, :duedil_id, :forename, :surname

  has_many :directorships
  has_many :companies, through: :directorships

  # validates :duedil_id, uniqueness: true
end

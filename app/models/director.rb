class Director < ActiveRecord::Base
  attr_accessible :date_of_birth, :duedil_director_url, :duedil_id, :forename, :surname

  has_many :directorships
  has_many :companies, through: :directorships
  before_destroy :delete_directorships
  # validates :duedil_id, uniqueness: true

    def delete_directorships
      Directorship.where(director_id: self.id).each {|directorship| directorship.destroy}
    end

end

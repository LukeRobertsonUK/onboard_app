class Directorship < ActiveRecord::Base
  attr_accessible :company_id, :director_id, :director_forename, :duedil_id, :active, :status, :appointment_date, :function, :position, :address1, :address2, :address3, :address4, :address5, :postcode
  belongs_to :director
  belongs_to :company

  validates :company_id, :uniqueness => { :scope => :director_id }


  def director_forename
    director.forename if director
  end

  def director_forename=(forename)
    self.director = Director.find_or_create_by_forename(forename) unless forename.blank?
  end

  def director_date_of_birth
    director.date_of_birth if director
  end

  def director_surname
    director.surname if director
  end

end
#
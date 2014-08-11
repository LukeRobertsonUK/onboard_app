class Directorship < ActiveRecord::Base
  attr_accessible :company_id, :director_id, :director_forename
  belongs_to :director
  belongs_to :company

  validates :company_id, :uniqueness => { :scope => :director_id }


  def director_forename
    director.forename if director
  end

  def director_forename=(forename)
    self.director = Director.find_or_create_by_forename(forename) unless forename.blank?

  end
end

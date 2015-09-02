class Company < ActiveRecord::Base
  attr_accessible :currency, :description, :duedil_co_url, :duedil_locale, :email, :employee_count, :incorporation_date, :name, :phone, :reg_address1, :reg_address2, :reg_address3, :reg_address4, :reg_address_postcode, :reg_co_num, :shareholders_funds, :turnover, :website, :turnover, :shareholders_funds, :directorships_attributes, :directors_attributes

  has_many :directorships
  has_many :directors, through: :directorships
  validates :name, presence: true
  validates :reg_co_num, uniqueness: true
  validates :reg_co_num, presence: true
  validates :duedil_co_url, uniqueness: :true
  before_destroy :delete_directorships
  accepts_nested_attributes_for :directorships, allow_destroy: true
  accepts_nested_attributes_for :directors, allow_destroy: true

    def delete_directorships
      Directorship.where(company_id: self.id).each {|directorship| directorship.destroy}
    end



    def self.duedil_search(name, limit)
        response = Duedil.company_search(name, limit)

        if response
            response["data"].map do |item|
                if item['locale']
                    item['locale'] = item['locale'].upcase
                    { label: "#{item['name']} (#{item['id']} / #{item['locale']})",
                    value: item }
                else
                    { label: "#{item['name']} (#{item['id']})",
                    value: item }
                end
            end
        end
  end

  def self.autopopulate_fields(duedil_co_url)
    company_hash = {}
    key_company_info = Futuroscope::Future.new{ Duedil.get(duedil_co_url)}
    registered_address = Futuroscope::Future.new{ Duedil.get("#{duedil_co_url}/registered-address")}


    if key_company_info.future_value
        company_hash[:duedil_co_url] = duedil_co_url
        duedil_co_url[20] == "u" ? company_hash[:locale] = "UK" : company_hash[:locale] = "ROI"
        company_hash[:reg_co_num] = key_company_info["id"]
        company_hash[:name] = key_company_info["name"]
        company_hash[:description] = key_company_info["description"]
        company_hash[:incorporation_date] = key_company_info["incorporation_date"]
        company_hash[:currency] =  key_company_info["accounts_currency"].upcase if key_company_info["accounts_currency"]
        company_hash [:status] = key_company_info["status"]
        company_hash [:employee_count] = key_company_info["accounts_no_of_employees"]
        company_hash[:turnover] = key_company_info["accounts_turnover"]
        company_hash[:shareholders_funds] = key_company_info["accounts_shareholder_funds"]
    end
    if registered_address.future_value
        company_hash[:website] = registered_address["website"]
        company_hash[:email] = registered_address["email"]
        company_hash[:reg_address1] = registered_address["address1"]
        company_hash[:reg_address2] = registered_address["address2"]
        company_hash[:reg_address3] = registered_address["address3"]
        company_hash[:reg_address4] = registered_address["address4"]
        company_hash[:reg_address_postcode] = registered_address["postcode"]
        company_hash[:phone] = registered_address["phone"]
    end
    company_hash

  end

  def self.existing_record(url)
    Company.where(duedil_co_url: url).first
  end

  def get_active_directorships
    directors_list = Futuroscope::Future.new {
      directors_response = Duedil.get("#{duedil_co_url}/directors", {limit: 100})
      list = directors_response["data"]
      next_directors_url = directors_response["pagination"]["next_url"]

      while next_directors_url
        response = Duedil.get_page(next_directors_url)
        list << response["data"]
        list.flatten!
        next_directors_url = response["pagination"]["next_url"]
      end
      list
    }

      directorships_list = Futuroscope::Future.new {
        directorships_response= Duedil.get("#{duedil_co_url}/directorships", {limit: 100})
        list = directorships_response["data"]
        next_directorships_url = directorships_response["pagination"]["next_url"]

        while next_directorships_url
          response = Duedil.get_page(next_directorships_url)
          directorships_list << response["data"]
          directorships_list.flatten!
          next_directorships_url = response["pagination"]["next_url"]
        end
        list
      }






    directorships_list.map do |directorship_hash|
      directorship_hash[:director] = directors_list.select {|director_hash| director_hash["director_url"] == directorship_hash["directors_uri"]}[0]
    end

    directorships_list.reject{|director_hash| director_hash["active"] != true}

  end

  def import_directors
    get_active_directorships.each do |directorship_hash|

      director_record = Director.find_or_initialize_by_duedil_director_url(directorship_hash[:director]["director_url"])
      director_record.update_attributes!(
        duedil_id: directorship_hash[:director]["id"],
        forename: directorship_hash[:director]["forename"],
        surname: directorship_hash[:director]["surname"],
        date_of_birth: directorship_hash[:director]["date_of_birth"]
      )

      directorship_record = Directorship.find_or_initialize_by_company_id_and_director_id(self.id, director_record.id)
      directorship_record.update_attributes!(
        duedil_id: directorship_hash["id"],
        active: directorship_hash["active"],
        status: directorship_hash["status"],
        appointment_date: directorship_hash["appointment_date"],
        function: directorship_hash["function"],
        position: directorship_hash["position"],
        address1: directorship_hash["address1"],
        address2: directorship_hash["address2"],
        address3: directorship_hash["address3"],
        address4: directorship_hash["address4"],
        postcode: directorship_hash["postcode"]
      )

    end


  end




end











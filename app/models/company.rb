class Company < ActiveRecord::Base
  attr_accessible :currency, :description, :duedil_co_url, :duedil_locale, :email, :employee_count, :incorporation_date, :name, :phone, :reg_address1, :reg_address2, :reg_address3, :reg_address4, :reg_address_postcode, :reg_co_num, :shareholders_funds, :turnover, :website, :turnover, :shareholders_funds


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


    # search_results = {}
    # search_results["array_of_names"] = response["data"].map { |result| result["name"] }
    # response["data"].each {|result| search_results[result["name"]] = result}
    # search_results
  end

  def self.autopopulate_fields(duedil_co_url)
    key_company_info = Duedil.get(duedil_co_url)
    registered_address = Duedil.get("#{duedil_co_url}/registered-address")
    company_hash = {}
    if key_company_info
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
    if registered_address
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


end

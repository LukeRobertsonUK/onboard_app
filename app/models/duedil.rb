class Duedil

  def self.company_search(name, limit)
    (HTTParty.get(URI.encode("http://duedil.io/v3/companies?filters={\"name\":\"#{name}\"}&api_key=#{Rails.application.config.duedil[:pro_api_v3_key]}&limit=#{limit}")))["response"]
  end

  def self.get(url)
     (HTTParty.get(URI.encode("#{url}?api_key=#{Rails.application.config.duedil[:pro_api_v3_key]}")))["response"]
  end


end
class Duedil

  def self.company_search(name, limit)
    url = "http://duedil.io/v3/companies?filters=%7B%22name%22:%22#{CGI::escape(name)}%22%7D&api_key=#{Rails.application.config.duedil[:pro_api_v3_key]}&limit=#{limit}"
    (HTTParty.get(url))["response"]
  end

  def self.get(url, options = {})
    if options[:limit]
     (HTTParty.get(URI.encode("#{url}?api_key=#{Rails.application.config.duedil[:pro_api_v3_key]}&limit=#{options[:limit]}")))["response"]
    else
      (HTTParty.get(URI.encode("#{url}?api_key=#{Rails.application.config.duedil[:pro_api_v3_key]}")))["response"]
    end
  end

  def self.get_page(url)
      (HTTParty.get(URI.encode("#{url}&api_key=#{Rails.application.config.duedil[:pro_api_v3_key]}")))["response"]
  end

end
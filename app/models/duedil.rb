class Duedil


  def self.encode(pagination_url)
    split_by_filters = pagination_url.split("filters={")
    if split_by_filters[1]
      url_start = URI.encode("#{split_by_filters[0]}filters={")
      url_end = URI.encode("}#{split_by_filters[1].split("}")[1]}")
      filters_text = CGI::escape(split_by_filters[1].split("}")[0])
      return url_start + filters_text + url_end
    else
      return URI.encode(split_by_filters[0])
    end
  end

  def self.company_search(name, limit)
    url = "http://duedil.io/v3/companies?filters={\"name\":\"#{name}\"}&api_key=#{Rails.application.config.duedil[:pro_api_v3_key]}&limit=#{limit}"
    (HTTParty.get(Duedil.encode(url)))["response"]

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
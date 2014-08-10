#coding: utf-8
module CompaniesHelper

  def pretty_name_string(company)
    company.name.split.map{|word| word.capitalize}.join(' ')
  end

  def currency(company)
    case company.currency
      when "GBP"
        "£"
      else
        company.currency
      end
  end

  def registered_address_string(line1, line2, line3, line4, postcode)
    [line1, line2, line3, line4, postcode].reject{|element| element.length == 0}.join(', ')
  end

  def one_liner(company)
    company.duedil_locale.blank? ? "#{pretty_name_string(company)} (#{company.reg_co_num})" : "#{pretty_name_string(company)} (#{company.reg_co_num} / #{company.duedil_locale})"
  end


end

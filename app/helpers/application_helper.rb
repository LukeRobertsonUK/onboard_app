module ApplicationHelper
 def financials(number)
    number_with_delimiter(number, :delimiter => ',')
  end

  def prettify(string)
    string.split.map{|word| word.capitalize}.join(' ')
  end

end

require 'date'
require 'rexml/document'

class Wish

  def initialize(parameters)
    @wish_date = Date.parse(parameters.attributes['date'])
    @wish_text = parameters.text.strip
  end

  def to_s
    return  "#{@wish_date.strftime("%d.%m.%Y")}: #{@wish_text}"
  end

  def overdue?
    today = Date.today
    if today >= @wish_date
      return true
    else
      false
    end
  end
end

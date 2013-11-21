module LoansHelper
  def conditional_format(number)
    if number.start_with?("-")
      "<span class=\"negative\">#{number}</span>".html_safe
    else
      "<span class=\"positive\">#{number}</span>".html_safe
    end
  end
end

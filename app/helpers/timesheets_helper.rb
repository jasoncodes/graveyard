module TimesheetsHelper
  def this_week
    (Date.today.beginning_of_week..Date.today.end_of_week)
  end
end

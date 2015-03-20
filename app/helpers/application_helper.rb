# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def next_work_day
    day = Date.today.next.wday.to_i
    day = 1 if (day==6 || day==0)
    day
  end
  
  def next_work_date
    date = Date.today.next
    day = date.wday.to_i
    if day == 6 # Sobota
      date += 2
    end
    if day == 0 # Nedela
      date += 1
    end
    date
  end
  
  def translate_wday wday
    days = {
      1 => "Pondelok",
      2 => "Utorok",
      3 => "Streda",
      4 => "Štvrtok",
      5 => "Piatok",
      6 => "Sobota",
      0 => "Nedeľa"
    }
    
    days[wday]
  end
  
  def nice_date day
    "#{translate_wday(day.wday)} (#{nice_week(day)})"
  end
  
  def nice_week day
    case day.cweek - Date.today.cweek
      when -2
        "Predminulý týždeň"
      when -1
        "Minulý týždeň"
      when 0
        "Tento týždeň"
      when 1
        "Ďalší týždeň"
      when 2
        "Týždeň po ďalšom týždni"
      else
        I18n.l(day)
    end
  end
end

module SubjectsHelper
  Colors = [:blue, :turquoise, :violet, :magenta, :red, :orange, :yellow, :green]
  
  def format_day day_number
    return 'Pondelok' if day_number == 1
    return 'Utorok' if day_number == 2
    return 'Streda' if day_number == 3
    return 'Štvrtok' if day_number == 4
    return 'Piatok' if day_number == 5
  end
end

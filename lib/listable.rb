module Listable
  # Listable methods go here
  
  def format_description(description)
    "#{description}(#{item_type})".ljust(30)
  end
  
  def format_due_date (due)
    due ? due.strftime("%D") : "No due date"
  end

  def format_duration_date (start_date, end_date)
    dates = start_date.strftime("%D") if start_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates = "N/A" if !dates
    return dates
  end

  def format_priority priority
    value = " ⇧".green if priority == "high"
    value = " ⇨".blue if priority == "medium"
    value = " ⇩".red if priority == "low"
    value = "" if !priority
    return value
  end
  
end

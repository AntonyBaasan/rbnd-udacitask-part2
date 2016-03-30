class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    
    if options[:priority] && !validate_priority(options[:priority])
        raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority value"
    end
    
    if type == "todo"
        @items.push TodoItem.new(description, options) 
    elsif type == "event"
        @items.push EventItem.new(description, options)
    elsif type == "link" 
        @items.push LinkItem.new(description, options) 
    else
        raise UdaciListErrors::InvalidItemType, "Invalid Item type!"
    end
  end
  
  
  def validate_priority priority
    priority = priority.downcase
    return true if priority == "high"
    return true if priority == "medium"
    return true if priority == "low"

    return false
  end
  
  def delete(index)
    if(@items.size < index)
        raise UdaciListErrors::IndexExceedsListSize, "Index exceeds error"
    end
    
    @items.delete_at(index - 1)
  end
  
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  
  def filter type
    header = "Filtered by '#{type}' result:"
    puts "-" * header.length
    puts header
    puts "-" * header.length
    
    @items.each_with_index do |item, position|
        if type == "todo" && item.is_a?(TodoItem)
            puts "#{position + 1}) #{item.details}" 
        elsif type == "event" && item.is_a?(EventItem)
            puts "#{position + 1}) #{item.details}"
        elsif type == "link"  && item.is_a?(LinkItem)
            puts "#{position + 1}) #{item.details}"
        end 
    end
  end
end

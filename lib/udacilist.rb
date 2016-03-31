require_relative "todo"
require_relative "event"
require_relative "link"


class UdaciList
  attr_reader :title, :items

  ALLOWED_TYPES = { todo: TodoItem, event: EventItem, link: LinkItem }

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    
    if options[:priority] && !validate_priority(options[:priority])
        raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority value"
    end
    
    if ALLOWED_TYPES.keys.include? type.to_sym
        @items.push ALLOWED_TYPES[type.to_sym].new(description, options)
    else
        raise UdaciListErrors::InvalidItemType, "Invalid Item Type: #{type}"
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
    
    if (@items.select {|item| item.item_type == type}).size ==0
        puts "No data with this type!"
    elsif
        @items.each_with_index do |item, position|
            if type == item.item_type
                puts "#{position + 1}) #{item.details}" 
            end
        end 
    end
  end
  
end

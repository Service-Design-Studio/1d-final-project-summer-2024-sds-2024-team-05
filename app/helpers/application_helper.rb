module ApplicationHelper
    def readable_date(date)
        day = date.day
        month = date.strftime("%B") # Full month name
        year = date.year
    
    
        # Return formatted date string
        "#{day} #{month} #{year}"
    end
end

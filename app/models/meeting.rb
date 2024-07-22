class Meeting < ApplicationRecord
    belongs_to :form

    def readable_start
        datetime = DateTime.parse(start_time.to_s)
  
        # Format the datetime object into custom format
        formatted_datetime = datetime.strftime("%a, %-d %B %Y, %l:%M%P")

        # Return the formatted datetime string
        formatted_datetime
    end

    def condensed_time
        datetime = DateTime.parse(start_time.to_s)

        # Extract the time part from the DateTime object
        time_part = datetime.strftime("%l:%M %p").strip

        # Return the formatted time string
        time_part
    end

    def past_date
        current_datetime = DateTime.now

        # Convert attribute_datetime to a DateTime object if it's not already
        attribute_datetime = DateTime.parse(start_time.to_s) unless attribute_datetime.is_a?(DateTime)

        # Compare current_datetime with attribute_datetime
        current_datetime > start_time
    end

    def parsed_start_time
        "#{start_time.hour}:00"
    end

    def hours
        timestamps = []

        # Define start and end times
        start_time = Time.parse("08:00")
        end_time = Time.parse("19:00")
      
        current_time = start_time
      
        # Iterate from start_time to end_time in steps of 1 hour
        while current_time <= end_time do
          # Format the current_time in military time format ("%H:%M")
          military_time = current_time.strftime("%H:%M")
      
          # Add to the timestamps array
          timestamps << military_time
      
          # Move to the next hour
          current_time += 1.hour
        end
      
        timestamps
    end
end

class Meeting < ApplicationRecord
    belongs_to :form, dependent: :destroy

    def readable_start
        datetime = DateTime.parse(start_time.to_s)

        # Format the datetime object into custom format
        formatted_datetime = datetime.strftime("%-d/%-m, %l:%M %p")

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
end

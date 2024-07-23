
  class SimpleCalendar::HourlyWeekCalendar < SimpleCalendar::Calendar
    def date_range
      start_time = start_date.beginning_of_day + 8.hours # Start from 8 AM
      end_time = start_time + additional_days.days + 1.day   # End one day after the last day

      (start_time.to_datetime...(end_time.to_datetime)).step(30.minutes).to_a
    end

    def td_classes_for(day)
      today = Time.current.to_date

      td_class = ["hour"]
      td_class << "today" if today == day.to_date
      td_class << "past" if today > day.to_date
      td_class << "future" if today < day.to_date

      td_class
    end

    def tr_classes_for(week)
      today = Time.current.to_date
      tr_class = ["day"]
      tr_class << "current-day" if week.include?(today)

      tr_class
    end

    def group_events_by_date(events)
      events_grouped_by_date = Hash.new { |h, k| h[k] = [] }

      events.each do |event|
        start_time = event.send(attribute)
        end_time = event.send(end_attribute) || start_time

        # Round start_time and end_time to nearest 30 minutes
        start_time = start_time.change(min: (start_time.min / 30) * 30, sec: 0)
        end_time = end_time.change(min: (end_time.min / 30) * 30, sec: 0)

        # Iterate through each 30-minute segment within the event duration
        (start_time.to_i..end_time.to_i).step(30.minutes) do |timestamp|
          enumerated_datetime = Time.at(timestamp).to_datetime
          events_grouped_by_date[enumerated_datetime] << event
        end
      end

      events_grouped_by_date
    end
  end


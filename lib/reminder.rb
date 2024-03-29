class Reminder

  def initialize(rules={})
    @reminder_time = {}
    Estate::CHARGE_PERIODS.each do |p|
      @reminder_time[p.to_sym] = rules[p.to_sym] || 1.month
    end
  end

  def on(date, estates)
    reminders = {}

    estates.each do |e|
      curr_reminders = []

      e.due_dates.each do |due_date|
        curr_year_due_date = Date.new(date.year, due_date[:month], due_date[:day])
        next_year_due_date = curr_year_due_date + 1.year

        if(date >= curr_year_due_date - @reminder_time[e.charge_period] and date <= curr_year_due_date)
          curr_reminders << curr_year_due_date
        elsif(date >= next_year_due_date - @reminder_time[e.charge_period])
          curr_reminders << next_year_due_date
        end
      end

      reminders[e.code] = curr_reminders if curr_reminders.any?
    end

    reminders
  end

end
